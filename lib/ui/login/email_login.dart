import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/account/email_login.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/account/email_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/common_update_logic.dart';

void openEmailLoginScreen(BuildContext context) {
  MyNavigator.push(context, EmailLoginPage());
}

class EmailLoginPage extends MyScreenPage<()> with SimpleUrlParser<EmailLoginPage> {
  EmailLoginPage() : super(builder: (_) => const EmailLoginScreen());

  @override
  EmailLoginPage create() => EmailLoginPage();
}

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = false;

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
    final isValid = email.isNotEmpty && email.contains('@');
    if (_isEmailValid != isValid) {
      setState(() {
        _isEmailValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.email_login_screen_title)),
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
          Text(
            context.strings.email_login_screen_input_email_description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Padding(padding: EdgeInsets.all(16)),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: context.strings.email_login_screen_email_hint,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            onTapOutside: (_) {
              FocusScope.of(context).unfocus();
            },
          ),
          const Padding(padding: EdgeInsets.all(16)),
          ElevatedButton(
            onPressed: _isEmailValid
                ? () {
                    FocusScope.of(context).unfocus();
                    final email = _emailController.text.trim();
                    context.read<EmailLoginBloc>().add(RequestEmailToken(email));
                    MyNavigator.push(context, EmailLoginCodePage());
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
  EmailLoginCodePage() : super(builder: (_) => const EmailLoginCodeScreen());

  @override
  EmailLoginCodePage create() => EmailLoginCodePage();
}

class EmailLoginCodeScreen extends StatefulWidget {
  const EmailLoginCodeScreen({super.key});

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
        appBar: AppBar(title: Text(context.strings.email_login_screen_title)),
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

          if (error is RequestTokenFailed || clientToken == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  context.strings.generic_error_occurred,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
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
                      _formatSeconds(state.tokenValiditySeconds!),
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
                  context.strings.email_login_screen_didnt_receive_code(
                    state.resendWaitSeconds != null
                        ? _formatSeconds(state.resendWaitSeconds!)
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

  String _formatSeconds(int seconds) {
    final duration = Duration(seconds: seconds);
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m ${duration.inSeconds.remainder(60)}s';
    } else {
      return '${duration.inSeconds}s';
    }
  }
}
