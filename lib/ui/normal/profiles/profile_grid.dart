import 'dart:async';

import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/profile/view_profiles.dart';
import 'package:app/logic/settings/ui_settings.dart';
import 'package:app/model/freezed/logic/profile/view_profiles.dart';
import 'package:app/model/freezed/logic/settings/ui_settings.dart';
import 'package:app/ui_utils/consts/colors.dart';
import 'package:app/ui_utils/consts/icons.dart';
import 'package:app/ui_utils/extensions/other.dart';
import 'package:app/ui_utils/profile_grid.dart';
import 'package:app/ui_utils/profile_thumbnail_image_or_error.dart';
import 'package:app/ui_utils/paged_grid_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/data/profile/profile_iterator_manager.dart';
import 'package:app/data/profile_repository.dart';
import 'package:database/database.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/bottom_navigation_state.dart';
import 'package:app/logic/profile/profile_filters.dart';
import 'package:app/model/freezed/logic/main/bottom_navigation_state.dart';
import 'package:app/model/freezed/logic/profile/profile_filters.dart';
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

class ProfileGrid extends StatefulWidget {
  final RepositoryInstances r;
  final ProfileFiltersBloc profileFiltersBloc;
  const ProfileGrid({required this.r, required this.profileFiltersBloc, super.key});

  @override
  State<ProfileGrid> createState() => ProfileGridState();
}

class ProfileGridState extends State<ProfileGrid> {
  final ScrollController _scrollController = ScrollController();
  PagingState<int, ProfileGridProfileEntry> pagingState = PagingState();
  StreamSubscription<ProfileChange>? _profileChangesSubscription;

  late final ProfileIteratorManager _mainProfilesViewIterator;

  final PagedGridLogic _gridLogic = PagedGridLogic();
  bool isDisposed = false;

  List<EventHandlingTracker> reloadEventDoneTrackers = [];

