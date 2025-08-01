
import 'dart:convert';

import 'package:app/ui/normal/chat/message_row.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:app/utils/time.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/data/login_repository.dart';
import 'package:database/database.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/dialog.dart';

class ReportChatMessageScreen extends StatefulWidget {
  final ProfileEntry profileEntry;
  final List<MessageEntry> messages;
  const ReportChatMessageScreen({
    required this.profileEntry,
    required this.messages,
    super.key,
  });

  @override
  State<ReportChatMessageScreen> createState() => _ReportChatMessageScreen();
}

class _ReportChatMessageScreen extends State<ReportChatMessageScreen> {
  final api = LoginRepository.getInstance().repositories.api;
  final db = LoginRepository.getInstance().repositories.accountDb;

  late final List<MessageEntry> messages;

  @override
  void initState() {
    super.initState();
    messages = widget.messages.where((v) => v.messageState.toInfoState() == null).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.report_screen_title)),
      body: list(context),
    );
  }

  Widget list(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final entry = messages[index];
        return messageRow(context, entry);
      }
    );
  }

  Widget messageRow(BuildContext context, MessageEntry entry) {
    final textNoOwnerIndicator = messageWidgetText(
      context,
      entry.message,
      entry.messageState.toSentState(),
      entry.messageState.toReceivedState()
    );

    final String text;
    if (entry.messageState.isSent() == true) {
      text = context.strings.chat_list_screen_sent_message_indicator(textNoOwnerIndicator);
    } else {
      text = textNoOwnerIndicator;
    }

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
        timeString(entry.unixTime ?? entry.localUnixTime),
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
                alignment: entry.messageState.isSent() == true ? Alignment.centerRight : Alignment.centerLeft,
                child: textWidget,
              ),
              const Padding(padding: EdgeInsets.only(top: 8)),
              Align(
                alignment: entry.messageState.isSent() == true ? Alignment.centerRight : Alignment.centerLeft,
                child: timeTextWidget,
              )
            ],
          )
        ),
        if (entry.messageState.isSent() == false) const Spacer(flex: 3),
      ],
    );

    return ListTile(
      onTap: () async {
        final r = await showConfirmDialog(
          context,
          context.strings.report_chat_message_screen_confirm_dialog_title,
          details: text,
          yesNoActions: true,
          scrollable: true,
        );
        if (context.mounted && r == true) {
          final backendSignedMessage = await db.accountData((db) => db.message.getBackendSignedPgpMessage(entry.localId)).ok();
          if (backendSignedMessage == null) {
            showSnackBar(R.strings.report_chat_message_screen_backend_signed_message_not_found);
            return;
          }
          final symmetricKey = await db.accountData((db) => db.message.getSymmetricMessageEncryptionKey(entry.localId)).ok();
          if (symmetricKey == null) {
            showSnackBar(R.strings.report_chat_message_screen_symmetric_message_encryption_key_not_found);
            return;
          }

          final result = await api.chat((api) => api.postChatMessageReport(UpdateChatMessageReport(
            target: widget.profileEntry.accountId,
            backendSignedMessageBase64: base64Encode(backendSignedMessage),
            decryptionKeyBase64: base64Encode(symmetricKey),
          ))).ok();

          if (result == null) {
            showSnackBar(R.strings.generic_error_occurred);
          } else if (result.errorOutdatedReportContent) {
            // Should not happen
            showSnackBar(R.strings.generic_error);
          } else if (result.errorTooManyReports) {
            showSnackBar(R.strings.report_screen_snackbar_too_many_reports_error);
          } else {
            showSnackBar(R.strings.report_screen_snackbar_report_successful);
          }
        }
      },
      title: textRow,
    );
  }
}
