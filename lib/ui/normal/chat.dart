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
import 'package:pihka_frontend/model/freezed/logic/main/bottom_navigation_state.dart';
import 'package:pihka_frontend/ui/normal/chat/conversation_page.dart';
import 'package:pihka_frontend/ui_utils/bottom_navigation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/list.dart';
import 'package:pihka_frontend/ui_utils/profile_thumbnail_image.dart';
import 'package:pihka_frontend/ui_utils/scroll_controller.dart';

var log = Logger("ChatView");

class ChatView extends BottomNavigationScreen {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();

  @override
  String title(BuildContext context) {
    return context.strings.chat_list_screen_title;
  }
}

typedef MatchEntry = ProfileEntry;

const _IMG_SIZE = 100.0;

class _ChatViewState extends State<ChatView> {
  final ScrollController _scrollController = ScrollController();
  StreamSubscription<ProfileChange>? _profileChangesSubscription;
  PagingController<int, MatchEntry>? _pagingController =
    PagingController(firstPageKey: 0);

  final ChatRepository chat = LoginRepository.getInstance().repositories.chat;
  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;

  @override
  void initState() {
    super.initState();
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
        BottomNavigationScreenId.chats,
        (state) => state.isScrolledChats,
      );
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
        ReloadMainProfileView() ||
        LikesChanged(): {}
    }
  }

  void removeAccountIdFromList(AccountId accountId) {
    final controller = _pagingController;
    if (controller != null) {
      setState(() {
        controller.itemList?.removeWhere((item) => item.uuid == accountId);
      });
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    if (pageKey == 0) {
      chat.matchesIteratorReset();
    }

    final profileList = await chat.matchesIteratorNext();

    if (profileList.isEmpty) {
      _pagingController?.appendLastPage([]);
    } else {
      _pagingController?.appendPage(profileList, pageKey + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (notification) {
        final isScrolled = notification.metrics.pixels > 0;
        updateIsScrolled(isScrolled);
        return true;
      },
      child: BlocListener<BottomNavigationStateBloc, BottomNavigationStateData>(
        listenWhen: (previous, current) => previous.isTappedAgainChats != current.isTappedAgainChats,
        listener: (context, state) {
          if (state.isTappedAgainChats) {
            context.read<BottomNavigationStateBloc>().add(SetIsTappedAgainValue(BottomNavigationScreenId.chats, false));
            _scrollController.bottomNavigationRelatedJumpToBeginningIfClientsConnected();
          }
        },
        child: grid(context),
      ),
    );
  }

  Widget grid(BuildContext context) {
    return PagedListView(
      scrollController: _scrollController,
      pagingController: _pagingController!,
      builderDelegate: PagedChildBuilderDelegate<MatchEntry>(
        animateTransitions: true,
        itemBuilder: (context, profileEntry, index) {
          final Widget imageWidget = ProfileThumbnailImage.fromProfileEntry(
            entry: profileEntry,
            width: _IMG_SIZE,
            height: _IMG_SIZE,
            cacheSize: ImageCacheSize.sizeForAppBarThumbnail(),
          );
          final textWidget = Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              profileEntry.profileTitle(),
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
                height: _IMG_SIZE,
                child: rowWidget,
              ),
            ),
          );
        },
        noItemsFoundIndicatorBuilder: (context) {
          return buildListReplacementMessage(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.strings.chat_list_screen_no_chats_or_matches_found,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
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
    _scrollController.removeListener(scrollEventListener);
    _scrollController.dispose();
    _pagingController?.dispose();
    _pagingController = null;
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = null;
    super.dispose();
  }
}
