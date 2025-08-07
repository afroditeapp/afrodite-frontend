

import 'dart:collection';
import 'dart:math';

import 'package:app/ui/utils/view_metrics.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/time.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

// TODO(quality): Add dispose calling to all TextEditingControllers

class MetricAndMinMaxValues {
  final Metric metric;
  final double minValue;
  final double maxValue;
  MetricAndMinMaxValues(this.metric, this.minValue, this.maxValue);

  static MetricAndMinMaxValues? create(Metric metric) {
    final values = metric.getValues();

    if (values.isEmpty || values.firstWhereOrNull((v) => v.y != 0) == null) {
      return null;
    }

    final (metricMin, metricMax) = values
        .map((v) => (v.y, v.y))
        .reduce((value, element) => (min(value.$1, element.$1), max(value.$2, element.$2)));

    return MetricAndMinMaxValues(metric, metricMin, metricMax);
  }

  String groupNameOrDefaultGroup() {
    return metric.group ?? "default";
  }
}

class MetricGroupManager {
  List<MetricAndMinMaxValues> data = [];
  LinkedHashSet<String> groups = LinkedHashSet();
  String selectedGroup = "";

  bool initialUpdateDone = false;

  void updateData(List<Metric> newData) {
    data = newData.map((v) => MetricAndMinMaxValues.create(v))
      .whereType<MetricAndMinMaxValues>()
      .toList();
    groups = LinkedHashSet.from({"default"});
    for (final d in data) {
      final g = d.metric.group;
      if (g != null) {
        groups.add(g);
      }
    }

    if (!initialUpdateDone) {
      initialUpdateDone = true;
      selectedGroup = groups.first;
    }
  }

  List<MetricAndMinMaxValues> selectedGroupData() {
    return data.where((v) => v.groupNameOrDefaultGroup() == selectedGroup).toList();
  }
}

class ViewMultipleMetricsController {
  MetricGroupManager group = MetricGroupManager();

  double minDataValue = 0;
  double maxDataValue = 0;

  double selectedMin = 0;
  double selectedMax = 0;

  bool initialUpdateDone = false;

  List<MetricAndMinMaxValues> data = [];
  List<(int, Metric)> filteredList = [];

  double xMinFiltered = 0;
  double xMaxFiltered = 0;

  void updateData(List<Metric> newData) {
    group.updateData(newData);
    _groupChangeRefresh();
  }

  void _groupChangeRefresh() {
    data = group.selectedGroupData();

    minDataValue = double.maxFinite;
    maxDataValue = -double.maxFinite;
    for (final m in data) {
      minDataValue = min(minDataValue, m.minValue);
      maxDataValue = max(maxDataValue, m.maxValue);
    }

    if (!initialUpdateDone) {
      initialUpdateDone = true;
      selectedMin = minDataValue;
      selectedMax = maxDataValue;
    }

    selectedMin = selectedMin.clamp(minDataValue, maxDataValue);
    selectedMax = selectedMax.clamp(minDataValue, maxDataValue);
    _refreshSelected(selectedMin, selectedMax);
  }

  void _refreshSelected(double newMin, double newMax) {
    selectedMin = newMin.clamp(minDataValue, maxDataValue);
    selectedMax = newMax.clamp(minDataValue, maxDataValue);
    filteredList = data
      .indexed
      .where((indexAndMetric) {
        return indexAndMetric.$2.minValue >= selectedMin && indexAndMetric.$2.maxValue <= selectedMax;
      })
      .map((v) => (v.$1, v.$2.metric))
      .toList();
    xMinFiltered = double.maxFinite;
    xMaxFiltered = -double.maxFinite;
    for (final (_, m) in filteredList) {
      final values = m.getValues();
      xMinFiltered = min(xMinFiltered, values.first.x);
      xMaxFiltered = max(xMaxFiltered, values.last.x);
    }
  }

