import 'package:app/utils/list.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/profile/statistics.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/profile/statistics.dart';
import 'package:app/ui_utils/consts/animation.dart';
import 'package:app/ui_utils/list.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/time.dart';
import 'package:utils/utils.dart';

Future<void> openStatisticsScreen(BuildContext context) {
  final pageKey = PageKey();
  return MyNavigator.pushWithKey(
    context,
    MaterialPage<void>(
      child: BlocProvider(
        create: (_) => StatisticsBloc(),
        lazy: false,
        child: const StatisticsScreen(),
      ),
    ),
    pageKey,
  );
}

enum SelectedConnectionStatistics { min, max, average }

enum HourGroup {
  first(0, 5),
  second(6, 11),
  third(12, 17),
  fourth(18, 23);

  final int startIndex;
  final int endIndex;
  const HourGroup(this.startIndex, this.endIndex);

  String uiText() => "$startIndex-$endIndex";
  bool contains(int value) => value >= startIndex && value <= endIndex;

  static HourGroup findLastGroupWithDataOrDefault(ConnectionStatisticsManager data) {
    for (var i = 23; i >= 0; i--) {
      if (data.men(i) != 0 || data.women(i) != 0 || data.nonbinaries(i) != 0) {
        if (HourGroup.fourth.contains(i)) {
          return HourGroup.fourth;
        } else if (HourGroup.third.contains(i)) {
          return HourGroup.third;
        } else if (HourGroup.second.contains(i)) {
          return HourGroup.second;
        } else if (HourGroup.first.contains(i)) {
          return HourGroup.first;
        }
      }
    }
    return HourGroup.fourth;
  }
}

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => StatisticsScreenState();
}

class StatisticsScreenState extends State<StatisticsScreen> {
  final api = LoginRepository.getInstance().repositories.api;

  bool adminGenerateStatistics = false;
  int adminVisibilitySelection = 0;

