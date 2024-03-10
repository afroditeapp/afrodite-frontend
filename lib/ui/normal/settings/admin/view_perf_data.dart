

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';


class ViewPerfDataPage extends StatefulWidget {
  const ViewPerfDataPage({Key? key}) : super(key: key);

  @override
  _ViewPerfDataPageState createState() => _ViewPerfDataPageState();
}

class _ViewPerfDataPageState extends State<ViewPerfDataPage> {

  final TextEditingController _controller = TextEditingController();

  final Server _selectedServer = Server.account;
  PerfData? _currentData;
  List<(int, PerfHistoryValue)> filteredList = [];
  int? selectedIndexFromAllData = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> updateData() async {
    final data = await getData(_selectedServer);
    final currentName = currentlySelectedName();
    setState(() {
      _currentData = data;

      // Update filtered list
      final list = data?.values ?? [];
      final filterText = _controller.text;
      if (filterText.isEmpty) {
        filteredList = list.indexed.toList();
      } else {
        filteredList = list
            .indexed
            .where((indexAndCounter) {
              final name = indexAndCounter.$2.counterName;
              return name.toLowerCase().contains(filterText.toLowerCase());
            })
            .toList();
      }

      // Try to select the same item as before
      selectedIndexFromAllData = null;
      if (currentName.isNotEmpty) {
        final item = filteredList.where(
          (element) => element.$2.counterName == currentName,
        ).firstOrNull;
        selectedIndexFromAllData = item?.$1;
      }
    });
  }

  String currentlySelectedName() {
    return _currentData?.values[selectedIndexFromAllData ?? 0].counterName ?? "";
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions;
    if (ApiManager.getInstance().inMicroserviceMode()) {
      actions = [];
    } else {
      actions = [];
    }
    actions.add(IconButton(onPressed: () async {
      await updateData();
    }, icon: const Icon(Icons.refresh)));

    Widget body;
    if (_currentData == null) {
      body = loadInitialData();
    } else {
      body = displayData();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Perf history: ${_selectedServer.name}"),
        actions: actions,
      ),
      body: body,
    );
  }


  Widget loadInitialData() {
    return FutureBuilder(
      future: getData(_selectedServer),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active || ConnectionState.waiting: {
            return buildProgressIndicator();
          }
          case ConnectionState.none || ConnectionState.done: {
            final data = snapshot.data;
            if (data != null) {
              _currentData = data;
              // Change widget tree so that data is displayed in the final
              // position. This fill fix keyboard closing after one character.
              Future.delayed(Duration.zero, () async {
                await updateData();
              });
              return displayData();
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

  Widget displayData() {
    return RefreshIndicator(
      onRefresh: () async {
        await updateData();
      },
      child: displayPerfData(context, _currentData!),
    );
  }

  Widget displayPerfData(BuildContext context, PerfData data) {
    if (data.values.isEmpty) {
      return const Center(
        child: Text("No data"),
      );
    }

    final Widget chart;
    if (selectedIndexFromAllData == null) {
      chart = Container();
    } else {
      final selected = data.values[selectedIndexFromAllData!];
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
                filteredList = data
                    .values
                    .indexed
                    .where((indexAndCounter) {
                      final name = indexAndCounter.$2.counterName;
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
                child: Text(counter.counterName),
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

  Widget getChart(BuildContext context, PerfHistoryValue value) {
    final data = <FlSpot>[];
    for (final pointArea in value.values) {
      if (pointArea.timeGranularity == TimeGranularity.hours) {
        throw Exception("Hours granularity not supported");
      }

      for (final (index, point) in pointArea.values.indexed) {
        final time = pointArea.startTime.unixTime + (index * 60);
        data.add(FlSpot(time.toDouble(), point.toDouble()));
      }
    }
    var upperTimeText = true;
    final style = DefaultTextStyle.of(context);

    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                final date = DateTime.fromMillisecondsSinceEpoch(touchedSpot.x.toInt() * 1000, isUtc: true);
                final time = "${date.toIso8601String()}, ${touchedSpot.y}";
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


Future<PerfData?> getData(Server server) async {
  final queryResults = await ApiManager.getInstance().commonAdmin(server, (api) => api.getPerfData());

  if (queryResults == null) {
    return null;
  }

  queryResults.counters.sort((a, b) {
    return a.counterName.compareTo(b.counterName);
  });
  return PerfData(queryResults.counters);
}

class PerfData {
  final List<PerfHistoryValue> values;

  PerfData(
    this.values,
  );
}
