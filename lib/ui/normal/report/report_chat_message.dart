import 'dart:convert';

import 'package:app/data/utils/repository_instances.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/chat/utils.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/utils/result.dart';
import 'package:app/ui_utils/extensions/locale.dart';
import 'package:app/ui_utils/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:database/database.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/dialog.dart';

class ReportChatMessagePage extends MyScreenPageLimited<()> {
  ReportChatMessagePage({required AccountId accountId, required List<MessageEntry> messages})
    : super(
        builder: (closer) =>
            ReportChatMessageScreen(accountId: accountId, messages: messages, closer: closer),
      );
}

class ReportChatMessageScreen extends StatefulWidget {
  final AccountId accountId;
  final List<MessageEntry> messages;
  final PageCloser<()> closer;
  const ReportChatMessageScreen({
    required this.accountId,
    required this.messages,
    required this.closer,
    super.key,
  });

  @override
  State<ReportChatMessageScreen> createState() => _ReportChatMessageScreen();
}

class _ReportChatMessageScreen extends State<ReportChatMessageScreen> {
  static const int _maxMessages = 10;

  late final List<MessageEntry> messages;
  int? _firstSelectedIndex;
  int? _lastSelectedIndex;

  @override
  void initState() {
    super.initState();
    messages = widget.messages.where((v) => v.messageState.toInfoState() == null).toList();
  }

  int get _selectedCount {
    if (_firstSelectedIndex == null || _lastSelectedIndex == null) return 0;
    return _lastSelectedIndex! - _firstSelectedIndex! + 1;
  }

  bool _isSelected(int index) {
    if (_firstSelectedIndex == null || _lastSelectedIndex == null) return false;
    return index >= _firstSelectedIndex! && index <= _lastSelectedIndex!;
  }