  HourGroup? startPositionForConnectionStatisticsByGender;
  SelectedConnectionStatistics selectedConnectionStatistics = SelectedConnectionStatistics.max;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.statistics_screen_title)),
      body: content(),
    );
  }

  Widget content() {
    return AnimatedSwitcher(
      duration: ANIMATED_SWITCHER_DEFAULT_DURATION,
      child: BlocBuilder<StatisticsBloc, StatisticsData>(
        builder: (context, state) {
          final item = state.item;
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.isError) {
            return buildListReplacementMessageSimple(
              context,
              context.strings.generic_error_occurred,
            );
          } else if (item == null) {
            return buildListReplacementMessageSimple(context, context.strings.generic_not_found);
          } else {
            return viewItem(context, item);
          }
        },
      ),
    );
  }

  Widget viewItem(BuildContext context, GetProfileStatisticsResult item) {
    final dataTime = fullTimeString(item.generationTime.toUtcDateTime());
    final adminSettingsAvailable = context
        .read<AccountBloc>()
        .state
        .permissions
        .adminProfileStatistics;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (adminSettingsAvailable) adminControls(context),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            Text(
              context.strings.statistics_screen_count_registered_users(
                item.accountCountBotsExcluded.toString(),
              ),
            ),
            Text(
              context.strings.statistics_screen_count_online_users(
                item.onlineAccountCountBotsExcluded.toString(),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            const Divider(),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            ...usersOnlineStatistics(context, item),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            const Divider(),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            ...publicProfileStatistics(context, item.ageCounts),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            const Divider(),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            Text(context.strings.statistics_screen_time(dataTime)),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          ],
        ),
      ),
    );
  }

  List<Widget> usersOnlineStatistics(BuildContext context, GetProfileStatisticsResult statistics) {
    final ConnectionStatistics connections = switch (selectedConnectionStatistics) {
      SelectedConnectionStatistics.min => statistics.connectionsMin,
      SelectedConnectionStatistics.max => statistics.connectionsMax,
      SelectedConnectionStatistics.average => statistics.connectionsAverage,
    };
    final data = ConnectionStatisticsManager.create(connections);

    final hourGroup =
        startPositionForConnectionStatisticsByGender ??
        HourGroup.findLastGroupWithDataOrDefault(data);
    startPositionForConnectionStatisticsByGender = hourGroup;

    return [
      Text(context.strings.statistics_screen_online_users_per_hour_statistics_title),
      const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
      Center(
        child: SegmentedButton<SelectedConnectionStatistics>(
          segments: [
            ButtonSegment(
              value: SelectedConnectionStatistics.min,
              label: Text(context.strings.generic_min),
            ),
            ButtonSegment(
              value: SelectedConnectionStatistics.average,
              label: Text(context.strings.generic_average),
            ),
            ButtonSegment(
              value: SelectedConnectionStatistics.max,
              label: Text(context.strings.generic_max),
            ),
          ],
          selected: {selectedConnectionStatistics},
          onSelectionChanged: (selected) {
            setState(() {
              selectedConnectionStatistics = selected.first;
            });
          },
          showSelectedIcon: false,
        ),
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
      getChart(
        context,
        () {
          final groups = <BarChartGroupData>[];
          for (final (localHour, _) in connections.all.indexed) {
            groups.add(
              BarChartGroupData(
                x: localHour,
                barRods: [
                  BarChartRodData(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    toY: data.all(localHour).toDouble(),
                  ),
                ],
              ),
            );
          }
          return groups;
        },
        (localHour, rods) {
          var text = "";
          text = appendToString(text, context.strings.statistics_screen_hour_value, localHour);
          text = appendToStringIfNotZero(
            text,
            context.strings.statistics_screen_count_online_users_bar_chart_tooltip,
            data.all(localHour),
          );
          return text.trim();
        },
        (i) {
          if (i == 23) {
            return i.toString();
          }
          return (i % 3) == 0 ? i.toString() : null;
        },
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
      getChart(
        context,
        () {
          final groups = <BarChartGroupData>[];
          for (final (i, _) in connections.all.skip(hourGroup.startIndex).take(6).indexed) {
            final localHour = hourGroup.startIndex + i;
            groups.add(
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(color: Colors.lightBlue, toY: data.men(localHour).toDouble()),
                  BarChartRodData(color: Colors.pink, toY: data.women(localHour).toDouble()),
                  BarChartRodData(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    toY: data.nonbinaries(localHour).toDouble(),
                  ),
                ],
              ),
            );
          }
          return groups;
        },
        (i, rods) {
          final localHour = hourGroup.startIndex + i;
          var text = "";
          text = appendToString(text, context.strings.statistics_screen_hour_value, localHour);
          text = appendToStringIfNotZero(
            text,
            context.strings.statistics_screen_count_men,
            data.men(localHour),
          );
          text = appendToStringIfNotZero(
            text,
            context.strings.statistics_screen_count_women,
            data.women(localHour),
          );
          text = appendToStringIfNotZero(
            text,
            context.strings.statistics_screen_count_nonbinaries,
            data.nonbinaries(localHour),
          );
          return text.trim();
        },
        (i) {
          final hour = hourGroup.startIndex + i;
          return hour.toString();
        },
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
      Center(
        child: SegmentedButton<HourGroup>(
          segments: [
            ButtonSegment(value: HourGroup.first, label: Text(HourGroup.first.uiText())),
            ButtonSegment(value: HourGroup.second, label: Text(HourGroup.second.uiText())),
            ButtonSegment(value: HourGroup.third, label: Text(HourGroup.third.uiText())),
            ButtonSegment(value: HourGroup.fourth, label: Text(HourGroup.fourth.uiText())),
          ],
          selected: {hourGroup},
          onSelectionChanged: (selected) {
            setState(() {
              startPositionForConnectionStatisticsByGender = selected.first;
            });
          },
          showSelectedIcon: false,
        ),
      ),
    ];
  }

  List<Widget> publicProfileStatistics(BuildContext context, ProfileAgeCounts ageCounts) {
    final data = AgeGroupManager();
    for (final (i, manCount) in ageCounts.men.indexed) {
      final age = ageCounts.startAge + i;
      data.addMen(age, manCount);
      final womanCount = ageCounts.women.getAtOrNull(i) ?? 0;
      data.addWomen(age, womanCount);
      final nonbinariesCount = ageCounts.nonbinaries.getAtOrNull(i) ?? 0;
      data.addNonbinaries(age, nonbinariesCount);
    }

    final profileCount = data.total();

    final String Function(String) currentCountFunction;
    if (adminVisibilitySelection == 0) {
      currentCountFunction = context.strings.statistics_screen_count_public_profiles;
    } else if (adminVisibilitySelection == 1) {
      currentCountFunction = context.strings.statistics_screen_count_private_profiles;
    } else if (adminVisibilitySelection == 2) {
      currentCountFunction = context.strings.statistics_screen_count_all_profiles;
    } else {
      currentCountFunction = (_) => context.strings.generic_error;
    }

    return [
      Text(currentCountFunction(profileCount.toString())),
      const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
      getChart(
        context,
        () {
          final groups = <BarChartGroupData>[];
          for (final (i, g) in data.groups.indexed) {
            groups.add(
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    toY: g.total().toDouble(),
                  ),
                ],
              ),
            );
          }
          return groups;
        },
        (i, rods) {
          var text = "";
          text = appendStringToString(
            text,
            context.strings.statistics_screen_age_range(data.groups[i].group().uiText()),
          );
          text = appendToStringIfNotZero(text, currentCountFunction, rods[0].toY.toInt());
          return text.trim();
        },
        (i) => data.groups[i].group().uiText(),
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
      Text(context.strings.statistics_screen_count_men(data.totalMan().toString())),
      Text(context.strings.statistics_screen_count_women(data.totalWoman().toString())),
      Text(context.strings.statistics_screen_count_nonbinaries(data.totalNonbinaries().toString())),
      const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
      getChart(
        context,
        () {
          final groups = <BarChartGroupData>[];
          for (final (i, g) in data.groups.indexed) {
            groups.add(
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(color: Colors.lightBlue, toY: g.men().toDouble()),
                  BarChartRodData(color: Colors.pink, toY: g.women().toDouble()),
                  BarChartRodData(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    toY: g.nonbinaries().toDouble(),
                  ),
                ],
              ),
            );
          }
          return groups;
        },
        (i, rods) {
          var text = "";
          text = appendStringToString(
            text,
            context.strings.statistics_screen_age_range(data.groups[i].group().uiText()),
          );
          text = appendToStringIfNotZero(
            text,
            context.strings.statistics_screen_count_men,
            rods[0].toY.toInt(),
          );
          text = appendToStringIfNotZero(
            text,
            context.strings.statistics_screen_count_women,
            rods[1].toY.toInt(),
          );
          text = appendToStringIfNotZero(
            text,
            context.strings.statistics_screen_count_nonbinaries,
            rods[2].toY.toInt(),
          );
          return text.trim();
        },
        (i) => data.groups[i].group().uiText(),
      ),
    ];
  }

  Widget getChart(
    BuildContext context,
    List<BarChartGroupData> Function() dataBuilder,
    String Function(int groupIndex, List<BarChartRodData> values) tooltipBuilder,
    String? Function(int index) groupTitleBuilder,
  ) {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          barGroups: dataBuilder(),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              fitInsideHorizontally: true,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  tooltipBuilder(groupIndex, group.barRods),
                  Theme.of(context).textTheme.labelLarge!,
                );
              },
              getTooltipColor: (group) {
                return Theme.of(context).colorScheme.primaryContainer;
              },
            ),
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                minIncluded: false,
                maxIncluded: false,
                reservedSize: 44,
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                minIncluded: false,
                maxIncluded: false,
                reservedSize: 44,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1.0,
                getTitlesWidget: (value, meta) {
                  final title = groupTitleBuilder(value.toInt());
                  if (title != null) {
                    return Padding(padding: const EdgeInsets.only(top: 2), child: Text(title));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget adminControls(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Admin settings", style: Theme.of(context).textTheme.titleLarge),
        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        CheckboxListTile(
          title: const Text("Show only fresh statistics"),
          value: adminGenerateStatistics,
          onChanged: (value) {
            setState(() {
              adminGenerateStatistics = value ?? false;
              reload(context);
            });
          },
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Profile visibility for profile statistics",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 5.0,
            children: List<ChoiceChip>.generate(StatisticsProfileVisibility.values.length, (i) {
              return ChoiceChip(
                label: Text(StatisticsProfileVisibility.values[i].toString()),
                selected: adminVisibilitySelection == i,
                onSelected: (value) {
                  setState(() {
                    adminVisibilitySelection = i;
                    reload(context);
                  });
                },
              );
            }),
          ),
        ),
        const Divider(),
      ],
    );
  }

  void reload(BuildContext context) {
    context.read<StatisticsBloc>().add(
      Reload(
        adminRefresh: true,
        generateNew: adminGenerateStatistics,
        visibility: StatisticsProfileVisibility.values[adminVisibilitySelection],
      ),
    );
  }

  String appendStringToString(String current, String value) {
    return "$current$value\n";
  }

  String appendToString(String current, String Function(String) getText, int value) {
    final text = getText(value.toString());
    return "$current$text\n";
  }

  String appendToStringIfNotZero(String current, String Function(String) getText, int value) {
    if (value == 0) {
      return current;
    } else {
      final text = getText(value.toString());
      return "$current$text\n";
    }
  }
}

