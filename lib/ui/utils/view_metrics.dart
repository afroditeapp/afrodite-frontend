

import 'package:app/ui/utils/view_metrics/view_multiple_metrics.dart';
import 'package:app/ui/utils/view_metrics/view_single_metric.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/result.dart';


class ViewMetricsScreen extends StatefulWidget {
  final String title;
  final GetMetrics metrics;
  const ViewMetricsScreen({required this.title, required this.metrics, super.key});

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
          if (!viewSingle) ViewMultipleMetricsActions(
            controller: _multipleController,
          ),
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
          )
        ],
      ),
      body: showState(),
    );
  }

  Widget showState() {
    final data = _currentData;
    if (data == null || isLoading) {
      return buildProgressIndicator();
    } else if (isError) {
      return Center(child: Text("Error"));
    } else {
      return displayData(data);
    }
  }

  Widget buildProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
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

  List<FlSpot> getValues();
}
