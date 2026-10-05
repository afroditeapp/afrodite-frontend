import 'dart:async';

import 'package:app/config_services.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/result.dart';
import 'package:app_attest/app_attest.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

final _log = Logger("AppAttestationManager");

sealed class PlayIntegrityError {}

class PlayIntegrityNotConfigured extends PlayIntegrityError {}

class PlayIntegrityNotSupported extends PlayIntegrityError {}

class PlayIntegrityErrorString extends PlayIntegrityError {
  final String message;
  PlayIntegrityErrorString(this.message);
}

sealed class AppleAppAttestError {}

class AppleAppAttestNotSupported extends AppleAppAttestError {}

class AppleAppAttestErrorString extends AppleAppAttestError {
  final String message;
  AppleAppAttestErrorString(this.message);
}

abstract class AppAttestationManagerCmd<T> {
  final BehaviorSubject<T?> completed = BehaviorSubject.seeded(null);

  /// Can be called only once
  Future<T> waitCompletionAndDispose() async {
    final value = await completed.whereType<T>().first;
    await completed.close();
    return value;
  }
}

class GetPlayIntegrityAppAttestation
    extends AppAttestationManagerCmd<Result<PlayIntegrityAppAttestation, PlayIntegrityError>> {
  final String requestHash;
  GetPlayIntegrityAppAttestation(this.requestHash);
}

class GetAppleAppAttestation
    extends AppAttestationManagerCmd<Result<AppleAppAttest, AppleAppAttestError>> {
  final String challenge;
  final AccountDatabaseManager db;
  GetAppleAppAttestation(this.challenge, this.db);
}

class AppAttestationManager extends AppSingleton {
  AppAttestationManager._private();
  static final _instance = AppAttestationManager._private();
  factory AppAttestationManager.getInstance() {
    return _instance;
  }

  bool _initDone = false;
  bool _playIntegrityTokenProviderPrepared = false;

  final PublishSubject<AppAttestationManagerCmd<Object?>> _cmds = PublishSubject();

  @override
  Future<void> init() async {
    if (_initDone) {
      return;
    }
    _initDone = true;

    _cmds
        .asyncMap((cmd) async {
          switch (cmd) {
            case GetPlayIntegrityAppAttestation():
              cmd.completed.add(
                await _getPlayIntegrityAppAttestation(requestHash: cmd.requestHash),
              );
            case GetAppleAppAttestation():
              cmd.completed.add(
                await _getAppleAppAttestation(challenge: cmd.challenge, db: cmd.db),
              );
          }
        })
        .listen(null);
  }

  Future<Result<PlayIntegrityAppAttestation, PlayIntegrityError>> _getPlayIntegrityAppAttestation({
    required String requestHash,
    bool retry = false,
  }) async {
    if (retry) {
      _log.info("Retrying Play Integrity app attestation");
    }

    try {
      final cloudProjectNumber = playIntegrityApiCloudProjectNumber();
      if (cloudProjectNumber == null) {
        return Err(PlayIntegrityNotConfigured());
      }
      if (!await AppAttest.isSupported()) {
        return Err(PlayIntegrityNotSupported());
      }
      if (!_playIntegrityTokenProviderPrepared) {
        await AppAttest.preparePlayIntegrityTokenProvider(cloudProjectNumber: cloudProjectNumber);
      }
      final token = await AppAttest.requestStandardPlayIntegrityToken(requestHash: requestHash);
      return Ok(PlayIntegrityAppAttestation(token: token));
    } on PlatformException catch (e) {
      _log.error("Play Integrity error: ${e.code}");
      if (e.code == "INTEGRITY_TOKEN_PROVIDER_INVALID" && !retry) {
        _playIntegrityTokenProviderPrepared = false;
        return await _getPlayIntegrityAppAttestation(requestHash: requestHash, retry: true);
      } else {
        return Err(PlayIntegrityErrorString(e.code));
      }
    } catch (e) {
      _log.error("Unknown Play Integrity error: $e");
      return Err(PlayIntegrityErrorString("Unknown error"));
    }
  }

  Future<Result<PlayIntegrityAppAttestation, PlayIntegrityError>> getPlayIntegrityAppAttestation({
    required String requestHash,
  }) async {
    final cmd = GetPlayIntegrityAppAttestation(requestHash);
    _cmds.add(cmd);
    return await cmd.waitCompletionAndDispose();
  }

  Future<Result<AppleAppAttest, AppleAppAttestError>> _getAppleAppAttestation({
    required String challenge,
    required AccountDatabaseManager db,
    bool retry = false,
  }) async {
    try {
      if (!await AppAttest.isSupported()) {
        return Err(AppleAppAttestNotSupported());
      }

      final keyId = await db.accountData((db) => db.appleAppAttest.getAppleAppAttestKey()).ok();

      if (keyId == null) {
        return await _attestNewAppleAppAttestKey(db, challenge);
      }

      // The key has already been attested, so prove it is still valid with an
      // assertion.
      try {
        final assertion = await AppAttest.generateAssertion(keyId: keyId, challenge: challenge);
        return Ok(AppleAppAttest(keyId: assertion.keyId, assertion: assertion.assertionObject));
      } on PlatformException catch (e) {
        if (_isInvalidKeyError(e) && !retry) {
          _log.info("Apple App Attest key is invalid, generating a new one");
          await db.accountAction((db) => db.appleAppAttest.updateAppleAppAttestKey(null));
          return await _getAppleAppAttestation(challenge: challenge, db: db, retry: true);
        }
        rethrow;
      }
    } on PlatformException catch (e) {
      _log.error("Apple App Attest error: ${e.code} ${e.message}");
      return Err(AppleAppAttestErrorString(e.code));
    } catch (e) {
      _log.error("Unknown Apple App Attest error: $e");
      return Err(AppleAppAttestErrorString("Unknown error"));
    }
  }

  Future<Result<AppleAppAttest, AppleAppAttestError>> _attestNewAppleAppAttestKey(
    AccountDatabaseManager db,
    String challenge,
  ) async {
    final newKeyId = await AppAttest.generateKey();
    final attestation = await AppAttest.attestKey(keyId: newKeyId, challenge: challenge);
    await db.accountAction((db) => db.appleAppAttest.updateAppleAppAttestKey(newKeyId));
    return Ok(AppleAppAttest(keyId: attestation.keyId, attestation: attestation.attestationObject));
  }

  /// Returns true if stored key is invalid and must be regenerated.
  bool _isInvalidKeyError(PlatformException e) {
    if (e.code != "GENERATE_ASSERTION_FAILED" && e.code != "ATTEST_KEY_FAILED") {
      return false;
    }
    final details = e.details;
    if (details is! Map) {
      return false;
    }

    // Domain of Apple's DeviceCheck (App Attest) errors, `DCErrorDomain`.
    const dcErrorDomain = "com.apple.devicecheck.error";

    // Apple's `DCErrorInvalidKey`, returned when a key is invalid or has been
    // revoked and must be regenerated.
    const dcErrorInvalidKey = 3;

    return details["domain"] == dcErrorDomain && details["code"] == dcErrorInvalidKey;
  }

  Future<Result<AppleAppAttest, AppleAppAttestError>> getAppleAppAttestation({
    required String challenge,
    required AccountDatabaseManager db,
  }) async {
    final cmd = GetAppleAppAttestation(challenge, db);
    _cmds.add(cmd);
    return await cmd.waitCompletionAndDispose();
  }
}
