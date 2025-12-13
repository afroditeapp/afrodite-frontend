import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:latlong2/latlong.dart";
import "package:app/localizations.dart";
import "package:app/logic/account/initial_setup.dart";
import "package:app/logic/app/navigator_state.dart";
import "package:app/logic/profile/attributes.dart";
import "package:app/ui/initial_setup/chat_info.dart";
import "package:app/ui/normal/settings/location.dart";
import "package:app/ui_utils/dialog.dart";
import "package:app/ui_utils/initial_setup_common.dart";

class AskLocationPage extends MyScreenPage<()> with SimpleUrlParser<AskLocationPage> {
  AskLocationPage() : super(builder: (_) => AskLocationScreen());

  @override
  AskLocationPage create() => AskLocationPage();
}

class AskLocationScreen extends StatelessWidget {
  const AskLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Init profile attributes as it is next screen
    context.read<ProfileAttributesBloc>();

    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        getContinueButtonCallback: (context, state) {
          if (state.profileLocation != null) {
            return () {
              MyNavigator.push(context, ChatInfoPage());
            };
          } else {
            return null;
          }
        },
        question: AskLocation(
          initialLocation: context.read<InitialSetupBloc>().state.profileLocation,
        ),
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
        if (!context.mounted) {
          return;
        }
        showInfoDialog(context, context.strings.initial_setup_screen_location_help_dialog_text);
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
        ),
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
    required void Function(bool) onComplete,
  }) async {
    onStart();
    if (context.mounted) {
      context.read<InitialSetupBloc>().add(SetLocation(location));
    }
    onComplete(true);
  }
}
