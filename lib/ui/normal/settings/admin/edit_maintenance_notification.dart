import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:utils/utils.dart';

class EditMaintenanceNotificationPage extends MyScreenPageLimited<()> {
  EditMaintenanceNotificationPage(RepositoryInstances r)
    : super(builder: (_) => EditMaintenanceNotificationScreen(r));
}

class EditMaintenanceNotificationScreen extends StatefulWidget {
  final ApiManager api;
  final ServerConnectionManager connectionManager;
  EditMaintenanceNotificationScreen(RepositoryInstances r, {super.key})
    : api = r.api,
      connectionManager = r.connectionManager;

  @override
  State<EditMaintenanceNotificationScreen> createState() =>
      _EditMaintenanceNotificationScreenState();
}

class _EditMaintenanceNotificationScreenState extends State<EditMaintenanceNotificationScreen> {
  final EditDateAndTimeController _startTime = EditDateAndTimeController();
  final EditDateAndTimeController _endTime = EditDateAndTimeController();
  ScheduledMaintenanceStatus? _currentState;

  bool saveInProgress = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    final data = await widget.api.commonAdmin((api) => api.getMaintenanceNotification()).ok();

    setState(() {
      isLoading = false;
      _currentState = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];
    actions.add(IconButton(onPressed: _refreshData, icon: const Icon(Icons.refresh)));

    return Scaffold(
      appBar: AppBar(title: const Text("Maintenance notification"), actions: actions),
      body: displayState(context),
    );
  }

  Widget displayState(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_currentState == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return showContent(context);
    }
  }

  Widget showContent(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        final startTime = _currentState?.start?.toUtcDateTime();
        final String start;
        if (startTime == null) {
          start = "null";
        } else {
          start = fullTimeString(startTime);
        }
        final endTime = _currentState?.end?.toUtcDateTime();
        final String end;
        if (endTime == null) {
          end = "null";
        } else {
          end = fullTimeString(endTime);
        }

        final widgets = [
          hPad(Text("Start: $start\nEnd: $end")),
          const Padding(padding: EdgeInsets.all(8.0)),
          hPad(displayMaintenanceNotification(context)),
        ];

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          ),
        );
      },
    );
  }

  Widget displayMaintenanceNotification(BuildContext context) {
    final clearButton = ElevatedButton(
      onPressed: () {
        setState(() {
          _startTime.clear();
          _endTime.clear();
        });
      },
      child: const Text("Clear"),
    );

    final saveButton = ElevatedButton(
      onPressed: () {
        if (saveInProgress) {
          showSnackBar(context.strings.generic_previous_action_in_progress);
          return;
        }

        final startTime = _startTime.timeInfo();
        final endTime = _endTime.timeInfo();
        final maintenanceStatus = ScheduledMaintenanceStatus(
          start: startTime?.$1,
          end: endTime?.$1,
        );
        final startTimeText = startTime?.$2 ?? "null";
        final endTimeText = endTime?.$2 ?? "null";
        showConfirmDialog(
          context,
          "Save selected times?",
          details: "New start: $startTimeText\nNew end: $endTimeText",
        ).then((value) async {
          if (value != true) {
            return;
          }
          saveInProgress = true;
          final result = await widget.api.commonAdminAction(
            (api) => api.postEditMaintenanceNotification(maintenanceStatus),
          );
          if (context.mounted) {
            await widget.connectionManager.restartIfRestartNotOngoing();
            await widget.connectionManager.tryWaitUntilConnected(waitTimeoutSeconds: 5);
            await _refreshData();
          }
          switch (result) {
            case Ok():
              showSnackBar("Saved!");
            case Err():
              showSnackBar("Save failed!");
          }
          saveInProgress = false;
        });
      },
      child: const Text("Save"),
    );

    final widgets = [
      Text("Start time", style: Theme.of(context).textTheme.titleMedium),
      const Padding(padding: EdgeInsets.all(8.0)),
      EditDateAndTime(controller: _startTime),
      const Padding(padding: EdgeInsets.all(8.0)),
      Text("End time", style: Theme.of(context).textTheme.titleMedium),
      const Padding(padding: EdgeInsets.all(8.0)),
      EditDateAndTime(controller: _endTime),
      const Padding(padding: EdgeInsets.all(8.0)),
      clearButton,
      const Padding(padding: EdgeInsets.all(8.0)),
      saveButton,
    ];

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }
}

class EditDateAndTimeController with ChangeNotifier {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void clear() {
    _selectedDate = null;
    _selectedTime = null;
    notifyListeners();
  }

  (UnixTime, String)? timeInfo() {
    final currentSelection = _selectedDate;
    if (currentSelection != null) {
      var currentDateSelection = UtcDateTime.fromDateTime(currentSelection);
      final hour = _selectedTime?.hour;
      final minute = _selectedTime?.minute;
      if (hour != null && minute != null) {
        currentDateSelection = currentDateSelection.add(Duration(hours: hour, minutes: minute));
      }
      return (currentDateSelection.toUnixTime(), fullTimeString(currentDateSelection));
    } else {
      return null;
    }
  }

  @override
  String toString() {
    return timeInfo()?.$2.toString() ?? "null";
  }
}

class EditDateAndTime extends StatefulWidget {
  final EditDateAndTimeController controller;
  const EditDateAndTime({required this.controller, super.key});

  @override
  State<EditDateAndTime> createState() => _EditDateAndTimeState();
}

class _EditDateAndTimeState extends State<EditDateAndTime> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(controllerChanged);
  }

  void controllerChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final dateButton = ElevatedButton(
      onPressed: () async {
        final last = DateTime.now().add(const Duration(days: 30));
        final selected = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: last,
        );
        if (!context.mounted) {
          return;
        }
        setState(() {
          if (selected != null) {
            widget.controller._selectedDate = selected;
          }
        });
      },
      child: const Text("Select date"),
    );

    final timeButton = ElevatedButton(
      onPressed: widget.controller._selectedDate == null
          ? null
          : () async {
              final selected = await showTimePicker(context: context, initialTime: TimeOfDay.now());
              if (!context.mounted) {
                return;
              }
              setState(() {
                if (selected != null) {
                  widget.controller._selectedTime = selected;
                }
              });
            },
      child: const Text("Select time"),
    );

    final widgets = [
      dateButton,
      const Padding(padding: EdgeInsets.all(8.0)),
      timeButton,
      const Padding(padding: EdgeInsets.all(8.0)),
      Text(widget.controller.toString()),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(controllerChanged);
    super.dispose();
  }
}
