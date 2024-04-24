import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/logic/app/navigator_state.dart";
import "package:pihka_frontend/model/freezed/logic/account/initial_setup.dart";
import "package:pihka_frontend/ui/initial_setup/security_selfie.dart";
import "package:pihka_frontend/ui_utils/initial_setup_common.dart";
import "package:pihka_frontend/utils/date.dart";


class AskBirthdateScreen extends StatelessWidget {
  const AskBirthdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        getContinueButtonCallback: (context, state) {
          final birthdate = state.birthdate;
          if (birthdate != null && birthdate.isNowAdult()) {
            return () {
              MyNavigator.push(context, MaterialPage<void>(child: const AskSecuritySelfieScreen()));
            };
          } else {
            return null;
          }
        },
        question: const AskBirthdate(),
      ),
    );
  }
}


class AskBirthdate extends StatefulWidget {
  const AskBirthdate({super.key});

  @override
  State<AskBirthdate> createState() => _AskBirthdateState();
}

class _AskBirthdateState extends State<AskBirthdate> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        questionTitleText(context, context.strings.initial_setup_screen_birthdate_title),
        birthDateRow(context),
        tooYoungError(context),
      ],
    );
  }

  Widget birthDateRow(BuildContext context) {
    return BlocBuilder<InitialSetupBloc, InitialSetupData>(
      builder: (context, state) {
        final birthdate = state.birthdate;
        final List<Widget> widgets;
        if (birthdate != null) {
          final locale = Localizations.localeOf(context);
          widgets = [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(DateFormat.yMMMMd(locale.toLanguageTag()).format(birthdate)),
            ),
            calendarButton(context, birthdate),
          ];
        } else {
          widgets = [
            calendarButton(context, birthdate),
          ];
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets,
        );
      }
    );
  }

  Widget tooYoungError(BuildContext context) {
    return BlocBuilder<InitialSetupBloc, InitialSetupData>(
      builder: (context, state) {
        final birthdate = state.birthdate;
        if (birthdate != null) {
          if (!birthdate.isNowAdult()) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(context.strings.initial_setup_screen_too_young_error),
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      }
    );
  }

  Widget calendarButton(BuildContext context, DateTime? birthdate) {
    if (birthdate == null) {
      return ElevatedButton.icon(
        onPressed: () => showCalendar(context, birthdate),
        icon: const Icon(Icons.calendar_today),
        label: Text(context.strings.initial_setup_screen_birthdate_button),
      );
    } else {
      return IconButton(
        onPressed: () => showCalendar(context, birthdate),
        icon: const Icon(Icons.edit),
      );
    }
  }

  void showCalendar(BuildContext context, DateTime? birthdate) {
    final DatePickerMode mode;
    if (birthdate == null) {
      mode = DatePickerMode.year;
    } else {
      mode = DatePickerMode.day;
    }

    showDatePicker(
      context: context,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: mode,
      initialDate: birthdate,
    ).then((value) {
      if (value != null) {
        context.read<InitialSetupBloc>().add(SetBirthdate(value));
      }
    });
  }
}
