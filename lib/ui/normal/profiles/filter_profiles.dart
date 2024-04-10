
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/logic/profile/profile_filtering_settings.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/profile_filtering_settings.dart';


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
