import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/chat/send_chat_backup.dart';
import 'package:app/model/freezed/logic/chat/send_chat_backup.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/chat/scan_pairing_code.dart';
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
    if (state.state is Success) {
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
          if (state.state case ErrorState(message: final errorMsg)) ...[
            const SizedBox(height: 24),
            _buildErrorMessage(context, errorMsg),
          ],
          const SizedBox(height: 24),
          if (state.state is Idle) _buildInputSection(context, state),
          if (state.state is! Idle && state.state is! ErrorState)
            _buildProgressSection(context, state),
          if (state.state is ErrorState) ...[_buildRetryButton(context)],
        ],
      ),
    );
  }

  Widget _buildStateIcon(BuildContext context, SendBackupData state) {
    IconData icon;
    Color? color;

    switch (state.state) {
      case ErrorState():
        icon = Icons.error_outline;
        color = Theme.of(context).colorScheme.error;
      case Idle():
        icon = Icons.send;
        color = Colors.blue;
      case Connecting():
        icon = Icons.cloud_upload_outlined;
        color = Colors.orange;
      case CreatingBackup():
        icon = Icons.archive;
        color = Colors.purple;
      case Transferring():
        icon = Icons.upload;
        color = Colors.green;
      case Success():
        icon = Icons.check_circle;
        color = Colors.green;
    }

    return Icon(icon, size: 80, color: color);
  }

  Widget _buildStateText(BuildContext context, SendBackupData state) {
    String text;

    switch (state.state) {
      case ErrorState():
        text = context.strings.generic_error_occurred;
      case Idle():
        text = context.strings.send_chat_backup_idle;
      case Connecting():
        text = context.strings.chat_backup_connecting;
      case CreatingBackup():
        text = context.strings.send_chat_backup_creating_backup;
      case Transferring():
        text = context.strings.send_chat_backup_transferring;
      case Success():
        text = context.strings.send_chat_backup_success;
    }

    return Text(text, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center);
  }

  Widget _buildInputSection(BuildContext context, SendBackupData state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            final pairingCode = await openScanPairingCodeScreen(context);
            if (pairingCode != null) {
              _pairingCodeController.text = pairingCode;
              setState(() {});
            }
          },
          icon: const Icon(Icons.qr_code_scanner),
          label: Text(context.strings.send_chat_backup_scan_qr_button),
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
