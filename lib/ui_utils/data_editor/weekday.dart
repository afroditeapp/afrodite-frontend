
import 'package:app/ui/normal/settings/profile/search_settings.dart';
import 'package:app/ui_utils/data_editor/base.dart';
import 'package:flutter/material.dart';

abstract class WeekdayDataManager implements BaseDataManagerProvider {
  int selectedWeekdays();
  void setWeekdays(int value);
}

class WeekdayDataViewer extends StatefulWidget {
  final WeekdayDataManager dataManager;
  const WeekdayDataViewer({required this.dataManager, super.key});

  @override
  State<WeekdayDataViewer> createState() => _WeekdayDataViewerState();
}

class _WeekdayDataViewerState extends State<WeekdayDataViewer> with RefreshSupport<WeekdayDataViewer> {
  @override
  BaseDataManager get baseDataManager => widget.dataManager.baseDataManager;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: Weekday.weekdays(context).map((day) {
        final currentValue = widget.dataManager.selectedWeekdays();
        return FilterChip(
          label: Text(day.text),
          selected: currentValue & day.bitflag == day.bitflag,
          onSelected: (value) {
            if (value) {
              widget.dataManager.setWeekdays(currentValue | day.bitflag);
            } else {
              widget.dataManager.setWeekdays(currentValue & ~day.bitflag);
            }
            widget.dataManager.baseDataManager.triggerUiRefresh();
          },
        );
      }).toList(),
    );
  }
}
