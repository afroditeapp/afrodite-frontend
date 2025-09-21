import 'dart:async';

import 'package:app/data/utils/repository_instances.dart';
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
import 'package:app/model/freezed/logic/main/bottom_navigation_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/splash_screen.dart';
import 'package:app/ui/utils/url_navigation.dart';
import 'package:app/ui/utils/web_navigation/web_navigation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:app/logic/chat/new_received_likes_available_bloc.dart';
import 'package:app/logic/chat/unread_conversations_bloc.dart';
import 'package:app/logic/media/content.dart';
import 'package:app/logic/media/image_processing.dart';
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
import 'package:provider/provider.dart';

class MainStateUiLogic extends StatelessWidget {
  const MainStateUiLogic({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainStateBloc, MainState>(
      builder: (context, state) {
        return switch (state) {
          MsSplashScreen() => SplashScreen(),
          MsLoginRequired() => NavigatorLoginScreen(),
          MsDemoAccount() => NavigatorDemoAccount(),
          MsLoggedInBasicScreen() => switch (state.screen) {
            LoggedInBasicScreen.initialSetup => NavigatorInitialSetup(r: state.repositories),
            LoggedInBasicScreen.accountBanned => NavigatorAccountBanned(r: state.repositories),
            LoggedInBasicScreen.pendingRemoval => NavigatorPendingRemoval(r: state.repositories),
            LoggedInBasicScreen.unsupportedClientVersion => NavigatorUnsupportedClient(
              r: state.repositories,
            ),
          },
          MsLoggedInMainScreen() => NavigatorNormal(
            r: state.repositories,
            notification: state.notification,
          ),
        };
      },
    );
  }
}

abstract class BasicRootScreen extends StatelessWidget {
  const BasicRootScreen({super.key});

  MyScreenPage<Object> rootScreen();
  Widget blocProvider(Widget child);

  @override
  Widget build(BuildContext context) {
    final NavigatorStateData blocInitialState = NavigatorStateData.rootPage(rootScreen());
    return MultiBlocProvider(
      providers: [
        // Navigation
        BlocProvider(create: (_) => NavigatorStateBloc(blocInitialState)),
        BlocProvider(create: (_) => BottomNavigationStateBloc(BottomNavigationStateData())),
      ],
      child: blocProvider(AppNavigatorAndUpdateNavigationBlocs()),
    );
  }
}

class NavigatorLoginScreen extends BasicRootScreen {
  const NavigatorLoginScreen({super.key});

  @override
  MyScreenPage<Object> rootScreen() => LoginPage();

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
  MyScreenPage<Object> rootScreen() => DemoAccountPage();

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
  final AppLaunchNotification? notification;
  const LoggedInRootScreen({required this.r, this.notification, super.key});

  MyScreenPage<Object> rootScreen();
  Widget blocProvider(Widget child);

  @override
  Widget build(BuildContext context) {
    final NavigatorStateData navigatorInitialState =
        notification?.navigatorState ?? NavigatorStateData.rootPage(rootScreen());
    final bottomNavigationInitialState =
        notification?.bottomNavigationState ?? BottomNavigationStateData();
    return Provider<RepositoryInstances>(
      create: (_) => r,
      child: MultiBlocProvider(
        providers: [
          // Navigation
          BlocProvider(create: (_) => NavigatorStateBloc(navigatorInitialState)),
          BlocProvider(create: (_) => BottomNavigationStateBloc(bottomNavigationInitialState)),
        ],
        child: blocProvider(AppNavigatorAndUpdateNavigationBlocs(r: r)),
      ),
    );
  }
}

class NavigatorInitialSetup extends LoggedInRootScreen {
  const NavigatorInitialSetup({required super.r, super.key});

  @override
  MyScreenPage<Object> rootScreen() => InitialSetupPage();

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
  MyScreenPage<Object> rootScreen() => AccountBannedPage(r);

  @override
  Widget blocProvider(Widget child) {
    return MultiBlocProvider(
      providers: [
        // Logout action
        BlocProvider(create: (_) => LoginBloc()),

        BlocProvider(create: (_) => AccountDetailsBloc(r)),
        BlocProvider(create: (_) => DataExportBloc(r)),
      ],
      child: child,
    );
  }
}

class NavigatorPendingRemoval extends LoggedInRootScreen {
  const NavigatorPendingRemoval({required super.r, super.key});

  @override
  MyScreenPage<Object> rootScreen() => PendingDeletionPage(r);

  @override
  Widget blocProvider(Widget child) {
    return MultiBlocProvider(
      providers: [
        // Logout action
        BlocProvider(create: (_) => LoginBloc()),

        BlocProvider(create: (_) => DataExportBloc(r)),
      ],
      child: child,
    );
  }
}

class NavigatorUnsupportedClient extends LoggedInRootScreen {
  const NavigatorUnsupportedClient({required super.r, super.key});

  @override
  MyScreenPage<Object> rootScreen() => UnsupportedClientPage();

  @override
  Widget blocProvider(Widget child) {
    return child;
  }
}

class NavigatorNormal extends LoggedInRootScreen {
  const NavigatorNormal({required super.r, required super.notification, super.key});

  @override
  MyScreenPage<Object> rootScreen() => NormalStatePage();

