

import 'package:app/localizations.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:utils/utils.dart';

class EditMaintenanceNotificationScreen extends StatefulWidget {
  const EditMaintenanceNotificationScreen({super.key});

  @override
  State<EditMaintenanceNotificationScreen> createState() => _EditMaintenanceNotificationScreenState();
}

class _EditMaintenanceNotificationScreenState extends State<EditMaintenanceNotificationScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  ScheduledMaintenanceStatus? _currentConfig;
  final api = LoginRepository.getInstance().repositories.api;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    final data = await api.accountCommonAdmin((api) => api.getMaintenanceNotification()).ok();

    setState(() {
      isLoading = false;
      _currentConfig = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];
    actions.add(IconButton(
      onPressed: _refreshData,
      icon: const Icon(Icons.refresh)
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Maintenance notification"),
        actions: actions,
      ),
      body: displayState(context),
    );
  }

  Widget displayState(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (_currentConfig == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return showContent(context);
    }
  }

  Widget showContent(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        final ut = _currentConfig?.scheduledMaintenance?.ut;
        final String? text;
        if (ut == null) {
          text = null;
        } else {
          final unixTime = UnixTime(ut: ut).toUtcDateTime();
          text = fullTimeString(unixTime);
        }

        final widgets = [
          hPad(Text("Current value: ${text.toString()}")),
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
      }
    );
  }

  Widget displayMaintenanceNotification(BuildContext context) {
    final dateButton = ElevatedButton(
      onPressed: () async {
        final last = DateTime.now().add(const Duration(days: 30));
        final selected = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: last);
        if (!context.mounted) {
          return;
        }
        setState(() {
          if (selected != null) {
            _selectedDate = selected;
          }
        });
      },
      child: const Text("Select date"),
    );

    final timeButton = ElevatedButton(
      onPressed: _selectedDate == null ? null : () async {
        final selected = await showTimePicker(context: context, initialTime: TimeOfDay.now());
        if (!context.mounted) {
          return;
        }
        setState(() {
          if (selected != null) {
            _selectedTime = selected;
          }
        });
      },
      child: const Text("Select time"),
    );

    final currentSelection = _selectedDate;
    UtcDateTime? currentDateSelection;
    final ScheduledMaintenanceStatus maintenanceStatus;
    final String currentDateSelectionText;
    if (currentSelection != null) {
      currentDateSelection = UtcDateTime.fromDateTime(currentSelection);
      final hour = _selectedTime?.hour;
      final minute = _selectedTime?.minute;
      if (hour != null && minute != null) {
        currentDateSelection = currentDateSelection.add(Duration(hours: hour, minutes: minute));
      }
      final UnixTime ut = currentDateSelection.toUnixTime();
      maintenanceStatus = ScheduledMaintenanceStatus(scheduledMaintenance: GetPerfDataEndTimeParameter(ut: ut.ut));
      currentDateSelectionText = fullTimeString(currentDateSelection);
    } else {
      maintenanceStatus = ScheduledMaintenanceStatus(scheduledMaintenance: null);
      currentDateSelection = null;
      currentDateSelectionText = "null";
    }

    final clearButton = ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedDate = null;
          _selectedTime = null;
        });
      },
      child: const Text("Clear"),
    );

    final saveButton = ElevatedButton(
      onPressed: () {
        showConfirmDialog(context, "Save selected time?", details: "New time: $currentDateSelectionText")
          .then((value) async {
            if (value == true) {
              final result = await api
                .accountCommonAdminAction(
                  (api) => api.postEditMaintenanceNotification(maintenanceStatus)
                );
              switch (result) {
                case Ok():
                  showSnackBar("Saved!");
                case Err():
                  showSnackBar("Save failed!");
              }
            }
            if (context.mounted) {
              await _refreshData();
            }
          });
      },
      child: const Text("Save"),
    );

    final widgets = [
      dateButton,
      const Padding(padding: EdgeInsets.all(8.0)),
      timeButton,
      const Padding(padding: EdgeInsets.all(8.0)),
      Text(currentDateSelectionText),
      const Padding(padding: EdgeInsets.all(8.0)),
      clearButton,
      const Padding(padding: EdgeInsets.all(8.0)),
      saveButton,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
