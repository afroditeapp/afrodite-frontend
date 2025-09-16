import 'package:app/data/image_cache.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/logic/profile/profile_filters.dart';
import 'package:app/model/freezed/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/profile/profile_filters.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/extensions/other.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/profile_thumbnail_image_or_error.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/settings/ui_settings.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/settings/ui_settings.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

Future<void> openProfileGridSettingsScreen(BuildContext context) {
  return MyNavigator.push(context, ProfileGridSettingsPage());
}

class ProfileGridSettingsPage extends MyScreenPage<()> {
  ProfileGridSettingsPage() : super(builder: (_) => ProfileGridSettingsScreenOpener());
}

class ProfileGridSettingsScreenOpener extends StatelessWidget {
  const ProfileGridSettingsScreenOpener({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileGridSettingsScreen(bloc: context.read<ProfileFiltersBloc>());
  }
}

class ProfileGridSettingsScreen extends StatefulWidget {
  final ProfileFiltersBloc bloc;
  const ProfileGridSettingsScreen({required this.bloc, super.key});

  @override
  State<ProfileGridSettingsScreen> createState() => _ProfileGridSettingsScreenState();
}

class _ProfileGridSettingsScreenState extends State<ProfileGridSettingsScreen> {
  UpdateState previousProfileFiltersUpdateState = const UpdateIdle();

  @override
  void initState() {
    super.initState();
    widget.bloc.add(ResetEditedValues());
    previousProfileFiltersUpdateState = widget.bloc.state.updateState;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.profile_grid_settings_screen_title)),
      body: SingleChildScrollView(child: content(context)),
    );
  }

  Widget content(BuildContext context) {
    return BlocBuilder<UiSettingsBloc, UiSettingsData>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            settingsCategoryTitle(
              context,
              context.strings.profile_grid_settings_screen_all_grids_title,
            ),
            const Padding(padding: EdgeInsets.only(top: 8)),
            hPad(TitleWithValue(title: context.strings.generic_size)),
            Padding(padding: const EdgeInsets.only(top: 8)),
            hPad(
              gridSettingModeListSettings(
                context,
                [GridSettingMode.large, GridSettingMode.medium, GridSettingMode.small],
                (value) => context.read<UiSettingsBloc>().add(UpdateItemSizeMode(value.toInt())),
                () => state.gridSettings.valueItemSizeMode(),
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 8)),
            hPad(TitleWithValue(title: context.strings.generic_margin)),
            Padding(padding: const EdgeInsets.only(top: 8)),
            hPad(
              gridSettingModeListSettings(
                context,
                [
                  GridSettingMode.large,
                  GridSettingMode.medium,
                  GridSettingMode.small,
                  GridSettingMode.disabled,
                ],
                (value) => context.read<UiSettingsBloc>().add(UpdatePaddingMode(value.toInt())),
                () => state.gridSettings.valuePaddingMode(),
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 8)),
            hPad(TitleWithValue(title: context.strings.generic_preview_noun)),
            Padding(padding: const EdgeInsets.only(top: 8)),
            gridSettingsPreview(context, state.gridSettings),
            resetToDefaults(context),
            settingsCategoryTitle(
              context,
              context.strings.profile_grid_settings_screen_profiles_screen,
            ),
            randomProfileOrderSetting(context),
          ],
        );
      },
    );
  }

  Widget gridSettingModeListSettings(
    BuildContext context,
    List<GridSettingMode> modes,
    void Function(GridSettingMode) onChanged,
    GridSettingMode Function() getValue,
  ) {
    return Wrap(
      spacing: 5.0,
      children: modes.map((m) {
        return ChoiceChip(
          label: Text(gridSettingModeUiText(context, m)),
          selected: getValue() == m,
          onSelected: (value) {
            onChanged(m);
          },
        );
      }).toList(),
    );
  }

  String gridSettingModeUiText(BuildContext context, GridSettingMode mode) {
    return switch (mode) {
      GridSettingMode.small => context.strings.generic_small,
      GridSettingMode.medium => context.strings.generic_medium,
      GridSettingMode.large => context.strings.generic_large,
      GridSettingMode.disabled => context.strings.generic_disabled,
    };
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

  Widget gridSettingsPreview(BuildContext context, GridSettings gridSettings) {
    return BlocBuilder<MyProfileBloc, MyProfileData>(
      builder: (context, myProfileState) {
        final entry = myProfileState.profile;
        if (entry == null) {
          return SizedBox.shrink();
        }
        return PagedGridView(
          state: PagingState<int, void>(
            pages: [List.generate(gridSettings.valueRowProfileCount(), (i) => i)],
            keys: [0],
            hasNextPage: false,
            isLoading: false,
          ),
          fetchNextPage: () => (),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: gridSettings.valueHorizontalPadding()),
          builderDelegate: PagedChildBuilderDelegate<void>(
            animateTransitions: true,
            itemBuilder: (context, item, index) {
              return ProfileThumbnailImageOrError.fromProfileEntry(
                entry: entry,
                borderRadius: BorderRadius.circular(
                  gridSettings.valueProfileThumbnailBorderRadius(),
                ),
                cacheSize: ImageCacheSize.maxDisplaySize(),
              );
            },
          ),
          gridDelegate: gridSettings.toSliverGridDelegate(context, itemWidth: null),
        );
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
          subtitle: state.valueRandomProfileOrder()
              ? Text(
                  context
                      .strings
                      .profile_grid_settings_screen_random_profile_order_description_enabled,
                )
              : Text(
                  context
                      .strings
                      .profile_grid_settings_screen_random_profile_order_description_disabled,
                ),
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
      },
    );
  }
}

class TitleWithValue extends StatelessWidget {
  final String title;
  final String? value;
  final bool isEnabled;
  const TitleWithValue({required this.title, this.value, this.isEnabled = true, super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = isEnabled ? null : TextStyle(color: Theme.of(context).disabledColor);
    final currentValue = value;
    return Row(
      children: [
        Text(title, style: textStyle),
        if (currentValue != null) const Spacer(),
        if (currentValue != null) Text(currentValue, style: textStyle),
      ],
    );
  }
}
