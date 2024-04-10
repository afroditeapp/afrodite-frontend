import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/logic/chat/conversation_bloc.dart';
import 'package:pihka_frontend/ui/normal/chat/conversation_page.dart';
import 'package:pihka_frontend/ui_utils/bottom_navigation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/image.dart';

var log = Logger("ChatView");

class ChatView extends BottomNavigationScreen {
  const ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();

  @override
  String title(BuildContext context) {
    return context.strings.pageChatListTitle;
  }
}

typedef MatchEntry = (AccountId account, ProfileEntry profile);


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
      case MatchesChanged():
        _pagingController?.refresh();
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
      final file = await ImageCacheData.getInstance().getImage(profile.uuid, profile.imageUuid);
      if (file == null) {
        log.warning("Skipping one profile because image loading failed");
        continue;
      }
      newList.add((profile.uuid, profile));
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
          final String name = profileEntry.name;
          final Widget imageWidget = accountImgWidget(
            profileEntry.uuid,
            profileEntry.imageUuid,
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
            onTap: () => openConversationScreen(context, profileEntry),
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
