
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/logic/app/bottom_navigation_state.dart';
import 'package:pihka_frontend/logic/chat/conversation_list_bloc.dart';
import 'package:pihka_frontend/model/freezed/logic/chat/conversation_list_bloc.dart';
import 'package:pihka_frontend/model/freezed/logic/main/bottom_navigation_state.dart';
import 'package:pihka_frontend/ui/normal/chat/conversation_page.dart';
import 'package:pihka_frontend/ui_utils/bottom_navigation.dart';

import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/profile_thumbnail_image.dart';
import 'package:pihka_frontend/ui_utils/scroll_controller.dart';
import 'package:pihka_frontend/utils/immutable_list.dart';

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
const _ITEM_PADDING_SIZE = 8.0;

class _ChatViewState extends State<ChatView> {
  final ScrollController _scrollController = ScrollController();

  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;

  int? initialItemCount;
  UnmodifiableList<IdAndEntry> conversations = const UnmodifiableList<IdAndEntry>.empty();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
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
        child: BlocBuilder<ConversationListBloc, ConversationListData>(
          builder: (context, state) {
            if (state.initialLoadDone) {
              final listState = _listKey.currentState;
              if (initialItemCount != null && listState != null) {

                // Animations
                for (final change in state.changesBetweenCurrentAndPrevious) {
                  switch (change) {
                    case AddItemEntry(:final i):
                      log.finest("Add, i: $i");
                      listState.insertItem(i);
                    case RemoveItemEntry(:final i, :final entry):
                      log.finest("Remove, i: $i");
                      listState.removeItem(
                        i,
                        (context, animation) {
                          return SizeTransition(
                            sizeFactor: animation,
                            child: FadeTransition(
                              opacity: animation,
                              child: itemWidgetForAnimation(context, entry, allowOpenConversation: false),
                            )
                          );
                        }
                      );
                  }
                }
              }
              initialItemCount ??= state.conversations.length;
              conversations = state.conversations;
              return grid(context);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget grid(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      controller: _scrollController,
      initialItemCount: initialItemCount!,
      itemBuilder: (context, index, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: FadeTransition(
            opacity: animation,
            child: itemWidgetForAnimation(
              context,
              // It is not sure is getAtOrNull needed or not
              conversations.getAtOrNull(index)?.entry,
              allowOpenConversation: true,
            ),
          )
        );
      },
    );
  }

  Widget itemWidgetForAnimation(BuildContext context, ProfileEntry? entry, {required bool allowOpenConversation}) {
    Widget w;
    if (entry == null) {
      w = Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(context.strings.generic_error),
        ),
      );
    } else {
      w = conversationItem(entry, allowOpenConversation: allowOpenConversation);
    }

    return SizedBox(
      height: _IMG_SIZE + _ITEM_PADDING_SIZE * 2,
      child: w,
    );
  }

  Widget conversationItem(
    ProfileEntry profileEntry,
    {required bool allowOpenConversation}
  ) {
    final Widget imageWidget = ProfileThumbnailImage.fromProfileEntry(
      entry: profileEntry,
      width: _IMG_SIZE,
      height: _IMG_SIZE,
      cacheSize: ImageCacheSize.sizeForAppBarThumbnail(),
      // NOTE: There seems to be duplicate single color images sometimes after
      // conversation position changes if widget
      // tree does not have other unique content (like the AccountId visible).
      // The GlobalKey seems to fix that.
      key: GlobalKey(),
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

    final rowAndPadding = Padding(
      padding: const EdgeInsets.all(_ITEM_PADDING_SIZE),
      child: SizedBox(
        height: _IMG_SIZE,
        child: rowWidget,
      ),
    );

    if (allowOpenConversation) {
      return InkWell(
        onTap: () => openConversationScreen(context, profileEntry),
        child: rowAndPadding,
      );
    } else {
      return rowAndPadding;
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollEventListener);
    _scrollController.dispose();
    super.dispose();
  }
}
