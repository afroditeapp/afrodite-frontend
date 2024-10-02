import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/profile/profile_iterator_manager.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/bottom_navigation_state.dart';
import 'package:pihka_frontend/logic/profile/my_profile.dart';
import 'package:pihka_frontend/logic/profile/profile_filtering_settings.dart';
import 'package:pihka_frontend/model/freezed/logic/main/bottom_navigation_state.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/my_profile.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/profile_filtering_settings.dart';
import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pihka_frontend/ui_utils/common_update_logic.dart';
import 'package:pihka_frontend/ui_utils/consts/corners.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';
import 'package:pihka_frontend/ui_utils/consts/size.dart';
import 'package:pihka_frontend/ui_utils/list.dart';
import 'package:pihka_frontend/ui_utils/profile_thumbnail_image.dart';
import 'package:pihka_frontend/ui_utils/scroll_controller.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

var log = Logger("ProfileGrid");

// TODO: Check that specific profile in profile grid updates if needed
// when returning from view profile screen.

class ProfileGrid extends StatefulWidget {
  final ProfileFilteringSettingsBloc filteringSettingsBloc;
  const ProfileGrid({required this.filteringSettingsBloc, Key? key}) : super(key: key);

  @override
  State<ProfileGrid> createState() => _ProfileGridState();
}

typedef ProfileViewEntry = ({ProfileEntry profile, ProfileHeroTag heroTag});


class _ProfileGridState extends State<ProfileGrid> {
  final ScrollController _scrollController = ScrollController();
  PagingController<int, ProfileViewEntry>? _pagingController =
    PagingController(firstPageKey: 0);
  int _heroUniqueIdCounter = 0;
  StreamSubscription<ProfileChange>? _profileChangesSubscription;

  // Use same progress indicator state that transition between
  // filter settings progress and grid progress is smooth.
  final GlobalKey _progressKey = GlobalKey();

  final AccountDatabaseManager accountDb = LoginRepository.getInstance().repositories.accountDb;

  final ProfileIteratorManager _mainProfilesViewIterator = ProfileIteratorManager(
    LoginRepository.getInstance().repositories.chat,
    LoginRepository.getInstance().repositories.media,
    LoginRepository.getInstance().repositories.accountBackgroundDb,
    LoginRepository.getInstance().repositories.accountDb,
    LoginRepository.getInstance().repositories.connectionManager,
    LoginRepository.getInstance().repositories.chat.currentUser,
  );
  bool _reloadInProgress = false;

  final profile = LoginRepository.getInstance().repositories.profile;

  @override
  void initState() {
    super.initState();

    if (widget.filteringSettingsBloc.state.showOnlyFavorites) {
      _mainProfilesViewIterator.reset(ModeFavorites());
    } else {
      _mainProfilesViewIterator.reset(ModePublicProfiles(
        clearDatabase: true,
      ));
    }

    _heroUniqueIdCounter = 0;
    _pagingController?.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = profile.profileChanges.listen((event) {
        handleProfileChange(event);
    });
    _scrollController.addListener(scrollEventListener);
  }

  void scrollEventListener() {
    bool isScrolled;
    if (!_scrollController.hasClients) {
      isScrolled = false;
    } else {
      isScrolled = _scrollController.position.pixels > 0;
    }
    updateIsScrolled(isScrolled);
  }

