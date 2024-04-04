import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/database/profile_entry.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/profile/profile_filtering_settings/profile_filtering_settings.dart';
import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pihka_frontend/ui_utils/image.dart';
import 'package:pihka_frontend/ui_utils/list.dart';

var log = Logger("ProfileGrid");

class ProfileGrid extends StatefulWidget {
  const ProfileGrid({Key? key}) : super(key: key);

  @override
  State<ProfileGrid> createState() => _ProfileGridState();
}

typedef ProfileViewEntry = (ProfileEntry profile, XFile img, int heroNumber);

class _ProfileGridState extends State<ProfileGrid> {
  PagingController<int, ProfileViewEntry>? _pagingController =
    PagingController(firstPageKey: 0);
  int _heroUniqueIdCounter = 0;
  StreamSubscription<ProfileChange>? _profileChangesSubscription;
  ProfileFilteringSettingsData currentFilteringSettings = ProfileFilteringSettingsData();

  @override
  void initState() {
    super.initState();
    _heroUniqueIdCounter = 0;
    _pagingController?.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = ProfileRepository.getInstance().profileChanges.listen((event) {
        handleProfileChange(event);
    });
  }

  void handleProfileChange(ProfileChange event) {
    switch (event) {
      case ProfileNowPrivate(): {
        // Remove profile if it was made private
        removeAccountIdFromList(event.profile);
      }
      case ProfileBlocked():
        removeAccountIdFromList(event.profile);
      case ProfileFavoriteStatusChange(): {
        // Remove profile if favorites filter is enabled and favorite status is changed to false
        final controller = _pagingController;
        if (controller != null && event.isFavorite == false && currentFilteringSettings.showOnlyFavorites) {
          setState(() {
            controller.itemList?.removeWhere((item) => item.$1.uuid == event.profile.accountId);
          });
        }
      }
      case ProfileUnblocked() ||
        ConversationChanged() ||
        MatchesChanged() ||
        LikesChanged(): {}
    }
  }

  void removeAccountIdFromList(AccountId accountId) {
    final controller = _pagingController;
    if (controller != null) {
      setState(() {
        controller.itemList?.removeWhere((item) => item.$1.uuid == accountId.accountId);
      });
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    if (pageKey == 0) {
      ProfileRepository.getInstance().resetIteratorToBeginning();
    }

    final profileList = await ProfileRepository.getInstance().nextList();

    // Get images here instead of FutureBuilder because there was some weird
    // Hero tag error even if the builder index is in the tag.
    // Not sure does this image loading change affect the issue.
    // The PagedChildBuilderDelegate seems to run the builder twice for some
    // reason for the initial page.
    final newList = List<ProfileViewEntry>.empty(growable: true);
    for (final profile in profileList) {
      final file = await ImageCacheData.getInstance().getImage(profile.uuid, profile.imageUuid);
      if (file == null) {
        log.warning("Skipping one profile because image loading failed");
        continue;
      }
      newList.add((profile, file, _heroUniqueIdCounter));
      _heroUniqueIdCounter++;
    }

    if (profileList.isEmpty) {
      _pagingController?.appendLastPage([]);
    } else {
      _pagingController?.appendPage(newList, pageKey + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await ProfileRepository.getInstance().refreshProfileIterator();
        // This might be disposed after resetProfileIterator completes.
        _pagingController?.refresh();
      },
      child: BlocListener<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
        listener: (context, data) {
          // Filtering settings changed
          currentFilteringSettings = data;
          setState(() {
            _pagingController?.refresh();
          });
        },
        child: grid(context),
      ),
    );
  }

  Widget grid(BuildContext context) {
    return PagedGridView(
      pagingController: _pagingController!,
      builderDelegate: PagedChildBuilderDelegate<ProfileViewEntry>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          final accountId = item.$1.uuid;
          final heroTag = (accountId, item.$3);
          return GestureDetector(
            onTap: () {
              openProfileView(context, accountId, item.$1, item.$2, heroTag);
            },
            child: Hero(
              tag: heroTag,
              child: xfileImgWidget(item.$2)
            )
          );
        },
        noItemsFoundIndicatorBuilder: (context) {
          final filterStatus = context.read<ProfileFilteringSettingsBloc>().state.isSomeFilterEnabled();
          final Widget descriptionText;
          if (filterStatus) {
            descriptionText = Text(
              context.strings.profile_grid_screen_no_profiles_found_description_filters_enabled,
            );
          } else {
            descriptionText = Text(
              context.strings.profile_grid_screen_no_profiles_found_description_filters_disabled,
            );
          }
          return buildListReplacementMessage(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.strings.profile_grid_screen_no_profiles_found_title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Padding(padding: EdgeInsets.all(8)),
                descriptionText,
              ],
            ),
          );
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
    );
  }

  @override
  void dispose() {
    _pagingController?.dispose();
    _pagingController = null;
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = null;
    super.dispose();
  }
}
