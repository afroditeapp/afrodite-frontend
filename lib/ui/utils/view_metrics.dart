

import 'package:app/utils/api.dart';
import 'package:app/utils/time.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/result.dart';
import 'package:openapi/api.dart';


class ViewMetricsScreen extends StatefulWidget {
  final String title;
  final GetMetrics metrics;
  const ViewMetricsScreen({required this.title, required this.metrics, super.key});

  @override
  State<ViewMetricsScreen> createState() => _ViewMetricsScreenState();
}

class _ViewMetricsScreenState extends State<ViewMetricsScreen> {

  final TextEditingController _controller = TextEditingController();

  List<Metric>? _currentData;
  List<(int, Metric)> filteredList = [];
  int? selectedIndexFromAllData = 0;

  Future<void> updateData() async {
    final data = await widget.metrics.getMetrics();
    final currentName = currentlySelectedName();
    setState(() {
      _currentData = data.ok();

      // Update filtered list
      final list = data.ok() ?? [];
      final filterText = _controller.text;
      if (filterText.isEmpty) {
        filteredList = list.indexed.toList();
      } else {
        filteredList = list
            .indexed
            .where((indexAndCounter) {
              final name = indexAndCounter.$2.name;
              return name.toLowerCase().contains(filterText.toLowerCase());
            })
            .toList();
      }

      // Try to select the same item as before
      selectedIndexFromAllData = null;
      if (currentName.isNotEmpty) {
        final item = filteredList.where(
          (element) => element.$2.name == currentName,
        ).firstOrNull;
        selectedIndexFromAllData = item?.$1;
      }
    });
  }

  String currentlySelectedName() {
    return _currentData?[selectedIndexFromAllData ?? 0].name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    final data = _currentData;
    if (data == null) {
      body = loadInitialData();
    } else {
      body = displayDataWithRefreshIndicator(data);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () async {
              await updateData();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: body,
    );
  }

  Widget loadInitialData() {
    return FutureBuilder(
      future: widget.metrics.getMetrics(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active || ConnectionState.waiting: {
            return buildProgressIndicator();
          }
          case ConnectionState.none || ConnectionState.done: {
            final data = snapshot.data?.ok();
            if (data != null) {
              _currentData = data;
              // Change widget tree so that data is displayed in the final
              // position. This fill fix keyboard closing after one character.
              Future.delayed(Duration.zero, () async {
                await updateData();
              });
              return displayDataWithRefreshIndicator(data);
            }
            return const Text("Error");
          }
        }
      }
    );
  }

  Widget buildProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget displayDataWithRefreshIndicator(List<Metric> metrics) {
    return RefreshIndicator(
      onRefresh: () async {
        await updateData();
      },
      child: displayData(context, metrics),
    );
  }

  Widget displayData(BuildContext context, List<Metric> metrics) {
    if (metrics.isEmpty) {
      return const Center(
        child: Text("No data"),
      );
    }

    final Widget chart;
    final selectedIndex = selectedIndexFromAllData;
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
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              // Filter the visible items based on the search value
              setState(() {
                filteredList = metrics
                    .indexed
                    .where((indexAndCounter) {
                      final name = indexAndCounter.$2.name;
                      return value.isEmpty || name.toLowerCase().contains(value.toLowerCase());
                    })
                    .toList();
                selectedIndexFromAllData = filteredList.firstOrNull?.$1;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            isExpanded: true,
            value: selectedIndexFromAllData?.toString(),
            onChanged: (newValue) {
              if (newValue == null) {
                return;
              }
              final index = int.parse(newValue);
              setState(() {
                selectedIndexFromAllData = index;
              });
            },
            items: filteredList.map<DropdownMenuItem<String>>((value) {
              final (index, counter) = value;
              return DropdownMenuItem<String>(
                value: index.toString(),
                child: Text(counter.name),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: chart,
          )
        ),
      ],
    );
  }

  Widget getChart(BuildContext context, Metric value) {
    final data = value.getValues();
    var upperTimeText = true;

    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                final utcTime = UnixTime(ut: touchedSpot.x.toInt()).toUtcDateTime();
                final time = "${timeString(utcTime)}, ${touchedSpot.y.toInt()}";
                return LineTooltipItem(
                  time,
                  Theme.of(context).textTheme.labelLarge!,
                );
              }).toList();
            },
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: data,
            isCurved: false,
            barWidth: 4,
          ),
        ],
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 44,
              getTitlesWidget: (value, meta) {
                if (value == data[0].x) {
                  upperTimeText = true;
                }
                final date = DateTime.fromMillisecondsSinceEpoch(value.toInt() * 1000, isUtc: true);
                final time = date.toUtc();
                // Add zero padding to formatting string
                final timeText = "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                if (upperTimeText) {
                  upperTimeText = false;
                  return Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: Text(timeText),
                  );
                } else {
                  upperTimeText = true;
                  return Padding(
                    padding: const EdgeInsets.only(top: 2),
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

abstract class GetMetrics {
  Future<Result<List<Metric>, void>> getMetrics();
}

abstract class Metric {
  String get name;

  List<FlSpot> getValues();
}
