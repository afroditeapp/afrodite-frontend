import 'dart:async';

import 'package:app/api/server_connection_protocol/server.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/profiles/profile_filters/profile_verification.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/utils/result.dart';

void openAccountVerificationSettings(
  BuildContext context,
  AccountVerificationMethodsConfig methods,
) {
  final r = context.read<RepositoryInstances>();
  MyNavigator.pushLimited(context, AccountVerificationSettingsPage(r.connectionManager, methods));
}

class AccountVerificationSettingsPage extends MyScreenPageLimited<()> {
  final ServerConnectionManager api;
  final AccountVerificationMethodsConfig methods;

  AccountVerificationSettingsPage(this.api, this.methods)
    : super(
        builder: (_) => AccountVerificationSettingsScreen(api: api, methods: methods),
      );
}

class AccountVerificationSettingsScreen extends StatefulWidget {
  final ServerConnectionManager api;
  final AccountVerificationMethodsConfig methods;

  const AccountVerificationSettingsScreen({required this.api, required this.methods, super.key});

  @override
  State<AccountVerificationSettingsScreen> createState() =>
      _AccountVerificationSettingsScreenState();
}

class _AccountVerificationSettingsScreenState extends State<AccountVerificationSettingsScreen> {
  StreamSubscription<ServerWsEvent>? _serverEventsSubscription;
  int? _queuePosition;
  bool _isLoading = true;
  bool _actionInProgress = false;

  @override
  void initState() {
    super.initState();
    _serverEventsSubscription = widget.api.serverEvents
        .where((event) => event is ServerMessageContainer)
        .cast<ServerMessageContainer>()
        .listen((ServerMessageContainer event) {
          if (event.message.type != ServerMessageTypeCode.accountVerificationQueuePositionChanged) {
            return;
          }

          if (!mounted) {
            return;
          }

          setState(() {
            _queuePosition = event.message.accountVerificationQueuePosition;
          });
        });
    _reloadQueueStatus();
  }

  @override
  void dispose() {
    _serverEventsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.account_verification_screen_title)),
      body: SingleChildScrollView(
        child: BlocBuilder<MyProfileBloc, MyProfileData>(
          builder: (context, state) {
            return column(context, state);
          },
        ),
      ),
    );
  }

  Widget column(BuildContext context, MyProfileData state) {
    final mediaVerificationStatus = state.profile?.mediaVerificationStatus ?? 0;
    final securitySelfieVerified =
        mediaVerificationStatus & ProfileVerificationStatusFlags.securityContentVerified != 0;
    final verificationOngoing = _queuePosition != null;
    final showVerificationMethods = !_isLoading && !verificationOngoing && !securitySelfieVerified;

    return Column(
      children: [
        _securitySelfieStatusTile(context, securitySelfieVerified: securitySelfieVerified),
        const Divider(),
        if (verificationOngoing)
          ListTile(
            leading: const Icon(Icons.hourglass_top, color: Colors.orange),
            title: Text(
              context.strings.account_verification_screen_queue_position(
                _queuePosition!.toString(),
              ),
            ),
          ),
        if (verificationOngoing) const Divider(),
        if (showVerificationMethods && widget.methods.debugAccept)
          ListTile(
            leading: const Icon(Icons.task_alt),
            title: const Text('debug_accept'),
            enabled: !_actionInProgress,
            onTap: () => _requestVerification("debug_accept"),
          ),
        if (showVerificationMethods && widget.methods.debugReject)
          ListTile(
            leading: const Icon(Icons.cancel_outlined),
            title: const Text('debug_reject'),
            enabled: !_actionInProgress,
            onTap: () => _requestVerification("debug_reject"),
          ),
      ],
    );
  }

  Widget _securitySelfieStatusTile(BuildContext context, {required bool securitySelfieVerified}) {
    final icon = securitySelfieVerified ? Icons.check_circle : Icons.cancel;
    final color = securitySelfieVerified ? Colors.green : Colors.red;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        context
            .strings
            .profile_filters_screen_profile_verification_status_filter_security_content_verified,
      ),
    );
  }

  Future<void> _reloadQueueStatus() async {
    final status = await widget.api.account((api) => api.getAccountVerificationQueueStatus()).ok();

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = false;
      _queuePosition = status?.queuePosition;
    });
  }

  Future<void> _requestVerification(String verificationMethod) async {
    setState(() {
      _actionInProgress = true;
    });

    final result = await widget.api
        .account(
          (api) => api.postAccountVerificationQueueItem(
            AccountVerificationQueueItem(
              verificationData: '',
              verificationMethod: verificationMethod,
              verificationScope: AccountVerificationScope(securityContent: true),
            ),
          ),
        )
        .ok();

    if (!mounted) {
      return;
    }

    if (result == null) {
      showSnackBar(context.strings.generic_error_occurred);
    } else if (result.errorAlreadyInQueue) {
      showSnackBar(context.strings.generic_error);
    } else if (result.errorQueueFull) {
      showSnackBar(context.strings.account_verification_screen_request_queue_full);
    } else if (result.error) {
      showSnackBar(context.strings.generic_error_occurred);
    } else {
      showSnackBar(context.strings.account_verification_screen_request_queued);
    }

    await _reloadQueueStatus();

    if (!mounted) {
      return;
    }

    setState(() {
      _actionInProgress = false;
    });
  }
}
