
import 'package:app/logic/profile/profile_filters.dart';
import 'package:app/model/freezed/logic/profile/profile_filters.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui/normal/settings/general/image_settings.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/settings/ui_settings.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/settings/ui_settings.dart';

Future<void> openProfileGridSettingsScreen(
  BuildContext context,
) {
  final bloc = context.read<ProfileFiltersBloc>();
  bloc.add(ResetEditedValues());
  final pageKey = PageKey();
  return MyNavigator.pushWithKey(
    context,
    MaterialPage<void>(
      child: ProfileGridSettingsScreen(
        initialProfileFiltersUpdateState: bloc.state.updateState,
      ),
    ),
    pageKey,
  );
}

class ProfileGridSettingsScreen extends StatefulWidget {
  final UpdateState initialProfileFiltersUpdateState;
  const ProfileGridSettingsScreen({
    required this.initialProfileFiltersUpdateState,
    super.key,
  });

  @override
  State<ProfileGridSettingsScreen> createState() => _ProfileGridSettingsScreenState();
}

class _ProfileGridSettingsScreenState extends State<ProfileGridSettingsScreen> {

  UpdateState previousProfileFiltersUpdateState = const UpdateIdle();

  @override
  void initState() {
    super.initState();
    previousProfileFiltersUpdateState = widget.initialProfileFiltersUpdateState;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.profile_grid_settings_screen_title),
      ),
      body: SingleChildScrollView(
        child: content(context),
      ),
    );
  }

  Widget content(BuildContext context) {
    return BlocBuilder<UiSettingsBloc, UiSettingsData>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            settingsCategoryTitle(context, context.strings.profile_grid_settings_screen_all_grids_title),
            const Padding(padding: EdgeInsets.only(top: 8)),
            ...intSlider(
              context,
              context.strings.profile_grid_settings_screen_row_profile_count,
              (value) => context.read<UiSettingsBloc>().add(UpdateRowProfileCount(value)),
              () => state.gridSettings.valueRowProfileCount(),
            ),
            ...doubleSlider(
              context,
              context.strings.profile_grid_settings_screen_horizontal_padding,
              (value) => context.read<UiSettingsBloc>().add(UpdateHorizontalPadding(value)),
              () => state.gridSettings.valueHorizontalPadding(),
            ),
            ...doubleSlider(
              context,
              context.strings.profile_grid_settings_screen_internal_padding,
              (value) => context.read<UiSettingsBloc>().add(UpdateInternalPadding(value)),
              () => state.gridSettings.valueInternalPadding(),
            ),
            ...doubleSlider(
              context,
              context.strings.profile_grid_settings_screen_profile_thumbnail_border_radius,
              (value) => context.read<UiSettingsBloc>().add(UpdateProfileThumbnailBorderRadius(value)),
              () => state.gridSettings.valueProfileThumbnailBorderRadius(),
            ),
            resetToDefaults(context),
            settingsCategoryTitle(context, context.strings.profile_grid_settings_screen_profiles_screen),
            randomProfileOrderSetting(context),
          ],
        );
      }
    );
  }

  List<Widget> intSlider(
    BuildContext context,
    String title,
    void Function(int) onChanged,
    int Function() getValue,
  ) {
    final value = getValue();
    return [
      hPad(TitleWithValue(title: title, value: value.toInt().toString())),
      Slider(
        min: 1,
        max: 4,
        divisions: 3,
        value: value.toDouble(),
        onChanged: (v) => onChanged(v.toInt()),
      ),
    ];
  }

  List<Widget> doubleSlider(
    BuildContext context,
    String title,
    void Function(double) onChanged,
    double Function() getValue,
  ) {
    final value = getValue();
    return [
      hPad(TitleWithValue(title: title, value: value.toString())),
      Slider(
        min: 0,
        max: 20,
        divisions: 20,
        value: value,
        onChanged: onChanged,
      ),
    ];
  }

  Widget resetToDefaults(BuildContext context) {
    return ListTile(
      title: Text(context.strings.generic_reset_to_defaults),
      onTap: () async {
        final accepted = await showConfirmDialog(
          context,
          context.strings.generic_reset_to_defaults_dialog_title,
        );
        if (accepted == true && context.mounted) {
          context.read<UiSettingsBloc>().add(ResetGridSettings());
        }
      },
    );
  }

  Widget randomProfileOrderSetting(BuildContext context) {
    return BlocBuilder<ProfileFiltersBloc, ProfileFiltersData>(
      builder: (context, state) {
        if (previousProfileFiltersUpdateState is! UpdateIdle && state.updateState is UpdateIdle) {
          showSnackBar(context.strings.generic_setting_saved);
        }
        previousProfileFiltersUpdateState = state.updateState;

        return SwitchListTile(
          title: Text(context.strings.profile_grid_settings_screen_random_profile_order),
          subtitle: state.valueRandomProfileOrder() ?
            Text(context.strings.profile_grid_settings_screen_random_profile_order_description_enabled) :
            Text(context.strings.profile_grid_settings_screen_random_profile_order_description_disabled),
          secondary: const Icon(Icons.shuffle),
          value: state.valueRandomProfileOrder(),
          onChanged: (bool value) {
            if (state.updateState is! UpdateIdle) {
              showSnackBar(context.strings.generic_previous_action_in_progress);
            } else {
              context.read<ProfileFiltersBloc>().add(SetRandomProfileOrderAndSaveSettings(value));
            }
          },
        );
      }
    );
  }
}