  void updateIsScrolled(bool isScrolled) {
    BottomNavigationStateBlocInstance.getInstance()
      .bloc
      .updateIsScrolled(
        isScrolled,
        BottomNavigationScreenId.profiles,
        (state) => state.isScrolledProfile,
      );
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
          if (event.showOnlyFavorites) {
            _mainProfilesViewIterator.reset(ModeFavorites());
          } else {
            _mainProfilesViewIterator.reset(ModePublicProfiles(
              clearDatabase: true,
            ));
          }
          _pagingController?.refresh();
        });
      case ProfileUnblocked() ||
        ConversationChanged() ||
        MatchesChanged() ||
        ReceivedLikeRemoved(): {}
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
      _mainProfilesViewIterator.resetToBeginning();
    }

    final profileList = await _mainProfilesViewIterator.nextList().ok();
    if (profileList == null) {
      // Show error UI
      _pagingController?.error = true;
      return;
    }

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
        if (!_reloadInProgress) {
          await refreshProfileGrid();
        }
      },
      child: BlocBuilder<MyProfileBloc, MyProfileData>(
        builder: (context, myProfileState) {
          return BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
            builder: (context, state) {
              if (state.updateState is UpdateIdle) {
                return NotificationListener<ScrollMetricsNotification>(
                  onNotification: (notification) {
                    final isScrolled = notification.metrics.pixels > 0;
                    updateIsScrolled(isScrolled);
                    return true;
                  },
                  child: BlocListener<BottomNavigationStateBloc, BottomNavigationStateData>(
                    listenWhen: (previous, current) => previous.isTappedAgainProfile != current.isTappedAgainProfile,
                    listener: (context, state) {
                      if (state.isTappedAgainProfile) {
                        context.read<BottomNavigationStateBloc>().add(SetIsTappedAgainValue(BottomNavigationScreenId.profiles, false));
                        _scrollController.bottomNavigationRelatedJumpToBeginningIfClientsConnected();
                      }
                    },
                    child: grid(context, myProfileState.profile?.unlimitedLikes ?? false)
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator(key: _progressKey));
              }
            }
          );
        }
      ),
    );
  }

  Widget grid(BuildContext context, bool iHaveUnlimitedLikesEnabled) {
    return PagedGridView(
      physics: const AlwaysScrollableScrollPhysics(),
      scrollController: _scrollController,
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
                // The animation might have issues because the data updates with
                // StreamBuilder.
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
              child: profileEntryWidgetStream(item.profile, iHaveUnlimitedLikesEnabled, accountDb),
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
        firstPageErrorIndicatorBuilder: (context) {
          return errorDetectedWidgetWithRetryButton();
        },
        newPageErrorIndicatorBuilder: (context) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(context.strings.profile_grid_screen_profile_loading_failed),
            ),
          );
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
    );
  }


  Widget errorDetectedWidgetWithRetryButton() {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Text(context.strings.profile_grid_screen_profile_loading_failed),
          const Padding(padding: EdgeInsets.all(8)),
          ElevatedButton(
            onPressed: () {
              if (!_reloadInProgress) {
                refreshProfileGrid();
              }
            },
            child: Text(context.strings.generic_try_again),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }

  Future<void> refreshProfileGrid() async {
    _reloadInProgress = true;
    await _mainProfilesViewIterator.loadingInProgress.firstWhere((e) => e == false);
    _mainProfilesViewIterator.refresh();
    // This might be disposed after resetProfileIterator completes.
    _pagingController?.refresh();
    _reloadInProgress = false;
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollEventListener);
    _scrollController.dispose();
    _pagingController?.dispose();
    _pagingController = null;
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = null;
    super.dispose();
  }
}

Widget profileEntryWidgetStream(
  ProfileEntry entry,
  bool iHaveUnlimitedLikesEnabled,
  AccountDatabaseManager db,
  {
    bool showNewLikeMarker = false,
  }
) {
  return StreamBuilder(
    stream: db.accountStream((db) => db.daoProfiles.watchProfileEntry(entry.uuid)).whereNotNull(),
    builder: (context, data) {
      final e = data.data ?? entry;
      final newLikeInfoReceivedTime = e.newLikeInfoReceivedTime;
      return ProfileThumbnailImage.fromProfileEntry(
        entry: e,
        cacheSize: ImageCacheSize.sizeForGrid(),
        child: Stack(
          children: [
            if (showNewLikeMarker && newLikeInfoReceivedTime != null)
              thumbnailStatusIndicatorForNewLikeMarker(newLikeInfoReceivedTime),
            thumbnailStatusIndicators(
              e,
              iHaveUnlimitedLikesEnabled,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Hero animation is disabled currently as UI looks better
                  // without it.
                  // openProfileView(context, item.profile, heroTag: item.heroTag);
                  openProfileView(context, e, ProfileRefreshPriority.low, heroTag: null);
                },
              ),
            ),
          ]
        ),
      );
    }
  );
}

Widget thumbnailStatusIndicators(
  ProfileEntry profile,
  bool iHaveUnlimitedLikesEnabled,
) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Row(
      children: [
        if (profile.lastSeenTimeValue == -1) Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: PROFILE_CURRENTLY_ONLINE_SIZE,
            height: PROFILE_CURRENTLY_ONLINE_SIZE,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(PROFILE_CURRENTLY_ONLINE_RADIUS),
            ),
          ),
        ),
        const Spacer(),
        iHaveUnlimitedLikesEnabled && profile.unlimitedLikes ?
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.all_inclusive,
              color: Colors.black,
            ),
          ) :
          const SizedBox.shrink(),
      ],
    ),
  );
}

Widget thumbnailStatusIndicatorForNewLikeMarker(
  UtcDateTime newLikeInfoReceivedTime,
) {
  final currentTime = UtcDateTime.now();
  if (currentTime.difference(newLikeInfoReceivedTime).inHours < 24) {
    return const Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.auto_awesome,
          color: Colors.amber,
        ),
      ),
    );
  } else {
    return const SizedBox.shrink();
  }
}
