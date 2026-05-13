import 'dart:async';

import 'package:app/api/server_connection_protocol/server.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/client_features_config.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/account/client_features_config.dart';
import 'package:app/model/freezed/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/profiles/profile_filters/profile_verification_flags.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/utils/result.dart';

bool isAccessToAccountVerificationScreenPossible(AccountVerificationMethodsConfig methods) {
  return methods != AccountVerificationMethodsConfig();
}

bool shouldShowAccountVerificationRequiredLimit({
  required AccountVerificationMethodsConfig? methods,
  required int myProfileVerificationStatus,
}) {
  if (methods == null || !isAccessToAccountVerificationScreenPossible(methods)) {
    return false;
  }

  return !hasAnyAccountVerificationCompleted(myProfileVerificationStatus);
}

class AccountVerificationInfoBannerItem extends StatelessWidget {
  const AccountVerificationInfoBannerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientFeaturesConfigBloc, ClientFeaturesConfigData>(
      builder: (context, configData) {
        return BlocBuilder<MyProfileBloc, MyProfileData>(
          builder: (context, myProfileState) {
            final accountVerificationMethods = configData.config.verificationMethods?.account;
            final profile = myProfileState.profile;
            if (!myProfileState.initialLoadingCompleted || profile == null) {
              return const SizedBox.shrink();
            }

            final shouldShowBanner = shouldShowAccountVerificationRequiredLimit(
              methods: accountVerificationMethods,
              myProfileVerificationStatus: profile.mergedVerificationStatus(),
            );
            if (!shouldShowBanner || accountVerificationMethods == null) {
              return const SizedBox.shrink();
            }

            return _accountVerificationRequiredBanner(context, accountVerificationMethods);
          },
        );
      },
    );
  }

  Widget _accountVerificationRequiredBanner(
    BuildContext context,
    AccountVerificationMethodsConfig methods,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Icon(Icons.gpp_maybe, color: Theme.of(context).colorScheme.onPrimaryContainer),
          ),
          const Padding(padding: EdgeInsets.only(left: 8)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                context.strings.profile_grid_screen_account_verification_banner_text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(left: 8)),
          TextButton(
            onPressed: () => openAccountVerificationSettings(context, methods),
            child: Text(context.strings.profile_grid_screen_account_verification_banner_button),
          ),
        ],
      ),
    );
  }
}

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
  bool _scopeSecurityContent = true;
  bool _scopeProfileAgeRange = true;
  bool _scopeProfileName = true;

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
    final verificationStatus = state.profile?.mergedVerificationStatus() ?? 0;
    final securitySelfieVerified =
        verificationStatus & ProfileVerificationStatusFlags.securityContentVerified != 0;
    final profileAgeRangeVerified =
        verificationStatus & ProfileVerificationStatusFlags.profileAgeVerified != 0;
    final profileNameVerified =
        verificationStatus & ProfileVerificationStatusFlags.profileNameVerified != 0;
    final verificationScope = AccountVerificationScope(
      securityContent: !securitySelfieVerified,
      profileAgeRange: !profileAgeRangeVerified,
      profileName: !profileNameVerified,
    );
    _syncScopeSelection(verificationScope);
    final selectedVerificationScope = _selectedVerificationScope(verificationScope);
    final verificationOngoing = _queuePosition != null;
    final showVerificationStates =
        profileAgeRangeVerified || profileNameVerified || securitySelfieVerified;
    final showVerificationMethods =
        !_isLoading && !verificationOngoing && _hasVerificationScope(verificationScope);

    return Column(
      children: [
        if (showVerificationStates) ...[
          _verificationStatusTile(
            context,
            verified: profileAgeRangeVerified,
            title: context
                .strings
                .profile_filters_screen_profile_verification_status_filter_profile_age_range_verified,
          ),
          _verificationStatusTile(
            context,
            verified: profileNameVerified,
            title: context
                .strings
                .profile_filters_screen_profile_verification_status_filter_profile_name_verified,
          ),
          _verificationStatusTile(
            context,
            verified: securitySelfieVerified,
            title: context
                .strings
                .profile_filters_screen_profile_verification_status_filter_security_content_verified,
          ),
          const Divider(),
        ],
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
        if (showVerificationMethods) ...[
          _sectionTitle(context.strings.account_verification_screen_start_verification_title),
          ..._verificationScopeAndActionTiles(
            context,
            availableScope: verificationScope,
            selectedScope: selectedVerificationScope,
          ),
        ],
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }

  List<Widget> _verificationScopeAndActionTiles(
    BuildContext context, {
    required AccountVerificationScope availableScope,
    required AccountVerificationScope selectedScope,
  }) {
    return [
      ..._verificationScopeCheckboxTiles(context, availableScope: availableScope),
      if (widget.methods.debugAccept)
        ListTile(
          leading: const Icon(Icons.task_alt),
          title: const Text('debug_accept'),
          enabled: !_actionInProgress && _hasVerificationScope(selectedScope),
          onTap: () => _requestVerification("debug_accept", selectedScope),
        ),
      if (widget.methods.debugReject)
        ListTile(
          leading: const Icon(Icons.cancel_outlined),
          title: const Text('debug_reject'),
          enabled: !_actionInProgress && _hasVerificationScope(selectedScope),
          onTap: () => _requestVerification("debug_reject", selectedScope),
        ),
      if (widget.methods.eudi)
        ListTile(
          leading: const Icon(Icons.badge_outlined),
          title: Text(
            context.strings.account_verification_screen_verification_method_eudi_unsupported,
          ),
          enabled: false,
        ),
    ];
  }

  List<Widget> _verificationScopeCheckboxTiles(
    BuildContext context, {
    required AccountVerificationScope availableScope,
  }) {
    return [
      if (availableScope.profileAgeRange)
        CheckboxListTile(
          title: Text(context.strings.account_verification_screen_scope_profile_age),
          value: _scopeProfileAgeRange,
          onChanged: _actionInProgress
              ? null
              : (value) {
                  setState(() {
                    _scopeProfileAgeRange = value == true;
                  });
                },
        ),
      if (availableScope.profileName)
        CheckboxListTile(
          title: Text(context.strings.account_verification_screen_scope_profile_name),
          value: _scopeProfileName,
          onChanged: _actionInProgress
              ? null
              : (value) {
                  setState(() {
                    _scopeProfileName = value == true;
                  });
                },
        ),
      if (availableScope.securityContent)
        CheckboxListTile(
          title: Text(
            context
                .strings
                .profile_filters_screen_profile_verification_status_filter_security_content_verified,
          ),
          value: _scopeSecurityContent,
          onChanged: _actionInProgress
              ? null
              : (value) {
                  setState(() {
                    _scopeSecurityContent = value == true;
                  });
                },
        ),
    ];
  }

  Widget _verificationStatusTile(
    BuildContext context, {
    required bool verified,
    required String title,
  }) {
    final icon = verified ? Icons.check_circle : Icons.cancel;
    final color = verified ? Colors.green : Colors.red;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
    );
  }

  bool _hasVerificationScope(AccountVerificationScope scope) {
    return scope.securityContent || scope.profileAgeRange || scope.profileName;
  }

  AccountVerificationScope _selectedVerificationScope(AccountVerificationScope availableScope) {
    return AccountVerificationScope(
      securityContent: availableScope.securityContent && _scopeSecurityContent,
      profileAgeRange: availableScope.profileAgeRange && _scopeProfileAgeRange,
      profileName: availableScope.profileName && _scopeProfileName,
    );
  }

  void _syncScopeSelection(AccountVerificationScope availableScope) {
    _scopeSecurityContent = availableScope.securityContent && _scopeSecurityContent;
    _scopeProfileAgeRange = availableScope.profileAgeRange && _scopeProfileAgeRange;
    _scopeProfileName = availableScope.profileName && _scopeProfileName;
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

  Future<void> _requestVerification(
    String verificationMethod,
    AccountVerificationScope verificationScope,
  ) async {
    if (!_hasVerificationScope(verificationScope)) {
      return;
    }

    setState(() {
      _actionInProgress = true;
    });

    final result = await widget.api
        .account(
          (api) => api.postAccountVerificationQueueItem(
            AccountVerificationQueueItem(
              verificationData: '',
              verificationMethod: verificationMethod,
              verificationScope: verificationScope,
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
