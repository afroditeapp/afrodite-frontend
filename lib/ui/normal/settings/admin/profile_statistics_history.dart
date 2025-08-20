import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/profile/profile_statistics_history.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/profile/profile_statistics_history.dart';
import 'package:app/ui_utils/consts/animation.dart';
import 'package:app/ui_utils/dropdown_menu.dart';
import 'package:app/ui_utils/list.dart';
import 'package:app/utils/age.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/time.dart';

Future<void> openProfileStatisticsHistoryScreen(BuildContext context) {
  final pageKey = PageKey();
  return MyNavigator.pushWithKey(
    context,
    MaterialPage<void>(
      child: BlocProvider(
        create: (_) => ProfileStatisticsHistoryBloc(),
        lazy: false,
        child: const ProfileStatisticsHistoryScreen(),
      ),
    ),
    pageKey,
  );
}

class ProfileStatisticsHistoryScreen extends StatefulWidget {
  const ProfileStatisticsHistoryScreen({super.key});

  @override
  State<ProfileStatisticsHistoryScreen> createState() => ProfileStatisticsHistoryScreenState();
}

class ProfileStatisticsHistoryScreenState extends State<ProfileStatisticsHistoryScreen> {
  final api = LoginRepository.getInstance().repositories.api;

  int age = 30;
  int historyValueSelection = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.profile_statistics_history_screen_title)),
      body: content(),
    );
  }

  Widget content() {
    return AnimatedSwitcher(
      duration: ANIMATED_SWITCHER_DEFAULT_DURATION,
      child: BlocBuilder<ProfileStatisticsHistoryBloc, ProfileStatisticsHistoryData>(
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

  Widget viewItem(BuildContext context, GetProfileStatisticsHistoryResult item) {
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
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            getChart(context, item),
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
          ],
        ),
      ),
    );
  }

  Widget getChart(BuildContext context, GetProfileStatisticsHistoryResult item) {
    final data = <FlSpot>[];
    for (final v in item.values) {
      data.add(FlSpot(v.ut.ut.toDouble(), v.c.toDouble()));
    }

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              fitInsideHorizontally: true,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((touchedSpot) {
                  final time = UnixTime(ut: touchedSpot.x.toInt()).toUtcDateTime();
                  final timeStringValue = fullTimeString(time);
                  final value = "$timeStringValue, ${touchedSpot.y}";
                  return LineTooltipItem(value, Theme.of(context).textTheme.labelLarge!);
                }).toList();
              },
              getTooltipColor: (group) {
                return Theme.of(context).colorScheme.primaryContainer;
              },
            ),
          ),
          lineBarsData: [LineChartBarData(spots: data, isCurved: false, barWidth: 4)],
          titlesData: const FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                minIncluded: false,
                maxIncluded: false,
                reservedSize: 44,
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                minIncluded: false,
                maxIncluded: false,
                reservedSize: 44,
              ),
            ),
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
        const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("Select history data", style: Theme.of(context).textTheme.bodyLarge),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 5.0,
            children: List<ChoiceChip>.generate(ProfileStatisticsHistoryValueType.values.length, (
              i,
            ) {
              return ChoiceChip(
                label: Text(ProfileStatisticsHistoryValueType.values[i].toString()),
                selected: historyValueSelection == i,
                onSelected: (value) {
                  setState(() {
                    historyValueSelection = i;
                    reload(context);
                  });
                },
              );
            }),
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        ageField(context),
        const Divider(),
        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
      ],
    );
  }

  Widget ageField(BuildContext context) {
    final currentSelection = ProfileStatisticsHistoryValueType.values[historyValueSelection];
    final ageSupported =
        currentSelection == ProfileStatisticsHistoryValueType.ageChange ||
        currentSelection == ProfileStatisticsHistoryValueType.ageChangeMan ||
        currentSelection == ProfileStatisticsHistoryValueType.ageChangeWoman ||
        currentSelection == ProfileStatisticsHistoryValueType.ageChangeNonBinary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: AgeDropdown(
        getMinValue: () => MIN_AGE,
        getMaxValue: () => MAX_AGE,
        value: age,
        onChanged: (value) {
          age = value;
          reload(context);
        },
        enabled: ageSupported,
      ),
    );
  }

  void reload(BuildContext context) {
    context.read<ProfileStatisticsHistoryBloc>().add(
      Reload(
        historyValue: ProfileStatisticsHistoryValueType.values[historyValueSelection],
        age: age,
        manualRefresh: true,
      ),
    );
  }
}
