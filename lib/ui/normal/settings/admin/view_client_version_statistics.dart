

import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui/utils/view_metrics.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/utils/api.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/utils/result.dart';
import 'package:utils/utils.dart';

void openViewClientVersionStatisticsScreen(BuildContext context, String title, ApiManager api, {bool daily = false}) {
  MyNavigator.push(
    context,
    MaterialPage<void>(
      child: ViewMetricsScreen(
        title: title,
        metrics: GetClientVersions(api, daily: daily),
      )
    ),
  );
}

class GetClientVersions extends GetMetrics {
  final ApiManager api;
  final bool daily;

  GetClientVersions(this.api, {this.daily = false});

  @override
  Future<Result<List<Metric>, ()>> getMetrics() async {
    final oldestDate = UtcDateTime.now().substract(const Duration(days: 30));
    final queryResults = await api.accountAdmin((api) => api.postGetClientVersionStatistics(GetClientVersionStatisticsSettings(minTime: oldestDate.toUnixTime()))).ok();

    if (queryResults == null) {
      return const Err(());
    }

    queryResults.values.sort((a, b) {
      return a.version.versionString().compareTo(b.version.versionString());
    });

    final list = queryResults.values.map((v) {
      final metric = ClientVersionMetric(v.version.versionString(), v.values);
      if (daily) {
        return DailyMetrics(metric);
      } else {
        return metric;
      }
    }).toList();

    return Ok(list);
  }
}

class ClientVersionMetric extends Metric {
  @override
  final String name;
  @override
  final String? group = null;
  List<FlSpot> _processedValues = [];

  ClientVersionMetric(this.name, List<ClientVersionCount> values) {
    final data = <FlSpot>[];
    for (final v in values) {
        data.add(FlSpot(v.t.ut.toDouble(), v.c.toDouble()));
    }
    _processedValues = data.sortedBy((v) => v.x);
  }

  @override
  List<FlSpot> getValues() => _processedValues;
}

class DailyMetrics extends Metric {
  @override
  final String name;
  @override
  final String? group;
  List<FlSpot> _processedValues = [];

  DailyMetrics(Metric metric) : name = metric.name, group = metric.group {
    final values = metric.getValues();
    final data = <FlSpot>[];
    DateTime date = DateTime.utc(2000);
    int count = 0;
    int? day;
    for (final v in values) {
      final valueUnixTime = UnixTime(ut: v.x.toInt());
      final valueDateTime = valueUnixTime.toUtcDateTime().dateTime;
      if (day == null) {
        date = DateTime.utc(valueDateTime.year, valueDateTime.month, valueDateTime.day);
        count = v.y.toInt();
        day = valueDateTime.day;
      } else if (day != valueDateTime.day) {
        data.add(FlSpot(UtcDateTime.fromDateTime(date).toUnixTime().ut.toDouble(), count.toDouble()));
        date = DateTime.utc(valueDateTime.year, valueDateTime.month, valueDateTime.day);
        count = v.y.toInt();
        day = valueDateTime.day;
      } else {
        count += v.y.toInt();
      }
    }
    if (values.isNotEmpty) {
      data.add(FlSpot(UtcDateTime.fromDateTime(date).toUnixTime().ut.toDouble(), count.toDouble()));
    }
    _processedValues = data.sortedBy((v) => v.x);
  }

  @override
  List<FlSpot> getValues() => _processedValues;
}
