

import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui/utils/view_metrics.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/utils/result.dart';

void openViewPerfDataScreen(BuildContext context, String title, ApiManager api) {
  MyNavigator.push(
    context,
    MaterialPage<void>(
      child: ViewMetricsScreen(
        title: title,
        metrics: GetPerfData(api),
      )
    ),
  );
}

class GetPerfData extends GetMetrics {
  final ApiManager api;

  GetPerfData(this.api);

  @override
  Future<Result<List<Metric>, void>> getMetrics() async {
    final queryResults = await api.accountCommonAdmin((api) => api.postGetPerfData(PerfMetricQuery())).ok();

    if (queryResults == null) {
      return const Err(null);
    }

    queryResults.metrics.sort((a, b) {
      return a.name.compareTo(b.name);
    });

    final list = queryResults.metrics.map((v) => PerfMetric(v.name, v.values)).toList();

    return Ok(list);
  }
}

class PerfMetric extends Metric {
  @override
  final String name;
  final List<PerfMetricValueArea> values;

  PerfMetric(this.name, this.values);

  @override
  List<FlSpot> getValues() {
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
    return data;
  }
}
