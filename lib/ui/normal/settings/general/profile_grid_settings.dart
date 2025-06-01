
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';
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
  final pageKey = PageKey();
  return MyNavigator.pushWithKey(
    context,
    const MaterialPage<void>(
      child: ProfileGridSettingsScreen(),
    ),
    pageKey,
  );
}

class ProfileGridSettingsScreen extends StatefulWidget {
  const ProfileGridSettingsScreen({
    super.key,
  });

  @override
  State<ProfileGridSettingsScreen> createState() => _ProfileGridSettingsScreenState();
}

class _ProfileGridSettingsScreenState extends State<ProfileGridSettingsScreen> {

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
            hPad(Text(
              context.strings.profile_grid_settings_screen_all_grids_title,
              style: Theme.of(context).textTheme.titleMedium,
            )),
            const Padding(padding: EdgeInsets.only(top: 16)),
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
      hPad(Text(title)),
      Slider(
        min: 1,
        max: 4,
        divisions: 3,
        value: value.toDouble(),
        onChanged: (v) => onChanged(v.toInt()),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: hPad(Text(
          value.toInt().toString(),
        )),
      )
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
      hPad(Text(title)),
      Slider(
        min: 0,
        max: 20,
        divisions: 20,
        value: value,
        onChanged: onChanged,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: hPad(Text(
          value.toString(),
        )),
      )
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
}
