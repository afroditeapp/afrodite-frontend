import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/ui/normal/chat/utils.dart';
import 'package:app/utils/cache.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

/// Cache for quoted message entries to avoid flickering
class QuotationCache {
  final RemoveOldestCache<String, MessageEntry> _cache = RemoveOldestCache(maxValues: 50);

  MessageEntry? get(String messageId) => _cache.get(messageId);

  void update(String messageId, MessageEntry entry) => _cache.update(messageId, entry);
}

/// Widget that lazily loads and displays a quoted message
class LazyQuotation extends StatefulWidget {
  final String replyToMessageId;
  final QuotationCache cache;
  final AccountId messageReceiver;

  const LazyQuotation({
    required this.replyToMessageId,
    required this.cache,
    required this.messageReceiver,
    super.key,
  });

  @override
  State<LazyQuotation> createState() => _LazyQuotationState();
}

class _LazyQuotationState extends State<LazyQuotation> {
  late Stream<MessageEntry?> _messageStream;

  @override
  void initState() {
    super.initState();
    final r = context.read<RepositoryInstances>();
    final messageId = MessageId(id: widget.replyToMessageId);
    _messageStream = r.accountDb.accountStream(
      (db) => db.message.getMessageUpdatesUsingMessageId(widget.messageReceiver, messageId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MessageEntry?>(
      stream: _messageStream,
      builder: (context, snapshot) {
        final String quotedText;
        final entry = snapshot.data;

        if (entry != null) {
          widget.cache.update(widget.replyToMessageId, entry);
          final message = entry.message;
          final sentState = entry.messageState.toSentState();
          final receivedState = entry.messageState.toReceivedState();
          quotedText = messageWidgetText(context, message, sentState, receivedState);
        } else {
          final cachedEntry = widget.cache.get(widget.replyToMessageId);
          if (cachedEntry != null) {
            final message = cachedEntry.message;
            final sentState = cachedEntry.messageState.toSentState();
            final receivedState = cachedEntry.messageState.toReceivedState();
            quotedText = messageWidgetText(context, message, sentState, receivedState);
          } else if (snapshot.hasError) {
            quotedText = context.strings.conversation_screen_message_not_found;
          } else {
            quotedText = '';
          }
        }

        return Quotation(text: quotedText);
      },
    );
  }
}

/// Widget that displays a quoted message with consistent styling
class Quotation extends StatelessWidget {
  final String text;

  const Quotation({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final quotationColor = theme.colorScheme.onSurface.withAlpha(128);
    final backgroundColor = theme.colorScheme.onSurface.withAlpha(12);

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(left: BorderSide(color: quotationColor, width: 4.0)),
      ),
      child: Text(
        text,
        style: TextStyle(color: quotationColor, fontSize: 13.0, fontStyle: FontStyle.italic),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