class AgeGroup {
  final int min;
  final int max;
  const AgeGroup(this.min, this.max);

  static const visibleGroups = [
    AgeGroup(18, 29),
    AgeGroup(30, 39),
    AgeGroup(40, 49),
    AgeGroup(50, 59),
    AgeGroup(60, 99),
  ];

  String uiText() {
    return "$min-$max";
  }

  bool includes(int age) {
    return age >= min && age <= max;
  }
}

class AgeGroupAndValues {
  final AgeGroup _group;
  int _men = 0;
  int _women = 0;
  int _nonbinaries = 0;
  AgeGroupAndValues(this._group);

  void addMen(int value) {
    _men += value;
  }

  void addWomen(int value) {
    _women += value;
  }

  void addNonbinaries(int value) {
    _nonbinaries += value;
  }

  bool includes(int age) {
    return _group.includes(age);
  }

  AgeGroup group() => _group;
  int men() => _men;
  int women() => _women;
  int nonbinaries() => _nonbinaries;
  int total() => _men + _women + _nonbinaries;
}

class AgeGroupManager {
  List<AgeGroupAndValues> groups;
  AgeGroupManager._(this.groups);

  factory AgeGroupManager() {
    return AgeGroupManager._(AgeGroup.visibleGroups.map((v) => AgeGroupAndValues(v)).toList());
  }

