

import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui/utils/view_metrics.dart';
import 'package:app/utils/api.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/utils/result.dart';
import 'package:utils/utils.dart';

void openViewApiUsageScreen(BuildContext context, String title, ApiManager api, AccountId account) {
  MyNavigator.push(
    context,
    MaterialPage<void>(
      child: ViewMetricsScreen(
        title: title,
        metrics: GetApiUsage(api, account),
      )
    ),
  );
}

class GetApiUsage extends GetMetrics {
  final ApiManager api;
  final AccountId account;

  GetApiUsage(this.api, this.account);

  @override
  Future<Result<List<Metric>, void>> getMetrics() async {
    final oldestDate = UtcDateTime.now().substract(const Duration(days: 30));
    final queryResults = await api.commonAdmin((api) => api.postGetApiUsageData(GetApiUsageStatisticsSettings(account: account, minTime: oldestDate.toUnixTime()))).ok();

    if (queryResults == null) {
      return const Err(null);
    }

    queryResults.values.sort((a, b) {
      return a.name.compareTo(b.name);
    });

    final list = queryResults.values.map((v) => ApiUsageMetric(v.name, v.values)).toList();

    return Ok(list);
  }
}

class ApiUsageMetric extends Metric {
  @override
  final String name;
  final List<ApiUsageCount> values;

  ApiUsageMetric(this.name, this.values);

  @override
  List<FlSpot> getValues() {
    final data = <FlSpot>[];

    for (final v in values) {
      data.add(FlSpot(v.t.ut.toDouble(), v.c.toDouble()));
    }

    return data;
  }
}
