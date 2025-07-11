import 'dart:async';

import 'package:app/data/general/iterator/base_iterator_manager.dart';
import 'package:app/logic/profile/view_profiles.dart';
import 'package:app/logic/settings/ui_settings.dart';
import 'package:app/model/freezed/logic/settings/ui_settings.dart';
import 'package:app/ui_utils/extensions/other.dart';
import 'package:app/ui_utils/paged_grid_logic.dart';
import 'package:app/ui_utils/profile_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/data/chat/received_likes_iterator_manager.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/data/profile_repository.dart';
import 'package:database/database.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/logic/app/bottom_navigation_state.dart';
import 'package:app/logic/app/like_grid_instance_manager.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/chat/new_received_likes_available_bloc.dart';
import 'package:app/model/freezed/logic/chat/new_received_likes_available_bloc.dart';
import 'package:app/model/freezed/logic/main/bottom_navigation_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/profiles/profile_grid.dart';
import 'package:app/ui_utils/bottom_navigation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:app/localizations.dart';
import 'package:app/ui_utils/list.dart';
import 'package:app/ui_utils/scroll_controller.dart';
import 'package:app/utils/result.dart';
import 'package:utils/utils.dart';

var log = Logger("LikeView");

class LikeView extends BottomNavigationScreen {
  const LikeView({super.key});

  @override
  State<LikeView> createState() => _LikeViewState();

  @override
  String title(BuildContext context) {
    return context.strings.likes_screen_title;
  }

  @override
  Widget? floatingActionButton(BuildContext context) {
    return refreshLikesFloatingActionButton();
  }
}

/// Use global instance for likes grid as notification navigation makes
/// possible to open a new screen which displays likes. Moving iterator state
/// to here from repository is not possible as server only supports only one
/// iterator instance.
final GlobalKey<LikeViewContentState> likeViewContentState = GlobalKey();

class _LikeViewState extends State<LikeView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikeGridInstanceManagerBloc, LikeGridInstanceManagerData>(
      builder: (context, state) {
        if (state.currentlyVisibleId == 0 && state.visible) {
          return LikeViewContent(
            receivedLikesBloc: context.read<NewReceivedLikesAvailableBloc>(),
            key: likeViewContentState,
          );
        } else if (state.currentlyVisibleId == 0 && !state.visible) {
          final bloc = context.read<LikeGridInstanceManagerBloc>();
          Future.delayed(Duration.zero, () {
            bloc.add(SetVisible(state.currentlyVisibleId));
          });
          return Center(child: Text(context.strings.generic_error));
        } else {
          return Center(child: Text(context.strings.generic_error));
        }
      }
    );
  }
}

NewPageDetails newLikesScreen(
  LikeGridInstanceManagerBloc likeGridInstanceManagerBloc,
) {
  final newGridId = likeGridInstanceManagerBloc.newId();
  return NewPageDetails(
    MaterialPage<void>(
      child: LikesScreen(
        gridInstanceId: newGridId,
        bloc: likeGridInstanceManagerBloc,
      ),
    ),
    pageInfo: const LikesPageInfo(),
  );
}

class LikesScreen extends StatefulWidget {
  final int gridInstanceId;
  final LikeGridInstanceManagerBloc bloc;
  const LikesScreen({
    required this.gridInstanceId,
    required this.bloc,
    super.key,
  });

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  bool likesBadgeResetDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.likes_screen_title),
      ),
      body: content(),
      floatingActionButton: refreshLikesFloatingActionButton(),
    );
  }

  Widget content() {
    if (!likesBadgeResetDone) {
      likesBadgeResetDone = true;
      context.read<NewReceivedLikesAvailableBloc>().add(UpdateReceivedLikesCountNotViewed(0));
    }

    return BlocBuilder<LikeGridInstanceManagerBloc, LikeGridInstanceManagerData>(
      builder: (context, state) {
        if (state.currentlyVisibleId == widget.gridInstanceId && state.visible) {
          return LikeViewContent(
            receivedLikesBloc: context.read<NewReceivedLikesAvailableBloc>(),
            key: likeViewContentState
          );
        } else if (state.currentlyVisibleId == widget.gridInstanceId && !state.visible) {
          final bloc = context.read<LikeGridInstanceManagerBloc>();
          Future.delayed(Duration.zero, () {
            bloc.add(SetVisible(state.currentlyVisibleId));
          });
          return const SizedBox.shrink();
        } else {
          return const SizedBox.shrink();
        }
      }
    );
  }

  @override
  void dispose() {
    widget.bloc.popId();
    super.dispose();
  }
}

