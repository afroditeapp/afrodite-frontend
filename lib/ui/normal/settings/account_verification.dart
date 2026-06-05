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
import 'package:app/ui_utils/extensions/locale.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/utils/result.dart';
import 'package:app/utils/api.dart';
import 'package:app/ui_utils/time.dart';

bool isAccessToAccountVerificationScreenPossible({
  required AccountVerificationMethodsConfig methods,
  required VerificationConfig verificationConfig,
}) {
  return !methods.allDisabled &&
      (verificationConfig.securityContent ||
          verificationConfig.profileAgeRange ||
          verificationConfig.profileName);
}

class AccountVerificationScopeStatuses {
  final bool showSecurityContent;
  final bool showProfileAgeRange;
  final bool showProfileName;
  final bool securitySelfieVerified;
  final bool profileAgeRangeVerified;
  final bool profileNameVerified;

  const AccountVerificationScopeStatuses({
    required this.showSecurityContent,
    required this.showProfileAgeRange,
    required this.showProfileName,
    required this.securitySelfieVerified,
    required this.profileAgeRangeVerified,
    required this.profileNameVerified,
  });

  bool get isAnyScopeVisible => showSecurityContent || showProfileAgeRange || showProfileName;

  bool get allVisibleScopesVerified {
    return (!showSecurityContent || securitySelfieVerified) &&
        (!showProfileAgeRange || profileAgeRangeVerified) &&
        (!showProfileName || profileNameVerified);
  }
}

AccountVerificationScopeStatuses accountVerificationScopeStatuses({
  required VerificationConfig verificationConfig,
  required int verificationStatus,
}) {
  final securitySelfieVerified =
      verificationStatus & ProfileVerificationStatusFlags.securityContentVerified != 0;
  final profileAgeRangeVerified =
      verificationStatus & ProfileVerificationStatusFlags.profileAgeVerified != 0;
  final profileNameVerified =
      verificationStatus & ProfileVerificationStatusFlags.profileNameVerified != 0;

  return AccountVerificationScopeStatuses(
    showSecurityContent: verificationConfig.securityContent,
    showProfileAgeRange: verificationConfig.profileAgeRange,
    showProfileName: verificationConfig.profileName,
    securitySelfieVerified: securitySelfieVerified,
    profileAgeRangeVerified: profileAgeRangeVerified,
    profileNameVerified: profileNameVerified,
  );
}

bool shouldShowAccountVerificationIncompleteBanner({
  required AccountVerificationMethodsConfig? methods,
  required VerificationConfig verificationConfig,
  required int verificationStatus,
}) {
  if (methods == null ||
      !isAccessToAccountVerificationScreenPossible(
        methods: methods,
        verificationConfig: verificationConfig,
      )) {
    return false;
  }

  final statuses = accountVerificationScopeStatuses(
    verificationConfig: verificationConfig,
    verificationStatus: verificationStatus,
  );

  return statuses.isAnyScopeVisible && !statuses.allVisibleScopesVerified;
}

