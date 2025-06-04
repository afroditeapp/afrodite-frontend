import 'dart:async';

import 'package:app/logic/profile/view_profiles.dart';
import 'package:app/logic/settings/ui_settings.dart';
import 'package:app/model/freezed/logic/profile/view_profiles.dart';
import 'package:app/model/freezed/logic/settings/ui_settings.dart';
import 'package:app/ui_utils/extensions/other.dart';
import 'package:app/ui_utils/profile_thumbnail_image_or_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/data/profile/profile_iterator_manager.dart';
import 'package:app/data/profile_repository.dart';
import 'package:database/database.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/bottom_navigation_state.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/logic/profile/profile_filtering_settings.dart';
import 'package:app/model/freezed/logic/main/bottom_navigation_state.dart';
import 'package:app/model/freezed/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/profile/profile_filtering_settings.dart';
import 'package:app/ui/normal/profiles/view_profile.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/consts/corners.dart';
import 'package:app/ui_utils/consts/size.dart';
import 'package:app/ui_utils/list.dart';
import 'package:app/ui_utils/scroll_controller.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

var log = Logger("ProfileGrid");

// TODO: Check that specific profile in profile grid updates if needed
// when returning from view profile screen.

class ProfileGrid extends StatefulWidget {
  final ProfileFilteringSettingsBloc filteringSettingsBloc;
  const ProfileGrid({required this.filteringSettingsBloc, super.key});

  @override
  State<ProfileGrid> createState() => _ProfileGridState();
}

typedef ProfileViewEntry = ({ProfileEntry profile, ProfileActionState? initialProfileAction});


class _ProfileGridState extends State<ProfileGrid> {
  final ScrollController _scrollController = ScrollController();
  PagingState<int, ProfileViewEntry> _pagingState = PagingState();
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
  final chat = LoginRepository.getInstance().repositories.chat;

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
      .updateIsScrolled(
        isScrolled,
        BottomNavigationScreenId.profiles,
        (state) => state.isScrolledProfile,
      );
  }

  void updatePagingState(PagingState<int, ProfileViewEntry> Function(PagingState<int, ProfileViewEntry>) action) {
    if (!context.mounted) {
      return;
    }
    setState(() {
      _pagingState = action(_pagingState);
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
        if (event.isFavorite == false && widget.filteringSettingsBloc.state.showOnlyFavorites) {
          updatePagingState((s) => s.filterItems((item) => item.profile.uuid != event.profile));
        }
      }
      case ReloadMainProfileView():
        updatePagingState((_) {
          if (event.showOnlyFavorites) {
            _mainProfilesViewIterator.reset(ModeFavorites());
          } else {
            _mainProfilesViewIterator.reset(ModePublicProfiles(
              clearDatabase: true,
            ));
          }
          return PagingState();
        });
      case ProfileUnblocked() ||
        ConversationChanged(): {}
    }
  }

  void removeAccountIdFromList(AccountId accountId) {
    updatePagingState((s) => s.filterItems((item) => item.profile.uuid != accountId));
  }

  void _fetchPage() async {
    if (_pagingState.isLoading) {
      return;
    }

    await Future<void>.value();

    updatePagingState((s) => s.copyAndShowLoading());

    final profileList = await _mainProfilesViewIterator.nextList().ok();
    if (profileList == null) {
      updatePagingState((s) => s.copyAndShowError());
      return;
    }

    final newList = List<ProfileViewEntry>.empty(growable: true);
    for (final profile in profileList) {
      final initialProfileAction = await resolveProfileAction(chat, profile.uuid);
      newList.add((
        profile: profile,
        initialProfileAction: initialProfileAction,
      ));
    }

    updatePagingState((s) => s.copyAndAdd(newList));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (!_reloadInProgress) {
          await refreshProfileGrid();
        }
      },
      child: BlocBuilder<UiSettingsBloc, UiSettingsData>(
        buildWhen: (previous, current) => previous.gridSettings != current.gridSettings,
        builder: (context, uiSettings) {
          return BlocBuilder<MyProfileBloc, MyProfileData>(
            builder: (context, myProfileState) {
              return BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
                builder: (context, state) {
                  if (state.updateState is UpdateIdle && !state.unsavedChanges()) {
                    return showGrid(context, myProfileState, uiSettings.gridSettings);
                  } else {
                    return Center(child: CircularProgressIndicator(key: _progressKey));
                  }
                }
              );
            }
          );
        }
      ),
    );
  }

  Widget showGrid(BuildContext context, MyProfileData myProfileState, GridSettings settings) {
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
        child: grid(context, myProfileState.profile?.unlimitedLikes ?? false, settings)
      ),
    );
  }

  Widget grid(BuildContext context, bool iHaveUnlimitedLikesEnabled, GridSettings settings) {
    return PagedGridView(
      state: _pagingState,
      fetchNextPage: _fetchPage,
      physics: const AlwaysScrollableScrollPhysics(),
      scrollController: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: settings.valueHorizontalPadding()),
      builderDelegate: PagedChildBuilderDelegate<ProfileViewEntry>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          return profileEntryWidgetStream(item.profile, iHaveUnlimitedLikesEnabled, item.initialProfileAction, accountDb, settings);
        },
        noItemsFoundIndicatorBuilder: (context) {
          final filterState = context.read<ProfileFilteringSettingsBloc>().state;
          final String descriptionText;
          if (filterState.showOnlyFavorites) {
            descriptionText =
              context.strings.profile_grid_screen_no_favorite_profiles_found_description;
          } else if (filterState.isSomeFilterEnabled()) {
            descriptionText =
              context.strings.profile_grid_screen_no_profiles_found_description_filters_enabled;
          } else {
            descriptionText =
              context.strings.profile_grid_screen_no_profiles_found_description_filters_disabled;
          }
          return buildListReplacementMessage(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  filterState.showOnlyFavorites ?
                    context.strings.profile_grid_screen_no_favorite_profiles_found_title :
                    context.strings.profile_grid_screen_no_profiles_found_title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Text(descriptionText),
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
              child: Text(context.strings.generic_profile_loading_failed),
            ),
          );
        },
      ),
      gridDelegate: settings.toSliverGridDelegate(),
    );
  }


  Widget errorDetectedWidgetWithRetryButton() {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Text(context.strings.generic_profile_loading_failed),
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
    updatePagingState((_) => PagingState());
    _reloadInProgress = false;
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollEventListener);
    _scrollController.dispose();
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = null;
    super.dispose();
  }
}

Widget profileEntryWidgetStream(
  ProfileEntry entry,
  bool iHaveUnlimitedLikesEnabled,
  ProfileActionState? initialProfileAction,
  AccountDatabaseManager db,
  GridSettings settings,
  {
    bool showNewLikeMarker = false,
    void Function(BuildContext)? overrideOnTap,
  }
) {
  return StreamBuilder(
    stream: db.accountStream((db) => db.daoProfiles.watchProfileEntry(entry.uuid)).whereNotNull(),
    builder: (context, data) {
      final e = data.data ?? entry;
      final newLikeInfoReceivedTime = e.newLikeInfoReceivedTime;
      return ProfileThumbnailImageOrError.fromProfileEntry(
        entry: e,
        borderRadius: BorderRadius.circular(settings.valueProfileThumbnailBorderRadius()),
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
                  if (overrideOnTap != null) {
                    return overrideOnTap(context);
                  }
                  openProfileView(context, e, initialProfileAction, ProfileRefreshPriority.low);
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
