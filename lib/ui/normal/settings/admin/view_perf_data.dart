import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui/utils/view_metrics.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/utils/result.dart';

void openViewPerfDataScreen(BuildContext context, String title, ApiManager api) {
  MyNavigator.push(
    context,
    MaterialPage<void>(
      child: ViewMetricsScreen(title: title, metrics: GetPerfData(api)),
    ),
  );
}

class GetPerfData extends GetMetrics {
  final ApiManager api;

  GetPerfData(this.api);

  @override
  Future<Result<List<Metric>, ()>> getMetrics() async {
    final queryResults = await api
        .commonAdmin((api) => api.postGetPerfData(PerfMetricQuery()))
        .ok();

    if (queryResults == null) {
      return const Err(());
    }

    queryResults.metrics.sort((a, b) {
      return a.name.compareTo(b.name);
    });

    final list = queryResults.metrics.map((v) => PerfMetric(v.name, v.group, v.values)).toList();

    return Ok(list);
  }
}

class PerfMetric extends Metric {
  @override
  final String name;
  @override
  final String? group;
  final List<PerfMetricValueArea> values;
  List<FlSpot> _processedValues = [];

  PerfMetric(this.name, this.group, this.values) {
    final data = <FlSpot>[];
    for (final pointArea in values) {
      if (pointArea.timeGranularity == TimeGranularity.hours) {
        throw Exception("Hours granularity not supported");
      }

      for (final (index, point) in pointArea.values.indexed) {
        final time = pointArea.firstTimeValue.ut + (index * 60);
        data.add(FlSpot(time.toDouble(), point.toDouble()));
      }
    }
    _processedValues = data.sortedBy((v) => v.x);
  }

  @override
  List<FlSpot> getValues() => _processedValues;
}
