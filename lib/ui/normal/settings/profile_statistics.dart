

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/profile/profile_statistics.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/profile_statistics.dart';
import 'package:pihka_frontend/ui_utils/consts/animation.dart';
import 'package:pihka_frontend/ui_utils/list.dart';
import 'package:pihka_frontend/utils/api.dart';
import 'package:pihka_frontend/utils/time.dart';


Future<void> openProfileStatisticsScreen(
  BuildContext context,
) {
  final pageKey = PageKey();
  return MyNavigator.pushWithKey(
    context,
    MaterialPage<void>(
      child: BlocProvider(
        create: (_) => ProfileStatisticsBloc(),
        lazy: false,
        child: const ProfileStatisticsScreen(),
      ),
    ),
    pageKey,
  );
}

class ProfileStatisticsScreen extends StatefulWidget {
  const ProfileStatisticsScreen({super.key});

  @override
  State<ProfileStatisticsScreen> createState() => ProfileStatisticsScreenState();
}

class ProfileStatisticsScreenState extends State<ProfileStatisticsScreen> {
  final api = LoginRepository.getInstance().repositories.api;

  bool adminGenerateStatistics = false;
  int adminVisibilitySelection = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.profile_statistics_screen_title),
      ),
      body: content(),
    );
  }

  Widget content() {
    return AnimatedSwitcher(
      duration: ANIMATED_SWITCHER_DEFAULT_DURATION,
      child: BlocBuilder<ProfileStatisticsBloc, ProfileStatisticsData>(
        builder: (context, state) {
          final item = state.item;
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.isError) {
            return buildListReplacementMessageSimple(
              context, context.strings.generic_error_occurred
            );
          } else if (item == null) {
            return buildListReplacementMessageSimple(
              context, context.strings.generic_not_found
            );
          } else {
            return viewItem(context, item);
          }
        }
      ),
    );
  }

  Widget viewItem(BuildContext context, GetProfileStatisticsResult item) {
    final dataTime = fullTimeString(item.generationTime.toUtcDateTime());
    final publicProfiles = item.publicProfileCounts.man +
      item.publicProfileCounts.woman +
      item.publicProfileCounts.nonBinary;
    final adminSettingsAvailable = context.read<AccountBloc>().state.permissions.adminProfileStatistics;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (adminSettingsAvailable) adminControls(context),
            Text(context.strings.profile_statistics_screen_time(dataTime)),
            Text(context.strings.profile_statistics_screen_count_account(item.accountCount.toString())),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            Text(
              context.strings.profile_statistics_screen_profiles_subtitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            Text(context.strings.profile_statistics_screen_count_man(item.publicProfileCounts.man.toString())),
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            getChart(context, item.ageCounts.startAge, item.ageCounts.man),
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            Text(context.strings.profile_statistics_screen_count_woman(item.publicProfileCounts.woman.toString())),
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            getChart(context, item.ageCounts.startAge, item.ageCounts.woman),
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            Text(context.strings.profile_statistics_screen_count_non_binary(item.publicProfileCounts.nonBinary.toString())),
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            getChart(context, item.ageCounts.startAge, item.ageCounts.nonBinary),
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            Text(context.strings.profile_statistics_screen_count_profiles(publicProfiles.toString())),
          ],
        ),
      )
    );
  }

  Widget getChart(BuildContext context, int startAge, List<int> counts) {
    final data = <BarChartGroupData>[];
    for (final (i, c) in counts.indexed) {
      final age = startAge + i;
      data.add(BarChartGroupData(
        x: age,
        barRods: [BarChartRodData(
          color: Theme.of(context).colorScheme.primaryContainer,
          toY: c.toDouble(),
        )],
      ));
    }

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          barGroups: data,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              fitInsideHorizontally: true,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  context.strings.profile_statistics_screen_count_bar_chart_tooltip(
                    rod.toY.toInt().toString(),
                    group.x.toString()
                  ),
                  Theme.of(context).textTheme.labelLarge!,
                );
              },
              getTooltipColor: (group) {
                return Theme.of(context).colorScheme.primaryContainer;
              }
            )
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                minIncluded: false,
                maxIncluded: false,
                reservedSize: 44
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                minIncluded: false,
                maxIncluded: false,
                reservedSize: 44
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1.0,
                minIncluded: false,
                maxIncluded: false,
                getTitlesWidget: (value, meta) {
                  final minIncluded = meta.sideTitles.minIncluded && value == startAge;
                  final maxIncluded = meta.sideTitles.maxIncluded && value == startAge + counts.length - 1;
                  if (minIncluded || maxIncluded || value.toInt() % 10 == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(value.toInt().toString()),
                    );
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
        Text(
          "Admin settings",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        CheckboxListTile(
          title: const Text("Show only fresh statistics"),
          value: adminGenerateStatistics,
          onChanged: (value) {
            setState(() {
              adminGenerateStatistics = value ?? false;
              reload(context);
            });
        }),
        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Bar chart included profiles",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 5.0,
            children: List<ChoiceChip>.generate(
              StatisticsProfileVisibility.values.length,
                (i) {
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
                },
              ),
          ),
        ),
        const Divider(),
        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
      ],
    );
  }

  void reload(BuildContext context) {
    context.read<ProfileStatisticsBloc>().add(Reload(
      adminRefresh: true,
      generateNew: adminGenerateStatistics,
      visibility: StatisticsProfileVisibility.values[adminVisibilitySelection],
    ));
  }
}
