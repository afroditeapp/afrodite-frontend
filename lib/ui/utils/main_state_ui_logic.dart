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
import 'package:app/utils/result.dart';
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
import 'package:provider/provider.dart';

class MainStateUiLogic extends StatelessWidget {
  const MainStateUiLogic({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainStateBloc, MainState>(
      builder: (context, state) {
        return switch (state) {
          MsSplashScreen() => NavigatorSplashScreen(),
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
        BlocProvider(create: (_) => BottomNavigationStateBloc(BottomNavigationStateData())),
      ],
      child: blocProvider(AppNavigatorAndUpdateNavigationBlocs()),
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
  final AppLaunchNotification? notification;
  const LoggedInRootScreen({required this.r, this.notification, super.key});

  Widget rootScreen();
  Widget blocProvider(Widget child);

  @override
  Widget build(BuildContext context) {
    final NavigatorStateData navigatorInitialState =
        notification?.navigatorState ??
        NavigatorStateData.rootPage(NewPageDetails(MaterialPage<void>(child: rootScreen())));
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
        child: blocProvider(AppNavigatorAndUpdateNavigationBlocs()),
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
  Widget rootScreen() => AccountBannedScreen(r);

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
  Widget rootScreen() => PendingDeletionPage(r);

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
  Widget rootScreen() => UnsupportedClientScreen();

  @override
  Widget blocProvider(Widget child) {
    return child;
  }
}

class NavigatorNormal extends LoggedInRootScreen {
  const NavigatorNormal({required super.r, required super.notification, super.key});

  @override
  Widget rootScreen() => NormalStateScreen();

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
        BlocProvider(create: (_) => NewModerationRequestBloc()),
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
  const AppNavigatorAndUpdateNavigationBlocs({super.key});

  @override
  Widget build(BuildContext context) {
    final navigatorStateBloc = context.read<NavigatorStateBloc>();
    NavigationStateBlocInstance.getInstance().setLatestBloc(navigatorStateBloc);
    final bottomNavigatorStateBloc = context.read<BottomNavigationStateBloc>();
    BottomNavigationStateBlocInstance.getInstance().setLatestBloc(bottomNavigatorStateBloc);

    return AppNavigator(bloc: navigatorStateBloc);
  }
}

class AppNavigator extends StatefulWidget {
  final NavigatorStateBloc bloc;
  const AppNavigator({required this.bloc, super.key});

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  late final MyRouterDelegate routerDelegate;
  late final PlatformRouteInformationProvider routeInfoProvider;

  @override
  void initState() {
    super.initState();
    routerDelegate = MyRouterDelegate(widget.bloc);
    final parser = MyRouteInformationParser();
    routeInfoProvider = PlatformRouteInformationProvider(
      initialRouteInformation: parser.restoreRouteInformation(Ok(widget.bloc.state.pages.length))!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: routerDelegate,
      routeInformationParser: MyRouteInformationParser(),
      routeInformationProvider: routeInfoProvider,
      backButtonDispatcher: RootBackButtonDispatcher(),
    );
  }
}

class MyRouterDelegate extends RouterDelegate<Result<int, Uri>>
    with PopNavigatorRouterDelegateMixin<Result<int, Uri>> {
  final NavigatorStateBloc bloc;
  MyRouterDelegate(this.bloc);

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  final Map<VoidCallback, StreamSubscription<NavigatorStateData>> subscriptions = {};

  @override
  void addListener(VoidCallback listener) {
    if (subscriptions[listener] == null) {
      subscriptions[listener] = bloc.stream.listen((event) => listener());
    }
  }

  @override
  void removeListener(VoidCallback listener) {
    final subscription = subscriptions.remove(listener);
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
  Result<int, Uri>? get currentConfiguration {
    final pages = NavigationStateBlocInstance.getInstance().navigationState.pages;
    return Ok(pages.length);
  }

  @override
  Future<void> setNewRoutePath(Result<int, Uri> configuration) {
    if (configuration case Ok()) {
      final event = PopUntilLenghtIs(configuration.v);
      bloc.add(event);
      return event.waitCompletionAndDispose();
    }
    return SynchronousFuture(null);
  }
}

class MyRouteInformationParser extends RouteInformationParser<Result<int, Uri>> {
  @override
  Future<Result<int, Uri>> parseRouteInformation(RouteInformation routeInformation) {
    final path = routeInformation.uri.path == "/" ? "1" : routeInformation.uri.path;
    final number = int.tryParse(path);
    if (number == null) {
      return SynchronousFuture(Err(routeInformation.uri));
    } else {
      return SynchronousFuture(Ok(number));
    }
  }

  @override
  RouteInformation? restoreRouteInformation(Result<int, Uri> configuration) {
    switch (configuration) {
      case Ok():
        if (configuration.value == 1) {
          return RouteInformation(uri: Uri.parse("/"));
        } else {
          return RouteInformation(uri: Uri.parse(configuration.v.toString()));
        }
      case Err():
        return RouteInformation(uri: configuration.e);
    }
  }
}
