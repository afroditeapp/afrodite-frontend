import 'package:app/api/server_connection_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/data_editor/base.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';

// TODO(refactor): Remove DataManager and related types as those
//                 are complex and require RefreshUiAction.
//                 Perhaps it would be better to just make reusable editor
//                 components with controller classes and copy-paste
//                 unsaved changes logic. Or perhaps the logic could be mixin.

abstract class DataManager implements BaseDataManager {
  const DataManager();
  bool unsavedChanges();
  String changesText();
  List<Widget> actions();
  List<Widget> slivers();
}

class EmptyDataManager extends DataManager {
  @override
  BaseDataManager get baseDataManager => this;

  @override
  bool unsavedChanges() {
    return false;
  }

  @override
  String changesText() {
    return "";
  }

  @override
  List<Widget> actions() {
    return [];
  }

  @override
  List<Widget> slivers() {
    return [];
  }

  @override
  void addUiRefreshAction(RefreshUiAction action) {}

  @override
  void removeUiRefreshAction(RefreshUiAction action) {}

  @override
  void triggerUiRefresh() {}
}

abstract class EditDataApi<T extends DataManager> {
  const EditDataApi();
  Future<Result<T, ()>> load(ApiManager api);
  Future<Result<(), String>> save(ApiManager api, T manager);
}

class EditDataScreen<T extends DataManager> extends StatefulWidget {
  final ApiManager api;
  final PageKey pageKey;
  final String title;
  final EditDataApi<T> dataApi;
  const EditDataScreen({
    required this.api,
    required this.pageKey,
    required this.title,
    required this.dataApi,
    super.key,
  });

  @override
  State<EditDataScreen> createState() => _EditDataScreenState();
}

class _EditDataScreenState extends State<EditDataScreen> {
  DataManager dataManager = EmptyDataManager();
  bool isLoading = true;
  bool isError = false;

  late final RefreshUiAction action;

  Future<void> _getData() async {
    final result = await widget.dataApi.load(widget.api).ok();

    if (!context.mounted) {
      return;
    }

    if (result == null) {
      showSnackBar(R.strings.generic_error);
      setState(() {
        isLoading = false;
        isError = true;
      });
    } else {
      setState(() {
        isLoading = false;
        dataManager.removeUiRefreshAction(action);
        dataManager = result;
        dataManager.addUiRefreshAction(action);
      });
    }
  }

  Future<void> saveData() async {
    final result = await widget.dataApi.save(widget.api, dataManager);
    if (result case Err()) {
      showSnackBar("Error: ${result.e}");
    }
  }

  @override
  void initState() {
    super.initState();
    action = RefreshUiAction(() {
      setState(() {});
    });
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final unsavedChanges = dataManager.unsavedChanges();
    return PopScope(
      canPop: !unsavedChanges,
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop) {
          final r = await showConfirmDialog(context, "Discard changes?", yesNoActions: true);
          if (r == true && context.mounted) {
            MyNavigator.removePage(context, widget.pageKey);
          }
        }
      },
      child: screen(context, unsavedChanges),
    );
  }

  Widget screen(BuildContext context, bool unsavedChanges) {
    Widget? saveButton;
    if (unsavedChanges) {
      saveButton = FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          final changes = dataManager.changesText();
          final r = await showConfirmDialog(
            context,
            context.strings.generic_save_confirmation_title,
            details: changes.isEmpty ? null : changes,
            scrollable: true,
          );
          if (r == true && context.mounted) {
            await saveData();
            if (context.mounted) {
              MyNavigator.removePage(context, widget.pageKey);
            }
          }
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: [...dataManager.actions()]),
      body: screenContent(context),
      floatingActionButton: saveButton,
    );
  }

  Widget screenContent(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (isError) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return showData(context);
    }
  }

  Widget showData(BuildContext context) {
    return CustomScrollView(
      slivers: [
        ...dataManager.slivers(),
        const SliverToBoxAdapter(
          child: Padding(padding: EdgeInsets.only(top: FLOATING_ACTION_BUTTON_EMPTY_AREA)),
        ),
      ],
    );
  }

  @override
  void dispose() {
    dataManager.removeUiRefreshAction(action);
    super.dispose();
  }
}
