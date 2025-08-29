import 'package:app/data/general/notification/utils/notification_payload.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/logic/account/client_features_config.dart';
import 'package:app/logic/account/custom_reports_config.dart';
import 'package:app/logic/account/demo_account.dart';
import 'package:app/logic/account/demo_account_login.dart';
import 'package:app/logic/app/info_dialog.dart';
import 'package:app/logic/app/like_grid_instance_manager.dart';
import 'package:app/logic/app/main_state_types.dart';
import 'package:app/logic/login.dart';
import 'package:app/logic/profile/automatic_profile_search_badge.dart';
import 'package:app/logic/server/address.dart';
import 'package:app/logic/server/maintenance.dart';
import 'package:app/logic/settings/data_export.dart';
import 'package:app/logic/sign_in_with.dart';
import 'package:app/main.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/account/account_details.dart';
import 'package:app/logic/account/initial_setup.dart';
import 'package:app/logic/account/news/news_count.dart';
import 'package:app/logic/app/bottom_navigation_state.dart';
import 'package:app/logic/app/main_state.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/app/notification_payload_handler.dart';
import 'package:app/logic/app/notification_permission.dart';
import 'package:app/logic/app/notification_settings.dart';
import 'package:app/logic/chat/conversation_list_bloc.dart';
import 'package:app/logic/chat/new_received_likes_available_bloc.dart';
import 'package:app/logic/chat/unread_conversations_bloc.dart';
import 'package:app/logic/media/content.dart';
import 'package:app/logic/media/image_processing.dart';
import 'package:app/logic/media/new_moderation_request.dart';
import 'package:app/logic/media/profile_pictures.dart';
import 'package:app/logic/media/select_content.dart';
import 'package:app/logic/profile/attributes.dart';
import 'package:app/logic/profile/edit_my_profile.dart';
import 'package:app/logic/profile/location.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/logic/profile/profile_filters.dart';
import 'package:app/logic/settings/blocked_profiles.dart';
import 'package:app/logic/settings/privacy_settings.dart';
import 'package:app/logic/settings/search_settings.dart';
import 'package:app/logic/settings/ui_settings.dart';
import 'package:app/ui/account_banned.dart';
import 'package:app/ui/demo_account.dart';
import 'package:app/ui/initial_setup.dart';
import 'package:app/ui/login_new.dart';
import 'package:app/ui/normal.dart';
import 'package:app/ui/pending_deletion.dart';
import 'package:app/ui/unsupported_client.dart';
import 'package:app/ui/utils/notification_payload_handler.dart';
import 'package:provider/provider.dart';

final _log = Logger("MainStateUiLogic");

class MainStateUiLogic extends StatelessWidget {
  const MainStateUiLogic({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainStateBloc, MainState>(
      builder: (context, state) {
        if (state is! MsSplashScreen &&
            !(state is MsLoggedIn && state.screen == LoggedInScreen.normal)) {
          // Clear app launch notification payload when app
          // does not start to main screen.
          NotificationManager.getInstance().getAndRemoveAppLaunchNotificationPayload();
        }

        return switch (state) {
          MsSplashScreen() => NavigatorSplashScreen(),
          MsLoginRequired() => NavigatorLoginScreen(),
          MsDemoAccount() => NavigatorDemoAccount(),
          MsLoggedIn() => switch (state.screen) {
            LoggedInScreen.initialSetup => NavigatorInitialSetup(r: state.repositories),
            LoggedInScreen.normal => NavigatorNormal(r: state.repositories),
            LoggedInScreen.accountBanned => NavigatorAccountBanned(r: state.repositories),
            LoggedInScreen.pendingRemoval => NavigatorPendingRemoval(r: state.repositories),
            LoggedInScreen.unsupportedClientVersion => NavigatorUnsupportedClient(
              r: state.repositories,
            ),
          },
        };
      },
    );
  }
}

abstract class BasicRootScreen extends StatelessWidget {
  const BasicRootScreen({super.key});

  Widget rootScreen();
  Widget blocProvider(Widget child);

