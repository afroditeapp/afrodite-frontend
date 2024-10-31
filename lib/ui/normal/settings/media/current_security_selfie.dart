

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/login.dart';
import 'package:app/logic/media/content.dart';
import 'package:app/model/freezed/logic/login.dart';
import 'package:app/model/freezed/logic/media/content.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/view_image_screen.dart';

// TODO(prod): Security selfie screen says "Error" when initial modreation
// is not done yet.

class CurrentSecuritySelfie extends StatefulWidget {
  const CurrentSecuritySelfie({
    Key? key,
  }) : super(key: key);

  @override
  State<CurrentSecuritySelfie> createState() => _CurrentSecuritySelfieState();
}

class _CurrentSecuritySelfieState extends State<CurrentSecuritySelfie> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.current_security_selfie_screen_title),
      ),
      body: BlocBuilder<LoginBloc, LoginBlocData>(
        builder: (context, lState) {
          final accountId = lState.accountId;
          if (accountId == null) {
            return Center(child: Text(context.strings.generic_error));
          }

          return BlocBuilder<ContentBloc, ContentData>(
            builder: (context, contentState) {
              final securitySelfie = contentState.currentOrPendingSecurityContent;
              if (securitySelfie == null) {
                return Center(child: Text(context.strings.generic_error));
              }

              return Column(
                children: [
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      securitySelfieWidget(accountId, securitySelfie),
                    ],
                  ),
                  const Spacer(flex: 3),
                ],
              );
            }
          );
        }
      )
    );
  }

  Widget securitySelfieWidget(AccountId accountId, ContentId securitySelfie) {
    return SizedBox(
      width: 150.0,
      height: 200.0,
      child: Material(
        child: InkWell(
          onTap: () =>
            MyNavigator.push(
              context,
              MaterialPage<void>(
                child: ViewImageScreen(ViewImageAccountContent(accountId, securitySelfie))
              )
            ),
          child: accountImgWidgetInk(accountId, securitySelfie),
        ),
      ),
    );
  }
}
