import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/notification_manager.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/account.dart";
import "package:pihka_frontend/logic/app/navigator_state.dart";

import "package:pihka_frontend/logic/app/notification_permission.dart";
import "package:pihka_frontend/logic/media/content.dart";
import "package:pihka_frontend/model/freezed/logic/account/account.dart";
import "package:pihka_frontend/model/freezed/logic/main/navigator_state.dart";
import "package:pihka_frontend/model/freezed/logic/media/content.dart";
import "package:pihka_frontend/ui/normal/chat.dart";
import "package:pihka_frontend/ui/normal/likes.dart";
import "package:pihka_frontend/ui/normal/profiles.dart";
import "package:pihka_frontend/ui/normal/settings.dart";
import "package:pihka_frontend/ui/normal/settings/my_profile.dart";
import "package:pihka_frontend/ui_utils/profile_thumbnail_image.dart";
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
        scrolledUnderElevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
          child: primaryImageButton(),
        ),
        title: Text(views[selectedView].title(context)),
        actions: views[selectedView].actions(context),
      ),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: selectedView,
              children: views,
            )
          ),
          const NotificationPermissionDialogOpener(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.people), label: views[0].title(context)),
          BottomNavigationBarItem(icon: const Icon(Icons.favorite), label: views[1].title(context)),
          BottomNavigationBarItem(icon: const Icon(Icons.message), label: views[2].title(context)),
          BottomNavigationBarItem(icon: const Icon(Icons.settings), label: views[3].title(context)),
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

  Widget primaryImageButton() {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, accountState) {
        final id = accountState.accountId;
        return BlocBuilder<ContentBloc, ContentData>(
          builder: (context, state) {
            final img = state.primaryProfilePicture;
            final cropInfo = state.primaryProfilePictureCropInfo;
            if (id != null && img != null) {
              return ProfileThumbnailImage(
                accountId: id,
                contentId: img,
                cropResults: cropInfo,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => MyNavigator.push(context, MaterialPage<void>(child: const MyProfileScreen()))
                  ),
                )
              );
            } else {
              return const SizedBox.shrink();
            }
          }
        );
      }
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

        return BlocBuilder<NotificationPermissionBloc, NotificationPermissionAsked>(
          builder: (context, state) {
            final storedPermissionAskedState = state.notificationPermissionAsked;
            if (storedPermissionAskedState == null) {
              return const SizedBox.shrink();
            }

            final notificationPermissionSupported = NotificationManager.getInstance().osSupportsNotificationPermission;
            if (notificationPermissionSupported && !storedPermissionAskedState && !askedOnce) {
              askedOnce = true;
              openNotificationPermissionDialog(context);
            }

            return const SizedBox.shrink();
          }
        );
      }
    );
  }

  void openNotificationPermissionDialog(BuildContext context) {
    final bloc = context.read<NotificationPermissionBloc>();
    final pageKey = PageKey();
    Future.delayed(Duration.zero, () => MyNavigator.showDialog<bool>(
      context: context,
      pageKey: pageKey,
      builder: (context) {
        return NotificationPermissionDialog(pageKey: pageKey);
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
  final PageKey pageKey;
  const NotificationPermissionDialog({required this.pageKey, super.key});

  @override
  Widget build(BuildContext context) {
    final dialogContent = Column(
      children: [
        const Icon(
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
            MyNavigator.removePage(context, pageKey, false);
          },
          child: Text(context.strings.generic_no),
        ),
        TextButton(
          onPressed: () {
            MyNavigator.removePage(context, pageKey, true);
          },
          child: Text(context.strings.generic_yes),
        ),
      ],
    );
  }
}
