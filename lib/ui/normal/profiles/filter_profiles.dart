
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/profile/edit_profile_filtering_settings.dart';
import 'package:pihka_frontend/logic/profile/profile_filtering_settings.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/edit_profile_filtering_settings.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/my_profile.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/profile_filtering_settings.dart';
import 'package:pihka_frontend/ui_utils/common_update_logic.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';

class ProfileFilteringSettingsPage extends StatefulWidget {
  final ProfileFilteringSettingsBloc profileFilteringSettingsBloc;
  final EditProfileFilteringSettingsBloc editProfileFilteringSettingsBloc;
  const ProfileFilteringSettingsPage({
    required this.profileFilteringSettingsBloc,
    required this.editProfileFilteringSettingsBloc,
    super.key,
  });

  @override
  State<ProfileFilteringSettingsPage> createState() => _ProfileFilteringSettingsPageState();
}

class _ProfileFilteringSettingsPageState extends State<ProfileFilteringSettingsPage> {

  @override
  void initState() {
    super.initState();
    widget.editProfileFilteringSettingsBloc.add(ResetStateWith(
      widget.profileFilteringSettingsBloc.state.showOnlyFavorites,
    ));
  }

  void validateAndSaveData(BuildContext context) {
    widget.profileFilteringSettingsBloc.add(SaveNewFilterSettings(
      widget.editProfileFilteringSettingsBloc.state.showOnlyFavorites,
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
        appBar: AppBar(title: Text(context.strings.profile_filtering_settings_screen_title)),
        body: updateStateHandler<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
          child: filteringSettingsWidget(context),
        ),
      ),
    );
  }

  Widget filteringSettingsWidget(BuildContext context) {
    return BlocBuilder<EditProfileFilteringSettingsBloc, EditProfileFilteringSettingsData>(
      builder: (context, state) {
        return Column(
          children: <Widget>[
            getShowFavoritesSelection(context, state),
          ],
        );
      }
    );
  }

  Widget getShowFavoritesSelection(BuildContext context, EditProfileFilteringSettingsData state) {
    return SwitchListTile(
      title: Text(context.strings.profile_filtering_settings_screen_favorite_profile_filter),
      secondary: const Icon(Icons.star_rounded),
      value: state.showOnlyFavorites,
      onChanged: (bool value) =>
          context.read<EditProfileFilteringSettingsBloc>().add(SetFavoriteProfilesFilter(value)),
    );
  }
}
