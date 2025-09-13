import "package:app/data/utils/repository_instances.dart";
import "package:app/logic/account/client_features_config.dart";
import "package:app/logic/profile/automatic_profile_search_badge.dart";
import "package:app/logic/server/maintenance.dart";
import "package:app/model/freezed/logic/account/client_features_config.dart";
import "package:app/model/freezed/logic/profile/automatic_profile_search_badge.dart";
import "package:app/ui/normal/menu.dart";
import "package:database/database.dart";
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/image_cache.dart";
import "package:app/data/notification_manager.dart";
import "package:app/localizations.dart";
import "package:app/logic/account/account.dart";
import "package:app/logic/account/news/news_count.dart";
import "package:app/logic/app/bottom_navigation_state.dart";
import "package:app/logic/app/navigator_state.dart";

import "package:app/logic/app/notification_permission.dart";
import "package:app/logic/chat/new_received_likes_available_bloc.dart";
import "package:app/logic/chat/unread_conversations_bloc.dart";
import "package:app/logic/media/content.dart";
import "package:app/logic/profile/attributes.dart";
import "package:app/logic/profile/my_profile.dart";
import "package:app/model/freezed/logic/account/account.dart";
import "package:app/model/freezed/logic/account/news/news_count.dart";
import "package:app/model/freezed/logic/chat/new_received_likes_available_bloc.dart";
import "package:app/model/freezed/logic/chat/unread_conversations_count_bloc.dart";
import "package:app/model/freezed/logic/main/bottom_navigation_state.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/model/freezed/logic/media/content.dart";
import "package:app/ui/normal/chat.dart";
import "package:app/ui/normal/likes.dart";
import "package:app/ui/normal/profiles.dart";
import "package:app/ui/normal/settings/my_profile.dart";
import "package:app/ui/utils/notification_payload_handler.dart";
import "package:app/ui_utils/profile_thumbnail_image.dart";

/// Main screen
class NormalStateScreen extends StatelessWidget {
  const NormalStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NormalStateInitializer();
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

class NormalStateInitializer extends StatefulWidget {
  const NormalStateInitializer({super.key});

  @override
  State<NormalStateInitializer> createState() => _NormalStateInitializerState();
}

class _NormalStateInitializerState extends State<NormalStateInitializer> {
  @override
  Widget build(BuildContext context) {
    return NormalStateContent(
      r: context.read<RepositoryInstances>(),
      // Init ProfileAttributesBloc here to avoid quick progress screen
      // displaying when opening view profile or view my profile screen.
      profileAttributesBloc: context.read<ProfileAttributesBloc>(),
      // Init MyProfileBloc here to avoid profile image fade in effect.
      myProfileBloc: context.read<MyProfileBloc>(),
    );
  }
}

class NormalStateContent extends StatefulWidget {
  final RepositoryInstances r;
  final ProfileAttributesBloc profileAttributesBloc;
  final MyProfileBloc myProfileBloc;
  const NormalStateContent({
    required this.r,
    required this.profileAttributesBloc,
    required this.myProfileBloc,
    super.key,
  });

  @override
  State<NormalStateContent> createState() => _NormalStateContentState();
}

class _NormalStateContentState extends State<NormalStateContent> {
  late final views = [ProfileView(), LikeView(), ChatView(widget.r), MenuView()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationStateBloc, BottomNavigationStateData>(
      builder: (context, state) {
        final isScrolled = switch (numberToScreen(state.screen.screenIndex)) {
          BottomNavigationScreenId.profiles => state.isScrolledProfile,
          BottomNavigationScreenId.likes => state.isScrolledLikes,
          BottomNavigationScreenId.chats => state.isScrolledChats,
          BottomNavigationScreenId.settings => state.isScrolledSettings,
        };

        return buildScreen(context, state.screen.screenIndex, isScrolled);
      },
    );
  }

