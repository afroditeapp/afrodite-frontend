import "dart:ffi";
import "dart:io";
import "dart:math";

import "package:camera/camera.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:image_picker/image_picker.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui/login.dart";
import "package:pihka_frontend/ui/main/home.dart";
import "package:pihka_frontend/ui/utils.dart";
import "package:pihka_frontend/ui/utils/camera_page.dart";
import "package:pihka_frontend/ui/utils/root_page.dart";

import "package:flutter/scheduler.dart";

// TODO: save initial setup values, so that it will be possible to restore state
//       if system kills the app when selecting profile photo

class InitialSetupPage extends RootPage {
  const InitialSetupPage({Key? key}) : super(MainState.initialSetup, key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Setup your new account")),
        body: BlocListener<InitialSetupBloc, InitialSetupData>(
          listener: (context, state) {
            if (state.sendingInProgress && !Navigator.canPop(context)) {
              print("Show dialog");
              showDialog<void>(context: context, barrierDismissible: false, builder: (context) {
                return WillPopScope(
                  onWillPop: () async => false,
                  child: AlertDialog(
                    title: const Text("Sending in progress..."),
                    content: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                      CircularProgressIndicator(),
                    ]),
                    actions: [],
                  ),
                );
              });
            } else if (!state.sendingInProgress && Navigator.canPop(context)) {
              print("pop");
              Navigator.pop(context);
              if (state.sendError != null) {
                showSnackBar(context, state.sendError ?? "");
              }
            }
          },
          child: const InitialSetupWidget(),
        ),
      );
  }
}

class InitialSetupWidget extends StatefulWidget {
  const InitialSetupWidget({super.key});

  @override
  State<InitialSetupWidget> createState() => _InitialSetupWidgetState();
}

class _InitialSetupWidgetState extends State<InitialSetupWidget> {
  final _accountFormKey = GlobalKey<FormState>();
  final _profileFormKey = GlobalKey<FormState>();

