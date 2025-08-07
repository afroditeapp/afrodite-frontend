

import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/view_client_version_statistics.dart';
import 'package:app/ui/utils/view_metrics.dart';
import 'package:app/utils/api.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/utils/result.dart';
import 'package:utils/utils.dart';

void openViewIpCountryStatisticsScreen(BuildContext context, String title, ApiManager api, {bool daily = false, bool fromRam = false}) {
  MyNavigator.push(
    context,
    MaterialPage<void>(
      child: ViewMetricsScreen(
        title: title,
        metrics: GetIpCountryHistory(api, daily: daily, fromRam: fromRam),
      )
    ),
  );
}

class GetIpCountryHistory extends GetMetrics {
  final ApiManager api;
  final bool daily;
  final bool fromRam;

  GetIpCountryHistory(this.api, {this.daily = false, this.fromRam = false});

  @override
  Future<Result<List<Metric>, ()>> getMetrics() async {
    final oldestDate = UtcDateTime.now().substract(const Duration(days: 30));

    final List<Metric> metrics = [];

    Future<Result<(), ()>> downloadStatistics(IpCountryStatisticsType statisticsType) async {
      final queryResults = await api.commonAdmin((api) => api.postGetIpCountryStatistics(
        GetIpCountryStatisticsSettings(minTime: oldestDate.toUnixTime(), dataFromRam: fromRam, statisticsType: statisticsType)
      )).ok();

      if (queryResults == null) {
        return const Err(());
      }

      final String group;
      if (statisticsType == IpCountryStatisticsType.newTcpConnections) {
        group = "tcp";
      } else {
        group = "http";
      }

      metrics.addAll(queryResults.values.map((v) {
        final metric = IpCountryMetric(
          "${group}_${v.country}", group, v.values
        );
        if (daily) {
          return DailyMetrics(metric);
        } else {
          return metric;
        }
      }));

      return Ok(());
    }

    final r = await downloadStatistics(IpCountryStatisticsType.newTcpConnections)
      .andThen((_) => downloadStatistics(IpCountryStatisticsType.newHttpRequests));

    if (r.isErr()) {
      return Err(());
    }

    metrics.sort((a, b) {
      return a.name.compareTo(b.name);
    });

    return Ok(metrics);
  }
}

class IpCountryMetric extends Metric {
  @override
  final String name;
  @override
  final String? group;
  List<FlSpot> _processedValues = [];

  IpCountryMetric(this.name, this.group, List<IpCountryStatisticsValue> values) {
    final data = <FlSpot>[];
    for (final v in values) {
        data.add(FlSpot(v.t?.ut.toDouble() ?? 0, v.c.toDouble()));
    }
    _processedValues = data.sortedBy((v) => v.x);
  }

  @override
  List<FlSpot> getValues() => _processedValues;
}
