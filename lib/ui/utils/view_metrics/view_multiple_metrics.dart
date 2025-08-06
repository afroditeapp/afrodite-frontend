

import 'dart:math';

import 'package:app/ui/utils/view_metrics.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/time.dart';
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

    if (values.isEmpty) {
      return null;
    }

    final (metricMin, metricMax) = values
        .map((v) => (v.y, v.y))
        .reduce((value, element) => (min(value.$1, element.$1), max(value.$2, element.$2)));

    return MetricAndMinMaxValues(metric, metricMin, metricMax);
  }
}

class ViewMultipleMetricsController {
  double minDataValue = 0;
  double maxDataValue = 0;

  double selectedMin = 0;
  double selectedMax = 0;

  bool initialUpdateDone = false;

  List<MetricAndMinMaxValues> data = [];
  List<(int, Metric)> filteredList = [];

  void updateData(List<Metric> newData) {
    data = newData.map((v) => MetricAndMinMaxValues.create(v))
      .whereType<MetricAndMinMaxValues>()
      .toList();

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
              maxIncluded: false,
              minIncluded: false,
              getTitlesWidget: (value, meta) {
                final date = DateTime.fromMillisecondsSinceEpoch(value.toInt() * 1000, isUtc: true);
                final time = date.toUtc();
                // Add zero padding to formatting string
                final timeText = "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(timeText),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
