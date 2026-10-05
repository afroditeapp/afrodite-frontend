import 'package:openapi/api.dart';

class LocalAccountId {
  final int id;
  LocalAccountId(this.id);
}

/// Apple App Attest key stored for the local account.
class AppleAppAttestKeyState {
  /// Key identifier returned by `DCAppAttestService.generateKey`.
  final String keyId;

  /// Challenge used in the App Attest attestation. Stored so attestation can be
  /// retried with the same key and challenge if Apple's App Attest service was
  /// temporarily unavailable.
  final String challenge;

  /// True when [keyId] is not yet successfully attested,
  /// for example because Apple's App Attest service was temporarily
  /// unavailable.
  final bool attestationPending;

  AppleAppAttestKeyState(this.keyId, this.challenge, this.attestationPending);
}

enum AccountState { initialSetup, normal, banned, pendingDeletion }

extension AccountStateContainerToAccountState on AccountStateContainer {
  AccountState toAccountState() {
    if (pendingDeletion) {
      return AccountState.pendingDeletion;
    } else if (banned) {
      return AccountState.banned;
    } else if (!initialSetupCompleted) {
      return AccountState.initialSetup;
    } else {
      return AccountState.normal;
    }
  }
}
