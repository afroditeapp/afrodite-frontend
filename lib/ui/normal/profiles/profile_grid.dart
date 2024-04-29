import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/profile/profile_filtering_settings.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/profile_filtering_settings.dart';
import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pihka_frontend/ui_utils/common_update_logic.dart';
import 'package:pihka_frontend/ui_utils/consts/corners.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';
import 'package:pihka_frontend/ui_utils/list.dart';
import 'package:pihka_frontend/ui_utils/profile_thumbnail_image.dart';

var log = Logger("ProfileGrid");

class ProfileGrid extends StatefulWidget {
  final ProfileFilteringSettingsBloc filteringSettingsBloc;
  const ProfileGrid({required this.filteringSettingsBloc, Key? key}) : super(key: key);

  @override
  State<ProfileGrid> createState() => _ProfileGridState();
}

typedef ProfileViewEntry = ({ProfileEntry profile, ProfileHeroTag heroTag});

class _ProfileGridState extends State<ProfileGrid> {
  PagingController<int, ProfileViewEntry>? _pagingController =
    PagingController(firstPageKey: 0);
  int _heroUniqueIdCounter = 0;
  StreamSubscription<ProfileChange>? _profileChangesSubscription;

  // Use same progress indicator state that transition between
  // filter settings progress and grid progress is smooth.
  final GlobalKey _progressKey = GlobalKey();

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
        if (controller != null && event.isFavorite == false && widget.filteringSettingsBloc.state.showOnlyFavorites) {
          setState(() {
            controller.itemList?.removeWhere((item) => item.profile.uuid == event.profile);
          });
        }
      }
      case ReloadMainProfileView():
        setState(() {
          _pagingController?.refresh();
        });
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
        controller.itemList?.removeWhere((item) => item.profile.uuid == accountId);
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
      newList.add((profile: profile, heroTag: ProfileHeroTag.from(profile.uuid, _heroUniqueIdCounter)));
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
      child: BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
        builder: (context, state) {
          if (state.updateState is UpdateIdle) {
            return grid(context);
          } else {
            return Center(child: CircularProgressIndicator(key: _progressKey));
          }
        }
      ),
    );
  }

  Widget grid(BuildContext context) {
    return PagedGridView(
      pagingController: _pagingController!,
      padding: const EdgeInsets.symmetric(horizontal: COMMON_SCREEN_EDGE_PADDING),
      builderDelegate: PagedChildBuilderDelegate<ProfileViewEntry>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          return GestureDetector(
            // This callback should be used when Hero animation is enabled.
            // onTap: () {
            //   openProfileView(context, item.profile, heroTag: item.heroTag);
            // },
            child: Hero(
              tag: item.heroTag.value,
              flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    final squareFactor = lerpDouble(1.0, 0.0, animation.value) ?? 0.0;
                    final radius = lerpDouble(PROFILE_PICTURE_BORDER_RADIUS, 0.0, animation.value) ?? 0.0;
                    return ProfileThumbnailImage.fromProfileEntry(
                      entry: item.profile,
                      squareFactor: squareFactor,
                      borderRadius: BorderRadius.all(Radius.circular(radius)),
                      cacheSize: ImageCacheSize.sizeForGrid(),
                    );
                  }
                );
              },
              child: ProfileThumbnailImage.fromProfileEntry(
                entry: item.profile,
                cacheSize: ImageCacheSize.sizeForGrid(),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // Hero animation is disabled currently as UI looks better
                      // without it.
                      // openProfileView(context, item.profile, heroTag: item.heroTag);
                      openProfileView(context, item.profile, heroTag: null);
                    },
                  ),
                ),
              ),
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
        firstPageProgressIndicatorBuilder: (context) {
          return Center(child: CircularProgressIndicator(key: _progressKey));
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
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
