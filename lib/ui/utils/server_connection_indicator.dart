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
            currentState is NoServerConnection && currentState.showRetryActionBanner;
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

  bool bannerVisibility = false;

  Future<void> init(ServerConnectionManager manager) async {
    _bannerStateSubscription = manager.state
        .map((currentState) {
          final context = globalScaffoldMessengerKey.currentContext;
          if (context == null || !context.mounted) {
            return;
          }

          switch (currentState) {
            case ReconnectWaitTime():
              _showBanner(manager);
            case NoServerConnection(:final showRetryActionBanner):
              if (showRetryActionBanner) {
                _showBanner(manager);
              } else {
                _hideBanner();
              }
            case ConnectingToServer(:final showBanner):
              if (showBanner) {
                _showBanner(manager);
              } else {
                _hideBanner();
              }
            default:
              _hideBanner();
          }
        })
        .listen(null);
  }

  void _showBanner(ServerConnectionManager manager) {
    if (bannerVisibility) {
      return;
    }

    final banner = MaterialBanner(
      // backgroundColor is not set because it does not update when
      // enabling/disabling dark theme.
      content: ServerConnectionBannerContent(manager: manager),
      actions: [ServerConnectionBannerActions(manager: manager)],
    );

    globalScaffoldMessengerKey.currentState?.showMaterialBanner(banner);
    bannerVisibility = true;
  }

  void _hideBanner() {
    globalScaffoldMessengerKey.currentState?.hideCurrentMaterialBanner();
    bannerVisibility = false;
  }

  Future<void> dispose() async {
    await _bannerStateSubscription?.cancel();
    _hideBanner();
  }
}

class ServerConnectionBannerContent extends StatefulWidget {
  final ServerConnectionManager manager;

  const ServerConnectionBannerContent({required this.manager, super.key});

  @override
  State<ServerConnectionBannerContent> createState() => _ServerConnectionBannerContentState();
}

class _ServerConnectionBannerContentState extends State<ServerConnectionBannerContent> {
  late final Stream<ServerConnectionManagerState> _stateStream;
  Widget? previouslyShownWidget;

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

        Widget newWidget;
        switch (currentState) {
          case ReconnectWaitTime(:final remainingSeconds):
            newWidget = _buildReconnectingIndicator(context, remainingSeconds);
          case NoServerConnection(:final showRetryActionBanner):
            if (showRetryActionBanner) {
              newWidget = _buildConnectionFailedIndicator(context);
            } else {
              newWidget = previouslyShownWidget ?? const SizedBox.shrink();
            }
          default:
            newWidget = previouslyShownWidget ?? const SizedBox.shrink();
        }

        previouslyShownWidget = newWidget;
        return newWidget;
      },
    );
  }

  Widget _buildConnectionFailedIndicator(BuildContext context) {
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

class ServerConnectionBannerActions extends StatefulWidget {
  final ServerConnectionManager manager;

  const ServerConnectionBannerActions({required this.manager, super.key});

  @override
  State<ServerConnectionBannerActions> createState() => _ServerConnectionBannerActionsState();
}

class _ServerConnectionBannerActionsState extends State<ServerConnectionBannerActions> {
  late final Stream<ServerConnectionManagerState> _stateStream;

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

        if (currentState is NoServerConnection && currentState.showRetryActionBanner) {
          return TextButton(
            onPressed: () {
              widget.manager.restartIfRestartNotOngoing();
            },
            child: Text(context.strings.generic_retry),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
