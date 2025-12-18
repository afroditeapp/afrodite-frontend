import 'package:app/localizations.dart';
import 'package:app/logic/chat/chat_enabled.dart';
import 'package:app/model/freezed/logic/chat/chat_enabled.dart';
import 'package:app/ui/normal/settings/chat/receive_chat_backup.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDataOutdatedWidget extends StatelessWidget {
  final VoidCallback onSkip;
  final bool isEnabling;
  final ChatEnableError? enableError;

  const ChatDataOutdatedWidget({
    required this.onSkip,
    this.isEnabling = false,
    this.enableError,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.warning_amber_rounded, size: 80, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 32),
            Text(
              context.strings.chat_data_outdated_title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              context.strings.chat_data_outdated_description,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () {
                openReceiveChatBackupScreen(context);
              },
              icon: const Icon(Icons.download),
              label: Text(context.strings.chat_data_outdated_receive_backup),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: isEnabling ? null : onSkip,
                child: isEnabling
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(context.strings.generic_skip),
              ),
            ),
            if (enableError != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _getErrorMessage(context, enableError!),
                  style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getErrorMessage(BuildContext context, ChatEnableError error) {
    return switch (error) {
      ChatEnableErrorTooManyKeys() => context.strings.chat_data_outdated_error_too_many_keys,
      ChatEnableErrorOther() => context.strings.generic_error_occurred,
    };
  }
}

/// Add only single instance of this widget to widget tree because
/// otherwise multiple dialogs will be opened.
class ChatDataOutdatedEventHandler extends StatelessWidget {
  const ChatDataOutdatedEventHandler({super.key});

  void _showSkipConfirmDialog(BuildContext context, int remainingGenerations) async {
    final message = context.strings.chat_data_outdated_skip_confirm_message(
      remainingGenerations.toString(),
    );

    final result = await showConfirmDialog(
      context,
      context.strings.chat_data_outdated_skip_confirm_title,
      details: message,
      yesNoActions: true,
    );

    if (result == true && context.mounted) {
      context.read<ChatEnabledBloc>().add(EnableChatWithNewKeypair());
    }
  }

  void _showPendingMessagesWarning(BuildContext context) async {
    final result = await showConfirmDialog(
      context,
      context.strings.generic_warning,
      details: context.strings.chat_data_outdated_pending_messages_warning,
      yesNoActions: true,
    );

    if (context.mounted) {
      context.read<ChatEnabledBloc>().add(ClearPendingMessagesWarning());

      if (result == true && context.mounted) {
        context.read<ChatEnabledBloc>().add(EnableChatWithNewKeypair(ignorePendingMessages: true));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatEnabledBloc, ChatEnabledData>(
      listenWhen: (previous, current) =>
          previous.remainingKeyGenerations != current.remainingKeyGenerations ||
          previous.showPendingMessagesWarning != current.showPendingMessagesWarning,
      listener: (context, state) {
        final remaining = state.remainingKeyGenerations;
        if (remaining != null) {
          context.read<ChatEnabledBloc>().add(ClearRemainingKeyGenerations());
          _showSkipConfirmDialog(context, remaining);
        }

        if (state.showPendingMessagesWarning) {
          _showPendingMessagesWarning(context);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}

/// Wraps a widget and shows ChatDataOutdatedWidget when chat is disabled.
class ChatViewingBlocker extends StatelessWidget {
  final Widget child;

  const ChatViewingBlocker({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatEnabledBloc, ChatEnabledData>(
      builder: (context, chatState) {
        if (!chatState.chatEnabled) {
          return ChatDataOutdatedWidget(
            onSkip: () {
              context.read<ChatEnabledBloc>().add(QueryKeyInfo());
            },
            isEnabling: chatState.isEnabling,
            enableError: chatState.enableError,
          );
        }
        return child;
      },
    );
  }
}
