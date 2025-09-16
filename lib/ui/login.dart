import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/config.dart";
import "package:app/logic/server/address.dart";

import 'package:app/localizations.dart';

const commonPadding = 5.0;

class LoginPageOld extends MyScreenPageLimited<()> {
  LoginPageOld() : super(builder: (_) => LoginScreenOld());
}

class LoginScreenOld extends StatefulWidget {
  const LoginScreenOld({super.key});

  @override
  State<LoginScreenOld> createState() => _LoginScreenOldState();
}

class _LoginScreenOldState extends State<LoginScreenOld> {
  final _serverAddressController = TextEditingController();
  final _serverAddressFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginPageWidgets = <Widget>[
      Text(context.strings.app_name),
      ServerAddressField(_serverAddressFormKey, _serverAddressController),
      ElevatedButton(
        child: const Text("Update address"),
        onPressed: () {
          final valid = _serverAddressFormKey.currentState?.validate();
          if (valid != null && valid) {
            _serverAddressFormKey.currentState?.save();
          }
        },
      ),
      changeAddressButton("http://10.0.2.2:3000"),
      changeAddressButton("http://localhost:3000"),
      changeAddressButton("http://192.168.0.13:3000"),
      changeAddressButton(defaultServerUrl()),
      const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
      // const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
      // ElevatedButton(
      //   child: const Text(
      //       "Sign in with Google"
      //   ),
      //   onPressed: () {
      //     context.read<SignInWithBloc>().add(SignInWithGoogle());
      //   },
      // ),
      // const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
      // ElevatedButton(
      //   child: const Text(
      //       "Logout from Google"
      //   ),
      //   onPressed: () => context.read<SignInWithBloc>().add(LogOutFromGoogle()),
      // ),
      // const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
      // SignInWithAppleButton(
      //   onPressed: () {
      //     context.read<SignInWithBloc>().add(SignInWithAppleEvent());
      //   },
      // ),
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: loginPageWidgets),
          ),
        ),
      ),
    );
  }

  Widget changeAddressButton(String addressUrl) {
    return ElevatedButton(
      child: Text(addressUrl),
      onPressed: () {
        _serverAddressController.text = addressUrl;
        final valid = _serverAddressFormKey.currentState?.validate();
        if (valid != null && valid) {
          _serverAddressFormKey.currentState?.save();
        }
      },
    );
  }

  @override
  void dispose() {
    _serverAddressController.dispose();
    super.dispose();
  }
}

class ServerAddressField extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  const ServerAddressField(this.formKey, this.controller, {super.key});

  @override
  State<StatefulWidget> createState() => _ServerAddressFieldState();
}

class _ServerAddressFieldState extends State<ServerAddressField> {
  @override
  Widget build(BuildContext context) {
    if (widget.controller.text.isEmpty) {
      widget.controller.text = context.read<ServerAddressBloc>().state;
    }

    final serverAddressFormWidget = Form(
      key: widget.formKey,
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            controller: widget.controller,
            decoration: const InputDecoration(
              icon: Icon(Icons.computer),
              hintText: "Server address",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Is empty";
              } else {
                var uri = Uri.tryParse(value);
                if (uri == null || uri.port > 65535 || uri.port < 0) {
                  return "Invalid address";
                } else {
                  return null;
                }
              }
            },
            onSaved: (newValue) {
              if (newValue != null) {
                context.read<ServerAddressBloc>().add(ChangeCachedServerAddress(newValue));
              }
            },
          ),
        ),
      ),
    );

    final serverAddressForm = BlocListener<ServerAddressBloc, String>(
      listener: (context, state) {
        setState(() {
          widget.controller.text = state;
        });
      },
      child: serverAddressFormWidget,
    );

    return serverAddressForm;
  }
}