  @override
  Widget build(BuildContext context) {
    final hasSelection = _firstSelectedIndex != null && _lastSelectedIndex != null;
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.generic_report_verb)),
      floatingActionButton: hasSelection
          ? FloatingActionButton.extended(
              onPressed: () => _reportSelectedMessages(context),
              icon: const Icon(Icons.report),
              label: Text(context.strings.generic_report_verb),
            )
          : null,
      body: Column(
        children: [
          _buildSelectionStatus(context),
          Expanded(
            child: CustomScrollView(
              reverse: true,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(padding: EdgeInsets.only(top: FLOATING_ACTION_BUTTON_EMPTY_AREA)),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final entry = messages[index];
                    return _messageRow(context, entry, index);
                  }, childCount: messages.length),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionStatus(BuildContext context) {
    final String statusText;
    if (_firstSelectedIndex == null || _lastSelectedIndex == null) {
      statusText = context.strings.report_chat_message_screen_selection_status_none;
    } else {
      statusText = context.strings.report_chat_message_screen_selection_status_count(
        _selectedCount.toString(),
        _maxMessages.toString(),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Text(
        statusText,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  void _toggleSelection(int index) {
    setState(() {
      if (_firstSelectedIndex == null || _lastSelectedIndex == null) {
        // First selection
        _firstSelectedIndex = index;
        _lastSelectedIndex = index;
      } else if (index >= _firstSelectedIndex! &&
          index <= _lastSelectedIndex! &&
          _firstSelectedIndex == _lastSelectedIndex) {
        // Single item selected, tapping it again deselects
        _firstSelectedIndex = null;
        _lastSelectedIndex = null;
      } else if (index >= _firstSelectedIndex! && index <= _lastSelectedIndex!) {
        // Tapping inside the range — shrink to the tapped index
        if (index == _firstSelectedIndex!) {
          _firstSelectedIndex = _firstSelectedIndex! + 1;
        } else if (index == _lastSelectedIndex!) {
          _lastSelectedIndex = _lastSelectedIndex! - 1;
        } else {
          // Tapping in the middle — shrink toward the closer end
          final distToFirst = index - _firstSelectedIndex!;
          final distToLast = _lastSelectedIndex! - index;
          if (distToFirst <= distToLast) {
            _firstSelectedIndex = index;
          } else {
            _lastSelectedIndex = index;
          }
        }
      } else {
        // Tapping outside the range — expand or shift
        final newFirst = index < _firstSelectedIndex! ? index : _firstSelectedIndex!;
        final newLast = index > _lastSelectedIndex! ? index : _lastSelectedIndex!;
        final newCount = newLast - newFirst + 1;
        if (newCount <= _maxMessages) {
          _firstSelectedIndex = newFirst;
          _lastSelectedIndex = newLast;
        } else {
          // Shift the range to include the new index while keeping max count
          final maxIndex = messages.length - 1;
          if (index < _firstSelectedIndex!) {
            _firstSelectedIndex = index;
            _lastSelectedIndex = (_firstSelectedIndex! + _maxMessages - 1).clamp(0, maxIndex);
          } else {
            _lastSelectedIndex = index;
            _firstSelectedIndex = (_lastSelectedIndex! - _maxMessages + 1).clamp(0, maxIndex);
          }
        }
      }
    });
  }

  Widget _messageRow(BuildContext context, MessageEntry entry, int index) {
    final textNoOwnerIndicator = messageWidgetText(
      context,
      entry.message,
      entry.messageState.toSentState(),
      entry.messageState.toReceivedState(),
    );

    final String text;
    if (entry.messageState.isSent() == true) {
      text = context.strings.chat_list_screen_sent_message_indicator(textNoOwnerIndicator);
    } else {
      text = textNoOwnerIndicator;
    }

    final isSelected = _isSelected(index);

    final textWidget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );

    final timeTextWidget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        timeString(entry.userVisibleTime(), Localizations.localeOf(context).localeString()),
        style: Theme.of(context).textTheme.bodySmall,
        overflow: TextOverflow.ellipsis,
      ),
    );

    final textRow = Row(
      children: [
        if (entry.messageState.isSent() == true) const Spacer(flex: 3),
        Expanded(
          flex: 7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: entry.messageState.isSent() == true
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: textWidget,
              ),
              const Padding(padding: EdgeInsets.only(top: 8)),
              Align(
                alignment: entry.messageState.isSent() == true
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: timeTextWidget,
              ),
            ],
          ),
        ),
        if (entry.messageState.isSent() == false) const Spacer(flex: 3),
      ],
    );

    return ListTile(
      selected: isSelected,
      selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
      onTap: () => _toggleSelection(index),
      title: textRow,
    );
  }

  Future<void> _reportSelectedMessages(BuildContext context) async {
    if (_firstSelectedIndex == null || _lastSelectedIndex == null) return;

    final selectedEntries = messages.sublist(_firstSelectedIndex!, _lastSelectedIndex! + 1);

    final r = await showConfirmDialog(
      context,
      context.strings.generic_report_verb_question,
      details: context.strings.report_chat_message_screen_selection_status_count(
        selectedEntries.length.toString(),
        _maxMessages.toString(),
      ),
      yesNoActions: true,
      scrollable: true,
    );
    if (!context.mounted || r != true) return;

    final repositories = context.read<RepositoryInstances>();

    final List<ChatMessageReportData> reportDataList = [];
    for (final entry in selectedEntries) {
      final serverSignedMessage = await repositories.accountDb
          .accountData((db) => db.message.getServerSignedPgpMessage(entry.localId))
          .ok();
      if (serverSignedMessage == null) {
        showSnackBar(R.strings.report_chat_message_screen_server_signed_message_not_found);
        return;
      }
      final symmetricKey = await repositories.accountDb
          .accountData((db) => db.message.getSymmetricMessageEncryptionKey(entry.localId))
          .ok();
      if (symmetricKey == null) {
        showSnackBar(
          R.strings.report_chat_message_screen_symmetric_message_encryption_key_not_found,
        );
        return;
      }
      reportDataList.add(
        ChatMessageReportData(
          serverSignedMessageBase64: base64Encode(serverSignedMessage),
          decryptionKeyBase64: base64Encode(symmetricKey),
        ),
      );
    }

    final result = await repositories.api
        .chat(
          (api) => api.postChatMessageReport(
            UpdateChatMessageReport(target: widget.accountId, messages: reportDataList),
          ),
        )
        .ok();

    if (!context.mounted) return;

    if (result == null) {
      showSnackBar(R.strings.generic_error_occurred);
    } else if (result.errorOutdatedReportContent) {
      // Should not happen
      showSnackBar(R.strings.generic_error);
    } else if (result.errorTooManyReports) {
      showSnackBar(R.strings.report_screen_snackbar_too_many_reports_error);
    } else if (result.error) {
      showSnackBar(R.strings.generic_error_occurred);
    } else {
      showSnackBar(R.strings.report_screen_snackbar_report_successful);
      widget.closer.close(context, ());
    }
  }
}