  void updateGroupSelection(String selected) {
    group.selectedGroup = selected;
    _groupChangeRefresh();
    _refreshSelected(minDataValue, maxDataValue);
  }
}

class ViewMultipleMetrics extends StatefulWidget {
  final List<Metric> metrics;
  final ViewMultipleMetricsController controller;
  const ViewMultipleMetrics({required this.metrics, required this.controller, super.key});

  @override
  State<ViewMultipleMetrics> createState() => _ViewMultipleMetricsState();
}

class _ViewMultipleMetricsState extends State<ViewMultipleMetrics> {
  @override
  Widget build(BuildContext context) {
    return displayData(context);
  }

  Widget displayData(BuildContext context) {
    final filteredMetrics = widget.controller.filteredList;

    final Widget chart;
    if (filteredMetrics.isEmpty) {
      chart = const Center(
        child: Text("No data"),
      );
    } else {
      chart = getChart(context, filteredMetrics);
    }

    return Column(
      children: [
        if (widget.controller.group.groups.length > 1) SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: widget.controller.group.groups
              .map((v) => FilterChip(
                label: Text(v),
                selected: v == widget.controller.group.selectedGroup,
                onSelected: (value) {
                  if (value) {
                    setState(() {
                      widget.controller.updateGroupSelection(v);
                    });
                  }
                },
              )
            ).toList()),
        ),
        RangeSlider(
          values: RangeValues(widget.controller.selectedMin, widget.controller.selectedMax),
          min: widget.controller.minDataValue,
          max: widget.controller.maxDataValue,
          onChanged: (RangeValues values) {
            setState(() {
              widget.controller._refreshSelected(values.start, values.end);
            });
          },
        ),
        hPad(Row(
          children: [
            Text("${widget.controller.minDataValue}"),
            Spacer(),
            Text("${widget.controller.selectedMin.toStringAsFixed(0)}, ${widget.controller.selectedMax.toStringAsFixed(0)}"),
            Spacer(),
            Text("${widget.controller.maxDataValue}"),
          ],
        )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: chart,
          )
        ),
      ],
    );
  }

  Widget getChart(BuildContext context, List<(int, Metric)> values) {
    final data = values.map((e) => LineChartBarData(
      spots: e.$2.getValues(),
      isCurved: false,
      barWidth: 4,
    )).toList();

    final xMin = widget.controller.xMinFiltered;
    final xMax = widget.controller.xMaxFiltered;
    final diff = xMax - xMin;
    final xAxisCenterAreaMin = xMin + diff / 3;
    final xAxisCenterAreaMax = xMin + (diff / 3) * 2;
    final xAxisTitleInterval = diff / 3;

    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                final name = values[touchedSpot.barIndex].$2.name;
                final utcTime = UnixTime(ut: touchedSpot.x.toInt()).toUtcDateTime();
                final time = "$name, ${timeString(utcTime)}, ${touchedSpot.y.toInt()}";
                return LineTooltipItem(
                  time,
                  Theme.of(context).textTheme.labelLarge!,
                );
              }).toList();
            },
          ),
        ),
        lineBarsData: data,
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 44,
              interval: xAxisTitleInterval,
              getTitlesWidget: (value, meta) {
                final upperTimeText = value == xMin || value == xMax || (value >= xAxisCenterAreaMin && value <= xAxisCenterAreaMax);
                final utcTime = UnixTime(ut: value.toInt()).toUtcDateTime();
                final timeText = timeString(utcTime);
                if (upperTimeText) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(timeText),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: Text(timeText),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ViewMultipleMetricsActions extends StatelessWidget {
  final ViewMultipleMetricsController controller;
  const ViewMultipleMetricsActions({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () async {
            final visibleMetrics = controller.filteredList.map((v) => v.$2.name).join("\n");
            final text = "Visible metrics:\n$visibleMetrics";
            await showInfoDialog(
              context,
              text,
              scrollable: true,
            );
          },
          icon: const Icon(Icons.info),
        ),
      ],
    );
  }
}
