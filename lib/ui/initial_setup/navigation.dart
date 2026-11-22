import "package:app/config_features.dart";
import "package:app/logic/account/initial_setup.dart";
import "package:app/logic/app/navigator_state.dart";
import "package:app/logic/profile/attributes.dart";
import "package:app/model/freezed/logic/account/initial_setup.dart";
import "package:app/ui/initial_setup/age_confirmation.dart";
import "package:app/ui/initial_setup/first_chat_backup.dart";
import "package:app/ui/initial_setup/email.dart";
import "package:app/ui/initial_setup/gender.dart";
import "package:app/ui/initial_setup/location.dart";
import "package:app/ui/initial_setup/profile_attributes.dart";
import "package:app/ui/initial_setup/profile_basic_info.dart";
import "package:app/ui/initial_setup/profile_pictures.dart";
import "package:app/ui/initial_setup/profile_privacy_settings.dart";
import "package:app/ui/initial_setup/search_settings.dart";
import "package:app/ui/initial_setup/security_selfie.dart";
import "package:app/ui_utils/initial_setup_common.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// Names for initial setup pages are generated with this function.
///
/// Generated string contains page order version which can be incremented
/// when changing the page order.
String initialSetupPageNameInDb(String name) => "order_v2_$name";

/// The order of initial setup pages.
///
/// This must contain at least a single page.
///
/// Some pages are skipped during navigation depending on the initial setup state.
/// See [isInitialSetupPageSkipped].
List<InitialSetupPageBase> getInitialSetupPageOrder() {
  return [
    AskEmailPage(),
    AgeConfirmationPage(),
    AskProfileBasicInfoPage(),
    AskGenderPage(),
    AskSearchSettingsPage(),
    AskSecuritySelfiePage(),
    AskProfilePicturesPage(),
    // Required to be the fourth last page
    AskLocationPage(),
    // Required to be the third last page
    AskProfileAttributesPage(attributeIndex: 0),
    // Required to be the second last page
    ProfilePrivacySetupPage(),
    // Required to be the last page
    FirstChatBackupPage(),
  ];
}

bool isSecuritySelfieScreenAskedInInitialSetup(Gender? gender) {
  return gender != null && FEATURE_INITIAL_SETUP_SECURITY_SELFIE_GENDERS.contains(gender);
}

/// Returns true if [page] is skipped in the initial setup for [gender].
bool isInitialSetupPageSkipped(InitialSetupPageBase page, Gender? gender) {
  return page is AskSecuritySelfiePage && !isSecuritySelfieScreenAskedInInitialSetup(gender);
}

void _pushInitialSetupPage(BuildContext context, InitialSetupPageBase nextPage) {
  MyNavigator.push(context, nextPage);
  context.read<InitialSetupBloc>().add(SetCurrentPage(nextPage.nameForDb));
}

/// Navigate to the next initial setup page based on current page.
void navigateToNextInitialSetupPage(BuildContext context) {
  final gender = context.read<InitialSetupBloc>().state.gender;
  final pageOrder = getInitialSetupPageOrder();
  final navigationState = context.read<NavigatorStateBloc>().state;
  final currentPage = navigationState.pages.lastOrNull;

  if (currentPage == null || pageOrder.last is! FirstChatBackupPage) {
    // This is not translated because users should not see this
    showSnackBar("Navigation error");
    return;
  }

  if (currentPage is AskLocationPage) {
    _navigateToNextInitialSetupPageFromAskLocationPage(context);
    return;
  }

  if (currentPage is AskProfileAttributesPage) {
    _navigateToNextInitialSetupPageFromAskProfileAttributesPage(context);
    return;
  }

  if (currentPage is FirstChatBackupPage) {
    context.read<InitialSetupBloc>().add(CompleteInitialSetup());
    return;
  }

  final currentPageName = currentPage is InitialSetupPageBase ? currentPage.nameForDb : null;
  if (currentPageName != null) {
    final currentIndex = pageOrder.indexWhere((page) => page.nameForDb == currentPageName);
    if (currentIndex != -1) {
      // Find the next page that is not skipped for the current gender.
      for (int i = currentIndex + 1; i < pageOrder.length; i++) {
        final nextPage = pageOrder[i];
        if (isInitialSetupPageSkipped(nextPage, gender)) continue;
        _pushInitialSetupPage(context, nextPage);
        return;
      }
    }
  }

  // This is not translated because users should not see this
  showSnackBar("Navigation error");
}

void _navigateToNextInitialSetupPageFromAskLocationPage(BuildContext context) {
  final attributes =
      context.read<ProfileAttributesBloc>().state.manager?.requiredAttributes() ?? [];
  final nextAttribute = attributes.firstOrNull;
  if (nextAttribute == null) {
    _pushInitialSetupPage(context, ProfilePrivacySetupPage());
  } else {
    _pushInitialSetupPage(context, AskProfileAttributesPage(attributeIndex: 0));
  }
}

void _navigateToNextInitialSetupPageFromAskProfileAttributesPage(BuildContext context) {
  final navigationState = context.read<NavigatorStateBloc>().state;
  final currentPage = navigationState.pages.lastOrNull;
  if (currentPage is! AskProfileAttributesPage) {
    // This is not translated because users should not see this
    showSnackBar("Navigation error");
    return;
  }

  final attributes =
      context.read<ProfileAttributesBloc>().state.manager?.requiredAttributes() ?? [];
  final nextAttributeIndex = currentPage.attributeIndex + 1;
  if (nextAttributeIndex >= attributes.length) {
    _pushInitialSetupPage(context, ProfilePrivacySetupPage());
  } else {
    _pushInitialSetupPage(context, AskProfileAttributesPage(attributeIndex: nextAttributeIndex));
  }
}
