import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:latlong2/latlong.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/logic/app/navigator_state.dart";
import "package:pihka_frontend/ui/initial_setup/profile_attributes.dart";
import "package:pihka_frontend/ui/normal/settings/location.dart";
import "package:pihka_frontend/ui_utils/dialog.dart";
import "package:pihka_frontend/ui_utils/initial_setup_common.dart";

class AskLocationScreen extends StatelessWidget {
  const AskLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        getContinueButtonCallback: (context, state) {
          if (state.profileLocation != null) {
            return () {
              MyNavigator.push(context, MaterialPage<void>(child: AskProfileAttributesScreen()));
            };
          } else {
            return null;
          }
        },
        question: AskLocation(initialLocation: context.read<InitialSetupBloc>().state.profileLocation),
        expandQuestion: true,
      ),
    );
  }
}

class AskLocation extends StatefulWidget {
  final LatLng? initialLocation;
  const AskLocation({required this.initialLocation, super.key});

  @override
  State<AskLocation> createState() => _AskLocationState();
}

class _AskLocationState extends State<AskLocation> {

  bool infoDialogShown = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialLocation == null && !infoDialogShown) {
      infoDialogShown = true;
      Future.delayed(Duration.zero, () {
        showInfoDialog(
          context,
          context.strings.initial_setup_screen_location_help_dialog_text,
        );
      });
    }

    final MapMode mode;
    if (widget.initialLocation == null) {
      mode = MapMode.selectInitialLocation;
    } else {
      mode = MapMode.selectLocation;
    }

    return Column(
      children: [
        questionTitleText(context, context.strings.initial_setup_screen_location_title),
        Expanded(
          child: LocationWidget(
            mode: mode,
            markerInitialLocation: widget.initialLocation,
            handler: InitialSetupLocationHandler(),
            editingHelpText: context.strings.map_select_location_help_text,
          ),
        )
      ],
    );
  }
}

class InitialSetupLocationHandler extends SelectedLocationHandler {
  @override
  Future<void> handleLocationSelection({
    required BuildContext context,
    required LatLng location,
    required void Function() onStart,
    required void Function(bool) onComplete
  }) async {
    onStart();
    if (context.mounted) {
      context.read<InitialSetupBloc>().add(SetLocation(location));
    }
    onComplete(true);
  }
}
