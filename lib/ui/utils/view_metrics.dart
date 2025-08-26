import 'dart:math';

import 'package:app/ui/utils/view_metrics/view_multiple_metrics.dart';
import 'package:app/ui/utils/view_metrics/view_single_metric.dart';
import 'package:app/utils/list.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/result.dart';

class ViewMetricsScreen extends StatefulWidget {
  final String title;
  final GetMetrics metrics;
  final String? dataAttribution;
  const ViewMetricsScreen({
    required this.title,
    required this.metrics,
    this.dataAttribution,
    super.key,
  });

  @override
  State<ViewMetricsScreen> createState() => _ViewMetricsScreenState();
}

class _ViewMetricsScreenState extends State<ViewMetricsScreen> {
  final ViewSingleMetricController _singleController = ViewSingleMetricController();
  final ViewMultipleMetricsController _multipleController = ViewMultipleMetricsController();

  List<Metric>? _currentData;
  bool isLoading = true;
  bool isError = false;

  bool viewSingle = false;

  Future<void> updateData() async {
    final data = await widget.metrics.getMetrics();
    setState(() {
      _singleController.updateData(_currentData, data.ok() ?? []);
      _multipleController.updateData(data.ok() ?? []);
      _currentData = data.ok();
      if (data.isErr()) {
        isError = true;
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (!viewSingle) ViewMultipleMetricsActions(controller: _multipleController),
          IconButton(
            onPressed: () async {
              setState(() {
                viewSingle = !viewSingle;
              });
            },
            icon: Icon(viewSingle ? Icons.show_chart : Icons.stacked_line_chart),
          ),
          IconButton(
            onPressed: () async {
              await updateData();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: showState(),
    );
  }

  Widget showState() {
    final data = _currentData;
    if (isError) {
      return Center(child: Text("Error"));
    } else if (data == null || isLoading) {
      return buildProgressIndicator();
    } else {
      final dataAttribution = widget.dataAttribution;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: displayData(data)),
          if (dataAttribution != null)
            Padding(
              padding: EdgeInsetsGeometry.only(left: 16, right: 16, bottom: 16, top: 0),
              child: Text(dataAttribution),
            ),
        ],
      );
    }
  }

  Widget buildProgressIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget displayData(List<Metric> data) {
    if (viewSingle) {
      return ViewSingleMetric(controller: _singleController, metrics: data);
    } else {
      return ViewMultipleMetrics(controller: _multipleController, metrics: data);
    }
  }
}

abstract class GetMetrics {
  Future<Result<List<Metric>, ()>> getMetrics();
}

abstract class Metric {
  String get name;
  String? get group;

  /// The values are sorted by X coordinate
  List<FlSpot> getValues();

  List<FlSpot> getValuesMax2SequentialValues() {
    final list = getValues();
    final List<FlSpot> newList = [];
    for (var i = 0; i < list.length; i++) {
      final previous = list.getAtOrNull(max(0, i - 1));
      final current = list[i];
      final next = list.getAtOrNull(min(list.length - 1, i + 1));
      if (previous != null && current.y == previous.y) {
        if (next != null && current.y != next.y) {
          newList.add(current);
        }
      } else {
        newList.add(current);
      }
    }
    return newList;
  }
}