  @override
  Widget build(BuildContext context) {
    final NavigatorStateData blocInitialState = NavigatorStateData.rootPage(
      NewPageDetails(MaterialPage<void>(child: rootScreen())),
    );
    return MultiBlocProvider(
      providers: [
        // Navigation
        BlocProvider(create: (_) => NavigatorStateBloc(blocInitialState)),
        BlocProvider(create: (_) => BottomNavigationStateBloc()),
      ],
      child: NavigationBlocUpdater(child: blocProvider(AppNavigator())),
    );
  }
}

class NavigatorSplashScreen extends BasicRootScreen {
  const NavigatorSplashScreen({super.key});

  @override
  Widget rootScreen() => SplashScreen();

  @override
  Widget blocProvider(Widget child) {
    return child;
  }
}

class NavigatorLoginScreen extends BasicRootScreen {
  const NavigatorLoginScreen({super.key});

  @override
  Widget rootScreen() => LoginScreen();

  @override
  Widget blocProvider(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ServerAddressBloc()),
        BlocProvider(create: (_) => SignInWithBloc()),
        BlocProvider(create: (_) => DemoAccountLoginBloc()),
      ],
      child: child,
    );
  }
}

class NavigatorDemoAccount extends BasicRootScreen {
  const NavigatorDemoAccount({super.key});

  @override
  Widget rootScreen() => DemoAccountScreen();

  @override
  Widget blocProvider(Widget child) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => DemoAccountBloc())],
      child: child,
    );
  }
}

abstract class LoggedInRootScreen extends StatelessWidget {
  final RepositoryInstances r;
  const LoggedInRootScreen({required this.r, super.key});

  Widget rootScreen();
  Widget blocProvider(Widget child);

  @override
  Widget build(BuildContext context) {
    final NavigatorStateData blocInitialState = NavigatorStateData.rootPage(
      NewPageDetails(MaterialPage<void>(child: rootScreen())),
    );
    return Provider<RepositoryInstances>(
      create: (_) => r,
      child: MultiBlocProvider(
        providers: [
          // Navigation
          BlocProvider(create: (_) => NavigatorStateBloc(blocInitialState)),
          BlocProvider(create: (_) => BottomNavigationStateBloc()),
        ],
        child: NavigationBlocUpdater(child: blocProvider(AppNavigator())),
      ),
    );
  }
}

class NavigatorInitialSetup extends LoggedInRootScreen {
  const NavigatorInitialSetup({required super.r, super.key});

  @override
  Widget rootScreen() => InitialSetupScreen();

  @override
  Widget blocProvider(Widget child) {
    return MultiBlocProvider(
      providers: [
        // Logout action
        BlocProvider(create: (_) => LoginBloc()),

        // Init AccountBloc so that the initial setup UI does not change from
        // text field to only text when sign in with login is used.
        BlocProvider(create: (_) => AccountBloc(r), lazy: false),
        BlocProvider(create: (_) => InitialSetupBloc(r)),
        BlocProvider(create: (_) => SecuritySelfieImageProcessingBloc(r)),
        BlocProvider(create: (_) => ProfilePicturesImageProcessingBloc(r)),
        BlocProvider(create: (_) => ProfileAttributesBloc(r)),
        BlocProvider(create: (_) => ContentBloc(r)),
        BlocProvider(create: (_) => SelectContentBloc(r)),
        BlocProvider(create: (_) => ProfilePicturesBloc(r)),
        // Disable lazy init for ClientFeaturesConfigBloc so that
        // location selection does not use the default map settings.
        // Also profile name text field requires the bloc.
        BlocProvider(create: (_) => ClientFeaturesConfigBloc(r), lazy: false),
      ],
      child: child,
    );
  }
}

class NavigatorAccountBanned extends LoggedInRootScreen {
  const NavigatorAccountBanned({required super.r, super.key});

  @override
  Widget rootScreen() => AccountBannedScreen();

  @override
  Widget blocProvider(Widget child) {
    return MultiBlocProvider(
      providers: [
        // Logout action
        BlocProvider(create: (_) => LoginBloc()),

        BlocProvider(create: (_) => AccountDetailsBloc()),
        BlocProvider(create: (_) => DataExportBloc()),
      ],
      child: child,
    );
  }
}

