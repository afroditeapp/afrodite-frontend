import 'package:flutter/widgets.dart';

abstract class BaseDataManager extends BaseDataManagerProvider {
  final List<RefreshUiAction> _actions = [];
  BaseDataManager();

  @override
  BaseDataManager get baseDataManager => this;

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

abstract class BaseDataManagerProvider {
  BaseDataManager get baseDataManager;
}

class RefreshUiAction {
  final void Function() action;
  RefreshUiAction(this.action);
}

mixin RefreshSupport<T extends StatefulWidget> on State<T> {
  late final RefreshUiAction action;

  BaseDataManager get baseDataManager;

  @override
  void initState() {
    super.initState();
    action = RefreshUiAction(() {
      setState(() {});
    });
    baseDataManager.addUiRefreshAction(action);
  }

  @override
  void dispose() {
    baseDataManager.removeUiRefreshAction(action);
    super.dispose();
  }
}
