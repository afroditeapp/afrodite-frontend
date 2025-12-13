import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/chat/receive_chat_backup.dart';
import 'package:app/model/freezed/logic/chat/receive_chat_backup.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/utils/format_bytes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';

void openReceiveChatBackupScreen(BuildContext context) {
  MyNavigator.push(context, ReceiveChatBackupPage());
}

class ReceiveChatBackupPage extends MyScreenPage<()> with SimpleUrlParser<ReceiveChatBackupPage> {
  ReceiveChatBackupPage() : super(builder: (_) => ReceiveChatBackupScreenOpener());

  @override
  ReceiveChatBackupPage create() => ReceiveChatBackupPage();
}

class ReceiveChatBackupScreenOpener extends StatelessWidget {
  const ReceiveChatBackupScreenOpener({super.key});

  @override
  Widget build(BuildContext context) {
    return ReceiveChatBackupScreen(bloc: context.read<ReceiveChatBackupBloc>());
  }
}

class ReceiveChatBackupScreen extends StatefulWidget {
  final ReceiveChatBackupBloc bloc;
  const ReceiveChatBackupScreen({required this.bloc, super.key});

  @override
  State<ReceiveChatBackupScreen> createState() => _ReceiveChatBackupScreenState();
}

class _ReceiveChatBackupScreenState extends State<ReceiveChatBackupScreen> {
  bool _showQrCode = true;

  @override
  void initState() {
    super.initState();
    widget.bloc.add(ConnectIfIdleOrConnecting());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.receive_chat_backup_screen_title)),
      body: BlocBuilder<ReceiveChatBackupBloc, ReceiveBackupData>(
        builder: (context, state) {
          return _buildContent(context, state);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, ReceiveBackupData state) {
    if (state.state is Success) {
      return _buildSuccessView(context);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          if (state.state is WaitingForSource && state.pairingCode != null)
            _buildPairingCodeSection(context, state.pairingCode!),
          if (state.state is Transferring) _buildProgressSection(context, state),
          if (state.state is Importing) _buildImportingSection(context),
          if (state.state is ErrorState) ...[_buildRetryButton(context)],
        ],
      ),
    );
  }

  Widget _buildStateIcon(BuildContext context, ReceiveBackupData state) {
    IconData icon;
    Color? color;

    switch (state.state) {
      case ErrorState():
        icon = Icons.error_outline;
        color = Theme.of(context).colorScheme.error;
      case Connecting():
        icon = Icons.cloud_upload_outlined;
        color = Colors.blue;
      case WaitingForSource():
        icon = Icons.devices;
        color = Colors.orange;
      case Transferring():
        icon = Icons.download;
        color = Colors.green;
      case Importing():
        icon = Icons.import_export;
        color = Colors.purple;
      case Success():
        icon = Icons.check_circle;
        color = Colors.green;
    }

    return Icon(icon, size: 80, color: color);
  }

  Widget _buildStateText(BuildContext context, ReceiveBackupData state) {
    String text;

    switch (state.state) {
      case ErrorState():
        text = context.strings.generic_error_occurred;
      case Connecting():
        text = context.strings.chat_backup_connecting;
      case WaitingForSource():
        text = context.strings.receive_chat_backup_waiting_for_source;
      case Transferring():
        text = context.strings.receive_chat_backup_transferring;
      case Importing():
        text = context.strings.receive_chat_backup_importing;
      case Success():
        text = context.strings.receive_chat_backup_import_success;
    }

    return Text(text, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center);
  }

  Widget _buildPairingCodeSection(BuildContext context, String pairingCode) {
    return Column(
      children: [
        Text(
          context.strings.chat_backup_pairing_code_label,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        if (_showQrCode) ...[
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: QrImageView(
              data: pairingCode,
              size: 200,
              errorCorrectionLevel: QrErrorCorrectLevel.L,
            ),
          ),
        ] else ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    pairingCode,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(fontFamily: 'monospace'),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: pairingCode));
                    showSnackBar(context.strings.generic_copied_to_clipboard);
                  },
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: () {
            setState(() {
              _showQrCode = !_showQrCode;
            });
          },
          icon: Icon(_showQrCode ? Icons.text_fields : Icons.qr_code),
          label: Text(
            _showQrCode
                ? context.strings.receive_chat_backup_show_text_code
                : context.strings.receive_chat_backup_show_qr_code,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.strings.receive_chat_backup_pairing_code_instruction,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              _instructionStep(
                context,
                context.strings.receive_chat_backup_pairing_code_step1(context.strings.app_name),
              ),
              const SizedBox(height: 12),
              _instructionStep(context, context.strings.receive_chat_backup_pairing_code_step2),
              const SizedBox(height: 12),
              _instructionStepWithIcon(
                context,
                context.strings.receive_chat_backup_pairing_code_step3,
                Icons.more_vert,
              ),
              const SizedBox(height: 12),
              _instructionStep(context, context.strings.receive_chat_backup_pairing_code_step4),
              const SizedBox(height: 12),
              _instructionStep(context, context.strings.receive_chat_backup_pairing_code_step5),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }

  Widget _instructionStep(BuildContext context, String text) {
    return Text(text, style: Theme.of(context).textTheme.bodyMedium);
  }

  Widget _instructionStepWithIcon(BuildContext context, String text, IconData icon) {
    return Row(
      children: [
        Flexible(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        const SizedBox(width: 8),
        Icon(icon, size: 24),
      ],
    );
  }

  Widget _buildProgressSection(BuildContext context, ReceiveBackupData state) {
    final totalBytes = state.totalBytes ?? 0;
    final transferredBytes = state.transferredBytes;
    final progress = totalBytes > 0 ? transferredBytes / totalBytes : 0.0;

    return Column(
      children: [
        const SizedBox(height: 24),
        LinearProgressIndicator(value: progress, minHeight: 8),
        const SizedBox(height: 12),
        Text(
          '${formatBytes(transferredBytes)} / ${formatBytes(totalBytes)}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildImportingSection(BuildContext context) {
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
        context.read<ReceiveChatBackupBloc>().add(ConnectIfIdleOrConnecting());
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
              context.strings.receive_chat_backup_import_success,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            ElevatedButton(
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

  @override
  void dispose() {
    widget.bloc.add(DisconnectIfIdle());
    super.dispose();
  }
}
