import 'dart:async';

import 'package:app/data/chat_repository.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/app/info_dialog.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/profile_thumbnail_image_or_error.dart';
import 'package:app/utils/result.dart';
import 'package:app/utils/time.dart';
import 'package:async/async.dart' show StreamExtensions;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/data/image_cache.dart';
import 'package:database/database.dart';
import 'package:app/logic/app/bottom_navigation_state.dart';
import 'package:app/logic/chat/conversation_list.dart';
import 'package:app/model/freezed/logic/main/bottom_navigation_state.dart';
import 'package:app/ui/normal/chat/conversation_page.dart';
import 'package:app/ui/normal/chat/message_row.dart';
import 'package:app/ui/normal/chat/select_match.dart';
import 'package:app/ui_utils/app_bar/menu_actions.dart';
import 'package:app/ui_utils/bottom_navigation.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/list.dart';
import 'package:app/ui_utils/scroll_controller.dart';
import 'package:app/utils/cache.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

final _log = Logger("ChatView");

class ChatView extends BottomNavigationScreen {
  final ProfileRepository profile;
  final ChatRepository chat;
  ChatView(RepositoryInstances r, {super.key}) : profile = r.profile, chat = r.chat;

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

  final ConversationListChangeCalculator calculator = ConversationListChangeCalculator();
  int initialItemCount = 0;
  List<AccountId>? items;

  final BehaviorSubject<SliverAnimatedListState?> _listState = BehaviorSubject.seeded(null);
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();

  /// Avoid UI flickering when conversation animation runs
  final RemoveOldestCache<AccountId, ConversationData> dataCache = RemoveOldestCache(maxValues: 25);

  StreamSubscription<void>? _conversationListSubscription;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(scrollEventListener);
    _conversationListSubscription = widget.profile
        .getConversationListUpdates()
        .asyncMap((data) async {
          final current = items;
          final toBeProcessed = calculator.calculate(data);
          if (current == null) {
            setState(() {
              initialItemCount = toBeProcessed.current.length;
              items = toBeProcessed.current;
            });
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final listState = _listKey.currentState;
              if (listState != null) {
                _listState.add(_listKey.currentState);
              }
            });
          } else {
            final listState = await _listState.whereNotNull().firstOrNull;
            if (listState == null) {
              return;
            }
            for (final change in toBeProcessed.changes) {
              switch (change) {
                case AddItem(:final i):
                  _log.finest("Add, i: $i");
                  listState.insertItem(i);
                case RemoveItem(:final i, :final id):
                  _log.finest("Remove, i: $i");
                  listState.removeItem(i, (context, animation) {
                    return animatedItem(
                      context,
                      id: id,
                      animation: animation,
                      allowOpenConversation: false,
                    );
                  });
              }
            }
            setState(() {
              items = toBeProcessed.current;
            });
          }
        })
        .listen(null);
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
      BottomNavigationScreenId.chats,
      (state) => state.isScrolledChats,
    );
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
      return conversationsSupportedWithZeroSizedWidget(context);
    }
  }

  Widget conversationsSupportedWithZeroSizedWidget(BuildContext context) {
    return Column(
      children: [
        Expanded(child: conversationsSupported(context)),

        // Zero sized widgets
        const ChatInfoDialogOpener(),
      ],
    );
  }

  Widget conversationsSupported(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (notification) {
        final isScrolled = notification.metrics.pixels > 0;
        updateIsScrolled(isScrolled);
        return true;
      },
      child: BlocListener<BottomNavigationStateBloc, BottomNavigationStateData>(
        listenWhen: (previous, current) =>
            previous.isTappedAgainChats != current.isTappedAgainChats,
        listener: (context, state) {
          if (state.isTappedAgainChats) {
            context.read<BottomNavigationStateBloc>().add(
              SetIsTappedAgainValue(BottomNavigationScreenId.chats, false),
            );
            _scrollController.bottomNavigationRelatedJumpToBeginningIfClientsConnected();
          }
        },
        child: currentItems(),
      ),
    );
  }

  Widget currentItems() {
    final current = items;
    if (current == null) {
      return SizedBox.shrink();
    } else {
      return listAndEmptyListText(context, current);
    }
  }

  Widget listAndEmptyListText(BuildContext context, List<AccountId> accounts) {
    return Stack(
      children: [
        list(context, accounts),
        if (accounts.isEmpty)
          buildListReplacementMessage(
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
  }

  Widget list(BuildContext context, List<AccountId> accounts) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAnimatedList(
          key: _listKey,
          initialItemCount: initialItemCount,
          itemBuilder: (context, index, animation) {
            return animatedItem(
              context,
              id: accounts[index],
              animation: animation,
              allowOpenConversation: true,
            );
          },
        ),
      ],
    );
  }

  Widget animatedItem(
    BuildContext context, {
    required AccountId id,
    required Animation<double> animation,
    required bool allowOpenConversation,
  }) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: UpdatingConversationListItem(
          // Avoid UI flickering. Probably Flutter tries to reuse
          // old widget in the widget tree and that causes the flickering.
          key: UniqueKey(),
          profile: widget.profile,
          chat: widget.chat,
          dataCache: dataCache,
          id: id,
          allowOpenConversation: allowOpenConversation,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollEventListener);
    _scrollController.dispose();
    _conversationListSubscription?.cancel();
    _listState.close();
    super.dispose();
  }
}

class UpdatingConversationListItem extends StatefulWidget {
  final ProfileRepository profile;
  final ChatRepository chat;
  final RemoveOldestCache<AccountId, ConversationData> dataCache;
  final AccountId id;
  final bool allowOpenConversation;
  const UpdatingConversationListItem({
    required this.profile,
    required this.chat,
    required this.dataCache,
    required this.id,
    required this.allowOpenConversation,
    super.key,
  });