  String? email;
  String? name;
  XFile? securitySelfie;
  XFile? profileImage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitialSetupBloc, InitialSetupData>(builder: ((context, state) {
      print(state);
      return createStepper(context, state);
    }));
  }

   Stepper createStepper(BuildContext contex, InitialSetupData state) {
    print("Creating new stepper");
    final steps = createSteps(state);
    void Function()? onStepCancelHandler;
    sendingInProgress() => state.currentStep == 4 && state.sendError == null;
    if (state.currentStep == 0 || sendingInProgress()) {
      onStepCancelHandler = null;
    } else {
      onStepCancelHandler = () {
        context.read<InitialSetupBloc>().add(GoBack(null));
      };
    }

    void Function()? onStepContinue;

    if (state.currentStep == 0) {
      onStepContinue = () {
        var valid = _accountFormKey.currentState?.validate() ?? false;
        if (valid) {
          _accountFormKey.currentState?.save();
          context.read<InitialSetupBloc>().add(SetAccountStep(email?.trim() ?? ""));
        }
      };
    } else if (state.currentStep == 1) {
      onStepContinue = () {
        var valid = _profileFormKey.currentState?.validate() ?? false;
        if (valid) {
          _profileFormKey.currentState?.save();
          context.read<InitialSetupBloc>().add(SetProfileStep(name?.trim() ?? ""));
        }
      };
    } else if (state.currentStep == 2) {
      onStepContinue = () {
        final file = securitySelfie;
        if (file != null) {
          context.read<InitialSetupBloc>().add(SetSecuritySelfieStep(file));
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No image. Take one using the camera button."), behavior: SnackBarBehavior.floating)
          );
        }
      };
    } else if (state.currentStep == 3) {
      onStepContinue = () {
        final file = profileImage;
        if (file != null) {
          context.read<InitialSetupBloc>().add(SetProfileImageStep(file));
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No image. Select one using the select button."), behavior: SnackBarBehavior.floating)
          );
        }
      };
    } else {
      onStepContinue = null;
    }

    return Stepper(
      currentStep: state.currentStep,
      onStepCancel: onStepCancelHandler,
      onStepContinue: onStepContinue,
      onStepTapped: (i) {
        context.read<InitialSetupBloc>().add(GoBack(i));
      },
      controlsBuilder: (context, details) {
        var buttonContinue = ElevatedButton(
          onPressed: details.onStepContinue,
          child: const Text("CONTINUE"),
        );
        var buttonBack = MaterialButton(
          onPressed: details.onStepCancel,
          child: const Text("BACK"),
        );
        Widget buttons = Row(children: [buttonContinue, const Padding(padding: EdgeInsets.symmetric(horizontal: 10.0)), buttonBack]);
        return Padding(padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0), child: buttons);
      },
      steps: steps,
    );
  }

  List<Step> createSteps(InitialSetupData state) {
    final counter = Counter();

    //timeDilation = 10.0;
    return [
        createAccountStep(counter.next(), state),
        createProfileStep(counter.next(), state),
        createTakeSelfieStep(counter.next(), state),
        createSelectProfileImageStep(counter.next(), state),
        //createCompleteInitialSetup(counter.next(), state),
      ];
  }

  Step createAccountStep(int id, InitialSetupData state) {
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
        onSaved: (newValue) => email = newValue,
      ),

    );

    return Step(
      title: const Text("Account"),
      // subtitle: counter.onlyIfSelected(
      //   _currentStep,
      //   Text("Your first name will be visible on your profile. It is not possible to change this later.")
      // ),
      isActive: state.currentStep == id,
      content: Container(
        alignment: Alignment.centerLeft,
        child: accountForm,
      ),
    );
  }

  Step createProfileStep(int id, InitialSetupData state) {
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
        onSaved: (newValue) => name = newValue,
      ),
    );
    return Step(
      title: const Text("Profile"),
      // subtitle: counter.onlyIfSelected(
      //   _currentStep,
      //   Text("Your first name will be visible on your profile. It is not possible to change this later.")
      // ),
      isActive: state.currentStep == id,
      content: Container(
        alignment: Alignment.centerLeft,
        child: profileForm,
      )
    );
  }

  Step createTakeSelfieStep(int id, InitialSetupData state) {
    Widget cameraButton = ElevatedButton.icon(label: Text("Camera"), icon: Icon(Icons.camera_alt), onPressed: () async {
      final image = await Navigator.push<XFile?>(
          context,
          MaterialPageRoute<XFile?>(builder: (_) {
            CameraPage camera = CameraPage(ImageType.securitySelfie);
            return camera;
          }),
      );
      setState(() {
        // Update to display current image
        securitySelfie = image;
      });
    });

    List<Widget> selfieImageWidgets = [cameraButton];
    final image = securitySelfie;
    if (image != null) {
      selfieImageWidgets = [Padding(
        padding: const EdgeInsets.all(20.0),
        child: Image.file(File(image.path), height: 200),
      ), cameraButton];
    }

    return Step(
      title: const Text("Take security selfie"),
      // subtitle: counter.onlyIfSelected(
      //   _currentStep,
      //   Text("Your first name will be visible on your profile. It is not possible to change this later.")
      // ),
      isActive: state.currentStep == id,
      content: Column(
        children: [
          const Text("Take image in which your face is clearly visible."),
          Row(children: [
            const Icon(Icons.person, size: 150.0, color: Colors.black45),
            Column(
              children: selfieImageWidgets
            ),
          ]),
        ],
      )
    );
  }

  Step createSelectProfileImageStep(int id, InitialSetupData state) {
    // TODO: Move LostDataResponse to somewhere else?

    Widget image = FutureBuilder<LostDataResponse>(
      future: ImagePicker().retrieveLostData(),
      builder: (BuildContext context, AsyncSnapshot<LostDataResponse> lostData) {
        Widget selectImageButton = ElevatedButton.icon(
          label: Text("Select image"),
          icon: Icon(Icons.image),
          onPressed: () async {
            final image  = await ImagePicker().pickImage(source: ImageSource.gallery);
            if (image != null) {
              print(image.path);
              setState(() {
                profileImage = image;
              });
            }
          }
        );
        List<Widget> imageWidgets = [selectImageButton];
        final XFile? image = profileImage;

        // Restore lost image
        var lostImageSelection = lostData.data?.file;
        if (profileImage == null && lostImageSelection != null) {
          setState(() {
            profileImage = lostImageSelection;
          });
        }

        if (image != null) {
          imageWidgets = [Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.file(File(image.path), height: 200,),
          ), selectImageButton];
        }
        return Column(
          children: imageWidgets
        );
      }
    );

    return Step(
      title: const Text("Select proifle image"),
      // subtitle: counter.onlyIfSelected(
      //   _currentStep,
      //   Text("Your first name will be visible on your profile. It is not possible to change this later.")
      // ),
      isActive: state.currentStep == id,
      content: Column(children: [
        const Text("Select profile image"),
        image,
      ]),
    );
  }

  // Step createCompleteInitialSetup(int id, InitialSetupData state) {
  //   Widget progress;
  //     if (state.sendError != null) {
  //       String error = state.sendError ?? "";
  //       progress = Column(children: [
  //         Text(error),
  //       ]);
  //     } else {
  //       progress = Column(children: const [
  //         Text("Sending the above information to server..."),
  //         CircularProgressIndicator(),
  //       ]);
  //     }

  //   return Step(
  //     title: const Text("Almost ready"),
  //     // subtitle: counter.onlyIfSelected(
  //     //   _currentStep,
  //     //   Text("Your first name will be visible on your profile. It is not possible to change this later.")
  //     // ),
  //     isActive: state.currentStep == id,
  //     content: progress,
  //   );
  // }
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
