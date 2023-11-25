import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/profile/profile_iterator_manager.dart';
import 'package:pihka_frontend/data/profile/profile_list/online_iterator.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/database/profile_database.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
import 'package:pihka_frontend/logic/profile/profile_filtering_settings/profile_filtering_settings.dart';
import 'package:pihka_frontend/logic/profile/view_profiles/view_profiles.dart';
import 'package:pihka_frontend/ui/normal/profiles/filter_profiles.dart';
import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:pihka_frontend/ui/utils.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pihka_frontend/ui/utils/image_page.dart';
import 'package:pihka_frontend/ui/utils/view_profile.dart';

var log = Logger("LikeView");

class LikeView extends BottomNavigationView {
  const LikeView({Key? key}) : super(key: key);

  @override
  _LikeViewState createState() => _LikeViewState();

  @override
  String title(BuildContext context) {
    return AppLocalizations.of(context).pageLikesTitle;
  }
}

typedef LikeViewEntry = (ProfileEntry profile, File img, int heroNumber);

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
        ProfileFavoriteStatusChange(): {}
    }
  }

  void _removeAccountIdFromList(AccountId accountId) {
    final controller = _pagingController;
    if (controller != null) {
      setState(() {
        controller.itemList?.removeWhere((item) => item.$1.uuid == accountId.accountId);
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
      final accountId = AccountId(accountId: profile.uuid);
      final contentId = ContentId(contentId: profile.imageUuid);
      final file = await ImageCacheData.getInstance().getImage(accountId, contentId);
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
          final accountId = AccountId(accountId: item.$1.uuid);
          final heroTag = (accountId, item.$3);
          return GestureDetector(
            onTap: () {
              openProfileView(context, accountId, item.$1, item.$2, heroTag);
            },
            child: Hero(
              tag: heroTag,
              child: Image.file(item.$2)
            )
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
