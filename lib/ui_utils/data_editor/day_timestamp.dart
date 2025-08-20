import 'package:app/ui_utils/data_editor/base.dart';
import 'package:flutter/material.dart';

abstract class DayTimestampDataManager implements BaseDataManagerProvider {
  int currentDayTimestamp();
  void setDayTimestamp(int value);
}

class DayTimestampDataViewer extends StatefulWidget {
  final DayTimestampDataManager dataManager;
  const DayTimestampDataViewer({required this.dataManager, super.key});

  @override
  State<DayTimestampDataViewer> createState() => _DayTimestampDataViewerState();
}

class _DayTimestampDataViewerState extends State<DayTimestampDataViewer>
    with RefreshSupport<DayTimestampDataViewer> {
  @override
  BaseDataManager get baseDataManager => widget.dataManager.baseDataManager;

  @override
  Widget build(BuildContext context) {
    final int allMinutes = widget.dataManager.currentDayTimestamp() ~/ 60;
    final int hours = allMinutes ~/ 60;
    final int minutes = allMinutes - (hours * 60);
    final String time = "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
    return Row(
      children: [
        Text(time),
        IconButton(
          onPressed: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: hours, minute: minutes),
            );
            if (!context.mounted || time == null) {
              return;
            }
            // Use "23:59" as a special value which is actually "23:59:59"
            final extraSeconds = time.hour == 23 && time.minute == 59 ? 59 : 0;
            final newSeconds = time.hour * 60 * 60 + time.minute * 60 + extraSeconds;
            widget.dataManager.setDayTimestamp(newSeconds);
            widget.dataManager.baseDataManager.triggerUiRefresh();
          },
          icon: const Icon(Icons.edit),
        ),
      ],
    );
  }
}
