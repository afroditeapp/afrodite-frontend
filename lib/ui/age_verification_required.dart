import "package:app/data/utils/repository_instances.dart";
import "package:app/localizations.dart";
import "package:app/logic/account/client_features_config.dart";
import "package:app/model/freezed/logic/account/client_features_config.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/ui/normal/settings/age_verification.dart";
import "package:app/ui_utils/app_bar/common_actions.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class AgeVerificationRequiredPage extends MyScreenPage<()>
    with SimpleUrlParser<AgeVerificationRequiredPage> {
  final RepositoryInstances r;
  AgeVerificationRequiredPage(this.r) : super(builder: (_) => AgeVerificationRequiredScreen(r));

  @override
  AgeVerificationRequiredPage create() => AgeVerificationRequiredPage(r);
}

class AgeVerificationRequiredScreen extends StatelessWidget {
  final RepositoryInstances r;
  const AgeVerificationRequiredScreen(this.r, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.age_verification_required_screen_title),
        actions: [loggedInBasicScreenActionsMenu(context)],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<ClientFeaturesConfigBloc, ClientFeaturesConfigData>(
                builder: (context, state) {
                  final methods = state.config.ageVerification?.methods;
                  final canOpen =
                      methods != null && isAccessToAgeVerificationScreenPossible(methods: methods);
                  return ElevatedButton(
                    onPressed: canOpen ? () => openAgeVerificationSettings(context, methods) : null,
                    child: Text(context.strings.age_verification_required_screen_verify_age_action),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
