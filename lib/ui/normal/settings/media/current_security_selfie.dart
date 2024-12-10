

import 'package:app/data/login_repository.dart';
import 'package:app/ui_utils/api.dart';
import 'package:app/ui_utils/moderation.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/media/content.dart';
import 'package:app/model/freezed/logic/media/content.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/view_image_screen.dart';

class CurrentSecuritySelfie extends StatefulWidget {
  const CurrentSecuritySelfie({
    Key? key,
  }) : super(key: key);

  @override
  State<CurrentSecuritySelfie> createState() => _CurrentSecuritySelfieState();
}

class _CurrentSecuritySelfieState extends State<CurrentSecuritySelfie> {

  final currentUser = LoginRepository.getInstance().repositories.accountId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.current_security_selfie_screen_title),
      ),
      body: BlocBuilder<ContentBloc, ContentData>(
        builder: (context, contentState) {
          return content(context, contentState);
        }
      ),
    );
  }

  Widget content(BuildContext context, ContentData data) {
    final securitySelfie = data.securityContent;
    String infoText = "";
    infoText = addModerationStateRow(context, infoText, securitySelfie?.state.toUiString(context));
    infoText = addRejectedCategoryRow(context, infoText, securitySelfie?.rejectedCategory?.value);
    infoText = addRejectedDeteailsRow(context, infoText, securitySelfie?.rejectedDetails?.value);
    infoText = infoText.trim();

    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(top: 8)),
                if (securitySelfie == null) Text(context.strings.generic_empty),
                if (securitySelfie != null) securitySelfieWidget(currentUser, securitySelfie.id),
                const Padding(padding: EdgeInsets.only(top: 8)),
                if (infoText.isNotEmpty) hPad(Text(infoText)),
                const Padding(padding: EdgeInsets.only(top: 8)),
              ],
            ),
          ),
        ],
      ),
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
