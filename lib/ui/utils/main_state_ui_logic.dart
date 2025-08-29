import 'package:app/data/general/notification/utils/notification_payload.dart';
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

final _log = Logger("MainStateUiLogic");

class MainStateUiLogic extends StatefulWidget {
  const MainStateUiLogic({super.key});

  @override
  State<MainStateUiLogic> createState() => _MainStateUiLogicState();
}

class _MainStateUiLogicState extends State<MainStateUiLogic> {
  UniqueKey navigationKey = UniqueKey();
  MainState? previousState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainStateBloc, MainState>(
      builder: (context, state) {
        // Generate new key only when needed
        if (previousState != state) {
          previousState = state;
          navigationKey = UniqueKey();
        }

        final screen = switch (state) {
          MsSplashScreen() => const SplashScreen(),
          MsLoginRequired() => const LoginScreen(),
          MsDemoAccount() => const DemoAccountScreen(),
          MsLoggedIn() => switch (state.screen) {
            LoggedInScreen.initialSetup => const InitialSetupScreen(),
            LoggedInScreen.normal => const NormalStateScreen(),
            LoggedInScreen.accountBanned => const AccountBannedScreen(),
            LoggedInScreen.pendingRemoval => const PendingDeletionPage(),
            LoggedInScreen.unsupportedClientVersion => const UnsupportedClientScreen(),
          },
        };

        var appLaunchPayloadNullable = NotificationManager.getInstance()
            .getAndRemoveAppLaunchNotificationPayload();
        if (screen is! NormalStateScreen) {
          appLaunchPayloadNullable = null;
        }
        final appLaunchPayload = appLaunchPayloadNullable;
        final accountBackgroundDb =
            LoginRepository.getInstance().repositoriesOrNull?.accountBackgroundDb;
        final accountDb = LoginRepository.getInstance().repositoriesOrNull?.accountDb;

        final NotificationActionHandlerObjects? notficationRelatedObjects;
        final NewPageDetails rootPage;
        if (appLaunchPayload != null && accountBackgroundDb != null && accountDb != null) {
          _log.info("Handling app launch notification payload");
          notficationRelatedObjects = NotificationActionHandlerObjects(
            appLaunchPayload,
            accountDb,
            accountBackgroundDb,
            NewPageDetails(MaterialPage<void>(child: screen)),
          );
          rootPage = NewPageDetails(const MaterialPage<void>(child: SplashScreen()));
        } else {
          notficationRelatedObjects = null;
          rootPage = NewPageDetails(MaterialPage<void>(child: screen));
        }

        final NavigatorStateData blocInitialState = ReplaceAllWith([
          rootPage,
        ], false).toInitialState();
        final navigator = AppNavigator();

        final blocProvider = switch (state) {
          MsLoginRequired() => _blocLoginRequired(navigator),
          MsDemoAccount() => _blocDemoAccount(navigator),
          MsLoggedIn() => switch (state.screen) {
            LoggedInScreen.initialSetup => _blocInitialSetup(navigator),
            LoggedInScreen.normal => _blocNormal(
              NotificationActionHandler(
                notificationNavigation: notficationRelatedObjects,
                child: navigator,
              ),
            ),
            LoggedInScreen.accountBanned => _blocAccountBanned(navigator),
            LoggedInScreen.pendingRemoval => _blocPendingRemoval(navigator),
            LoggedInScreen.unsupportedClientVersion => navigator,
          },
          MsSplashScreen() => navigator,
        };

        final loggedInStateRelatedBlocs = switch (state) {
          MsSplashScreen() || MsLoginRequired() || MsDemoAccount() => blocProvider,
          MsLoggedIn() => MultiBlocProvider(
            providers: [
              // Logout action
              BlocProvider(create: (_) => LoginBloc()),
            ],
            child: blocProvider,
          ),
        };

        return MultiBlocProvider(
          // Create new Blocs when MainState changes
          key: navigationKey,
          providers: [
            // Navigation
            BlocProvider(create: (_) => NavigatorStateBloc(blocInitialState)),
            BlocProvider(create: (_) => BottomNavigationStateBloc()),
          ],
          child: NavigationBlocUpdater(child: loggedInStateRelatedBlocs),
        );
      },
    );
  }

  Widget _blocLoginRequired(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ServerAddressBloc()),
        BlocProvider(create: (_) => SignInWithBloc()),
        BlocProvider(create: (_) => DemoAccountLoginBloc()),
      ],
      child: child,
    );
  }

  Widget _blocDemoAccount(Widget child) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => DemoAccountBloc())],
      child: child,
    );
  }

  Widget _blocInitialSetup(Widget child) {
    return MultiBlocProvider(
      providers: [
        // Init AccountBloc so that the initial setup UI does not change from
        // text field to only text when sign in with login is used.
        BlocProvider(create: (_) => AccountBloc(), lazy: false),
        BlocProvider(create: (_) => InitialSetupBloc()),
        BlocProvider(create: (_) => SecuritySelfieImageProcessingBloc()),
        BlocProvider(create: (_) => ProfilePicturesImageProcessingBloc()),
        BlocProvider(create: (_) => ProfileAttributesBloc()),
        BlocProvider(create: (_) => ContentBloc()),
        BlocProvider(create: (_) => SelectContentBloc()),
        BlocProvider(create: (_) => ProfilePicturesBloc()),
        // Disable lazy init for ClientFeaturesConfigBloc so that
        // location selection does not use the default map settings.
        // Also profile name text field requires the bloc.
        BlocProvider(create: (_) => ClientFeaturesConfigBloc(), lazy: false),
      ],
      child: child,
    );
  }

  Widget _blocNormal(Widget child) {
    return MultiBlocProvider(
      providers: [
        // Initial setup (MainState.initialSetupSkipped requires this)
        BlocProvider(create: (_) => InitialSetupBloc()),

        // General
        BlocProvider(create: (_) => ProfilePicturesImageProcessingBloc()),
        BlocProvider(create: (_) => SecuritySelfieImageProcessingBloc()),
        BlocProvider(create: (_) => NotificationPermissionBloc()),
        BlocProvider(create: (_) => NotificationPayloadHandlerBloc()),
        BlocProvider(create: (_) => ProfileAttributesBloc()),
        BlocProvider(create: (_) => ConversationListBloc()),
        BlocProvider(create: (_) => UnreadConversationsCountBloc()),
        BlocProvider(create: (_) => NewReceivedLikesAvailableBloc()),
        BlocProvider(create: (_) => CustomReportsConfigBloc()),
        BlocProvider(create: (_) => ClientFeaturesConfigBloc()),
        BlocProvider(create: (_) => InfoDialogBloc()),

        // Account data
        BlocProvider(create: (_) => AccountBloc()),
        BlocProvider(create: (_) => ContentBloc()),
        BlocProvider(create: (_) => LocationBloc()),
        BlocProvider(create: (_) => MyProfileBloc()),
        BlocProvider(create: (_) => AccountDetailsBloc()),
        BlocProvider(create: (_) => ProfileFiltersBloc()),

        // Settings
        BlocProvider(create: (_) => EditMyProfileBloc()),
        BlocProvider(create: (_) => SelectContentBloc()),
        BlocProvider(create: (_) => NewModerationRequestBloc()),
        BlocProvider(create: (_) => ProfilePicturesBloc()),
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

  Widget _blocAccountBanned(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AccountDetailsBloc()),
        BlocProvider(create: (_) => DataExportBloc()),
      ],
      child: child,
    );
  }

  Widget _blocPendingRemoval(Widget child) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => DataExportBloc())],
      child: child,
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