class NavigatorPendingRemoval extends LoggedInRootScreen {
  const NavigatorPendingRemoval({required super.r, super.key});

  @override
  Widget rootScreen() => PendingDeletionPage();

  @override
  Widget blocProvider(Widget child) {
    return MultiBlocProvider(
      providers: [
        // Logout action
        BlocProvider(create: (_) => LoginBloc()),

        BlocProvider(create: (_) => DataExportBloc()),
      ],
      child: child,
    );
  }
}

class NavigatorUnsupportedClient extends LoggedInRootScreen {
  const NavigatorUnsupportedClient({required super.r, super.key});

  @override
  Widget rootScreen() => UnsupportedClientScreen();

  @override
  Widget blocProvider(Widget child) {
    return child;
  }
}

class NavigatorNormal extends StatelessWidget {
  final RepositoryInstances r;
  const NavigatorNormal({required this.r, super.key});

  Widget rootScreen() => NormalStateScreen();

  Widget blocProvider(Widget child) {
    return MultiBlocProvider(
      providers: [
        // Logout action
        BlocProvider(create: (_) => LoginBloc()),

        // Initial setup (it is possible to access it if it is skipped)
        BlocProvider(create: (_) => InitialSetupBloc(r)),

        // General
        BlocProvider(create: (_) => ProfilePicturesImageProcessingBloc(r)),
        BlocProvider(create: (_) => SecuritySelfieImageProcessingBloc(r)),
        BlocProvider(create: (_) => NotificationPermissionBloc()),
        BlocProvider(create: (_) => NotificationPayloadHandlerBloc()),
        BlocProvider(create: (_) => ProfileAttributesBloc(r)),
        BlocProvider(create: (_) => ConversationListBloc()),
        BlocProvider(create: (_) => UnreadConversationsCountBloc()),
        BlocProvider(create: (_) => NewReceivedLikesAvailableBloc()),
        BlocProvider(create: (_) => CustomReportsConfigBloc()),
        BlocProvider(create: (_) => ClientFeaturesConfigBloc(r)),
        BlocProvider(create: (_) => InfoDialogBloc()),

        // Account data
        BlocProvider(create: (_) => AccountBloc(r)),
        BlocProvider(create: (_) => ContentBloc(r)),
        BlocProvider(create: (_) => LocationBloc()),
        BlocProvider(create: (_) => MyProfileBloc()),
        BlocProvider(create: (_) => AccountDetailsBloc()),
        BlocProvider(create: (_) => ProfileFiltersBloc()),

        // Settings
        BlocProvider(create: (_) => EditMyProfileBloc()),
        BlocProvider(create: (_) => SelectContentBloc(r)),
        BlocProvider(create: (_) => NewModerationRequestBloc()),
        BlocProvider(create: (_) => ProfilePicturesBloc(r)),
        BlocProvider(create: (_) => PrivacySettingsBloc()),
        BlocProvider(create: (_) => BlockedProfilesBloc()),
        BlocProvider(create: (_) => SearchSettingsBloc()),
        BlocProvider(create: (_) => NotificationSettingsBloc()),
        BlocProvider(create: (_) => UiSettingsBloc()),
        BlocProvider(create: (_) => DataExportBloc()),

        // News
        BlocProvider(create: (_) => NewsCountBloc()),

        // Server maintenance
        BlocProvider(create: (_) => ServerMaintenanceBloc()),

        // Likes
        BlocProvider(create: (_) => LikeGridInstanceManagerBloc()),

        // Automatic profile search
        BlocProvider(create: (_) => AutomaticProfileSearchBadgeBloc()),
      ],
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLaunchPayload = NotificationManager.getInstance()
        .getAndRemoveAppLaunchNotificationPayload();
    final accountBackgroundDb =
        LoginRepository.getInstance().repositoriesOrNull?.accountBackgroundDb;
    final accountDb = LoginRepository.getInstance().repositoriesOrNull?.accountDb;

    final NotificationActionHandlerObjects? notficationRelatedObjects;
    final NewPageDetails rootPage = NewPageDetails(MaterialPage<void>(child: rootScreen()));
    if (appLaunchPayload != null && accountBackgroundDb != null && accountDb != null) {
      _log.info("Handling app launch notification payload");
      notficationRelatedObjects = NotificationActionHandlerObjects(
        appLaunchPayload,
        accountDb,
        accountBackgroundDb,
        rootPage,
      );
    } else {
      notficationRelatedObjects = null;
    }

    final NavigatorStateData blocInitialState = NavigatorStateData.rootPage(rootPage);
    return Provider<RepositoryInstances>(
      create: (_) => r,
      child: MultiBlocProvider(
        providers: [
          // Navigation
          BlocProvider(create: (_) => NavigatorStateBloc(blocInitialState)),
          BlocProvider(create: (_) => BottomNavigationStateBloc()),
        ],
        child: NavigationBlocUpdater(
          child: blocProvider(
            NotificationActionHandler(
              notificationNavigation: notficationRelatedObjects,
              child: AppNavigator(),
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationBlocUpdater extends StatelessWidget {
  const NavigationBlocUpdater({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final navigatorStateBloc = context.read<NavigatorStateBloc>();
    NavigationStateBlocInstance.getInstance().setLatestBloc(navigatorStateBloc);
    final bottomNavigatorStateBloc = context.read<BottomNavigationStateBloc>();
    BottomNavigationStateBlocInstance.getInstance().setLatestBloc(bottomNavigatorStateBloc);

    return child;
  }
}

class NotificationActionHandlerObjects {
  final NotificationPayload payload;
  final AccountDatabaseManager accountDb;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final NewPageDetails rootPage;
  NotificationActionHandlerObjects(
    this.payload,
    this.accountDb,
    this.accountBackgroundDb,
    this.rootPage,
  );
}

class NotificationActionHandler extends StatefulWidget {
  const NotificationActionHandler({
    required this.notificationNavigation,
    required this.child,
    super.key,
  });
  final NotificationActionHandlerObjects? notificationNavigation;
  final Widget child;

  @override
  State<NotificationActionHandler> createState() => _NotificationActionHandlerState();
}

class _NotificationActionHandlerState extends State<NotificationActionHandler> {
  bool navigationDone = false;

  @override
  Widget build(BuildContext context) {
    final navigatorStateBloc = context.read<NavigatorStateBloc>();
    final bottomNavigatorStateBloc = context.read<BottomNavigationStateBloc>();
    final likeGridInstanceBloc = context.read<LikeGridInstanceManagerBloc>();

    final notificationNavigation = widget.notificationNavigation;
    if (notificationNavigation != null && !navigationDone) {
      createHandlePayloadCallback(
        context,
        notificationNavigation.accountBackgroundDb,
        notificationNavigation.accountDb,
        navigatorStateBloc,
        bottomNavigatorStateBloc,
        likeGridInstanceBloc,
        showError: false,
        navigateToAction: (bloc, page) {
          final pages = [notificationNavigation.rootPage];
          if (page != null) {
            pages.add(page);
          }
          bloc.replaceAllWith(pages, disableAnimation: true);
        },
      )(notificationNavigation.payload);
      navigationDone = true;
    }

    return widget.child;
  }
}

class AppNavigator extends StatelessWidget {
  AppNavigator({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorStateBloc, NavigatorStateData>(
      builder: (context, state) {
        return NavigatorPopHandler(
          onPopWithResult: (_) {
            navigatorKey.currentState?.maybePop();
          },
          child: createNavigator(context, state),
        );
      },
    );
  }

  Widget createNavigator(BuildContext context, NavigatorStateData state) {
    final TransitionDelegate<void> transitionDelegate = state.disableAnimation
        ? const ReplaceSplashScreenTransitionDelegate()
        : const DefaultTransitionDelegate();
    return Navigator(
      key: navigatorKey,
      transitionDelegate: transitionDelegate,
      pages: state.getPages(),
      onDidRemovePage: (page) {
        context.read<NavigatorStateBloc>().add(RemovePageUsingFlutterObject(page));
      },
    );
  }
}
