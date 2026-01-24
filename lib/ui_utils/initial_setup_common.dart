import 'package:app/logic/media/profile_pictures.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/initial_setup.dart';
import 'package:app/model/freezed/logic/account/initial_setup.dart';
import 'package:app/logic/account/client_features_config.dart';
import 'package:app/model/freezed/logic/account/client_features_config.dart';
import 'package:app/logic/profile/attributes.dart';
import 'package:app/model/freezed/logic/profile/attributes.dart';
import 'package:app/ui_utils/app_bar/common_actions.dart';
import 'package:app/ui_utils/app_bar/menu_actions.dart';
import 'package:app/ui_utils/consts/padding.dart';

abstract class InitialSetupPageBase extends MyScreenPage<()> {
  InitialSetupPageBase({required super.builder});

  String get nameForDb;
}

class InitialSetupLoadingGuard extends StatelessWidget {
  final Widget child;
  const InitialSetupLoadingGuard({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitialSetupBloc, InitialSetupData>(
      buildWhen: (previous, current) => previous.loadingComplete != current.loadingComplete,
      builder: (context, setupState) {
        return BlocBuilder<ClientFeaturesConfigBloc, ClientFeaturesConfigData>(
          buildWhen: (previous, current) => previous.loadingComplete != current.loadingComplete,
          builder: (context, configState) {
            return BlocBuilder<ProfileAttributesBloc, AttributesData>(
              buildWhen: (previous, current) => previous.loadingComplete != current.loadingComplete,
              builder: (context, attributesState) {
                if (setupState.loadingComplete &&
                    configState.loadingComplete &&
                    attributesState.loadingComplete) {
                  return child;
                }

                return const SizedBox.shrink();
              },
            );
          },
        );
      },
    );
  }
}

Widget commonInitialSetupScreenContent({
  required BuildContext context,
  required Widget child,
  bool resizeToAvoidBottomInset = true,
  bool showSkipInitialSetupAction = false,
  bool showRefreshSecuritySelfieFaceDetectedValuesAction = false,
  bool showRefreshProfilePicturesFaceDetectedValuesAction = false,
}) {
  return Scaffold(
    appBar: AppBar(
      actions: [
        if (kDebugMode)
          IconButton(
            icon: const Icon(Icons.skip_next),
            onPressed: () {
              context.read<InitialSetupBloc>().add(CreateDebugAdminAccount());
            },
          ),
        menuActions([
          ...commonActionsWhenLoggedInAndAccountIsNotNormallyUsable(context),
          if (showSkipInitialSetupAction)
            MenuItemButton(
              child: Text(context.strings.generic_skip),
              onPressed: () async {
                final r = await showConfirmDialog(
                  context,
                  context.strings.initial_setup_screen_skip_dialog_title,
                  details: context.strings.initial_setup_screen_skip_dialog_description,
                  yesNoActions: true,
                );
                if (r == true && context.mounted) {
                  context.read<InitialSetupBloc>().add(SkipInitialSetup());
                }
              },
            ),
          if (showRefreshSecuritySelfieFaceDetectedValuesAction)
            MenuItemButton(
              child: Text(context.strings.initial_setup_screen_refresh_face_detected_values_action),
              onPressed: () async {
                if (context.mounted) {
                  context.read<InitialSetupBloc>().add(RefreshSecuritySelfieFaceDetectedValue());
                }
              },
            ),
          if (showRefreshProfilePicturesFaceDetectedValuesAction)
            MenuItemButton(
              child: Text(context.strings.initial_setup_screen_refresh_face_detected_values_action),
              onPressed: () async {
                if (context.mounted) {
                  context.read<ProfilePicturesBloc>().add(
                    RefreshProfilePicturesFaceDetectedValues(),
                  );
                }
              },
            ),
        ]),
      ],
    ),
    body: child,
    resizeToAvoidBottomInset: resizeToAvoidBottomInset,
  );
}

void Function()? defaultAction(BuildContext context, InitialSetupData data) {
  return null;
}

class QuestionAsker extends StatefulWidget {
  final Widget question;
  final void Function()? Function(BuildContext context, InitialSetupData state)
  getContinueButtonCallback;

  /// If this is set, the getContentButtonCallback is ignored.
  final Widget Function(BuildContext)? continueButtonBuilder;
  final bool expandQuestion;
  const QuestionAsker({
    required this.question,
    this.getContinueButtonCallback = defaultAction,
    this.continueButtonBuilder,
    this.expandQuestion = false,
    super.key,
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
            final void Function()? wrappedCallback;
            if (onPressed == null) {
              wrappedCallback = null;
            } else {
              wrappedCallback = () {
                FocusManager.instance.primaryFocus?.unfocus();
                onPressed();
              };
            }
            return ElevatedButton(
              onPressed: wrappedCallback,
              child: Text(context.strings.generic_continue),
            );
          },
        );
      };
    }

    final continueButton = Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(INITIAL_SETUP_PADDING),
        child: buttonBuilder(context),
      ),
    );

    if (widget.expandQuestion) {
      return Column(
        children: [
          Expanded(child: widget.question),
          continueButton,
        ],
      );
    } else {
      return CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: widget.question),
          SliverFillRemaining(hasScrollBody: false, fillOverscroll: true, child: continueButton),
        ],
      );
    }
  }
}

Widget questionTitleText(BuildContext context, String title) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.all(INITIAL_SETUP_PADDING),
      child: Text(title, style: Theme.of(context).textTheme.headlineSmall),
    ),
  );
}
