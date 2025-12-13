import 'package:app/data/utils/repository_instances.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/account_banned.dart';
import 'package:app/ui/demo_account.dart';
import 'package:app/ui/initial_setup.dart';
import 'package:app/ui/initial_setup/age_confirmation.dart';
import 'package:app/ui/initial_setup/email.dart';
import 'package:app/ui/initial_setup/gender.dart';
import 'package:app/ui/initial_setup/location.dart';
import 'package:app/ui/initial_setup/profile_attributes.dart';
import 'package:app/ui/initial_setup/profile_basic_info.dart';
import 'package:app/ui/initial_setup/profile_pictures.dart';
import 'package:app/ui/initial_setup/search_settings.dart';
import 'package:app/ui/initial_setup/security_selfie.dart';
import 'package:app/ui/login_new.dart';
import 'package:app/ui/normal.dart';
import 'package:app/ui/normal/chat/conversation_page.dart';
import 'package:app/ui/normal/chat/select_match.dart';
import 'package:app/ui/normal/profiles/profile_filters.dart';
import 'package:app/ui/normal/profiles/view_profile.dart';
import 'package:app/ui/normal/report/report.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui/normal/settings/account_settings.dart';
import 'package:app/ui/normal/settings/admin.dart';
import 'package:app/ui/normal/settings/blocked_profiles.dart';
import 'package:app/ui/normal/settings/chat/chat_data.dart';
import 'package:app/ui/normal/settings/data_export.dart';
import 'package:app/ui/normal/settings/debug.dart';
import 'package:app/ui/login/email_login.dart';
import 'package:app/ui/normal/settings/general/profile_grid_settings.dart';
import 'package:app/ui/normal/settings/location.dart';
import 'package:app/ui/normal/settings/media/content_management.dart';
import 'package:app/ui/normal/settings/media/current_security_selfie.dart';
import 'package:app/ui/normal/settings/my_profile.dart';
import 'package:app/ui/normal/settings/news/news_list.dart';
import 'package:app/ui/normal/settings/news/view_news.dart';
import 'package:app/ui/normal/settings/notification_settings.dart';
import 'package:app/ui/normal/settings/notifications/automatic_profile_search_results.dart';
import 'package:app/ui/normal/settings/privacy_settings.dart';
import 'package:app/ui/normal/settings/profile/edit_profile.dart';
import 'package:app/ui/normal/settings/profile/search_settings.dart';
import 'package:app/ui/normal/settings/chat/receive_chat_backup.dart';
import 'package:app/ui/normal/settings/chat/send_chat_backup.dart';
import 'package:app/ui/normal/settings/statistics.dart';
import 'package:app/ui/pending_deletion.dart';
import 'package:app/ui/splash_screen.dart';
import 'package:app/ui/unsupported_client.dart';
import 'package:app/ui_utils/navigation/url.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:utils/utils.dart';

final _log = Logger("MyRouteInformationParser");

/// Empty state does not update page stack
class UrlNavigationState {
  final List<MyPageWithUrlNavigation<Object>> list;
  UrlNavigationState(this.list);
  UrlNavigationState.empty() : list = [];

  static UrlNavigationState convert(NavigatorStateData navigatorState) {
    final List<MyPageWithUrlNavigation<Object>> list = [];
    for (final p in navigatorState.pages) {
      if (p is MyPageWithUrlNavigation<Object>) {
        list.add(p);
      }
    }
    return UrlNavigationState(list);
  }
}

class MyRouteInformationParser extends RouteInformationParser<UrlNavigationState> {
  final Map<String, UrlParser<MyScreenPage<Object>>> _pageNames = {};
  MyRouteInformationParser(RepositoryInstances? r) {
    for (final p in loggedOutPages()) {
      _pageNames[p.urlName] = p;
    }
    if (r != null) {
      for (final p in loggedInPages(r)) {
        _pageNames[p.urlName] = p;
      }
    }
  }

  @override
  Future<UrlNavigationState> parseRouteInformation(RouteInformation routeInformation) async {
    var segments = UrlSegments.fromRouteInformation(routeInformation);
    final List<MyPageWithUrlNavigation<Object>> list = [];

    while (segments.isNotEmpty) {
      final pageName = segments.first;
      final p = _pageNames[pageName];
      if (p == null) {
        _log.error("Page $pageName not found");
        return UrlNavigationState.empty();
      }
      switch (await p.parseFromSegments(segments)) {
        case Ok(v: (final parsedPage, final newSegments)):
          list.add(parsedPage);
          segments = newSegments;
        case Err():
          _log.error("Parsing page $pageName failed");
          return UrlNavigationState.empty();
      }
    }

    return UrlNavigationState(list);
  }

  @override
  RouteInformation? restoreRouteInformation(UrlNavigationState configuration) {
    final path = configuration.list.map((v) => v.urlPath).join("");
    return RouteInformation(uri: Uri(path: path));
  }
}

List<UrlParser<MyScreenPage<Object>>> loggedOutPages() => [
  // Root
  SplashPage(),
  LoginPage(),
  DemoAccountPage(),

  // Other
  EmailLoginPage(),
  EmailLoginCodePage(),
  SendChatBackupPage(),
];

List<UrlParser<MyScreenPage<Object>>> loggedInPages(RepositoryInstances r) => [
  // Root
  InitialSetupPage(),
  AccountBannedPage(r),
  PendingDeletionPage(r),
  UnsupportedClientPage(),
  NormalStatePage(),

  // Initial setup
  AskEmailPage(),
  AgeConfirmationPage(),
  AskSecuritySelfiePage(),
  AskProfilePicturesPage(),
  AskProfileBasicInfoPage(),
  AskGenderPage(),
  AskSearchSettingsPage(),
  AskLocationPage(),
  AskProfileAttributesPageUrlParser(),

  // Profile
  ProfileFiltersPage(),
  ViewProfilePageUrlParser(r),
  EditProfilePageUrlParser(r),

  // Chat
  SelectMatchPage(),
  ConversationPageUrlParser(r),

  // Profile and chat
  ReportPageUrlParser(r),

  // Menu
  MyProfilePage(),
  NewsListPage(),
  ViewNewsPageUrlParser(),
  StatisticsPage(),
  AutomaticProfileSearchResultsPage(),
  SettingsPage(),
  AdminSettingsPage(),
  DebugSettingsPage(r),

  // Settings
  AccountSettingsPage(),
  SearchSettingsPage(),
  LocationPage(),
  PrivacySettingsPage(),
  BlockedProfilesPage(r),
  CurrentSecuritySelfiePage(),
  ContentManagementPage(),
  DataExportPageMyData(r),
  NotificationSettingsPage(),
  ProfileGridSettingsPage(),
  ChatDataPage(),
  ReceiveChatBackupPage(),
];
