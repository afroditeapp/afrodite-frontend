
import 'package:openapi/api.dart';

enum AccountState {
  initialSetup,
  normal,
  banned,
  pendingDeletion,
}

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
