import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/localizations.dart";
import "package:app/logic/account/account.dart";
import "package:app/logic/account/initial_setup.dart";
import "package:app/logic/app/navigator_state.dart";
import "package:app/model/freezed/logic/account/account.dart";
import "package:app/ui/initial_setup/age_confirmation.dart";
import "package:app/ui_utils/initial_setup_common.dart";

class AskEmailScreen extends StatelessWidget {
  const AskEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        final currentAccountEmail = state.email;
        return commonInitialSetupScreenContent(
          context: context,
          showSkipInitialSetupAction: true,
          child: QuestionAsker(
            getContinueButtonCallback: (context, state) {
              final email = state.email;
              if ((email != null && isValidEmail(email)) || currentAccountEmail != null) {
                return () {
                  MyNavigator.push(context, const MaterialPage<void>(child: AgeConfirmationScreen()));
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
      // TODO(prod): Make email editing possible even if sign in with login
      //             is used.
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
  if (!emailTrimmed.contains("@")) {
    return false;
  }

  final emailParts = emailTrimmed.split("@");
  var domainOk = false;
  var localOk = false;
  // Check domain part first
  for (final (i, part) in emailParts.reversed.indexed) {
    if (i == 0) {
      if (part.contains(".")) {
        final domainParts = part.split(".");
        var topLevelDomainOk = false;
        var latestSubLevelDomainOk = false;
        var allSubLevelDomainsOk = true;
        // Check top level domain first
        for (final (i, part) in domainParts.reversed.indexed) {
          if (i == 0) {
            topLevelDomainOk = part.runes.length >= 2;
          } else {
            latestSubLevelDomainOk = part.runes.isNotEmpty;
            if (allSubLevelDomainsOk) {
              allSubLevelDomainsOk = part.runes.isNotEmpty;
            }
          }
        }
        domainOk = topLevelDomainOk && latestSubLevelDomainOk && allSubLevelDomainsOk;
      } else {
        domainOk = false;
      }
    } else if (i == 1) {
      localOk = part.runes.isNotEmpty;
    } else {
      break;
    }
  }
  return domainOk && localOk;
}
