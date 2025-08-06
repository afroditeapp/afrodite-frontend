
abstract class BaseDataManager {
  final List<RefreshUiAction> _actions = [];
  BaseDataManager();

  void addUiRefreshAction(RefreshUiAction action) {
    _actions.add(action);
  }
  void removeUiRefreshAction(RefreshUiAction action) {
    _actions.remove(action);
  }
  void triggerUiRefresh() {
    for (final a in _actions) {
      a.action();
    }
  }
}

class RefreshUiAction {
  final void Function() action;
  RefreshUiAction(this.action);
}
