import 'package:app/localizations.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/time.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';

class ServerTasksScreen extends StatefulWidget {
  final Permissions permissions;
  const ServerTasksScreen({required this.permissions, super.key});

  @override
  State<ServerTasksScreen> createState() => _ServerTasksScreenState();
}

class _ServerTasksScreenState extends State<ServerTasksScreen> {
  ManagerInstanceNameList? _managers;
  List<ManagerInstanceRelatedState>? _currentData = [];
  final api = LoginRepository.getInstance().repositories.api;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    _managers ??= await api.commonAdmin((api) => api.getManagerInstanceNames()).ok();

    final managers = _managers?.names ?? [];
    final List<ManagerInstanceRelatedState> data = [];
    for (final m in managers) {
      if (!widget.permissions.adminServerMaintenanceRestartBackend) {
        data.add(ManagerInstanceRelatedState(m, null));
        continue;
      }
      final status = await api.commonAdmin((api) => api.getScheduledTasksStatus(m)).ok();
      if (status != null) {
        data.add(ManagerInstanceRelatedState(m, status));
      } else {
        data.add(ManagerInstanceRelatedState(m, null));
      }
    }

    setState(() {
      isLoading = false;
      _currentData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];
    actions.add(IconButton(onPressed: _refreshData, icon: const Icon(Icons.refresh)));

    return Scaffold(
      appBar: AppBar(title: const Text("Server tasks"), actions: actions),
      body: displayState(),
    );
  }

