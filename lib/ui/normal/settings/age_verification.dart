import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/utils/result.dart';

bool isAccessToAgeVerificationScreenPossible({required AgeVerificationMethodsConfig methods}) {
  return methods != AgeVerificationMethodsConfig();
}

void openAgeVerificationSettings(BuildContext context, AgeVerificationMethodsConfig methods) {
  final r = context.read<RepositoryInstances>();
  MyNavigator.pushLimited(context, AgeVerificationSettingsPage(r.connectionManager, methods));
}

typedef AgeVerificationStateChanged = void Function(BuildContext context, bool ageVerified);

class AgeVerificationSettingsPage extends MyScreenPageLimited<()> {
  final ServerConnectionManager api;
  final AgeVerificationMethodsConfig methods;

  AgeVerificationSettingsPage(this.api, this.methods)
    : super(
        builder: (_) => AgeVerificationSettingsScreen(api: api, methods: methods),
      );
}

class AgeVerificationSettingsScreen extends StatefulWidget {
  final ServerConnectionManager api;
  final AgeVerificationMethodsConfig methods;

  const AgeVerificationSettingsScreen({required this.api, required this.methods, super.key});

  @override
  State<AgeVerificationSettingsScreen> createState() => _AgeVerificationSettingsScreenState();
}

class _AgeVerificationSettingsScreenState extends State<AgeVerificationSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.age_verification_screen_title)),
      body: SingleChildScrollView(
        child: AgeVerificationContent(api: widget.api, methods: widget.methods),
      ),
    );
  }
}

class AgeVerificationContent extends StatefulWidget {
  final ServerConnectionManager api;
  final AgeVerificationMethodsConfig methods;
  final AgeVerificationStateChanged? onVerificationStateChanged;

  const AgeVerificationContent({
    required this.api,
    required this.methods,
    this.onVerificationStateChanged,
    super.key,
  });

  @override
  State<AgeVerificationContent> createState() => _AgeVerificationContentState();
}

class _AgeVerificationContentState extends State<AgeVerificationContent> {
  bool _isLoading = true;
  bool _actionInProgress = false;
  bool _ageVerified = false;
  bool _hasLoadError = false;

  @override
  void initState() {
    super.initState();
    _reloadAgeVerificationStatus();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasLoadError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.strings.generic_error_occurred),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _actionInProgress ? null : _reloadAgeVerificationStatus,
              child: Text(context.strings.generic_retry),
            ),
          ],
        ),
      );
    }

    return _column(context);
  }

  Widget _column(BuildContext context) {
    return Column(
      children: [
        _sectionTitle(context.strings.age_verification_screen_current_verification_status_title),
        _verificationStatusTile(
          verified: _ageVerified,
          title: context.strings.age_verification_screen_age_is_18_or_older,
        ),
        const Divider(),
        if (!_ageVerified) ...[
          _sectionTitle(context.strings.age_verification_screen_start_verification_title),
          ..._verificationMethodTiles(context),
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

  Widget _verificationStatusTile({required bool verified, required String title}) {
    final icon = verified ? Icons.check : Icons.close;
    final color = verified ? Colors.green : Colors.red;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
    );
  }

  List<Widget> _verificationMethodTiles(BuildContext context) {
    return [
      if (widget.methods.debug)
        ListTile(
          leading: const Icon(Icons.task_alt),
          title: const Text('Debug verify'),
          enabled: !_actionInProgress,
          onTap: () => _requestVerification(
            verificationMethod: AgeVerificationMethod.debug,
            verificationData: '',
          ),
        ),
      if (widget.methods.eudi)
        ListTile(
          leading: Icon(Icons.badge_outlined),
          title: Text(context.strings.age_verification_screen_verification_method_eudi_unsupported),
          enabled: false,
        ),
    ];
  }

  Future<void> _reloadAgeVerificationStatus() async {
    if (_hasLoadError) {
      setState(() {
        _hasLoadError = false;
      });
    }

    final accountState = await widget.api.account((api) => api.getAccountState()).ok();

    if (!mounted) {
      return;
    }

    if (accountState == null) {
      setState(() {
        _isLoading = false;
        _hasLoadError = true;
      });
      return;
    }

    final ageVerified = accountState.ageVerified;

    setState(() {
      _isLoading = false;
      _ageVerified = ageVerified;
      _hasLoadError = false;
    });

    widget.onVerificationStateChanged?.call(context, ageVerified);
  }

  Future<void> _requestVerification({
    required AgeVerificationMethod verificationMethod,
    required String verificationData,
  }) async {
    setState(() {
      _actionInProgress = true;
    });

    final result = await widget.api
        .account(
          (api) => api.postAgeVerification(
            PostAgeVerification(
              verificationData: verificationData,
              verificationMethod: verificationMethod,
            ),
          ),
        )
        .ok();

    if (!mounted) {
      return;
    }

    if (result?.errorAgeAlreadyVerified == true) {
      showSnackBar(context.strings.age_verification_screen_error_age_already_verified);
    } else if (result?.errorAgeUnder18 == true) {
      showSnackBar(context.strings.age_verification_screen_error_age_under_18);
    } else if (result?.errorVerificationDataParsingFailed == true) {
      showSnackBar(context.strings.age_verification_screen_error_verification_data_parsing_failed);
    } else if (result?.errorVerificationDataVerificationFailed == true) {
      showSnackBar(
        context.strings.age_verification_screen_error_verification_data_verification_failed,
      );
    } else if (result?.errorVerificationMethodNotConfigured == true) {
      showSnackBar(
        context.strings.age_verification_screen_error_verification_method_not_configured,
      );
    } else if (result?.error == true) {
      showSnackBar(context.strings.generic_error);
    }

    await _reloadAgeVerificationStatus();

    if (!mounted) {
      return;
    }

    setState(() {
      _actionInProgress = false;
    });
  }
}
