import "package:app/localizations.dart";
import "package:app/ui_utils/app_bar/common_actions.dart";
import "package:app/ui_utils/app_bar/menu_actions.dart";
import "package:app/ui_utils/list.dart";
import "package:flutter/material.dart";

class UnsupportedClientScreen extends StatelessWidget {
  const UnsupportedClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.unsupported_client_screen_title),
        actions: [
          menuActions([
            commonActionLogout(context),
            commonActionOpenAboutDialog(context),
          ]),
        ],
      ),
      body: showInfo(context),
    );
  }

  Widget showInfo(BuildContext context) {
    return buildListReplacementMessage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(context.strings.unsupported_client_screen_info),
        ],
      )
    );
  }
}