class LikeViewContent extends StatefulWidget {
  final NewReceivedLikesAvailableBloc receivedLikesBloc;
  const LikeViewContent({
    required this.receivedLikesBloc,
    super.key,
  });


  @override
  State<LikeViewContent> createState() => LikeViewContentState();
}

class LikeViewContentState extends State<LikeViewContent> {
  final ScrollController _scrollController = ScrollController();
  PagingState<int, ProfileGridProfileEntry> _pagingState = PagingState();
  StreamSubscription<ProfileChange>? _profileChangesSubscription;

  final ChatRepository chatRepository = LoginRepository.getInstance().repositories.chat;
  final ProfileRepository profileRepository = LoginRepository.getInstance().repositories.profile;

  final AccountDatabaseManager accountDb = LoginRepository.getInstance().repositories.accountDb;

  final UiProfileIterator _mainProfilesViewIterator = ReceivedLikesIteratorManager(
    LoginRepository.getInstance().repositories.chat,
    LoginRepository.getInstance().repositories.media,
    LoginRepository.getInstance().repositories.accountBackgroundDb,
    LoginRepository.getInstance().repositories.accountDb,
    LoginRepository.getInstance().repositories.connectionManager,
    LoginRepository.getInstance().repositories.chat.currentUser,
  );
  bool _onLoginReloadDoneOnce = false;
  UtcDateTime? _previousAutomaticReloadTime;

  final PagedGridLogic _gridLogic = PagedGridLogic();
  bool isDisposed = false;

