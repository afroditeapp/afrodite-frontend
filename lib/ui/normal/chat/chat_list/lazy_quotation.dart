import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/ui/normal/chat/utils.dart';
import 'package:app/utils/cache.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

/// Represents the different states of a quoted message
sealed class QuotationState {}

/// Message was loaded successfully
class QuotationLoaded extends QuotationState {
  final MessageEntry entry;
  QuotationLoaded(this.entry);
}

/// Message was not found
class QuotationNotFound extends QuotationState {}

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
  final ProfileEntry? profileEntry;

  const LazyQuotation({
    required this.replyToMessageId,
    required this.cache,
    required this.messageReceiver,
    required this.profileEntry,
    super.key,
  });

  @override
  State<LazyQuotation> createState() => _LazyQuotationState();
}

class _LazyQuotationState extends State<LazyQuotation> {
  late Stream<QuotationState> _quotationStream;

  @override
  void initState() {
    super.initState();
    final r = context.read<RepositoryInstances>();
    final messageId = MessageId(id: widget.replyToMessageId);
    _quotationStream = r.accountDb
        .accountStream(
          (db) => db.message.getMessageUpdatesUsingMessageId(widget.messageReceiver, messageId),
        )
        .map((entry) {
          if (entry != null) {
            widget.cache.update(widget.replyToMessageId, entry);
            return QuotationLoaded(entry);
          } else {
            return QuotationNotFound();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuotationState>(
      stream: _quotationStream,
      builder: (context, snapshot) {
        final data = snapshot.data;

        if (data == null) {
          final cached = widget.cache.get(widget.replyToMessageId);
          if (cached != null) {
            return buildQuotation(context, cached, widget.profileEntry);
          }
          return const Quotation(text: '', senderName: '');
        }

        return switch (data) {
          QuotationLoaded(:final entry) => buildQuotation(context, entry, widget.profileEntry),
          QuotationNotFound() => Quotation(
            text: context.strings.conversation_screen_message_not_found,
            senderName: '',
          ),
        };
      },
    );
  }
}

Widget buildQuotation(BuildContext context, MessageEntry entry, ProfileEntry? profileEntry) {
  final message = entry.message;
  final sentState = entry.messageState.toSentState();
  final receivedState = entry.messageState.toReceivedState();
  final quotedText = messageWidgetText(context, message, sentState, receivedState);

  // Determine sender: if sent state exists, it's from current user
  final senderName = sentState != null
      ? context.strings.generic_you
      : profileEntry?.profileTitle() ?? '';

  return Quotation(text: quotedText, senderName: senderName);
}

/// Widget that displays a quoted message with consistent styling
class Quotation extends StatelessWidget {
  final String text;
  final String senderName;

  const Quotation({required this.text, required this.senderName, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final quotationColor = theme.colorScheme.onSurface.withAlpha(128);
    final blendColor = theme.brightness == Brightness.dark ? Colors.white : Colors.black;
    final backgroundColor =
        Color.lerp(theme.colorScheme.primaryContainer, blendColor, 0.05) ??
        theme.colorScheme.primaryContainer;
    final textColor = theme.colorScheme.onPrimaryContainer;

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(left: BorderSide(color: quotationColor, width: 4.0)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (senderName.isNotEmpty)
            Text(
              senderName,
              style: TextStyle(color: textColor, fontSize: 13.0, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          Text(
            text,
            style: TextStyle(color: textColor, fontSize: 13.0, fontStyle: FontStyle.italic),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
