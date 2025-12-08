import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/chat/send_chat_backup.dart';
import 'package:app/model/freezed/logic/chat/send_chat_backup.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';

void openSendChatBackupScreen(BuildContext context) {
  MyNavigator.push(context, SendChatBackupPage());
}

class SendChatBackupPage extends MyScreenPage<()> with SimpleUrlParser<SendChatBackupPage> {
  SendChatBackupPage() : super(builder: (_) => SendChatBackupScreen());

  @override
  SendChatBackupPage create() => SendChatBackupPage();
}

class SendChatBackupScreen extends StatefulWidget {
  const SendChatBackupScreen({super.key});

  @override
  State<SendChatBackupScreen> createState() => _SendChatBackupScreenState();
}

class _SendChatBackupScreenState extends State<SendChatBackupScreen> {
  final TextEditingController _pairingCodeController = TextEditingController();

  @override
  void dispose() {
    _pairingCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.send_chat_backup_screen_title)),
      body: BlocBuilder<SendChatBackupBloc, SendBackupData>(
        builder: (context, state) {
          return _buildContent(context, state);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, SendBackupData state) {
    if (state.state == SendBackupState.success) {
      return _buildSuccessView(context);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),
          _buildStateIcon(context, state),
          const SizedBox(height: 32),
          _buildStateText(context, state),
          if (state.errorMessage != null) ...[
            const SizedBox(height: 24),
            _buildErrorMessage(context, state.errorMessage!),
          ],
          const SizedBox(height: 24),
          if (state.state == SendBackupState.idle && state.errorMessage == null)
            _buildInputSection(context, state),
          if (state.state != SendBackupState.idle && state.errorMessage == null)
            _buildProgressSection(context, state),
          if (state.errorMessage != null) ...[_buildRetryButton(context)],
        ],
      ),
    );
  }

  Widget _buildStateIcon(BuildContext context, SendBackupData state) {
    IconData icon;
    Color? color;

    if (state.errorMessage != null) {
      icon = Icons.error_outline;
      color = Theme.of(context).colorScheme.error;
    } else {
      switch (state.state) {
        case SendBackupState.idle:
          icon = Icons.send;
          color = Colors.blue;
        case SendBackupState.connecting:
          icon = Icons.cloud_upload_outlined;
          color = Colors.orange;
        case SendBackupState.creatingBackup:
          icon = Icons.archive;
          color = Colors.purple;
        case SendBackupState.transferring:
          icon = Icons.upload;
          color = Colors.green;
        case SendBackupState.success:
          icon = Icons.check_circle;
          color = Colors.green;
      }
    }

    return Icon(icon, size: 80, color: color);
  }

  Widget _buildStateText(BuildContext context, SendBackupData state) {
    String text;

    if (state.errorMessage != null) {
      text = context.strings.generic_error_occurred;
    } else {
      switch (state.state) {
        case SendBackupState.idle:
          text = context.strings.send_chat_backup_idle;
        case SendBackupState.connecting:
          text = context.strings.chat_backup_connecting;
        case SendBackupState.creatingBackup:
          text = context.strings.send_chat_backup_creating_backup;
        case SendBackupState.transferring:
          text = context.strings.send_chat_backup_transferring;
        case SendBackupState.success:
          text = context.strings.send_chat_backup_success;
      }
    }

    return Text(text, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center);
  }

  Widget _buildInputSection(BuildContext context, SendBackupData state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.strings.send_chat_backup_pairing_code_instruction,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        TextField(
          controller: _pairingCodeController,
          decoration: InputDecoration(
            labelText: context.strings.chat_backup_pairing_code_label,
            hintText: context.strings.send_chat_backup_pairing_code_hint,
            border: const OutlineInputBorder(),
          ),
          onChanged: (value) {
            // Update button state
            setState(() {});
          },
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
          },
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _pairingCodeController.text.isNotEmpty
              ? () {
                  FocusScope.of(context).unfocus();
                  context.read<SendChatBackupBloc>().add(
                    StartSendBackup(_pairingCodeController.text),
                  );
                }
              : null,
          child: Text(context.strings.send_chat_backup_start_button),
        ),
      ],
    );
  }

  Widget _buildProgressSection(BuildContext context, SendBackupData state) {
    return const Column(children: [SizedBox(height: 24), CircularProgressIndicator()]);
  }

  Widget _buildErrorMessage(BuildContext context, String errorMessage) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        errorMessage,
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<SendChatBackupBloc>().add(ResetToInitialState());
      },
      icon: const Icon(Icons.refresh),
      label: Text(context.strings.generic_retry),
    );
  }

  Widget _buildSuccessView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 32),
            Text(
              context.strings.send_chat_backup_success,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                context.read<SendChatBackupBloc>().add(ResetToInitialState());
                _pairingCodeController.clear();
              },
              child: Text(context.strings.send_chat_backup_send_another_button),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(context.strings.generic_close),
            ),
          ],
        ),
      ),
    );
  }
}
