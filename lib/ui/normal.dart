import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/notification_manager.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/account.dart";

import "package:pihka_frontend/logic/app/notification_permission.dart";
import "package:pihka_frontend/ui/normal/chat.dart";
import "package:pihka_frontend/ui/normal/likes.dart";
import "package:pihka_frontend/ui/normal/profiles.dart";
import "package:pihka_frontend/ui/normal/settings.dart";
import "package:pihka_frontend/ui_utils/root_screen.dart";

class NormalStateScreen extends RootScreen {
  const NormalStateScreen({Key? key}) : super(key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    return const NormalStateContent();
  }
}

class NormalStateContent extends StatefulWidget {
  const NormalStateContent({Key? key}) : super(key: key);

  @override
  State<NormalStateContent> createState() => _NormalStateContentState();
}

class _NormalStateContentState extends State<NormalStateContent> {
  int selectedView = 0;

  @override
  Widget build(BuildContext context) {
    const views = [
      ProfileView(),
      LikeView(),
      ChatView(),
      SettingsView(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(views[selectedView].title(context)),
        actions: views[selectedView].actions(context),
      ),
      body: Column(
        children: [
          Expanded(child: views[selectedView]),
          const NotificationPermissionDialogOpener(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.account_box), label: views[selectedView].title(context)),
          BottomNavigationBarItem(icon: const Icon(Icons.favorite), label: views[selectedView].title(context)),
          BottomNavigationBarItem(icon: const Icon(Icons.message), label: views[selectedView].title(context)),
          BottomNavigationBarItem(icon: const Icon(Icons.settings), label: views[selectedView].title(context)),
        ],
        selectedItemColor: Colors.lightBlue[900],
        unselectedItemColor: Colors.black54,
        currentIndex: selectedView,
        onTap: (value) {
          setState(() {
            selectedView = value;
          });
        },
      ),
    );
  }
}

class NotificationPermissionDialogOpener extends StatefulWidget {
  const NotificationPermissionDialogOpener({super.key});

  @override
  State<NotificationPermissionDialogOpener> createState() => _NotificationPermissionDialogOpenerState();
}

class _NotificationPermissionDialogOpenerState extends State<NotificationPermissionDialogOpener> {
  bool askedOnce = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        if (state.accountState != AccountState.normal) {
          return const SizedBox.shrink();
        }

        final storedPermissionAskedState = context.read<NotificationPermissionBloc>().state.notificationPermissionAsked;
        final notificationPermissionSupported = NotificationManager.getInstance().osSupportsNotificationPermission;
        if (notificationPermissionSupported && !storedPermissionAskedState && !askedOnce) {
          askedOnce = true;
          openNotificationPermissionDialog(context);
        }

        return const SizedBox.shrink();
      }
    );
  }

  void openNotificationPermissionDialog(BuildContext context) {
    final bloc = context.read<NotificationPermissionBloc>();
    Future.delayed(Duration.zero, () => showDialog<bool>(
      context: context,
      builder: (context) {
        return const NotificationPermissionDialog();
      },
    ).then((value) {
      if (value == true) {
        bloc.add(AcceptPermissions());
      } else {
        bloc.add(DenyPermissions());
      }
    }));
  }
}

class NotificationPermissionDialog extends StatelessWidget {
  const NotificationPermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final dialogContent = Column(
      children: [
        Icon(
          Icons.notifications_outlined,
          size: 48,
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        Text(
          context.strings.notification_permission_dialog_title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        Text(context.strings.notification_permission_dialog_description),
      ]
    );

    return AlertDialog(
      scrollable: true,
      content: dialogContent,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(context.strings.generic_no),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(context.strings.generic_yes),
        ),
      ],
    );
  }
}