  Widget displayState() {
    final data = _currentData;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_managers == null || data == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return displayData(data);
    }
  }

  Widget displayData(List<ManagerInstanceRelatedState> statusList) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.builder(
        itemCount: statusList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, i) {
          final data = statusList[i];
          return displaySoftwareUpdate(context, data);
        },
      ),
    );
  }

  Widget displaySoftwareUpdate(BuildContext context, ManagerInstanceRelatedState data) {
    final status = data.status;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            data.manager,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        hPad(Text("Tasks", style: Theme.of(context).textTheme.titleLarge)),
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        if (widget.permissions.adminServerMaintenanceRestartBackend)
          hPad(
            actionButton(
              context,
              data,
              "Backend restart",
              null,
              (api) => api.postTriggerBackendRestart(data.manager),
            ),
          ),
        if (widget.permissions.adminServerMaintenanceRestartBackend)
          hPad(
            actionButton(
              context,
              data,
              "System reboot",
              null,
              (api) => api.postTriggerSystemReboot(data.manager),
            ),
          ),
        if (widget.permissions.adminServerMaintenanceResetData)
          hPad(
            actionButton(
              context,
              data,
              "Reset data",
              null,
              (api) => api.postTriggerBackendDataReset(data.manager),
            ),
          ),
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        if (widget.permissions.adminServerMaintenanceRestartBackend && status == null)
          hPad(Text(context.strings.generic_error)),
        if (widget.permissions.adminServerMaintenanceRestartBackend && status != null)
          displayScheduledtasks(context, data, status),
      ],
    );
  }

  Widget displayScheduledtasks(
    BuildContext context,
    ManagerInstanceRelatedState state,
    ScheduledTaskStatus status,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.all(8.0)),
        hPad(Text("Scheduled tasks", style: Theme.of(context).textTheme.titleLarge)),
        const Padding(padding: EdgeInsets.all(8.0)),
        ...displayMaintenanceTasks(context, state, status.backendRestart, status.systemReboot),
        const Padding(padding: EdgeInsets.all(8.0)),
      ],
    );
  }

  List<Widget> displayMaintenanceTasks(
    BuildContext context,
    ManagerInstanceRelatedState state,
    MaintenanceTask? backendRestart,
    MaintenanceTask? systemReboot,
  ) {
    final List<Widget> widgets = [];

    const restartBackendTitle = "Backend restart";
    const restartBackendTaskType = ScheduledTaskType.backendRestart;
    widgets.add(hPad(Text(restartBackendTitle, style: Theme.of(context).textTheme.titleMedium)));
    widgets.add(const Padding(padding: EdgeInsets.all(8.0)));
    if (backendRestart != null) {
      widgets.add(
        displayMaintenanceTaskState(
          context,
          state,
          restartBackendTitle,
          backendRestart,
          restartBackendTaskType,
        ),
      );
      widgets.add(const Padding(padding: EdgeInsets.all(8.0)));
    } else {
      widgets.add(
        hPad(
          actionButton(
            context,
            state,
            "Schedule",
            restartBackendTitle,
            (api) => api.postScheduleTask(state.manager, restartBackendTaskType, true),
          ),
        ),
      );
      widgets.add(
        hPad(
          actionButton(
            context,
            state,
            "Schedule hidden",
            restartBackendTitle,
            (api) => api.postScheduleTask(state.manager, restartBackendTaskType, false),
          ),
        ),
      );
    }

    const systemRebootTitle = "System reboot";
    const systemRebootTaskType = ScheduledTaskType.systemReboot;
    widgets.add(const Padding(padding: EdgeInsets.all(8.0)));
    widgets.add(hPad(Text(systemRebootTitle, style: Theme.of(context).textTheme.titleMedium)));
    widgets.add(const Padding(padding: EdgeInsets.all(8.0)));
    if (systemReboot != null) {
      widgets.add(
        displayMaintenanceTaskState(
          context,
          state,
          systemRebootTitle,
          systemReboot,
          systemRebootTaskType,
        ),
      );
      widgets.add(const Padding(padding: EdgeInsets.all(8.0)));
    } else {
      widgets.add(
        hPad(
          actionButton(
            context,
            state,
            "Schedule",
            systemRebootTitle,
            (api) => api.postScheduleTask(state.manager, systemRebootTaskType, true),
          ),
        ),
      );
      widgets.add(
        hPad(
          actionButton(
            context,
            state,
            "Schedule hidden",
            systemRebootTitle,
            (api) => api.postScheduleTask(state.manager, systemRebootTaskType, false),
          ),
        ),
      );
    }

    return widgets;
  }

  Widget displayMaintenanceTaskState(
    BuildContext context,
    ManagerInstanceRelatedState state,
    String title,
    MaintenanceTask info,
    ScheduledTaskType taskType,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hPad(Text("Start time", style: Theme.of(context).textTheme.titleSmall)),
        hPad(Text(fullTimeString(info.time.toUtcDateTime()))),
        const Padding(padding: EdgeInsets.all(8.0)),
        hPad(Text("Notify backend", style: Theme.of(context).textTheme.titleSmall)),
        hPad(Text(info.notifyBackend.toString())),
        const Padding(padding: EdgeInsets.all(8.0)),
        hPad(
          actionButton(
            context,
            state,
            "Unschedule",
            title,
            (api) => api.postUnscheduleTask(state.manager, taskType),
          ),
        ),
      ],
    );
  }

  Widget actionButton(
    BuildContext context,
    ManagerInstanceRelatedState state,
    String title,
    String? actionTitle,
    Future<void> Function(CommonAdminApi) action,
  ) {
    String buttonTitle;
    if (actionTitle != null) {
      buttonTitle = "$title ${actionTitle.toLowerCase()}?";
    } else {
      buttonTitle = "$title?";
    }
    return ElevatedButton(
      onPressed: () {
        showConfirmDialog(context, buttonTitle).then((value) async {
          if (value == true) {
            final result = await api.commonAdminAction(action);
            if (result case Ok()) {
              showSnackBar("Action successful");
            } else {
              showSnackBar("Action failed");
            }
            if (context.mounted) {
              await _refreshData();
            }
          }
        });
      },
      child: Text(title),
    );
  }
}

class ManagerInstanceRelatedState {
  String manager;
  ScheduledTaskStatus? status;
  ManagerInstanceRelatedState(this.manager, this.status);
}
