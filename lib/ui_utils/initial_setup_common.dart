


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/account/initial_setup.dart';
import 'package:pihka_frontend/ui_utils/app_bar/common_actions.dart';
import 'package:pihka_frontend/ui_utils/app_bar/menu_actions.dart';

Widget commonInitialSetupScreenContent({
  required BuildContext context,
  required Widget child
}) {
  return Scaffold(
    appBar: AppBar(
      actions: [
        // TODO(prod): Hide this from release build
        IconButton(
          icon: const Icon(Icons.skip_next),
          onPressed: () {
            context.read<InitialSetupBloc>().add(CreateDebugAdminAccount());
          },
        ),
        menuActions([
            ...commonActionsWhenLoggedInAndAccountIsNotNormallyUsable(context),
        ]),
      ],
    ),
    body: child,
    resizeToAvoidBottomInset: false,
  );
}

void Function()? defaultAction(BuildContext context, InitialSetupData data) {
  return null;
}

class QuestionAsker extends StatefulWidget {
  final Widget question;
  final void Function()? Function(BuildContext context, InitialSetupData state) getContinueButtonCallback;
  /// If this is set, the getContentButtonCallback is ignored.
  final Widget Function(BuildContext)? continueButtonBuilder;
  const QuestionAsker({
    required this.question,
    this.getContinueButtonCallback = defaultAction,
    this.continueButtonBuilder,
    super.key
  });

  @override
  State<QuestionAsker> createState() => _QuestionAskerState();
}

class _QuestionAskerState extends State<QuestionAsker> {
  @override
  Widget build(BuildContext context) {
    final Widget Function(BuildContext)? buttonBuilderFromWidget = widget.continueButtonBuilder;
    final Widget Function(BuildContext) buttonBuilder;
    if (buttonBuilderFromWidget != null) {
      buttonBuilder = buttonBuilderFromWidget;
    } else {
      buttonBuilder = (BuildContext context) {
        return BlocBuilder<InitialSetupBloc, InitialSetupData>(
          builder: (context, state) {
            final onPressed = widget.getContinueButtonCallback(context, state);
            return ElevatedButton(
              onPressed: onPressed,
              child: Text(context.strings.generic_continue),
            );
          }
        );
      };
    }

    return Column(
      verticalDirection: VerticalDirection.up,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: buttonBuilder(context),
          ),
        ),
        Expanded(child: widget.question),
      ],
    );
  }
}


Widget questionTitleText(BuildContext context, String title) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall
      ),
    ),
  );
}
