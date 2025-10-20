import 'dart:async';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/main.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:flutter/material.dart';

class ServerConnectionErrorDialogOpener extends StatefulWidget {
  final ServerConnectionManager manager;

  const ServerConnectionErrorDialogOpener({required this.manager, super.key});

  @override
  State<ServerConnectionErrorDialogOpener> createState() =>
      _ServerConnectionErrorDialogOpenerState();
}

class _ServerConnectionErrorDialogOpenerState extends State<ServerConnectionErrorDialogOpener> {
  late final Stream<ServerConnectionManagerState> _stateStream;
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    _stateStream = widget.manager.state;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ServerConnectionManagerState>(
      stream: _stateStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final currentState = snapshot.data!;

        final maxRetriesReached =
            currentState is NoServerConnection && currentState.maxRetriesReached;
        if (maxRetriesReached && !_dialogShown) {
          _dialogShown = true;
          showInfoDialog(
            context,
            context.strings.server_connection_indicator_connection_failed_dialog_text,
          );
        } else if (!maxRetriesReached) {
          _dialogShown = false;
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class ServerConnectionBannerLogic {
  StreamSubscription<void>? _bannerStateSubscription;
  bool _reconnectBannerShown = false;

  Future<void> init(ServerConnectionManager manager) async {
    _bannerStateSubscription = manager.state
        .map((currentState) {
          final context = globalScaffoldMessengerKey.currentContext;
          if (context == null || !context.mounted) {
            return;
          }

          switch (currentState) {
            case ReconnectWaitTime():
              // Banner updates itself
              if (!_reconnectBannerShown) {
                _showBanner(currentState, manager);
                _reconnectBannerShown = true;
              }
            case NoServerConnection(:final maxRetriesReached) when maxRetriesReached:
              _hideBanner();
              _showBanner(currentState, manager);
            case ConnectingToServer():
              if (!_reconnectBannerShown) {
                _hideBanner();
              }
            default:
              _hideBanner();
          }
        })
        .listen(null);
  }

  void _showBanner(ServerConnectionManagerState state, ServerConnectionManager manager) {
    final context = globalScaffoldMessengerKey.currentContext;
    if (context == null) return;

    final banner = MaterialBanner(
      // backgroundColor is not set because it does not update when
      // enabling/disabling dark theme.
      content: state is ReconnectWaitTime
          ? ServerConnectionIndicator(manager: manager)
          : ConnectionFailedIndicator(),
      actions: state is NoServerConnection && state.maxRetriesReached
          ? [
              TextButton(
                onPressed: () {
                  manager.restartIfRestartNotOngoing();
                },
                child: Text(context.strings.generic_retry),
              ),
            ]
          : const [SizedBox.shrink()],
    );

    globalScaffoldMessengerKey.currentState?.showMaterialBanner(banner);
  }

  void _hideBanner() {
    globalScaffoldMessengerKey.currentState?.hideCurrentMaterialBanner();
    _reconnectBannerShown = false;
  }

  Future<void> dispose() async {
    await _bannerStateSubscription?.cancel();
    _hideBanner();
  }
}

class ConnectionFailedIndicator extends StatelessWidget {
  const ConnectionFailedIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error_outline, size: 16),
        const SizedBox(width: 8),
        Text(
          context.strings.server_connection_indicator_connection_failed,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class ServerConnectionIndicator extends StatefulWidget {
  final ServerConnectionManager manager;

  const ServerConnectionIndicator({required this.manager, super.key});

  @override
  State<ServerConnectionIndicator> createState() => _ServerConnectionIndicatorState();
}

class _ServerConnectionIndicatorState extends State<ServerConnectionIndicator> {
  late final Stream<ServerConnectionManagerState> _stateStream;
  ReconnectWaitTime? _lastReconnectWaitTime;

  @override
  void initState() {
    super.initState();
    _stateStream = widget.manager.state;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ServerConnectionManagerState>(
      stream: _stateStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final currentState = snapshot.data!;

        // Save the last ReconnectWaitTime state
        if (currentState is ReconnectWaitTime) {
          _lastReconnectWaitTime = currentState;
        }

        return switch (currentState) {
          ReconnectWaitTime(:final remainingSeconds) => _buildReconnectingIndicator(
            context,
            remainingSeconds,
          ),
          _ =>
            _lastReconnectWaitTime != null
                ? _buildReconnectingIndicator(context, _lastReconnectWaitTime!.remainingSeconds)
                : const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _buildReconnectingIndicator(BuildContext context, int remainingSeconds) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          context.strings.server_connection_indicator_reconnecting_in_seconds(
            remainingSeconds.toString(),
          ),
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ],
    );
  }
}
