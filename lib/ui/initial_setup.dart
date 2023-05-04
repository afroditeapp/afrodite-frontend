import "dart:ffi";

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
  String? _selfie;
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
    } else if (_currentStep == 2) {
      if (_selfie != null) {
        onStepContinue = onStepContinueHandler;
      }
      onStepContinue = () {
        if (_selfie != null) {
          onStepContinueHandler();
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No image. Take one using the camera button."), behavior: SnackBarBehavior.floating));
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

    //timeDilation = 10.0;
    return [
        createAccountStep(counter.next()),
        createProfileStep(counter.next()),
        createTakeSelfieStep(counter.next()),
        createSelectProfileImageStep(counter.next()),
      ];
  }

  Step createAccountStep(int id) {
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

    return Step(
      title: const Text("Account"),
      // subtitle: counter.onlyIfSelected(
      //   _currentStep,
      //   Text("Your first name will be visible on your profile. It is not possible to change this later.")
      // ),
      isActive: _currentStep == id,
      content: Container(
        alignment: Alignment.centerLeft,
        child: accountForm,
      ),
    );
  }

  Step createProfileStep(int id) {
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
    return Step(
      title: const Text("Profile"),
      // subtitle: counter.onlyIfSelected(
      //   _currentStep,
      //   Text("Your first name will be visible on your profile. It is not possible to change this later.")
      // ),
      isActive: _currentStep == id,
      content: Container(
        alignment: Alignment.centerLeft,
        child: profileForm,
      )
    );
  }

  Step createTakeSelfieStep(int id) {
    return Step(
      title: const Text("Take security selfie"),
      // subtitle: counter.onlyIfSelected(
      //   _currentStep,
      //   Text("Your first name will be visible on your profile. It is not possible to change this later.")
      // ),
      isActive: _currentStep == id,
      content: Column(
        children: [
          const Text("Take image in which your face is clearly visible."),
          Row(children: [
            Icon(Icons.person, size: 150.0, color: Colors.black45),
            Column(
              children: [
                ElevatedButton.icon(label: Text("Camera"), icon: Icon(Icons.camera_alt), onPressed: () {

                }),
              ],
            ),
          ]),
        ],
      )
    );
  }

  Step createSelectProfileImageStep(int id) {
    return Step(
      title: const Text("Select proifle image"),
      // subtitle: counter.onlyIfSelected(
      //   _currentStep,
      //   Text("Your first name will be visible on your profile. It is not possible to change this later.")
      // ),
      isActive: _currentStep == id,
      content: const Text("data"),
    );
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