class AccountVerificationInfoBannerItem extends StatelessWidget {
  const AccountVerificationInfoBannerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientFeaturesConfigBloc, ClientFeaturesConfigData>(
      builder: (context, configData) {
        return BlocBuilder<MyProfileBloc, MyProfileData>(
          builder: (context, myProfileState) {
            final accountVerificationMethods = configData.config.accountVerification?.methods;
            final verificationConfig = configData.verificationConfig();
            final profile = myProfileState.profile;
            if (!myProfileState.initialLoadingCompleted || profile == null) {
              return const SizedBox.shrink();
            }

            final verificationStatus = profile.mergedVerificationStatus();
            final shouldShowBanner = shouldShowAccountVerificationIncompleteBanner(
              methods: accountVerificationMethods,
              verificationConfig: verificationConfig,
              verificationStatus: verificationStatus,
            );
            if (!shouldShowBanner || accountVerificationMethods == null) {
              return const SizedBox.shrink();
            }

            final anyAccountVerificationCompleted = hasAnyAccountVerificationCompleted(
              verificationStatus,
            );
            return _accountVerificationRequiredBanner(
              context,
              accountVerificationMethods,
              anyAccountVerificationCompleted,
            );
          },
        );
      },
    );
  }

  Widget _accountVerificationRequiredBanner(
    BuildContext context,
    AccountVerificationMethodsConfig methods,
    bool accountVerificationIncomplete,
  ) {
    final bannerText = accountVerificationIncomplete
        ? context.strings.profile_grid_screen_account_verification_banner_text_incomplete
        : context.strings.profile_grid_screen_account_verification_banner_text;

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
                bannerText,
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
  static const int _verificationMethodNotConfigured = 0x1;
  static const int _verificationDataParsingFailed = 0x2;
  static const int _verificationDataVerificationFailed = 0x4;
  static const int _profileAgeRangeVerificationFailed = 0x8;
  static const int _profileAgeRangeVerificationMismatch = 0x10;
  static const int _profileAgeRangeMismatch = 0x20;
  static const int _profileNameVerificationFailed = 0x40;
  static const int _profileNameVerificationMismatch = 0x80;
  static const int _profileNameMismatch = 0x100;
  static const int _securityContentVerificationFailed = 0x200;
  static const int _securityContentVerificationMismatch = 0x400;
  static const int _securityContentMismatch = 0x800;

  StreamSubscription<ServerWsEvent>? _serverEventsSubscription;
  int? _queuePosition;
  UnixTime? _previousVerificationUnixTime;
  int _verificationErrorFlags = 0;
  int _profileVerificationStatus = 0;
  int _mediaVerificationStatus = 0;
  bool _isLoading = true;
  bool _actionInProgress = false;
  bool _scopeSecurityContent = true;
  bool _scopeProfileAgeRange = true;
  bool _scopeProfileName = true;
  late final _QueueStatusReloader _reloader;

  @override
  void initState() {
    _reloader = _QueueStatusReloader(_reloadQueueStatus);
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

          final queuePosition = event.message.accountVerificationQueuePosition;
          if (queuePosition == null) {
            unawaited(_reloader.trigger());
          } else {
            setState(() {
              _queuePosition = queuePosition;
            });
          }
        });
    unawaited(_reloader.trigger());
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(child: column(context)),
    );
  }

  Widget column(BuildContext context) {
    final verificationConfig = context.read<ClientFeaturesConfigBloc>().state.verificationConfig();
    final verificationStatus = _profileVerificationStatus | _mediaVerificationStatus;
    final statuses = accountVerificationScopeStatuses(
      verificationConfig: verificationConfig,
      verificationStatus: verificationStatus,
    );

    final verificationOngoing = _queuePosition != null;
    final showPreviousVerification = !verificationOngoing && _previousVerificationUnixTime != null;
    final previousVerificationErrors = _verificationErrors(context);
    final showVerificationStates = _previousVerificationUnixTime != null;
    final showVerificationMethods =
        !verificationOngoing && statuses.isAnyScopeVisible && !statuses.allVisibleScopesVerified;

    return Column(
      children: [
        if (showVerificationStates) ...[
          if (statuses.showProfileAgeRange)
            _verificationStatusTile(
              context,
              verified: statuses.profileAgeRangeVerified,
              title: context
                  .strings
                  .profile_filters_screen_profile_verification_status_filter_profile_age_range_verified,
            ),
          if (statuses.showProfileName)
            _verificationStatusTile(
              context,
              verified: statuses.profileNameVerified,
              title: context
                  .strings
                  .profile_filters_screen_profile_verification_status_filter_profile_name_verified,
            ),
          if (statuses.showSecurityContent)
            _verificationStatusTile(
              context,
              verified: statuses.securitySelfieVerified,
              title: context
                  .strings
                  .profile_filters_screen_profile_verification_status_filter_security_content_verified,
            ),
          const Divider(),
        ],
        if (verificationOngoing) ...[
          _sectionTitle(context.strings.account_verification_screen_verification_in_progress_title),
          ListTile(
            leading: const Icon(Icons.hourglass_top, color: Colors.orange),
            title: Text(
              context.strings.account_verification_screen_queue_position(
                _queuePosition!.toString(),
              ),
            ),
          ),
        ],
        if (verificationOngoing) const Divider(),
        if (showPreviousVerification) ...[
          _sectionTitle(context.strings.account_verification_screen_previous_verification_title),
          ListTile(
            leading: const Icon(Icons.history),
            title: Text(
              context.strings.account_verification_screen_previous_verification_time(
                fullTimeWithSecondsString(
                  _previousVerificationUnixTime!.toUtcDateTime(),
                  Localizations.localeOf(context).localeString(),
                ),
              ),
            ),
          ),
          if (previousVerificationErrors.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.strings.account_verification_screen_previous_verification_errors_title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          ...previousVerificationErrors.map(
            (error) => ListTile(
              leading: const Icon(Icons.error_outline, color: Colors.orange),
              title: Text(error),
            ),
          ),
          const Divider(),
        ],
        if (showVerificationMethods) ...[
          _sectionTitle(context.strings.account_verification_screen_start_verification_title),
          ..._verificationScopeAndActionTiles(context, verificationConfig),
        ],
      ],
    );
  }

  List<String> _verificationErrors(BuildContext context) {
    final errorFlags = _verificationErrorFlags;
    if (errorFlags == 0) {
      return const [];
    }

    final errors = <String>[];
    if (errorFlags & _verificationMethodNotConfigured != 0) {
      errors.add(
        context.strings.account_verification_screen_error_verification_method_not_configured,
      );
    }
    if (errorFlags & _verificationDataParsingFailed != 0) {
      errors.add(
        context.strings.account_verification_screen_error_verification_data_parsing_failed,
      );
    }
    if (errorFlags & _verificationDataVerificationFailed != 0) {
      errors.add(
        context.strings.account_verification_screen_error_verification_data_verification_failed,
      );
    }
    if (errorFlags & _profileAgeRangeVerificationFailed != 0) {
      errors.add(
        context.strings.account_verification_screen_error_profile_age_range_verification_failed,
      );
    }
    if (errorFlags & _profileAgeRangeVerificationMismatch != 0) {
      errors.add(
        context.strings.account_verification_screen_error_profile_age_range_verification_mismatch,
      );
    }
    if (errorFlags & _profileAgeRangeMismatch != 0) {
      errors.add(context.strings.account_verification_screen_error_profile_age_range_mismatch);
    }
    if (errorFlags & _profileNameVerificationFailed != 0) {
      errors.add(
        context.strings.account_verification_screen_error_profile_name_verification_failed,
      );
    }
    if (errorFlags & _profileNameVerificationMismatch != 0) {
      errors.add(
        context.strings.account_verification_screen_error_profile_name_verification_mismatch,
      );
    }
    if (errorFlags & _profileNameMismatch != 0) {
      errors.add(context.strings.account_verification_screen_error_profile_name_mismatch);
    }
    if (errorFlags & _securityContentVerificationFailed != 0) {
      errors.add(
        context.strings.account_verification_screen_error_security_content_verification_failed,
      );
    }
    if (errorFlags & _securityContentVerificationMismatch != 0) {
      errors.add(
        context.strings.account_verification_screen_error_security_content_verification_mismatch,
      );
    }
    if (errorFlags & _securityContentMismatch != 0) {
      errors.add(context.strings.account_verification_screen_error_security_content_mismatch);
    }

    return errors;
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
    BuildContext context,
    VerificationConfig verificationConfig,
  ) {
    final selectedScope = _selectedVerificationScope(verificationConfig);
    return [
      ..._verificationScopeCheckboxTiles(context, verificationConfig),
      if (widget.methods.debugEnabled)
        ListTile(
          leading: const Icon(Icons.task_alt),
          title: const Text('Debug accept'),
          enabled: !_actionInProgress && _hasVerificationScope(selectedScope),
          onTap: () => _requestVerification(
            verificationMethod: VerificationMethod.debug,
            verificationScope: selectedScope,
            verificationData: 'accept',
          ),
        ),
      if (widget.methods.debugEnabled)
        ListTile(
          leading: const Icon(Icons.cancel_outlined),
          title: const Text('Debug reject'),
          enabled: !_actionInProgress && _hasVerificationScope(selectedScope),
          onTap: () => _requestVerification(
            verificationMethod: VerificationMethod.debug,
            verificationScope: selectedScope,
            verificationData: 'reject',
          ),
        ),
      if (widget.methods.eudiEnabled)
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
    BuildContext context,
    VerificationConfig verificationConfig,
  ) {
    return [
      if (verificationConfig.profileAgeRange)
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
      if (verificationConfig.profileName)
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
      if (verificationConfig.securityContent)
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
    final icon = verified ? Icons.check : Icons.close;
    final color = verified ? Colors.green : Colors.red;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
    );
  }

  bool _hasVerificationScope(AccountVerificationScope scope) {
    return scope.securityContent || scope.profileAgeRange || scope.profileName;
  }

  AccountVerificationScope _selectedVerificationScope(VerificationConfig verificationConfig) {
    return AccountVerificationScope(
      securityContent: verificationConfig.securityContent && _scopeSecurityContent,
      profileAgeRange: verificationConfig.profileAgeRange && _scopeProfileAgeRange,
      profileName: verificationConfig.profileName && _scopeProfileName,
    );
  }

  Future<void> _reloadQueueStatus() async {
    final status = await widget.api.account((api) => api.getAccountVerificationQueueStatus()).ok();
    final profile = await widget.api.profile((api) => api.getMyProfile()).ok();
    final mediaContent = await widget.api.media((api) => api.getMediaContentInfo()).ok();

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = false;
      _queuePosition = status?.queuePosition;
      _previousVerificationUnixTime = status?.verificationUnixTime;
      _verificationErrorFlags = status?.verificationErrorFlags.v ?? 0;
      if (profile != null) {
        _profileVerificationStatus = profile.profile.verificationStatus.v;
      }
      if (mediaContent != null) {
        _mediaVerificationStatus = mediaContent.profileContent.verificationStatus.v;
      }
    });
  }

  Future<void> _requestVerification({
    required VerificationMethod verificationMethod,
    required AccountVerificationScope verificationScope,
    required String verificationData,
  }) async {
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
              verificationData: verificationData,
              verificationMethod: verificationMethod,
              verificationScope: verificationScope,
            ),
          ),
        )
        .ok();

    if (!mounted) {
      return;
    }

    if (result?.errorAlreadyInQueue == true) {
      showSnackBar(context.strings.generic_error);
    } else if (result?.errorQueueFull == true) {
      showSnackBar(context.strings.account_verification_screen_request_queue_full);
    } else if (result?.errorInitialSetupNotCompleted == true) {
      showSnackBar(context.strings.account_verification_screen_request_initial_setup_not_completed);
    } else if (result?.error == true) {
      showSnackBar(context.strings.generic_error_occurred);
    }

    await _reloader.trigger();

    if (!mounted) {
      return;
    }

    setState(() {
      _actionInProgress = false;
    });
  }
}

class _QueueStatusReloader {
  final Future<void> Function() _reload;
  bool _inProgress = false;
  bool _requested = false;

  _QueueStatusReloader(this._reload);

  Future<void> trigger() async {
    _requested = true;
    if (_inProgress) {
      return;
    }
    _inProgress = true;
    try {
      while (_requested) {
        _requested = false;
        await _reload();
      }
    } finally {
      _inProgress = false;
    }
  }
}
