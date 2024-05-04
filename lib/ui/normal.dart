import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/image_cache.dart";
import "package:pihka_frontend/data/notification_manager.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/account.dart";
import "package:pihka_frontend/logic/app/bottom_navigation_state.dart";
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
import "package:pihka_frontend/ui/utils/notification_payload_handler.dart";
import "package:pihka_frontend/ui_utils/profile_thumbnail_image.dart";
import "package:pihka_frontend/ui_utils/root_screen.dart";

class NormalStateScreen extends RootScreen {
  const NormalStateScreen({Key? key}) : super(key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    return const NormalStateContent();
  }
}

BottomNavigationScreenId numberToScreen(int value) {
  switch (value) {
    case 0:
      return BottomNavigationScreenId.profiles;
    case 1:
      return BottomNavigationScreenId.likes;
    case 2:
      return BottomNavigationScreenId.chats;
    case 3:
      return BottomNavigationScreenId.settings;
    default:
      throw ArgumentError("Unknown screen number");
  }
}

class NormalStateContent extends StatefulWidget {
  const NormalStateContent({Key? key}) : super(key: key);

  @override
  State<NormalStateContent> createState() => _NormalStateContentState();
}

class _NormalStateContentState extends State<NormalStateContent> {

  final profileViewKey = UniqueKey();
  final likeViewKey = UniqueKey();
  final chatViewKey = UniqueKey();
  final settingsViewKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    BottomNavigationStateBlocInstance.getInstance().bloc
      .add(ChangeScreen(BottomNavigationScreenId.profiles));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationStateBloc, BottomNavigationStateData>(
      builder: (context, state) {
        return buildScreen(context, state.screen.screenIndex);
      }
    );
  }

  Widget buildScreen(BuildContext context, int selectedView) {
    final views = [
      ProfileView(key: profileViewKey),
      LikeView(key: likeViewKey),
      ChatView(key: chatViewKey),
      SettingsView(key: settingsViewKey),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
          child: primaryImageButton(),
        ),
        title: Text(views[selectedView].title(context)),
        actions: views[selectedView].actions(context),
        notificationPredicate: (scrollNotification) {
          if (ScrollEventResender.acceptNext) {
            ScrollEventResender.acceptNext = false;
            return true;
          }

          if (scrollNotification.context?.findAncestorWidgetOfExactType<ProfileView>()?.key == profileViewKey) {
            ScrollEventResender.profileViewLastNotification = scrollNotification;
          } else if (scrollNotification.context?.findAncestorWidgetOfExactType<LikeView>()?.key == likeViewKey) {
            ScrollEventResender.likeViewLastNotification = scrollNotification;
          } else if (scrollNotification.context?.findAncestorWidgetOfExactType<ChatView>()?.key == chatViewKey) {
            ScrollEventResender.chatViewLastNotification = scrollNotification;
          } else if (scrollNotification.context?.findAncestorWidgetOfExactType<SettingsView>()?.key == settingsViewKey) {
            ScrollEventResender.settingsViewLastNotification = scrollNotification;
          }

          switch (numberToScreen(selectedView)) {
            case BottomNavigationScreenId.profiles:
              return scrollNotification.context?.findAncestorWidgetOfExactType<ProfileView>()?.key == profileViewKey;
            case BottomNavigationScreenId.likes:
              return scrollNotification.context?.findAncestorWidgetOfExactType<LikeView>()?.key == likeViewKey;
            case BottomNavigationScreenId.chats:
              return scrollNotification.context?.findAncestorWidgetOfExactType<ChatView>()?.key == chatViewKey;
            case BottomNavigationScreenId.settings:
              return scrollNotification.context?.findAncestorWidgetOfExactType<SettingsView>()?.key == settingsViewKey;
          }
        },
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
          const NotificationPayloadHandler(),
          const ScrollEventResender(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.people), label: views[0].title(context)),
          BottomNavigationBarItem(icon: const Icon(Icons.favorite), label: views[1].title(context)),
          BottomNavigationBarItem(icon: const Icon(Icons.message), label: views[2].title(context)),
          BottomNavigationBarItem(icon: const Icon(Icons.settings), label: views[3].title(context)),
        ],
        useLegacyColorScheme: false,
        currentIndex: selectedView,
        onTap: (value) {
          context.read<BottomNavigationStateBloc>().add(ChangeScreen(numberToScreen(value)));
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
                cacheSize: ImageCacheSize.sizeForAppBarThumbnail(),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => MyNavigator.push(context, const MaterialPage<void>(child: MyProfileScreen()))
                  ),
                )
              );
            } else {
              // TODO: It seems that some times info about current account's
              // profile image does not load after directly after login, so
              // implement placeholder image here. Also add reloading logic
              // to view profile screen.

              // TODO: Drag and drop colors in edit profile screen
              // TODO: "Image moderation status" screen progress icon color

              // TODO: My profile screen image is not centered
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

/// Make sure that AppBar has correct elevation
/// after switching between bottom navigation screens.
/// This is a workaround for bug:
/// https://github.com/flutter/flutter/issues/139393
class ScrollEventResender extends StatelessWidget {
  const ScrollEventResender({super.key});

  static ScrollNotification? profileViewLastNotification;
  static ScrollNotification? likeViewLastNotification;
  static ScrollNotification? chatViewLastNotification;
  static ScrollNotification? settingsViewLastNotification;
  static bool acceptNext = false;

  @override
  Widget build(BuildContext context) {
    profileViewLastNotification ??= resetScrollEvent(context);
    likeViewLastNotification ??= resetScrollEvent(context);
    chatViewLastNotification ??= resetScrollEvent(context);
    settingsViewLastNotification ??= resetScrollEvent(context);

    return BlocBuilder<BottomNavigationStateBloc, BottomNavigationStateData>(
      builder: (_, state) {
        Future.delayed(Duration.zero, () {
          if (!context.mounted) {
            return;
          }

          acceptNext = true;
          switch (numberToScreen(state.screen.screenIndex)) {
            case BottomNavigationScreenId.profiles:
              profileViewLastNotification?.dispatch(context);
            case BottomNavigationScreenId.likes:
              likeViewLastNotification?.dispatch(context);
            case BottomNavigationScreenId.chats:
              chatViewLastNotification?.dispatch(context);
            case BottomNavigationScreenId.settings:
              settingsViewLastNotification?.dispatch(context);
          }
        });

        return const SizedBox.shrink();
      }
    );
  }

  ScrollNotification resetScrollEvent(BuildContext context) {
    return ScrollUpdateNotification(
      metrics: NoScrollMetrics(),
      context: context
    );
  }
}

class NoScrollMetrics with ScrollMetrics {
  @override
  AxisDirection get axisDirection => AxisDirection.down;

  @override
  double get devicePixelRatio => 1.0;

  @override
  bool get hasContentDimensions => true;

  @override
  bool get hasPixels => true;

  @override
  bool get hasViewportDimension => true;

  @override
  double get maxScrollExtent => 100.0;

  @override
  double get minScrollExtent => 100.0;

  @override
  double get pixels => 100.0;

  @override
  double get viewportDimension => 100.0;
}
