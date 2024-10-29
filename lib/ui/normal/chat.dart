
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/logic/app/bottom_navigation_state.dart';
import 'package:pihka_frontend/logic/chat/conversation_list_bloc.dart';
import 'package:pihka_frontend/logic/settings/user_interface.dart';
import 'package:pihka_frontend/model/freezed/logic/chat/conversation_list_bloc.dart';
import 'package:pihka_frontend/model/freezed/logic/main/bottom_navigation_state.dart';
import 'package:pihka_frontend/ui/normal/chat/conversation_page.dart';
import 'package:pihka_frontend/ui/normal/chat/message_row.dart';
import 'package:pihka_frontend/ui/normal/chat/select_match.dart';
import 'package:pihka_frontend/ui_utils/app_bar/menu_actions.dart';
import 'package:pihka_frontend/ui_utils/bottom_navigation.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/list.dart';
import 'package:pihka_frontend/ui_utils/profile_thumbnail_image.dart';
import 'package:pihka_frontend/ui_utils/scroll_controller.dart';
import 'package:pihka_frontend/utils/cache.dart';
import 'package:pihka_frontend/utils/immutable_list.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("ChatView");

class ChatView extends BottomNavigationScreen {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();

  @override
  List<Widget> actions(BuildContext context) {
    return [
      menuActions([
        MenuItemButton(
          child: Text(context.strings.chat_list_screen_open_matches_screen_action),
          onPressed: () async {
            final entry = await openSelectMatchView(context);
            if (entry == null || !context.mounted) {
              return;
            }
            openConversationScreen(context, entry);
          },
        ),
      ]),
    ];
  }

  @override
  String title(BuildContext context) {
    return context.strings.chat_list_screen_title;
  }
}

typedef MatchEntry = ProfileEntry;

const _IMG_SIZE = 100.0;
const _ITEM_PADDING_SIZE = 8.0;

class ConversationData {
  final ProfileEntry entry;
  final UnreadMessagesCount count;
  final MessageEntry? message;
  ConversationData(this.entry, this.count, this.message);
}

class _ChatViewState extends State<ChatView> {
  final ScrollController _scrollController = ScrollController();

  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;
  final ChatRepository chat = LoginRepository.getInstance().repositories.chat;

  int? initialItemCount;
  UnmodifiableList<AccountId> conversations = const UnmodifiableList<AccountId>.empty();

  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();

  /// Avoid UI flickering when conversation animation runs
  final RemoveOldestCache<AccountId, ConversationData> dataCache =
    RemoveOldestCache(maxValues: 25);

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

  Stream<ConversationData> conversationData(AccountId id) {
    return Rx.combineLatest3(
      profile.getProfileEntryUpdates(id),
      profile.getUnreadMessagesCountStream(id),
      chat.watchLatestMessage(id),
      (a, b, c) {
        if (a != null) {
          return ConversationData(
            a,
            b ?? const UnreadMessagesCount(0),
            c,
          );
        } else {
          return null;
        }
      },
    ).whereNotNull();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return buildListReplacementMessage(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.strings.generic_not_supported_on_web,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
    } else {
      return conversationsSupported(context);
    }
  }

  Widget conversationsSupported(BuildContext context) {
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
                    case AddItem(:final i):
                      log.finest("Add, i: $i");
                      listState.insertItem(i);
                    case RemoveItem(:final i, :final id):
                      log.finest("Remove, i: $i");
                      listState.removeItem(
                        i,
                        (context, animation) {
                          return SizeTransition(
                            sizeFactor: animation,
                            child: FadeTransition(
                              opacity: animation,
                              child: itemWidgetForAnimation(context, id, allowOpenConversation: false),
                            )
                          );
                        }
                      );
                  }
                }
              }
              initialItemCount ??= state.conversations.length;
              conversations = state.conversations;
              return Stack(
                children: [
                  grid(context),
                  if (conversations.isEmpty) buildListReplacementMessage(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.strings.chat_list_screen_no_chats_found,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget grid(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAnimatedList(
          key: _listKey,
          initialItemCount: initialItemCount!,
          itemBuilder: (context, index, animation) {
            return SizeTransition(
              sizeFactor: animation,
              child: FadeTransition(
                opacity: animation,
                child: itemWidgetForAnimation(
                  context,
                  // It is not sure is getAtOrNull needed or not
                  conversations.getAtOrNull(index),
                  allowOpenConversation: true,
                ),
              )
            );
          },
        ),
      ],
    );
  }

  Widget errorWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(context.strings.generic_error),
      ),
    );
  }

  Widget itemWidgetForAnimation(BuildContext context, AccountId? id, {required bool allowOpenConversation}) {
    Widget w;
    if (id == null) {
      w = errorWidget(context);
    } else {
      w = StreamBuilder(
        // Avoid UI flickering. Probably Flutter tries to reuse
        // old widget in the widget tree and that causes the flickering.
        key: UniqueKey(),
        stream: conversationData(id),
        builder: (context, state) {
          final dataFromStream = state.data;
          final ConversationData? cData;
          if (dataFromStream == null) {
            cData = dataCache.get(id);
          } else {
            dataCache.update(id, dataFromStream);
            cData = dataFromStream;
          }

          if (cData == null) {
            return errorWidget(context);
          } else {
            return conversationItem(cData, allowOpenConversation: allowOpenConversation);
          }
        },
      );
    }

    return SizedBox(
      height: _IMG_SIZE + _ITEM_PADDING_SIZE * 2,
      child: w,
    );
  }

  Widget conversationItem(
    ConversationData data,
    {required bool allowOpenConversation}
  ) {
    final Widget imageWidget = ProfileThumbnailImage.fromProfileEntry(
      entry: data.entry,
      width: _IMG_SIZE,
      height: _IMG_SIZE,
      cacheSize: ImageCacheSize.sizeForAppBarThumbnail(),
    );
    final Widget textColumn = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.entry.profileTitle(
            context.read<UserInterfaceSettingsBloc>().state.showNonAcceptedProfileNames,
          ),
          style: Theme.of(context).textTheme.titleMedium,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        ...conversationStatusText(context, data),
      ],
    );
    final Widget rowWidget = Row(
      children: [
        imageWidget,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: textColumn,
          ),
        ),
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
        onTap: () => openConversationScreen(context, data.entry),
        child: rowAndPadding,
      );
    } else {
      return rowAndPadding;
    }
  }

  List<Widget> conversationStatusText(BuildContext context, ConversationData data) {
    final String? messageText = data.message?.messageText;
    final SentMessageState? sentMessageState = data.message?.messageState.toSentState();
    final ReceivedMessageState? receivedMessageState = data.message?.messageState.toReceivedState();
    final TextStyle? textStyle;
    final String text;
    if (data.count.count > 0) {
      textStyle = Theme.of(context).textTheme.titleMedium;
      text = context.strings.chat_list_screen_unread_message;
    } else if (messageText != null) {
      textStyle = Theme.of(context).textTheme.bodyMedium;
      text = messageWidgetText(context, messageText, sentMessageState, receivedMessageState);
    } else {
      return [];
    }
    return [
      const Padding(padding: EdgeInsets.only(top: 8.0)),
      Text(
        text,
        style: textStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ];
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollEventListener);
    _scrollController.dispose();
    super.dispose();
  }
}
