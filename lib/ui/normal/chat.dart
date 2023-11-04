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

var log = Logger("ChatView");

class ChatView extends BottomNavigationView {
  const ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();

  @override
  String title(BuildContext context) {
    return AppLocalizations.of(context).pageChatListTitle;
  }
}

typedef MatchEntry = (AccountId account, ProfileEntry profile, File img);


class _ChatViewState extends State<ChatView> {
  StreamSubscription<ProfileChange>? _profileChangesSubscription;
  PagingController<int, MatchEntry>? _pagingController =
    PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
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
      case ProfileBlocked():
        // TODO: or hide info and show report option?
        removeAccountIdFromList(event.profile);
      case ProfileNowPrivate() ||
        ProfileUnblocked() ||
        ProfileFavoriteStatusChange() ||
        ConversationChanged() ||
        LikesChanged(): {}
    }
  }

  void removeAccountIdFromList(AccountId accountId) {
    final controller = _pagingController;
    if (controller != null) {
      setState(() {
        controller.itemList?.removeWhere((item) => item.$1.accountId == accountId.accountId);
      });
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    if (pageKey == 0) {
      ChatRepository.getInstance().matchesIteratorReset();
    }

    final profileList = await ChatRepository.getInstance().matchesIteratorNext();

    final newList = List<MatchEntry>.empty(growable: true);
    for (final profile in profileList) {
      final accountId = AccountId(accountId: profile.uuid);
      final contentId = ContentId(contentId: profile.imageUuid);
      final file = await ImageCacheData.getInstance().getImage(accountId, contentId);
      if (file == null) {
        log.warning("Skipping one profile because image loading failed");
        continue;
      }
      newList.add((accountId, profile, file));
    }

    if (profileList.isEmpty) {
      _pagingController?.appendLastPage([]);
    } else {
      _pagingController?.appendPage(newList, pageKey + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: grid(context),
    );
  }

  Widget grid(BuildContext context) {
    return PagedListView(
      pagingController: _pagingController!,
      builderDelegate: PagedChildBuilderDelegate<MatchEntry>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          final profileEntry = item.$2;
          final image = item.$3;
          final String name = profileEntry.name;
          final Widget imageWidget = Image.file(
            image,
            width: 100,
          );

          final textWidget = Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
          final Widget rowWidget = Row(
            children: [
              imageWidget,
              textWidget,
            ],
          );

          return InkWell(
            onTap: () {
              // TODO: Open chat
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 125,
                child: rowWidget,
              ),
            ),
          );
        },
      ),

      // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,
      //   crossAxisSpacing: 4,
      //   mainAxisSpacing: 4,
      // ),
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
