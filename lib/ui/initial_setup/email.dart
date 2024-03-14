import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/account.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/ui/initial_setup/birthdate.dart";
import "package:pihka_frontend/ui/initial_setup/gender.dart";
import "package:pihka_frontend/ui_utils/initial_setup_common.dart";
import "package:pihka_frontend/utils/date.dart";

class AskEmailScreen extends StatelessWidget {
  const AskEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        final currentAccountEmail = state.email;
        return commonInitialSetupScreenContent(
          context: context,
          child: QuestionAsker(
            getContinueButtonCallback: (context, state) {
              final email = state.email;
              if ((email != null && isValidEmail(email)) || currentAccountEmail != null) {
                return () {
                  Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const AskBirthdateScreen()));
                };
              } else {
                return null;
              }
            },
            question: AskEmail(initialEmail: currentAccountEmail),
          ),
        );
      }
    );
  }
}

class AskEmail extends StatefulWidget {
  final String? initialEmail;
  const AskEmail({required this.initialEmail, super.key});

  @override
  State<AskEmail> createState() => _AskEmailState();
}

class _AskEmailState extends State<AskEmail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        questionTitleText(context, context.strings.initial_setup_screen_email_title),
        emailRow(context),
      ],
    );
  }

  Widget emailRow(BuildContext context) {
    final email = widget.initialEmail;
    if (email != null) {
      // TODO(prod): Perhaps add IconButton which displays info dialog about
      // the email address. Or text which says "The above email adderss is
      // provided by Sign in with Apple/Google"
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(email),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
            icon: const Icon(Icons.email),
            hintText: context.strings.initial_setup_screen_email_hint_text,
          ),
          onChanged: (value) {
            context.read<InitialSetupBloc>().add(SetEmail(value.trim()));
          },
        ),
      );
    }
  }
}

bool isValidEmail(String email) {
  final emailTrimmed = email.trim();
  return emailTrimmed.runes.length >= 3 && emailTrimmed.contains("@");
}
