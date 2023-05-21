import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/account/account.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/logic/server/address.dart";
import "package:pihka_frontend/logic/sign_in_with.dart";
import "package:pihka_frontend/ui/login.dart";
import 'package:pihka_frontend/ui/normal.dart';
import "package:pihka_frontend/ui/utils/root_page.dart";

import 'package:openapi/api.dart' as client_api;
import "package:sign_in_with_apple/sign_in_with_apple.dart";

const commonPadding = 5.0;

class LoginPage extends RootPage {
  LoginPage({Key? key}) : super(MainState.loginRequired, key: key);

  final _serverAddressFormKey = GlobalKey<FormState>();


  @override
  Widget buildRootWidget(BuildContext context) {
    final serverAddressForm = Form(
      key: _serverAddressFormKey,
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            initialValue: context.read<ServerAddressBloc>().state,
            decoration: const InputDecoration(
              icon: Icon(Icons.computer),
              hintText: "Server address",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Is empty";
              } else if (value != null && !(value.contains("192.168.0") || value.contains("10.0.2.2") || value.contains("127.0.0.1") || value.contains("/localhost:") )) {
                return "Public IP addresses are not supported";
              } else {
                return null;
              }
            },
            onSaved: (newValue) {
              if (newValue != null) {
                context.read<ServerAddressBloc>().add(ChangeCachedServerAddress(newValue));
              }
              context.read<AccountBloc>().add(DoRegister(newValue));
            },
          ),
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              const Text(
                "Pihka"
              ),
              serverAddressForm,
              ElevatedButton(
                child: const Text(
                    "Register"
                ),
                onPressed: () {
                  final valid = _serverAddressFormKey.currentState?.validate();
                  if (valid != null && valid) {
                    _serverAddressFormKey.currentState?.save();
                  }
                },
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
              BlocBuilder<AccountBloc, AccountData>(
                buildWhen: (previous, current) => previous.accountId != current.accountId,
                builder: (_, state) {
                  return Text(
                    "Account ID: ${state.accountId ?? "not set"}"
                  );
                }
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
              ElevatedButton(
                child: const Text(
                    "Login"
                ),
                onPressed: () => context.read<AccountBloc>().add(DoLogin()),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
              BlocBuilder<AccountBloc, AccountData>(
                buildWhen: (previous, current) => previous.apiKey != current.apiKey,
                builder: (_, state) {
                  return Text(
                    "API key: ${state.apiKey ?? "not set"}"
                  );
                }
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
              ElevatedButton(
                child: const Text(
                    "Sign in with Google"
                ),
                onPressed: () => context.read<SignInWithBloc>().add(SignInWithGoogle()),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
              ElevatedButton(
                child: const Text(
                    "Logout from Google"
                ),
                onPressed: () => context.read<SignInWithBloc>().add(LogOutFromGoogle()),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
              SignInWithAppleButton(
                onPressed: () => context.read<SignInWithBloc>().add(SignInWithAppleEvent()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
