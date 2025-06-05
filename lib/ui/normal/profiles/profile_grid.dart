import 'dart:async';

import 'package:app/logic/profile/view_profiles.dart';
import 'package:app/logic/settings/ui_settings.dart';
import 'package:app/model/freezed/logic/profile/view_profiles.dart';
import 'package:app/model/freezed/logic/settings/ui_settings.dart';
import 'package:app/ui_utils/consts/colors.dart';
import 'package:app/ui_utils/extensions/other.dart';
import 'package:app/ui_utils/profile_thumbnail_image_or_error.dart';
import 'package:app/utils/command_runner.dart';
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

typedef ProfileViewEntry = ({ProfileThumbnail profile, ProfileActionState? initialProfileAction});


class _ProfileGridState extends State<ProfileGrid> {
  final ScrollController _scrollController = ScrollController();
  PagingState<int, ProfileViewEntry> _pagingState = PagingState();
  StreamSubscription<ProfileChange>? _profileChangesSubscription;

  final AccountDatabaseManager accountDb = LoginRepository.getInstance().repositories.accountDb;

  final ProfileIteratorManager _mainProfilesViewIterator = ProfileIteratorManager(
    LoginRepository.getInstance().repositories.chat,
    LoginRepository.getInstance().repositories.media,
    LoginRepository.getInstance().repositories.accountBackgroundDb,
    LoginRepository.getInstance().repositories.accountDb,
    LoginRepository.getInstance().repositories.connectionManager,
    LoginRepository.getInstance().repositories.chat.currentUser,
  );

  final profileRepository = LoginRepository.getInstance().repositories.profile;
  final chatRepository = LoginRepository.getInstance().repositories.chat;

  final SynchronousCommandRunner _commandRunner = SynchronousCommandRunner();
  bool isDisposed = false;

  @override
  void initState() {
    super.initState();

    _commandRunner.init();

    if (widget.filteringSettingsBloc.state.showOnlyFavorites) {
      _mainProfilesViewIterator.reset(ModeFavorites());
    } else {
      _mainProfilesViewIterator.reset(ModePublicProfiles(
        clearDatabase: true,
      ));
    }

    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = profileRepository.profileChanges.listen((event) {
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
    if (isDisposed || !context.mounted) {
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
          updatePagingState((s) => s.filterItems((item) => item.profile.entry.uuid != event.profile));
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
    updatePagingState((s) => s.filterItems((item) => item.profile.entry.uuid != accountId));
  }

  Future<void> _fetchPage() async {
    if (!_pagingState.hasNextPage) {
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
      final initialProfileAction = await resolveProfileAction(chatRepository, profile.uuid);
      final isFavorite = await profileRepository.isInFavorites(profile.uuid);
      newList.add((
        profile: ProfileThumbnail(entry: profile, isFavorite: isFavorite),
        initialProfileAction: initialProfileAction,
      ));
    }

    updatePagingState((s) => s.copyAndAdd(newList));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await refreshProfileGrid();
      },
      child: BlocBuilder<UiSettingsBloc, UiSettingsData>(
        buildWhen: (previous, current) => previous.gridSettings != current.gridSettings,
        builder: (context, uiSettings) {
          return BlocBuilder<MyProfileBloc, MyProfileData>(
            builder: (context, myProfileState) {
              return BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
                builder: (context, state) {
                  if (state.updateState is UpdateIdle && !state.unsavedChanges()) {
                    return showGrid(context, myProfileState, uiSettings.gridSettings, _pagingState);
                  } else {
                    return showGrid(context, myProfileState, uiSettings.gridSettings, _pagingState.copyAndShowLoading());
                  }
                }
              );
            }
          );
        }
      ),
    );
  }

  Widget showGrid(
    BuildContext context,
    MyProfileData myProfileState,
    GridSettings settings,
    PagingState<int, ProfileViewEntry> pagingState,
  ) {
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
        child: grid(context, myProfileState.profile?.unlimitedLikes ?? false, settings, pagingState)
      ),
    );
  }

  Widget grid(
    BuildContext context,
    bool iHaveUnlimitedLikesEnabled,
    GridSettings settings,
    PagingState<int, ProfileViewEntry> pagingState,
  ) {
    return PagedGridView(
      state: pagingState,
      fetchNextPage: () {
        _commandRunner.add(Command("fetchPage", _fetchPage));
      },
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
          return const Center(child: CircularProgressIndicator());
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
              refreshProfileGrid();
            },
            child: Text(context.strings.generic_try_again),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }

  Future<void> refreshProfileGrid() async {
    _commandRunner.addIfNotAlreadyScheduled(Command("refresh", () {
      _mainProfilesViewIterator.refresh();
      updatePagingState((_) => PagingState());
    }));
  }

  @override
  void dispose() {
    isDisposed = true;
    _commandRunner.dispose();
    _scrollController.removeListener(scrollEventListener);
    _scrollController.dispose();
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = null;
    super.dispose();
  }
}

Widget profileEntryWidgetStream(
  ProfileThumbnail profile,
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
    stream: db.accountStream((db) => db.daoProfiles.watchProfileThumbnail(profile.entry.uuid)).whereNotNull(),
    builder: (context, data) {
      final e = data.data ?? profile;
      return ProfileThumbnailImageOrError.fromProfileEntry(
        entry: e.entry,
        borderRadius: BorderRadius.circular(settings.valueProfileThumbnailBorderRadius()),
        cacheSize: ImageCacheSize.sizeForGrid(),
        child: Stack(
          children: [
            _thumbnailStatusIndicatorsTop(
              showNewLikeMarker,
              e.entry.newLikeInfoReceivedTime,
              e.isFavorite,
            ),
            _thumbnailStatusIndicatorsBottom(
              context,
              e.entry,
              iHaveUnlimitedLikesEnabled,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  if (overrideOnTap != null) {
                    return overrideOnTap(context);
                  }
                  openProfileView(context, e.entry, initialProfileAction, ProfileRefreshPriority.low);
                },
              ),
            ),
          ]
        ),
      );
    }
  );
}

Widget _thumbnailStatusIndicatorsBottom(
  BuildContext context,
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
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.all_inclusive,
              color: getUnlimitedLikesColor(context),
            ),
          ) :
          const SizedBox.shrink(),
      ],
    ),
  );
}

Widget _thumbnailStatusIndicatorsTop(
  bool showNewLikeMarker,
  UtcDateTime? newLikeInfoReceivedTime,
  bool isFavorite,
) {
  final currentTime = UtcDateTime.now();
  final showNewLikeIcon = showNewLikeMarker &&
    newLikeInfoReceivedTime != null &&
    currentTime.difference(newLikeInfoReceivedTime).inHours < 24;
  return Align(
    alignment: Alignment.topLeft,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showNewLikeIcon) const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.auto_awesome,
            color: Colors.amber,
          ),
        ),
        if (isFavorite) Padding(
          padding: showNewLikeIcon ? const EdgeInsets.all(0) : const EdgeInsets.all(4.0),
          child: const Icon(
            Icons.star_rounded,
            color: Colors.orange,
          ),
        ),
      ],
    ),
  );
}
