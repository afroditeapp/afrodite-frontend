import 'package:app/ui/utils/view_metrics.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/time.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class ViewSingleMetricController {
  final TextEditingController textEditingController = TextEditingController();
  List<(int, Metric)> filteredList = [];
  int? selectedIndexFromAllData = 0;

  void updateData(List<Metric>? currentData, List<Metric> newData) {
    final currentName = _currentlySelectedName(currentData);

    // Update filtered list
    final filterText = textEditingController.text;
    if (filterText.isEmpty) {
      filteredList = newData.indexed.toList();
    } else {
      filteredList = newData.indexed.where((indexAndCounter) {
        final name = indexAndCounter.$2.name;
        return name.toLowerCase().contains(filterText.toLowerCase());
      }).toList();
    }

    // Try to select the same item as before
    selectedIndexFromAllData = null;
    if (currentName.isNotEmpty) {
      final item = filteredList.where((element) => element.$2.name == currentName).firstOrNull;
      selectedIndexFromAllData = item?.$1;
    }

    if (selectedIndexFromAllData == null && newData.isNotEmpty) {
      selectedIndexFromAllData = 0;
    }
  }

  String _currentlySelectedName(List<Metric>? currentData) {
    return currentData?[selectedIndexFromAllData ?? 0].name ?? "";
  }
}

class ViewSingleMetric extends StatefulWidget {
  final List<Metric> metrics;
  final ViewSingleMetricController controller;
  const ViewSingleMetric({required this.metrics, required this.controller, super.key});

  @override
  State<ViewSingleMetric> createState() => _ViewSingleMetricState();
}

class _ViewSingleMetricState extends State<ViewSingleMetric> {
  @override
  Widget build(BuildContext context) {
    return displayData(context, widget.metrics);
  }

  Widget displayData(BuildContext context, List<Metric> metrics) {
    if (metrics.isEmpty) {
      return const Center(child: Text("No data"));
    }

    final Widget chart;
    final selectedIndex = widget.controller.selectedIndexFromAllData;
    if (selectedIndex == null) {
      chart = Container();
    } else {
      final selected = metrics[selectedIndex];
      chart = getChart(context, selected);
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: widget.controller.textEditingController,
            decoration: const InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              // Filter the visible items based on the search value
              setState(() {
                widget.controller.filteredList = metrics.indexed.where((indexAndCounter) {
                  final name = indexAndCounter.$2.name;
                  return value.isEmpty || name.toLowerCase().contains(value.toLowerCase());
                }).toList();
                widget.controller.selectedIndexFromAllData =
                    widget.controller.filteredList.firstOrNull?.$1;
              });
            },
            onTapOutside: (_) {
              FocusScope.of(context).unfocus();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            isExpanded: true,
            value: widget.controller.selectedIndexFromAllData?.toString(),
            onChanged: (newValue) {
              if (newValue == null) {
                return;
              }
              final index = int.parse(newValue);
              setState(() {
                widget.controller.selectedIndexFromAllData = index;
              });
            },
            items: widget.controller.filteredList.map<DropdownMenuItem<String>>((value) {
              final (index, counter) = value;
              return DropdownMenuItem<String>(value: index.toString(), child: Text(counter.name));
            }).toList(),
          ),
        ),
        Expanded(
          child: Padding(padding: const EdgeInsets.all(8.0), child: chart),
        ),
      ],
    );
  }

  Widget getChart(BuildContext context, Metric value) {
    final data = value.getValues();
    final diff = data.last.x - data.first.x;
    final xAxisCenterAreaMin = data.first.x + diff / 3;
    final xAxisCenterAreaMax = data.first.x + (diff / 3) * 2;
    final xAxisTitleInterval = diff / 3;
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                final utcTime = UnixTime(ut: touchedSpot.x.toInt()).toUtcDateTime();
                final time = "${timeString(utcTime)}, ${touchedSpot.y.toInt()}";
                return LineTooltipItem(time, Theme.of(context).textTheme.labelLarge!);
              }).toList();
            },
          ),
        ),
        lineBarsData: [LineChartBarData(spots: data, isCurved: false, barWidth: 4)],
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 44,
              interval: xAxisTitleInterval != 0 ? xAxisTitleInterval : null,
              getTitlesWidget: (value, meta) {
                final upperTimeText =
                    value == data.first.x ||
                    value == data.last.x ||
                    (value >= xAxisCenterAreaMin && value <= xAxisCenterAreaMax);
                final utcTime = UnixTime(ut: value.toInt()).toUtcDateTime();
                final timeText = timeString(utcTime);
                if (upperTimeText) {
                  return Padding(padding: const EdgeInsets.only(top: 4), child: Text(timeText));
                } else {
                  return Padding(padding: const EdgeInsets.only(top: 22), child: Text(timeText));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
