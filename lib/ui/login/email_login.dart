import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/account/email_login.dart';
import 'package:app/logic/sign_in_with.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/account/email_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/utils/consts/limit.dart';
import 'package:app/utils/email_address_validator.dart';
import 'package:app/utils/time.dart';

/// Email sign in method chooser screen. Lets the user choose between logging
/// in to an existing account or registering a new account.
void openEmailLoginMethodScreen(BuildContext context) {
  MyNavigator.push(context, EmailLoginMethodPage());
}

class EmailLoginMethodPage extends MyScreenPage<()> with SimpleUrlParser<EmailLoginMethodPage> {
  EmailLoginMethodPage() : super(builder: (_) => const EmailLoginMethodScreen());

  @override
  EmailLoginMethodPage create() => EmailLoginMethodPage();
}

class EmailLoginMethodScreen extends StatelessWidget {
  const EmailLoginMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.email_login_method_screen_title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _MethodButton(
              icon: Icons.login,
              title: context.strings.email_login_method_screen_existing_account,
              description: context.strings.email_login_method_screen_existing_account_description,
              onPressed: () => MyNavigator.push(context, EmailLoginPage(loginOnly: true)),
            ),
            const SizedBox(height: 16),
            _MethodButton(
              icon: Icons.person_add,
              title: context.strings.email_login_method_screen_new_account,
              description: context.strings.email_login_method_screen_new_account_description,
              onPressed: () => MyNavigator.push(context, EmailLoginPage(loginOnly: false)),
            ),
          ],
        ),
      ),
    );
  }
}

class _MethodButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onPressed;

  const _MethodButton({
    required this.icon,
    required this.title,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 32, color: colorScheme.onPrimaryContainer),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(description, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailLoginPage extends MyScreenPage<()> with SimpleUrlParser<EmailLoginPage> {
  /// If true, the email login token is requested for logging in to an
  /// existing account. If false, it can be used for either login or
  /// registration.
  final bool loginOnly;

  EmailLoginPage({this.loginOnly = false})
    : super(builder: (_) => EmailLoginScreen(loginOnly: loginOnly));

  @override
  EmailLoginPage create() => EmailLoginPage(loginOnly: loginOnly);
}

class EmailLoginScreen extends StatefulWidget {
  final bool loginOnly;
  const EmailLoginScreen({super.key, this.loginOnly = false});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = false;
  bool _unsupportedEmailAddress = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateEmail);
    _emailController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    final email = _emailController.text.trim();
    if (widget.loginOnly) {
      final isValid = email.isNotEmpty && email.contains('@');
      if (_isEmailValid != isValid) {
        setState(() {
          _isEmailValid = isValid;
          _unsupportedEmailAddress = false;
        });
      }
    } else {
      final isValid = EmailAddressValidator().validate(email) == null;
      final unsupportedEmailAddress = _isEmailTypingComplete(email) && !isValid;
      if (_isEmailValid != isValid || _unsupportedEmailAddress != unsupportedEmailAddress) {
        setState(() {
          _isEmailValid = isValid;
          _unsupportedEmailAddress = unsupportedEmailAddress;
        });
      }
    }
  }

  bool _isEmailTypingComplete(String email) {
    final domain = email.split('@').last;
    return email.contains('@') && domain.contains('.') && !domain.endsWith('.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.loginOnly
              ? context.strings.email_login_screen_title
              : context.strings.email_login_screen_title_register,
        ),
      ),
      body: content(),
    );
  }

  Widget content() {
    return inputEmailView(context, context.watch<EmailLoginBloc>().state);
  }

  Widget inputEmailView(BuildContext context, EmailLoginBlocData state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(padding: EdgeInsets.all(8)),
          Row(
            children: [
              Icon(Icons.info, color: Theme.of(context).colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.loginOnly
                      ? context.strings.email_login_screen_login_only_info
                      : context.strings.email_login_screen_registration_only_info,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.all(16)),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: context.strings.email_login_screen_email_hint,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            maxLength: EMAIL_MAX_LENGTH,
            onTapOutside: (_) {
              FocusScope.of(context).unfocus();
            },
          ),
          if (_unsupportedEmailAddress)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(context.strings.email_login_screen_registration_unsupported_email),
            ),
          const Padding(padding: EdgeInsets.all(16)),
          ElevatedButton(
            onPressed: _isEmailValid
                ? () {
                    FocusScope.of(context).unfocus();
                    final email = _emailController.text.trim();
                    context.read<EmailLoginBloc>().add(
                      RequestEmailToken(email, loginOnly: widget.loginOnly),
                    );
                    MyNavigator.push(context, EmailLoginCodePage(loginOnly: widget.loginOnly));
                  }
                : null,
            child: Text(context.strings.email_login_screen_send_code_button),
          ),
        ],
      ),
    );
  }
}