  @override
  State<UpdatingConversationListItem> createState() => _UpdatingConversationListItemState();
}

class _UpdatingConversationListItemState extends State<UpdatingConversationListItem> {
  late final Stream<Result<ConversationData, ()>> stream;

  @override
  void initState() {
    super.initState();
    stream = Rx.combineLatest3(
      widget.profile.getProfileEntryUpdates(widget.id, isMatch: true),
      widget.profile.getUnreadMessagesCountStream(widget.id),
      widget.chat.watchLatestMessage(widget.id),
      (a, b, c) {
        if (a != null) {
          return Ok(ConversationData(a, b ?? const UnreadMessagesCount(0), c));
        } else {
          return Err(());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget w = StreamBuilder(
      stream: stream,
      builder: (context, state) {
        final dataFromStream = state.data;
        final ConversationData? cData;
        switch (dataFromStream) {
          case Ok():
            widget.dataCache.update(widget.id, dataFromStream.v);
            cData = dataFromStream.v;
          case Err():
            return errorWidget(context);
          case null:
            cData = widget.dataCache.get(widget.id);
        }

        if (cData == null) {
          return emptyWidget(context);
        } else {
          return ConversationListItem(
            data: cData,
            allowOpenConversation: widget.allowOpenConversation,
          );
        }
      },
    );

    return SizedBox(height: _IMG_SIZE + _ITEM_PADDING_SIZE * 2, child: w);
  }

  Widget errorWidget(BuildContext context) {
    return Center(
      child: Padding(padding: const EdgeInsets.all(8), child: Text(context.strings.generic_error)),
    );
  }

  Widget emptyWidget(BuildContext context) {
    return SizedBox.shrink();
  }
}

class ConversationListItem extends StatelessWidget {
  final ConversationData data;
  final bool allowOpenConversation;

  const ConversationListItem({required this.data, required this.allowOpenConversation, super.key});

  @override
  Widget build(BuildContext context) {
    final Widget imageWidget = ProfileThumbnailImageOrError.fromProfileEntry(
      entry: data.entry,
      width: _IMG_SIZE,
      height: _IMG_SIZE,
      cacheSize: ImageCacheSize.squareImageForListWithTextContent(context, _IMG_SIZE),
    );
    final Widget textColumn = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [conversationTitle(context, data), ...conversationStatusText(context, data)],
    );
    final Widget rowWidget = Row(
      children: [
        imageWidget,
        Expanded(
          child: Padding(padding: const EdgeInsets.all(8.0), child: textColumn),
        ),
      ],
    );

    final rowAndPadding = Padding(
      padding: const EdgeInsets.all(_ITEM_PADDING_SIZE),
      child: SizedBox(height: _IMG_SIZE, child: rowWidget),
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

  Widget conversationTitle(BuildContext context, ConversationData data) {
    final UtcDateTime? messageTime = data.message?.unixTime ?? data.message?.localUnixTime;
    final TextStyle? textStyle;
    if (data.count.count > 0) {
      textStyle = Theme.of(context).textTheme.titleMedium;
    } else {
      textStyle = Theme.of(context).textTheme.bodyMedium;
    }
    return Row(
      children: [
        Text(
          data.entry.profileTitle(),
          style: Theme.of(context).textTheme.titleMedium,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const Spacer(),
        if (messageTime != null) const Padding(padding: EdgeInsets.only(left: 8)),
        if (messageTime != null) Text(timeString(messageTime), style: textStyle),
      ],
    );
  }

  List<Widget> conversationStatusText(BuildContext context, ConversationData data) {
    final Message? message = data.message?.message;
    final SentMessageState? sentMessageState = data.message?.messageState.toSentState();
    final ReceivedMessageState? receivedMessageState = data.message?.messageState.toReceivedState();
    final TextStyle? textStyle;
    final String text;
    if (data.count.count > 0) {
      textStyle = Theme.of(context).textTheme.titleMedium;
      text = context.strings.chat_list_screen_unread_message;
    } else if (message != null) {
      textStyle = Theme.of(context).textTheme.bodyMedium;
      final messageText = messageWidgetText(
        context,
        message,
        sentMessageState,
        receivedMessageState,
      );
      if (data.message?.messageState.isSent() == true) {
        text = context.strings.chat_list_screen_sent_message_indicator(messageText);
      } else {
        text = messageText;
      }
    } else {
      return [];
    }
    return [
      const Padding(padding: EdgeInsets.only(top: 8.0)),
      Text(text, style: textStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
    ];
  }
}

class ChatInfoDialogOpener extends StatefulWidget {
  const ChatInfoDialogOpener({super.key});

  @override
  State<ChatInfoDialogOpener> createState() => _ChatInfoDialogOpenerState();
}

class _ChatInfoDialogOpenerState extends State<ChatInfoDialogOpener> {
  bool askedOnce = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoDialogBloc, InfoDialogData>(
      builder: (context, state) {
        if (state.chatInfoDialogShown) {
          return const SizedBox.shrink();
        }

        return BlocBuilder<BottomNavigationStateBloc, BottomNavigationStateData>(
          builder: (context, state) {
            if (askedOnce || state.screen != BottomNavigationScreenId.chats) {
              return const SizedBox.shrink();
            }

            askedOnce = true;
            context.read<InfoDialogBloc>().add(MarkChatInfoDialogShown());
            openNotificationPermissionDialog(context);
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  void openNotificationPermissionDialog(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (!context.mounted) {
        return;
      }
      showInfoDialog(context, context.strings.chat_list_screen_info_dialog_text);
    });
  }
}
