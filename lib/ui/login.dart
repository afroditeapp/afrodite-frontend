import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/account/account.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/logic/server/address.dart";
import "package:pihka_frontend/model/freezed/logic/account/account.dart";
import "package:pihka_frontend/ui_utils/root_screen.dart";



import 'package:pihka_frontend/localizations.dart';

const commonPadding = 5.0;

class LoginScreenOld extends RootScreen {
  LoginScreenOld({Key? key}) : super(key: key);

  final _serverAddressController = TextEditingController();
  final _serverAddressFormKey = GlobalKey<FormState>();

  @override
  Widget buildRootWidget(BuildContext context) {
    final loginPageWidgets = <Widget>[
      Text(context.strings.app_name),
      ServerAddressField(_serverAddressFormKey, _serverAddressController),
      ElevatedButton(
        child: const Text(
            "Update address"
        ),
        onPressed: () {
          final valid = _serverAddressFormKey.currentState?.validate();
          if (valid != null && valid) {
            _serverAddressFormKey.currentState?.save();
          }
        },
      ),
      changeAddressButton("***REMOVED***"),
      changeAddressButton("http://localhost:3000"),
      changeAddressButton("http://192.168.0.13:3000"),
      changeAddressButton("***REMOVED***"),
      ElevatedButton(
        child: Text(context.strings.login_screen_register_button),
        onPressed: () {
          context.read<AccountBloc>().add(DoRegister());
        },
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
      BlocBuilder<AccountBloc, AccountBlocData>(
        buildWhen: (previous, current) => previous.accountId != current.accountId,
        builder: (_, state) {
          return Text(
            "Account ID: ${state.accountId ?? "not set"}"
          );
        }
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
      ElevatedButton(
        child: Text(context.strings.login_screen_login_button),
        onPressed: () {
          context.read<InitialSetupBloc>().add(ResetState());
          context.read<AccountBloc>().add(DoLogin());
        }
      ),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: loginPageWidgets,
            ),
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
}

class ServerAddressField extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  const ServerAddressField(this.formKey, this.controller, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ServerAddressFieldState();
}

class _ServerAddressFieldState extends State<ServerAddressField> {
  late TextEditingController _serverAddressController;

  @override
  void initState() {
    super.initState();
    _serverAddressController = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    if (_serverAddressController.text.isEmpty) {
      _serverAddressController.text = context.read<ServerAddressBloc>().state;
    }

    final serverAddressFormWidget = Form(
      key: widget.formKey,
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            controller: _serverAddressController,
            decoration: const InputDecoration(
              icon: Icon(Icons.computer),
              hintText: "Server address",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Is empty";
              } else if (!(value.contains("***REMOVED***") || value.contains("192.168.") || value.contains("10.0.2.2") || value.contains("127.0.0.1") || value.contains("/localhost:") )) {
                return "Public IP addresses are not supported";
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
          _serverAddressController.text = state;
        });
      },
      child: serverAddressFormWidget,
    );

    return serverAddressForm;
  }
}
