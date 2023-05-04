import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui/login.dart";
import "package:pihka_frontend/ui/main/home.dart";
import "package:pihka_frontend/ui/utils/root_page.dart";

import "package:flutter/scheduler.dart";

class InitialSetupPage extends RootPage {
  const InitialSetupPage({Key? key}) : super(MainState.initialSetup, key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Setup your new account")),
        body: InitialSetupWidget(),
      );
  }
}



// body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text("Initial setup"),
//               ElevatedButton(
//                 child: const Text("Complete"),
//                 onPressed: () => context.read<MainStateBloc>().add(ToMainScreen()),
//               )
//             ],
//           ),
//         ),

class InitialSetupWidget extends StatefulWidget {
  const InitialSetupWidget({super.key});

  @override
  State<InitialSetupWidget> createState() => _InitialSetupWidgetState();
}

class _InitialSetupWidgetState extends State<InitialSetupWidget> {
  final _accountFormKey = GlobalKey<FormState>();
  final _profileFormKey = GlobalKey<FormState>();
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final steps = createSteps();
    void Function()? onStepCancelHandler;
    if (_currentStep == 0) {
      onStepCancelHandler = null;
    } else {
      onStepCancelHandler = () {
        if (_currentStep > 0) {
          setState(() {
            updateStep(_currentStep - 1);
          });
        }
      };
    }

    onStepContinueHandler() {
      if (_currentStep < steps.length - 1) {
        setState(() {
          updateStep(_currentStep + 1);
        });
      }
    }
    void Function()? onStepContinue;
    if (_currentStep == 0) {
      onStepContinue = () {
        var valid = _accountFormKey.currentState?.validate() ?? false;
        if (valid) {
          onStepContinueHandler();
        }
      };
    } else if (_currentStep == 1) {
      onStepContinue = () {
        var valid = _profileFormKey.currentState?.validate() ?? false;
        if (valid) {
          onStepContinueHandler();
        }
      };
    } else {
      onStepContinue = onStepContinueHandler;
    }


    return Stepper(
      currentStep: _currentStep,
      onStepCancel: onStepCancelHandler,
      onStepContinue: onStepContinue,
      onStepTapped: (i) {
        if (i < steps.length && (i < _currentStep)) {
          setState(() {
            updateStep(i);
          });
        }
      },
      controlsBuilder: (context, details) {
        var buttonContinue = ElevatedButton(
          child: const Text("CONTINUE"),
          onPressed: details.onStepContinue,
        );
        var buttonBack = MaterialButton(
          child: const Text("BACK"),
          onPressed: details.onStepCancel,
        );
        Widget buttons = Row(children: [buttonContinue, const Padding(padding: EdgeInsets.symmetric(horizontal: 10.0)), buttonBack]);
        return Padding(padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0), child: buttons);
      },
      steps: steps,
    );
  }

  void updateStep(int i) {
    _currentStep = i;
  }

  List<Step> createSteps() {
    final counter = Counter();
    final accountForm = Form(
      key: _accountFormKey,
      child: TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.email),
          hintText: "Email",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Is empty";
          } else {
            return null;
          }
        },
      ),
    );
    final profileForm = Form(
      key: _profileFormKey,
      child: TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: "First name",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Is empty";
          } else {
            return null;
          }
        },
      ),
    );
    //timeDilation = 10.0;
    return [
        Step(
          title: const Text("Account"),
          // subtitle: counter.onlyIfSelected(
          //   _currentStep,
          //   Text("Your first name will be visible on your profile. It is not possible to change this later.")
          // ),
          isActive: _currentStep == counter.next(),
          content: Container(
            alignment: Alignment.centerLeft,
            child: accountForm,
          ),
        ),
        Step(
          title: const Text("Profile"),
          // subtitle: counter.onlyIfSelected(
          //   _currentStep,
          //   Text("Your first name will be visible on your profile. It is not possible to change this later.")
          // ),
          isActive: _currentStep == counter.next(),
          content: Container(
            alignment: Alignment.centerLeft,
            child: profileForm,
          )
        ),
        Step(
          title: const Text("Take security selfie"),
          // subtitle: counter.onlyIfSelected(
          //   _currentStep,
          //   Text("Your first name will be visible on your profile. It is not possible to change this later.")
          // ),
          isActive: _currentStep == counter.next(),
          content: const Text("This image will not be visible on your profile")
        ),
        Step(
          title: const Text("Select proifle image"),
          // subtitle: counter.onlyIfSelected(
          //   _currentStep,
          //   Text("Your first name will be visible on your profile. It is not possible to change this later.")
          // ),
          isActive: _currentStep == counter.next(),
          content: const Text("data"),
        ),
      ];
  }
}

class Counter {
  int value = 0;

  Widget? onlyIfSelected(int i, Widget w) {
    if (value == i) {
      return w;
    } else {
      return null;
    }
  }

  int next() {
    var current = value;
    value += 1;
    return current;
  }
}
