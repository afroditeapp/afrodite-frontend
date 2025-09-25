import 'dart:math';

import 'package:app/ui_utils/data_editor/base.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/slider.dart';
import 'package:flutter/material.dart';

abstract class DayTimestampDataManager implements BaseDataManagerProvider {
  int currentDayTimestamp();
  void setDayTimestamp(int value);
}

class DayTimestampDataViewer extends StatefulWidget {
  final DayTimestampDataManager start;
  final DayTimestampDataManager end;
  const DayTimestampDataViewer({required this.start, required this.end, super.key});

  @override
  State<DayTimestampDataViewer> createState() => _DayTimestampDataViewerState();
}

class _DayTimestampDataViewerState extends State<DayTimestampDataViewer>
    with RefreshSupport<DayTimestampDataViewer> {
  double start = 0;
  double end = 1;

  @override
  void initState() {
    super.initState();
    start = widget.start.currentDayTimestamp().toDouble();
    end = widget.end.currentDayTimestamp().toDouble();
  }

  @override
  BaseDataManager get baseDataManager => widget.start.baseDataManager;

  @override
  Widget build(BuildContext context) {
    final startUtc = widget.start.currentDayTimestamp();
    final endUtc = widget.end.currentDayTimestamp();
    final startLocal = DayTimestamp.fromInt(_utcDayTimestampToLocal(startUtc));
    final endLocal = DayTimestamp.fromInt(_utcDayTimestampToLocal(endUtc));

    final diff = end - start;
    final time = DayTimestamp.fromInt(diff.toInt());
    final durationText =
        "Daily time: ${time.hours.toString().padLeft(2, '0')}h ${time.minutes.toString().padLeft(2, '0')}m ${time.seconds.toString().padLeft(2, '0')}s";

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hPad(Row(children: [Text(startLocal.toString()), Spacer(), Text(endLocal.toString())])),
        RangeSliderWithPadding(
          values: RangeValues(start, end),
          min: 0,
          max: _SECONDS_IN_DAY.toDouble(),
          divisions: 24 * 2,
          onChanged: (values) {
            start = values.start;
            end = values.end;
            widget.start.setDayTimestamp(min(values.start.toInt(), _SECONDS_IN_DAY - 1));
            widget.end.setDayTimestamp(min(values.end.toInt(), _SECONDS_IN_DAY - 1));
            widget.start.baseDataManager.triggerUiRefresh();
          },
        ),
        Padding(padding: EdgeInsetsGeometry.only(top: 8)),
        hPad(Text(durationText)),
      ],
    );
  }
}

class DayTimestamp {
  final int hours;
  final int minutes;
  final int seconds;
  DayTimestamp._(this.hours, this.minutes, this.seconds);

  factory DayTimestamp.fromInt(int dayTimestamp) {
    final int seconds = dayTimestamp % 60;
    final int allMinutes = dayTimestamp ~/ 60;
    final int hours = allMinutes ~/ 60;
    final int minutes = allMinutes - (hours * 60);
    return DayTimestamp._(hours, minutes, seconds);
  }

  @override
  String toString() {
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
  }
}

const int _SECONDS_IN_DAY = 60 * 60 * 24;

int _utcDayTimestampToLocal(int utcDayTimestamp) {
  final utcOffsetSeconds = DateTime.now().timeZoneOffset.inSeconds;
  // "_SECONDS_IN_DAY +" prevents negative values
  final localDayTimestamp =
      (_SECONDS_IN_DAY + utcDayTimestamp + utcOffsetSeconds) % _SECONDS_IN_DAY;
  return localDayTimestamp;
}
