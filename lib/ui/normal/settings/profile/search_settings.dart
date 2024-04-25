

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/settings/edit_search_settings.dart';
import 'package:pihka_frontend/logic/settings/search_settings.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/model/freezed/logic/settings/search_settings.dart';
import 'package:pihka_frontend/ui_utils/common_update_logic.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';
import 'package:pihka_frontend/ui_utils/text_field.dart';
import 'package:pihka_frontend/utils/age.dart';


class SearchSettingsScreen extends StatefulWidget {
  final PageKey pageKey;
  final SearchSettingsBloc searchSettingsBloc;
  final EditSearchSettingsBloc editSearchSettingsBloc;
  const SearchSettingsScreen({
    required this.pageKey,
    required this.searchSettingsBloc,
    required this.editSearchSettingsBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchSettingsScreen> createState() => _SearchSettingsScreenState();
}

class _SearchSettingsScreenState extends State<SearchSettingsScreen> {
  String initialMinAge = "";
  String initialMaxAge = "";

  @override
  void initState() {
    super.initState();

    final minAge = widget.searchSettingsBloc.state.minAge;
    final maxAge = widget.searchSettingsBloc.state.maxAge;

    widget.editSearchSettingsBloc.add(SetInitialValues(
      minAge: minAge,
      maxAge: maxAge,
      searchGroups: widget.searchSettingsBloc.state.searchGroups,
    ));

    initialMinAge = minAge?.toString() ?? "";
    initialMaxAge = maxAge?.toString() ?? "";
  }

  void validateAndSaveData(BuildContext context) {
    final s = widget.editSearchSettingsBloc.state;

    final minAge = s.minAge;
    final maxAge = s.maxAge;
    if (minAge == null || maxAge == null || !ageRangeIsValid(minAge, maxAge)) {
      showSnackBar(context.strings.search_settings_screen_age_range_is_invalid);
      return;
    }

    // Check is setting saving needed
    final currentState = widget.searchSettingsBloc.state;
    if (minAge == currentState.minAge && maxAge == currentState.maxAge) {
      MyNavigator.pop(context);
      return;
    }

    context.read<SearchSettingsBloc>().add(SaveSearchSettings(
      minAge: minAge,
      maxAge: maxAge,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        validateAndSaveData(context);
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.strings.search_settings_screen_title)),
        body: updateStateHandler<SearchSettingsBloc, SearchSettingsData>(
          context: context,
          pageKey: widget.pageKey,
          child: edit(context),
        ),
      ),
    );
  }

  Widget edit(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(8)),
          withPadding(Text(context.strings.search_settings_screen_age_range_min_value_title)),
          withPadding(minAgeField()),
          withPadding(Text(context.strings.search_settings_screen_age_range_max_value_title)),
          withPadding(maxAgeField()),
        ],
      ),
    );
  }

  Widget withPadding(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: COMMON_SCREEN_EDGE_PADDING),
      child: child,
    );
  }

  Widget minAgeField() {
    return AgeTextField(
      getInitialValue: () => initialMinAge,
      onChanged: (value) {
        final min = int.tryParse(value);
        context.read<EditSearchSettingsBloc>().add(UpdateMinAge(min));
      },
    );
  }

  Widget maxAgeField() {
    return AgeTextField(
      getInitialValue: () => initialMaxAge,
      onChanged: (value) {
        final max = int.tryParse(value);
        context.read<EditSearchSettingsBloc>().add(UpdateMaxAge(max));
      },
    );
  }
}
