import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/profile/profile.dart';
import 'package:pihka_frontend/logic/profile/profile_filtering_settings/profile_filtering_settings.dart';
import 'package:pihka_frontend/logic/profile/view_profiles/view_profiles.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/moderate_images.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/edit_profile.dart';
import 'package:pihka_frontend/ui/utils.dart';
import 'package:pihka_frontend/ui/utils/view_profile.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Might return [RemoveProfileFromList] when navigating back to previous page
class ProfileFilteringSettingsPage extends StatelessWidget {
  const ProfileFilteringSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: filteringSettingsPage(context),
      ),
    );
  }

  Widget filteringSettingsPage(BuildContext context) {
    return BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
      builder: (context, state) {
        return Column(
          children: <Widget>[
            getShowFavoritesSelection(context, state),
          ],
        );
      }
    );
  }

  Widget getShowFavoritesSelection(BuildContext context, ProfileFilteringSettingsData state) {
    return SwitchListTile(
      title: Text("Favorite profile"),
      secondary: const Icon(Icons.star_rounded),
      value: state.showOnlyFavorites,
      onChanged: (bool value) =>
          context.read<ProfileFilteringSettingsBloc>().add(ShowOnlyFavoritesChange(value)),
    );
  }
}