  @override
  void initState() {
    super.initState();

    _mainProfilesViewIterator = ProfileIteratorManager(
      widget.r.chat,
      widget.r.media,
      widget.r.accountBackgroundDb,
      widget.r.accountDb,
      widget.r.connectionManager,
      widget.r.chat.currentUser,
    );

    _gridLogic.init();

    if (widget.profileFiltersBloc.state.showOnlyFavorites) {
      _mainProfilesViewIterator.reset(ModeFavorites());
    } else {
      _mainProfilesViewIterator.reset(ModePublicProfiles(clearDatabase: true));
    }

    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = widget.r.profile.profileChanges.listen((event) {
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
    BottomNavigationStateBlocInstance.getInstance().updateIsScrolled(
      isScrolled,
      BottomNavigationScreenId.profiles,
      (state) => state.isScrolledProfile,
    );
  }

  void updatePagingState(
    PagingState<int, ProfileGridProfileEntry> Function(PagingState<int, ProfileGridProfileEntry>)
    action,
  ) {
    if (isDisposed || !context.mounted) {
      return;
    }
    setState(() {
      pagingState = action(pagingState);
    });
  }

  void handleProfileChange(ProfileChange event) {
    switch (event) {
      case ProfileNowPrivate():
        {
          // Remove profile if it was made private
          removeAccountIdFromList(event.profile);
        }
      case ProfileBlocked():
        removeAccountIdFromList(event.profile);
      case ProfileFavoriteStatusChange():
        {
          // Remove profile if favorites filter is enabled and favorite status is changed to false
          if (event.isFavorite == false && widget.profileFiltersBloc.state.showOnlyFavorites) {
            updatePagingState(
              (s) => s.filterItems((item) => item.profile.entry.accountId != event.profile),
            );
          }
        }
      case ReloadMainProfileView():
        final tracker = event.eventHandlingTracker;
        if (tracker != null) {
          reloadEventDoneTrackers.add(tracker);
        }
        updatePagingState((_) {
          if (event.showOnlyFavorites) {
            _mainProfilesViewIterator.reset(ModeFavorites());
          } else {
            _mainProfilesViewIterator.reset(ModePublicProfiles(clearDatabase: true));
          }
          return PagingState();
        });
      case ProfileUnblocked() || ConversationChanged():
        {}
    }
  }

  void removeAccountIdFromList(AccountId accountId) {
    updatePagingState((s) => s.filterItems((item) => item.profile.entry.accountId != accountId));
  }

  Future<List<ProfileGridProfileEntry>?> _fetchPage() async {
    if (!pagingState.hasNextPage) {
      return null;
    }

    await Future<void>.value();

    updatePagingState((s) => s.copyAndShowLoading());

    final profileList = await _mainProfilesViewIterator.nextList().ok();
    if (profileList == null) {
      updatePagingState((s) => s.copyAndShowError());
      return null;
    }

    final newList = List<ProfileGridProfileEntry>.empty(growable: true);
    for (final profile in profileList) {
      final initialProfileAction = await resolveProfileAction(widget.r.chat, profile.accountId);
      final isFavorite = await widget.r.profile.isInFavorites(profile.accountId);
      newList.add((
        profile: ProfileThumbnail(entry: profile, isFavorite: isFavorite),
        initialProfileAction: initialProfileAction,
      ));
    }

    return newList;
  }

  void _addPage(List<ProfileGridProfileEntry> page) {
    updatePagingState((s) => s.copyAndAdd(page));
    reloadEventDoneTrackers.removeWhere((handle) {
      handle.handleAndDispose();
      return true;
    });
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
          return BlocBuilder<ProfileFiltersBloc, ProfileFiltersData>(
            builder: (context, state) {
              if (state.updateState is UpdateIdle && !state.unsavedChanges()) {
                return showGrid(context, uiSettings.gridSettings, pagingState, true);
              } else {
                return showGrid(
                  context,
                  uiSettings.gridSettings,
                  PagingState(isLoading: true),
                  false,
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget showGrid(
    BuildContext context,
    GridSettings settings,
    PagingState<int, ProfileGridProfileEntry> pagingState,
    bool fetchPages,
  ) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (notification) {
        final isScrolled = notification.metrics.pixels > 0;
        updateIsScrolled(isScrolled);
        return true;
      },
      child: BlocListener<BottomNavigationStateBloc, BottomNavigationStateData>(
        listenWhen: (previous, current) =>
            previous.isTappedAgainProfile != current.isTappedAgainProfile,
        listener: (context, state) {
          if (state.isTappedAgainProfile) {
            context.read<BottomNavigationStateBloc>().add(
              SetIsTappedAgainValue(BottomNavigationScreenId.profiles, false),
            );
            _scrollController.bottomNavigationRelatedJumpToBeginningIfClientsConnected();
          }
        },
        child: grid(context, settings, pagingState, fetchPages),
      ),
    );
  }

  Widget grid(
    BuildContext context,
    GridSettings settings,
    PagingState<int, ProfileGridProfileEntry> pagingState,
    bool fetchPages,
  ) {
    final singleItemWidth = settings.singleItemWidth(context);
    return PagedGridView(
      state: pagingState,
      fetchNextPage: () {
        if (fetchPages) {
          _gridLogic.fetchPage(_fetchPage, _addPage);
        }
      },
      physics: const AlwaysScrollableScrollPhysics(),
      scrollController: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: settings.valueHorizontalPadding()),
      builderDelegate: PagedChildBuilderDelegate<ProfileGridProfileEntry>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          return UpdatingProfileThumbnailWithInfo(
            initialData: item.profile,
            initialProfileAction: item.initialProfileAction,
            db: widget.r.accountDb,
            settings: settings,
            maxItemWidth: singleItemWidth,
          );
        },
        noItemsFoundIndicatorBuilder: (context) {
          final filterState = context.read<ProfileFiltersBloc>().state;
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
                  filterState.showOnlyFavorites
                      ? context.strings.profile_grid_screen_no_favorite_profiles_found_title
                      : context.strings.profile_grid_screen_no_profiles_found_title,
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
      gridDelegate: settings.toSliverGridDelegate(context, itemWidth: singleItemWidth),
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
    _gridLogic.refresh(
      () {
        _mainProfilesViewIterator.refresh();
        updatePagingState((_) => PagingState());
      },
      _fetchPage,
      _addPage,
    );
  }

  @override
  void dispose() {
    isDisposed = true;
    _gridLogic.dispose();
    _scrollController.removeListener(scrollEventListener);
    _scrollController.dispose();
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = null;
    _mainProfilesViewIterator.dispose();
    super.dispose();
  }
}

class UpdatingProfileThumbnailWithInfo extends StatefulWidget {
  final AccountDatabaseManager db;
  final ProfileThumbnail initialData;
  final ProfileActionState? initialProfileAction;
  final GridSettings settings;
  final bool showNewLikeMarker;
  final double maxItemWidth;
  const UpdatingProfileThumbnailWithInfo({
    required this.db,
    required this.initialData,
    required this.initialProfileAction,
    required this.settings,
    this.showNewLikeMarker = false,
    required this.maxItemWidth,
    super.key,
  });

  @override
  State<UpdatingProfileThumbnailWithInfo> createState() => _UpdatingProfileThumbnailWithInfoState();
}

class _UpdatingProfileThumbnailWithInfoState extends State<UpdatingProfileThumbnailWithInfo> {
  late final Stream<ProfileThumbnail> stream;

  @override
  void initState() {
    super.initState();
    stream = widget.db
        .accountStream((db) => db.profile.watchProfileThumbnail(widget.initialData.entry.accountId))
        .whereNotNull();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, data) {
        final e = data.data ?? widget.initialData;
        return ProfileThumbnailImageOrError.fromProfileEntry(
          entry: e.entry,
          borderRadius: BorderRadius.circular(widget.settings.valueProfileThumbnailBorderRadius()),
          cacheSize: ImageCacheSize.squareImageForGrid(context, widget.maxItemWidth),
          child: Stack(
            children: [
              _thumbnailStatusIndicatorsTop(
                widget.showNewLikeMarker,
                e.entry.newLikeInfoReceivedTime,
                e.isFavorite,
              ),
              _thumbnailStatusIndicatorsBottom(context, e.entry),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    openProfileView(
                      context,
                      e.entry,
                      widget.initialProfileAction,
                      ProfileRefreshPriority.low,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _thumbnailStatusIndicatorsBottom(BuildContext context, ProfileEntry profile) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Row(
      children: [
        if (profile.lastSeenTimeValue == -1)
          Padding(
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
        profile.unlimitedLikes
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(UNLIMITED_LIKES_ICON, color: getUnlimitedLikesColor(context)),
              )
            : const SizedBox.shrink(),
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
  final showNewLikeIcon =
      showNewLikeMarker &&
      newLikeInfoReceivedTime != null &&
      currentTime.difference(newLikeInfoReceivedTime).inHours < 24;
  return Align(
    alignment: Alignment.topLeft,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showNewLikeIcon)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.auto_awesome, color: Colors.amber),
          ),
        if (isFavorite)
          Padding(
            padding: showNewLikeIcon ? const EdgeInsets.all(0) : const EdgeInsets.all(4.0),
            child: const Icon(Icons.star_rounded, color: Colors.orange),
          ),
      ],
    ),
  );
}
