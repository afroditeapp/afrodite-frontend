import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ServerConnectionIndicator extends StatefulWidget {
  final RepositoryInstances r;

  const ServerConnectionIndicator({required this.r, super.key});

  @override
  State<ServerConnectionIndicator> createState() => _ServerConnectionIndicatorState();
}

class _ServerConnectionIndicatorState extends State<ServerConnectionIndicator> {
  late final Stream<List<ServerConnectionManagerState>> _stateStream;

  @override
  void initState() {
    super.initState();
    _stateStream = widget.r.connectionManager.state.pairwise();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ServerConnectionManagerState>>(
      stream: _stateStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final states = snapshot.data!;
        if (states.length < 2) {
          return const SizedBox.shrink();
        }

        final previousState = states[0];
        final currentState = states[1];

        // If transitioning from ReconnectWaitTime to ConnectingToServer,
        // keep showing the previous reconnect indicator to avoid flicker
        if (previousState is ReconnectWaitTime && currentState is ConnectingToServer) {
          return _buildReconnectingIndicator(context, previousState.remainingSeconds);
        }

        return switch (currentState) {
          ReconnectWaitTime(:final remainingSeconds) => _buildReconnectingIndicator(
            context,
            remainingSeconds,
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _buildReconnectingIndicator(BuildContext context, int remainingSeconds) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
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
      ),
    );
  }
}
