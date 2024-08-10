import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/logic/app/bottom_navigation_state.dart';
import 'package:pihka_frontend/logic/app/like_grid_instance_manager.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/model/freezed/logic/main/bottom_navigation_state.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:pihka_frontend/ui_utils/bottom_navigation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';
import 'package:pihka_frontend/ui_utils/list.dart';
import 'package:pihka_frontend/ui_utils/profile_thumbnail_image.dart';
import 'package:pihka_frontend/ui_utils/scroll_controller.dart';

var log = Logger("LikeView");

class LikeView extends BottomNavigationScreen {
  const LikeView({super.key});

  @override
  State<LikeView> createState() => _LikeViewState();

  @override
  String title(BuildContext context) {
    return context.strings.likes_screen_title;
  }
}

/// Use global instance for likes grid as notification navigation makes
/// possible to open a new screen which displays likes. Moving iterator state
/// to here from repository is not possible currently as there will be
/// server API change which changes likes to have paging.
final GlobalKey<LikeViewContentState> likeViewContentState = GlobalKey();

/*

TODO(prod): Remove likeViewContentState once server API paging is better (multiple
iterators are supported).

If that is not done perhaps open the likes screen only when the original widget
is disappeared.

════════ Exception caught by widgets library ═══════════════════════════════════
The following assertion was thrown while finalizing the widget tree:
Multiple widgets used the same GlobalKey.
The key [LabeledGlobalKey<LikeViewContentState>#099b4] was used by multiple widgets. The parents of those widgets were:
- BlocListener<LikeGridInstanceManagerBloc, int>(state: _BlocListenerBaseState<LikeGridInstanceManagerBloc, int>#c21cd)
- BlocListener<LikeGridInstanceManagerBloc, int>(state: _BlocListenerBaseState<LikeGridInstanceManagerBloc, int>#85737)
A GlobalKey can only be specified on one widget at a time in the widget tree.

*/

class _LikeViewState extends State<LikeView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikeGridInstanceManagerBloc, LikeGridInstanceManagerData>(
      builder: (context, state) {
        if (state.currentlyVisibleId == 0) {
          return LikeViewContent(key: likeViewContentState);
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
    Key? key,
  }) : super(key: key);

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.likes_screen_title),
      ),
      body: content(),
    );
  }

  Widget content() {
    return BlocBuilder<LikeGridInstanceManagerBloc, LikeGridInstanceManagerData>(
      builder: (context, state) {
        if (state.currentlyVisibleId == widget.gridInstanceId) {
          return LikeViewContent(key: likeViewContentState);
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
  const LikeViewContent({Key? key}) : super(key: key);

  @override
  State<LikeViewContent> createState() => LikeViewContentState();
}

typedef LikeViewEntry = ({ProfileEntry profile, ProfileHeroTag heroTag});

class LikeViewContentState extends State<LikeViewContent> {
  final ScrollController _scrollController = ScrollController();
  PagingController<int, LikeViewEntry>? _pagingController =
    PagingController(firstPageKey: 0);
  int _heroUniqueIdCounter = 0;
  StreamSubscription<ProfileChange>? _profileChangesSubscription;

  final ChatRepository chat = LoginRepository.getInstance().repositories.chat;

  @override
  void initState() {
    super.initState();
    _heroUniqueIdCounter = 0;
    _pagingController?.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = ProfileRepository.getInstance().profileChanges.listen((event) {
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
      .bloc
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
      case LikesChanged():
        _refreshLikes();
      case ProfileUnblocked() ||
        ConversationChanged() ||
        MatchesChanged() ||
        ReloadMainProfileView() ||
        ProfileFavoriteStatusChange(): {}
    }
  }

  void _removeAccountIdFromList(AccountId accountId) {
    final controller = _pagingController;
    if (controller != null) {
      setState(() {
        controller.itemList?.removeWhere((item) => item.profile.uuid == accountId);
      });
    }
  }

  void _refreshLikes() {
    chat.receivedLikesIteratorReset();
    // This might be disposed after resetProfileIterator completes.
    _pagingController?.refresh();
  }

  Future<void> _fetchPage(int pageKey) async {
    if (pageKey == 0) {
      chat.receivedLikesIteratorReset();
    }

    final profileList = await chat.receivedLikesIteratorNext();
    final newList = List<LikeViewEntry>.empty(growable: true);
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
        chat.receivedLikesIteratorReset();
        // This might be disposed after resetProfileIterator completes.
        _pagingController?.refresh();
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
          child: grid(context),
        ),
      ),
    );
  }

  Widget grid(BuildContext context) {
    return PagedGridView(
      pagingController: _pagingController!,
      padding: const EdgeInsets.symmetric(horizontal: COMMON_SCREEN_EDGE_PADDING),
      builderDelegate: PagedChildBuilderDelegate<LikeViewEntry>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          return GestureDetector(
            // This callback should be used when Hero animation is enabled.
            // onTap: () => openProfileView(context, item.profile, heroTag: item.heroTag),
            child: Hero(
              tag: item.heroTag.value,
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
    _scrollController.removeListener(scrollEventListener);
    _scrollController.dispose();
    _pagingController?.dispose();
    _pagingController = null;
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = null;
    super.dispose();
  }
}