  Widget buildScreen(BuildContext context, int selectedView, bool isScrolled) {
    return Scaffold(
      appBar: AppBar(
        // Make sure that AppBar has correct elevation
        // after switching between bottom navigation screens.
        // This is a workaround for bug:
        // https://github.com/flutter/flutter/issues/139393
        // 3.0 is the default scrolledUnderElevation for AppBar when Material 3
        // is enabled.
        elevation: isScrolled ? 3.0 : 0.0,
        scrolledUnderElevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
          child: primaryImageButton(),
        ),
        title: Text(views[selectedView].title(context)),
        actions: views[selectedView].actions(context),
        notificationPredicate: (scrollNotification) => false,
      ),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(index: selectedView, children: views),
          ),
          const NotificationPermissionDialogOpener(),
          const NotificationPayloadHandler(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomNavigationBarContent(selectedView),
        useLegacyColorScheme: false,
        currentIndex: selectedView,
        onTap: (value) {
          final bloc = context.read<BottomNavigationStateBloc>();
          bloc.add(ChangeScreen(numberToScreen(value)));
          if (value == selectedView) {
            // Jump to beginning of currently visible list
            // only if it is already visible.
            bloc.add(SetIsTappedAgainValue(numberToScreen(value), true));
          }
        },
      ),
      floatingActionButton: views[selectedView].floatingActionButton(context),
    );
  }

  List<BottomNavigationBarItem> bottomNavigationBarContent(int selectedView) {
    return [
      BottomNavigationBarItem(
        icon: Icon(selectedView == 0 ? Icons.people : Icons.people_outline),
        label: views[0].title(context),
      ),
      BottomNavigationBarItem(
        icon: BlocBuilder<NewReceivedLikesAvailableBloc, NewReceivedLikesAvailableData>(
          builder: (context, state) {
            final icon = Icon(selectedView == 1 ? Icons.waving_hand : Icons.waving_hand_outlined);
            final count = state.newReceivedLikesCount;
            if (count == 0) {
              return icon;
            } else {
              return Badge.count(count: count, child: icon);
            }
          },
        ),
        label: views[1].title(context),
      ),
      BottomNavigationBarItem(
        icon: BlocBuilder<UnreadConversationsCountBloc, UnreadConversationsCountData>(
          builder: (context, state) {
            final icon = Icon(selectedView == 2 ? Icons.chat : Icons.chat_outlined);
            if (state.unreadConversations == 0) {
              return icon;
            } else {
              return Badge.count(count: state.unreadConversations, child: icon);
            }
          },
        ),
        label: views[2].title(context),
      ),
      BottomNavigationBarItem(
        icon: BlocBuilder<ClientFeaturesConfigBloc, ClientFeaturesConfigData>(
          builder: (context, clientFeatures) {
            return BlocBuilder<ServerMaintenanceBloc, ServerMaintenanceInfo>(
              builder: (context, serverMaintenanceInfo) {
                return BlocBuilder<NewsCountBloc, NewsCountData>(
                  builder: (context, newsState) {
                    return BlocBuilder<
                      AutomaticProfileSearchBadgeBloc,
                      AutomaticProfileSearchBadgeData
                    >(
                      builder: (context, searchState) {
                        final icon = Icon(selectedView == 3 ? Icons.menu : Icons.menu_outlined);
                        final count =
                            serverMaintenanceInfo.uiBadgeCount() +
                            newsState.newsCountForUi(clientFeatures.config) +
                            searchState.profileCount();
                        if (count == 0) {
                          return icon;
                        } else {
                          return Badge.count(count: count, child: icon);
                        }
                      },
                    );
                  },
                );
              },
            );
          },
        ),
        label: views[3].title(context),
      ),
    ];
  }

  Widget primaryImageButton() {
    return BlocBuilder<ContentBloc, ContentData>(
      builder: (context, state) {
        final img = state.primaryProfilePicture;
        final cropInfo = state.primaryProfilePictureCropInfo;
        if (state.isLoadingPrimaryContent) {
          return SizedBox.shrink();
        } else if (img != null) {
          const double IMG_HEIGHT = 40;
          final r = context.read<RepositoryInstances>();
          return ProfileThumbnailImage(
            media: r.media,
            accountId: r.accountId,
            contentId: img,
            cropArea: cropInfo,
            width: IMG_HEIGHT,
            height: IMG_HEIGHT,
            cacheSize: ImageCacheSize.squareImageForAppBarThumbnail(context, IMG_HEIGHT),
            child: Material(
              color: Colors.transparent,
              child: InkWell(onTap: () => openMyProfileScreen(context)),
            ),
          );
        } else {
          return primaryImageButtonError();
        }
      },
    );
  }

  Widget primaryImageButtonError() {
    return IconButton(
      icon: const Icon(Icons.warning_rounded),
      onPressed: () => openMyProfileScreen(context),
    );
  }
}

class NotificationPermissionDialogOpener extends StatefulWidget {
  const NotificationPermissionDialogOpener({super.key});

  @override
  State<NotificationPermissionDialogOpener> createState() =>
      _NotificationPermissionDialogOpenerState();
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

            final notificationPermissionSupported =
                NotificationManager.getInstance().osSupportsNotificationPermission;
            if (notificationPermissionSupported && !storedPermissionAskedState && !askedOnce) {
              askedOnce = true;
              openNotificationPermissionDialog(context);
            }

            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  void openNotificationPermissionDialog(BuildContext context) {
    final bloc = context.read<NotificationPermissionBloc>();
    final pageKey = PageKey();
    Future.delayed(Duration.zero, () {
      if (!context.mounted) {
        return;
      }
      MyNavigator.showDialog<bool>(
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
      });
    });
  }
}

class NotificationPermissionDialog extends StatelessWidget {
  final PageKey pageKey;
  const NotificationPermissionDialog({required this.pageKey, super.key});

  @override
  Widget build(BuildContext context) {
    final dialogContent = Column(
      children: [
        const Icon(Icons.notifications_outlined, size: 48),
        const Padding(padding: EdgeInsets.all(8.0)),
        Text(
          context.strings.notification_permission_dialog_title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        Text(context.strings.notification_permission_dialog_description),
      ],
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