  @override
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
        BlocProvider(create: (_) => NotificationPermissionBloc(r)),
        BlocProvider(create: (_) => NotificationPayloadHandlerBloc(r)),
        BlocProvider(create: (_) => ProfileAttributesBloc(r)),
        BlocProvider(create: (_) => UnreadConversationsCountBloc(r)),
        BlocProvider(create: (_) => NewReceivedLikesAvailableBloc(r)),
        BlocProvider(create: (_) => CustomReportsConfigBloc(r)),
        BlocProvider(create: (_) => ClientFeaturesConfigBloc(r)),
        BlocProvider(create: (_) => InfoDialogBloc()),

        // Account data
        BlocProvider(create: (_) => AccountBloc(r)),
        BlocProvider(create: (_) => ContentBloc(r)),
        BlocProvider(create: (_) => LocationBloc(r)),
        BlocProvider(create: (_) => MyProfileBloc(r)),
        BlocProvider(create: (_) => AccountDetailsBloc(r)),
        BlocProvider(create: (_) => ProfileFiltersBloc(r)),

        // Settings
        BlocProvider(create: (_) => EditMyProfileBloc(r)),
        BlocProvider(create: (_) => SelectContentBloc(r)),
        BlocProvider(create: (_) => ProfilePicturesBloc(r)),
        BlocProvider(create: (_) => PrivacySettingsBloc(r)),
        BlocProvider(create: (_) => BlockedProfilesBloc(r)),
        BlocProvider(create: (_) => SearchSettingsBloc(r)),
        BlocProvider(create: (_) => NotificationSettingsBloc(r)),
        BlocProvider(create: (_) => UiSettingsBloc(r)),
        BlocProvider(create: (_) => DataExportBloc(r)),

        // News
        BlocProvider(create: (_) => NewsCountBloc(r)),

        // Server maintenance
        BlocProvider(create: (_) => ServerMaintenanceBloc(r)),

        // Likes
        BlocProvider(create: (_) => LikeGridInstanceManagerBloc()),

        // Automatic profile search
        BlocProvider(create: (_) => AutomaticProfileSearchBadgeBloc(r)),
      ],
      child: child,
    );
  }
}

class AppNavigatorAndUpdateNavigationBlocs extends StatelessWidget {
  final RepositoryInstances? r;
  const AppNavigatorAndUpdateNavigationBlocs({this.r, super.key});

  @override
  Widget build(BuildContext context) {
    final navigatorStateBloc = context.read<NavigatorStateBloc>();
    NavigationStateBlocInstance.getInstance().setLatestBloc(navigatorStateBloc);
    final bottomNavigatorStateBloc = context.read<BottomNavigationStateBloc>();
    BottomNavigationStateBlocInstance.getInstance().setLatestBloc(bottomNavigatorStateBloc);

    return AppNavigator(navigatorStateBloc: navigatorStateBloc, r: r);
  }
}

class AppNavigator extends StatefulWidget {
  final NavigatorStateBloc navigatorStateBloc;
  final RepositoryInstances? r;
  const AppNavigator({required this.navigatorStateBloc, this.r, super.key});

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  late final MyRouterDelegate routerDelegate;
  MyRouteInformationParser? routeInfoParser;
  PlatformRouteInformationProvider? routeInfoProvider;

  @override
  void initState() {
    super.initState();
    routerDelegate = MyRouterDelegate(widget.navigatorStateBloc);
    if (kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      // Browser URL navigation is not needed as gesture
      // back navigation works with iOS Safari.
      return;
    }

    final newRouteInfoParser = MyRouteInformationParser(widget.r);
    final info = newRouteInfoParser.restoreRouteInformation(
      UrlNavigationState.convert(widget.navigatorStateBloc.state),
    )!;
    replaceInitialWebBrowserUrl(info);
    routeInfoParser = newRouteInfoParser;
    routeInfoProvider = PlatformRouteInformationProvider(initialRouteInformation: info);
  }

  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: routerDelegate,
      routeInformationParser: routeInfoParser,
      routeInformationProvider: routeInfoProvider,
      backButtonDispatcher: RootBackButtonDispatcher(),
    );
  }
}

class MyRouterDelegate extends RouterDelegate<UrlNavigationState>
    with PopNavigatorRouterDelegateMixin<UrlNavigationState> {
  final NavigatorStateBloc bloc;
  MyRouterDelegate(this.bloc);

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  final Map<VoidCallback, StreamSubscription<NavigatorStateData>> navigatorStateSubscriptions = {};

  @override
  void addListener(VoidCallback listener) {
    if (navigatorStateSubscriptions[listener] == null) {
      navigatorStateSubscriptions[listener] = bloc.stream.listen((event) => listener());
    }
  }

  @override
  void removeListener(VoidCallback listener) {
    final subscription = navigatorStateSubscriptions.remove(listener);
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: key,
      pages: bloc.state.getPages(),
      onDidRemovePage: (page) {
        bloc.add(RemovePageUsingFlutterObject(page));
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => key;

  @override
  UrlNavigationState? get currentConfiguration {
    return UrlNavigationState.convert(bloc.state);
  }

  @override
  Future<void> setNewRoutePath(UrlNavigationState configuration) async {
    // Detect pop
    final current = currentConfiguration;
    final secondLast = current?.list.reversed.skip(1).firstOrNull;
    final newLast = configuration.list.lastOrNull;
    if (secondLast != null && newLast != null && secondLast.checkEquality(newLast)) {
      // Browser URL might flicker if pop is prevented as
      // browser pops current URL from browser navigation history
      // and app adds it back.
      await navigatorKey?.currentState?.maybePop(null);
      return;
    }

    final event = UpdateUrlNavigation(configuration);
    bloc.add(event);
    return await event.waitCompletionAndDispose();
  }
}