  @override
  void initState() {
    super.initState();
    _gridLogic.init();
    _mainProfilesViewIterator.reset(false);
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = profileRepository.profileChanges.listen((event) {
      _handleProfileChange(event);
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
        BottomNavigationScreenId.likes,
        (state) => state.isScrolledLikes,
      );
  }

  void _handleProfileChange(ProfileChange event) {
    switch (event) {
      case ProfileNowPrivate():
        _removeAccountIdFromList(event.profile);
      case ProfileBlocked():
        _removeAccountIdFromList(event.profile);
      case ProfileUnblocked() ||
        ConversationChanged() ||
        ReloadMainProfileView() ||
        ProfileFavoriteStatusChange(): {}
    }
  }

  void updatePagingState(PagingState<int, ProfileGridProfileEntry> Function(PagingState<int, ProfileGridProfileEntry>) action) {
    if (isDisposed || !context.mounted) {
      return;
    }
    setState(() {
      _pagingState = action(_pagingState);
    });
  }

  void _removeAccountIdFromList(AccountId accountId) {
    updatePagingState((s) => s.filterItems((item) => item.profile.entry.uuid != accountId));
  }

  Future<List<ProfileGridProfileEntry>?> _fetchPage() async {
    if (!_pagingState.hasNextPage) {
      return null;
    }

    await Future<void>.value();

    updatePagingState((s) => s.copyAndShowLoading());

    if (_pagingState.isInitialPage()) {
      _mainProfilesViewIterator.resetToBeginning();
    }

    final profileList = await _mainProfilesViewIterator.nextList().ok();
    if (profileList == null) {
      updatePagingState((s) => s.copyAndShowError());
      return null;
    }

    final newList = List<ProfileGridProfileEntry>.empty(growable: true);
    for (final profile in profileList) {
      final initialProfileAction = await resolveProfileAction(chatRepository, profile.uuid);
      final isFavorite = await profileRepository.isInFavorites(profile.uuid);
      newList.add((
        profile: ProfileThumbnail(entry: profile, isFavorite: isFavorite),
        initialProfileAction: initialProfileAction,
      ));
    }

    return newList;
  }

  void _addPage(List<ProfileGridProfileEntry> page) {
    updatePagingState((s) => s.copyAndAdd(page));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.receivedLikesBloc.add(UpdateReceivedLikesCountNotViewed(0));
        await refreshProfileGrid();
      },
      child: NotificationListener<ScrollMetricsNotification>(
        onNotification: (notification) {
          final isScrolled = notification.metrics.pixels > 0;
          updateIsScrolled(isScrolled);
          return true;
        },
        child: BlocListener<BottomNavigationStateBloc, BottomNavigationStateData>(
          listenWhen: (previous, current) => previous.isTappedAgainLikes != current.isTappedAgainLikes,
          listener: (context, state) {
            if (state.isTappedAgainLikes) {
              context.read<BottomNavigationStateBloc>().add(SetIsTappedAgainValue(BottomNavigationScreenId.likes, false));
              _scrollController.bottomNavigationRelatedJumpToBeginningIfClientsConnected();
            }
          },
          child: Column(children: [
            Expanded(
              child: BlocBuilder<UiSettingsBloc, UiSettingsData>(
                buildWhen: (previous, current) => previous.gridSettings != current.gridSettings,
                builder: (context, uiSettings) {
                  return grid(context, uiSettings.gridSettings);
                }
              ),
            ),
            logicRefreshLikesCommandFromFloatingActionButton(),
            logicResetLikesCountWhenLikesScreenOpens(),
            logicAutomaticReload(),
          ],),
        ),
      ),
    );
  }

  Widget grid(BuildContext context, GridSettings settings) {
    return PagedGridView(
      state: _pagingState,
      fetchNextPage: () {
        _gridLogic.fetchPage(_fetchPage, _addPage);
      },
      physics: const AlwaysScrollableScrollPhysics(),
      scrollController: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: settings.valueHorizontalPadding()),
      builderDelegate: PagedChildBuilderDelegate<ProfileGridProfileEntry>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          return profileEntryWidgetStream(
            item.profile,
            item.initialProfileAction,
            accountDb,
            settings,
            showNewLikeMarker: true,
          );
        },
        noItemsFoundIndicatorBuilder: (context) {
          return buildListReplacementMessage(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.strings.likes_screen_no_received_likes_found,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        },
        firstPageErrorIndicatorBuilder: (context) {
          return errorDetectedWidgetWithRetryButton(context);
        },
        newPageErrorIndicatorBuilder: (context) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(context.strings.likes_screen_like_loading_failed),
            ),
          );
        },
      ),
      gridDelegate: settings.toSliverGridDelegate(),
    );
  }

  Widget errorDetectedWidgetWithRetryButton(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Text(context.strings.likes_screen_like_loading_failed),
          const Padding(padding: EdgeInsets.all(8)),
          ElevatedButton(
            onPressed: () {
              context.read<NewReceivedLikesAvailableBloc>().add(UpdateReceivedLikesCountNotViewed(0));
              refreshProfileGrid();
            },
            child: Text(context.strings.generic_try_again),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }

  Widget logicRefreshLikesCommandFromFloatingActionButton() {
    return BlocBuilder<NewReceivedLikesAvailableBloc, NewReceivedLikesAvailableData>(
      buildWhen: (previous, current) => previous.triggerReceivedLikesRefresh != current.triggerReceivedLikesRefresh,
      builder: (context, state) {
        if (state.triggerReceivedLikesRefresh) {
          final bloc = context.read<NewReceivedLikesAvailableBloc>();
          bloc.add(UpdateReceivedLikesCountNotViewed(0));
          bloc.add(SetTriggerReceivedLikesRefreshWithButton(false));
          refreshProfileGrid();
        }
        return const SizedBox.shrink();
      }
    );
  }

  Widget logicResetLikesCountWhenLikesScreenOpens() {
    return BlocBuilder<BottomNavigationStateBloc, BottomNavigationStateData>(
      buildWhen: (previous, current) => previous.screen != current.screen,
      builder: (context, state) {
        if (state.screen == BottomNavigationScreenId.likes) {
          final bloc = context.read<NewReceivedLikesAvailableBloc>();
          bloc.add(UpdateReceivedLikesCountNotViewed(0));
        }
        return const SizedBox.shrink();
      }
    );
  }

  Widget logicAutomaticReload() {
    return BlocBuilder<NewReceivedLikesAvailableBloc, NewReceivedLikesAvailableData>(
      buildWhen: (previous, current) => previous.newReceivedLikesCount != current.newReceivedLikesCount,
      builder: (context, state) {
        final currentTime = UtcDateTime.now();
        final previousTime = _previousAutomaticReloadTime;
        final enoughTimeElapsedFromPreviousReload = previousTime == null ||
          currentTime.difference(previousTime).inSeconds > 5;

        if (!enoughTimeElapsedFromPreviousReload) {
          return const SizedBox.shrink();
        }

        final repositories = LoginRepository.getInstance().repositoriesOrNull;
        if (state.newReceivedLikesCount == 0 && repositories != null && repositories.accountLoginHappened && !_onLoginReloadDoneOnce) {
          // This exits to get current received likes from the server after
          // login.
          automaticReloadLogic(state);
          _onLoginReloadDoneOnce = true;
          _previousAutomaticReloadTime = currentTime;
        } else if (state.newReceivedLikesCount > 0 && !context.read<BottomNavigationStateBloc>().state.isScrolledLikes) {
          automaticReloadLogic(state);
          _onLoginReloadDoneOnce = true;
          _previousAutomaticReloadTime = currentTime;
        }

        return const SizedBox.shrink();
      }
    );
  }

  Future<void> automaticReloadLogic(NewReceivedLikesAvailableData state) async {
    final bloc = widget.receivedLikesBloc;
    final navigationBlocState = BottomNavigationStateBlocInstance.getInstance().navigationState;
    // Refresh resets server side new likes count so it needs to be saved
    // to keep the count badge visible.
    if (navigationBlocState.screen != BottomNavigationScreenId.likes) {
      log.info("Automatic like screen refresh on background");
      final newReceivedLikesCountBeforeReload = bloc.state.newReceivedLikesCount;
      final event = UpdateReceivedLikesCountNotViewed(newReceivedLikesCountBeforeReload);
      bloc.add(event);
      await event.waitDone.firstWhere((v) => v);
    } else {
      log.info("Automatic like screen refresh");
    }
    await refreshProfileGrid();
  }

  Future<void> refreshProfileGrid() async {
    _gridLogic.refresh(() {
      _mainProfilesViewIterator.reset(true);
      updatePagingState((_) => PagingState());
    }, _fetchPage, _addPage);
  }

  @override
  void dispose() {
    isDisposed = true;
    _gridLogic.dispose();
    _scrollController.removeListener(scrollEventListener);
    _scrollController.dispose();
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = null;
    super.dispose();
  }
}

Widget refreshLikesFloatingActionButton() {
  return BlocBuilder<NewReceivedLikesAvailableBloc, NewReceivedLikesAvailableData>(
    builder: (context, state) {
      if (state.showRefreshButton) {
        final bloc = context.read<NewReceivedLikesAvailableBloc>();
        return FloatingActionButton.extended(
          onPressed: () => bloc.add(SetTriggerReceivedLikesRefreshWithButton(true)),
          label: Text(context.strings.likes_screen_refresh_action),
          icon: const Icon(Icons.refresh),
        );
      } else {
        return const SizedBox.shrink();
      }
    }
  );
}
