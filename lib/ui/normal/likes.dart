import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:pihka_frontend/ui_utils/bottom_navigation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/image.dart';
import 'package:pihka_frontend/ui_utils/list.dart';

var log = Logger("LikeView");

class LikeView extends BottomNavigationScreen {
  const LikeView({Key? key}) : super(key: key);

  @override
  State<LikeView> createState() => _LikeViewState();

  @override
  String title(BuildContext context) {
    return context.strings.likes_screen_title;
  }
}

typedef LikeViewEntry = ({ProfileEntry profile, ProfileHeroTag heroTag});

class _LikeViewState extends State<LikeView> {
  PagingController<int, LikeViewEntry>? _pagingController =
    PagingController(firstPageKey: 0);
  int _heroUniqueIdCounter = 0;
  StreamSubscription<ProfileChange>? _profileChangesSubscription;

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
    ChatRepository.getInstance().receivedLikesIteratorReset();
    // This might be disposed after resetProfileIterator completes.
    _pagingController?.refresh();
  }

  Future<void> _fetchPage(int pageKey) async {
    if (pageKey == 0) {
      ChatRepository.getInstance().receivedLikesIteratorReset();
    }

    final profileList = await ChatRepository.getInstance().receivedLikesIteratorNext();
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
        ChatRepository.getInstance().receivedLikesIteratorReset();
        // This might be disposed after resetProfileIterator completes.
        _pagingController?.refresh();
      },
      child: grid(context),
    );
  }

  Widget grid(BuildContext context) {
    return PagedGridView(
      pagingController: _pagingController!,
      builderDelegate: PagedChildBuilderDelegate<LikeViewEntry>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          return GestureDetector(
            onTap: () => openProfileView(context, item.profile, heroTag: item.heroTag),
            child: Hero(
              tag: item.heroTag.value,
              child: accountImgWidget(item.profile.uuid, item.profile.imageUuid)
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
