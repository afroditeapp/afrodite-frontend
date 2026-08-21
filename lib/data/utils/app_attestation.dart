import 'package:app/config_services.dart';
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
    extends AppAttestationManagerCmd<Result<PlayIntegrityAppAttestation, PlayIntegrityError>> {}

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
              cmd.completed.add(await _getPlayIntegrityAppAttestation());
          }
        })
        .listen(null);
  }

  Future<Result<PlayIntegrityAppAttestation, PlayIntegrityError>> _getPlayIntegrityAppAttestation({
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
      final token = await AppAttest.requestStandardPlayIntegrityToken(requestHash: "-");
      return Ok(PlayIntegrityAppAttestation(token: token));
    } on PlatformException catch (e) {
      _log.error("Play Integrity error: ${e.code}");
      if (e.code == "INTEGRITY_TOKEN_PROVIDER_INVALID" && !retry) {
        _playIntegrityTokenProviderPrepared = false;
        return await _getPlayIntegrityAppAttestation(retry: true);
      } else {
        return Err(PlayIntegrityErrorString(e.code));
      }
    } catch (e) {
      _log.error("Unknown Play Integrity error: $e");
      return Err(PlayIntegrityErrorString("Unknown error"));
    }
  }

  Future<Result<PlayIntegrityAppAttestation, PlayIntegrityError>>
  getPlayIntegrityAppAttestation() async {
    final cmd = GetPlayIntegrityAppAttestation();
    _cmds.add(cmd);
    return await cmd.waitCompletionAndDispose();
  }
}