  void addMen(int age, int value) {
    for (final group in groups) {
      if (group.includes(age)) {
        group.addMen(value);
      }
    }
  }

  void addWomen(int age, int value) {
    for (final group in groups) {
      if (group.includes(age)) {
        group.addWomen(value);
      }
    }
  }

  void addNonbinaries(int age, int value) {
    for (final group in groups) {
      if (group.includes(age)) {
        group.addNonbinaries(value);
      }
    }
  }

  int total() {
    return groups.fold(0, (count, v) => v.total() + count);
  }

  int totalMan() {
    return groups.fold(0, (count, v) => v.men() + count);
  }

  int totalWoman() {
    return groups.fold(0, (count, v) => v.women() + count);
  }

  int totalNonbinaries() {
    return groups.fold(0, (count, v) => v.nonbinaries() + count);
  }
}

class ConnectionStatisticsManager {
  final ConnectionStatistics _data;
  final int _currentUtcOffset;

  ConnectionStatisticsManager._(this._data, this._currentUtcOffset);

  factory ConnectionStatisticsManager.create(ConnectionStatistics data) {
    final utcOffset = UtcDateTime.now().dateTime.toLocal().timeZoneOffset.inHours;
    return ConnectionStatisticsManager._(data, utcOffset);
  }

  int _getUsingLocalHour(int localHour, List<int> data) {
    final utcHour = ((localHour - _currentUtcOffset) % 24).abs();
    return data[utcHour];
  }

  int all(int localHour) => _getUsingLocalHour(localHour, _data.all);
  int men(int localHour) => _getUsingLocalHour(localHour, _data.men);
  int women(int localHour) => _getUsingLocalHour(localHour, _data.women);
  int nonbinaries(int localHour) => _getUsingLocalHour(localHour, _data.nonbinaries);
}