class EmailLoginCodePage extends MyScreenPage<()> with SimpleUrlParser<EmailLoginCodePage> {
  final bool loginOnly;
  EmailLoginCodePage({this.loginOnly = false})
    : super(builder: (_) => EmailLoginCodeScreen(loginOnly: loginOnly));

  @override
  EmailLoginCodePage create() => EmailLoginCodePage(loginOnly: loginOnly);
}

class EmailLoginCodeScreen extends StatefulWidget {
  final bool loginOnly;
  const EmailLoginCodeScreen({super.key, this.loginOnly = false});

  @override
  State<EmailLoginCodeScreen> createState() => _EmailLoginCodeScreenState();
}

class _EmailLoginCodeScreenState extends State<EmailLoginCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  bool _isCodeValid = false;

  @override
  void initState() {
    super.initState();
    _codeController.addListener(_validateCode);
  }

  @override
  void dispose() {
    _codeController.removeListener(_validateCode);
    _codeController.dispose();
    super.dispose();
  }

  void _validateCode() {
    final code = _codeController.text.trim();
    final isValid = code.isNotEmpty;
    if (_isCodeValid != isValid) {
      setState(() {
        _isCodeValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return updateStateHandler<EmailLoginBloc, EmailLoginBlocData>(
      context: context,
      pageKey: null,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.loginOnly
                ? context.strings.email_login_screen_title
                : context.strings.email_login_screen_title_register,
          ),
        ),
        body: content(),
      ),
    );
  }

  Widget content() {
    return BlocConsumer<EmailLoginBloc, EmailLoginBlocData>(
      listener: (context, state) {
        // Start timer when tokenValiditySeconds is set
        if (state.tokenValiditySeconds != null) {
          context.read<EmailLoginBloc>().startTokenValidityTimer();
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final error = state.error;
          final clientToken = state.clientToken;

          if (error is RegistrationAllPlatformsDisabledError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  context.strings.email_login_screen_registration_all_platforms_disabled_error,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }
          if (error is RegistrationPlatformDisabledError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  context.strings.email_login_screen_registration_platform_disabled_error(
                    platformNameFromClientType(),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }
          if (error is RegistrationIpAddressLimitReachedError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  context.strings.email_login_screen_registration_ip_address_limit_reached_error,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }
          if (error is RegistrationLimitReachedError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  context.strings.email_login_screen_registration_limit_reached_error,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }
          if (error is RegistrationDomainNotAcceptedError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  context.strings.email_login_screen_registration_domain_not_accepted_error(
                    error.domain,
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }
          if (error is RegistrationUnsupportedEmailError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  context.strings.email_login_screen_registration_unsupported_email,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }

          if (error is RequestTokenFailed || clientToken == null) {
            final errorMessage = error is RequestTokenFailed && error.maintenanceInfo != null
                ? error.maintenanceInfo!.toLocalizedText(context)
                : context.strings.generic_error_occurred;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(errorMessage, style: Theme.of(context).textTheme.bodyLarge),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(padding: EdgeInsets.all(8)),
                Text(
                  context.strings.email_login_screen_input_code_description(state.email ?? ''),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Padding(padding: EdgeInsets.only(top: 16)),
                if (error is LoginFailed)
                  Text(
                    error.error,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                if (error is LoginFailed) const Padding(padding: EdgeInsets.all(8)),
                if (state.tokenValiditySeconds != null)
                  Text(
                    context.strings.email_login_screen_token_validity(
                      formatSeconds(state.tokenValiditySeconds!),
                    ),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                const Padding(padding: EdgeInsets.only(top: 24)),
                TextField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    labelText: context.strings.email_login_screen_code_hint,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onTapOutside: (_) {
                    FocusScope.of(context).unfocus();
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 24)),
                ElevatedButton(
                  onPressed: _isCodeValid
                      ? () {
                          FocusScope.of(context).unfocus();
                          context.read<EmailLoginBloc>().add(
                            SubmitLoginCode(clientToken.token, _codeController.text.trim()),
                          );
                        }
                      : null,
                  child: Text(context.strings.generic_login),
                ),
                const Padding(padding: EdgeInsets.only(top: 24)),
                Text(
                  context.strings.email_login_screen_did_not_receive_code(
                    state.resendWaitSeconds != null
                        ? formatSeconds(state.resendWaitSeconds!)
                        : '...',
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
