import "package:app/logic/account/initial_setup.dart";
import "package:app/logic/app/navigator_state.dart";
import "package:app/logic/profile/attributes.dart";
import "package:app/ui/initial_setup/age_confirmation.dart";
import "package:app/ui/initial_setup/first_chat_backup.dart";
import "package:app/ui/initial_setup/email.dart";
import "package:app/ui/initial_setup/gender.dart";
import "package:app/ui/initial_setup/location.dart";
import "package:app/ui/initial_setup/profile_attributes.dart";
import "package:app/ui/initial_setup/profile_basic_info.dart";
import "package:app/ui/initial_setup/profile_pictures.dart";
import "package:app/ui/initial_setup/search_settings.dart";
import "package:app/ui/initial_setup/security_selfie.dart";
import "package:app/ui_utils/initial_setup_common.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/// The order of initial setup pages.
///
/// This must contain at least a single page.
List<InitialSetupPageBase> getInitialSetupPageOrder() {
  return [
    AskEmailPage(),
    AgeConfirmationPage(),
    AskSecuritySelfiePage(),
    AskProfilePicturesPage(),
    AskProfileBasicInfoPage(),
    AskGenderPage(),
    AskSearchSettingsPage(),
    AskLocationPage(),
    // Required to be the second last page
    FirstChatBackupPage(),
    // Required to be the last page
    AskProfileAttributesPage(attributeIndex: 0),
  ];
}

/// Navigate to the next initial setup page based on current page.
void navigateToNextInitialSetupPage(BuildContext context) {
  final pageOrder = getInitialSetupPageOrder();
  final navigationState = context.read<NavigatorStateBloc>().state;
  final currentPage = navigationState.pages.lastOrNull;

  if (currentPage == null || pageOrder.last is! AskProfileAttributesPage) {
    // This is not translated because users should not see this
    showSnackBar("Navigation error");
    return;
  }

  if (currentPage is FirstChatBackupPage) {
    navigateToNextInitialSetupPageFromFirstChatBackupPage(context);
    return;
  }

  if (currentPage is AskProfileAttributesPage) {
    navigateToNextInitialSetupPageFromAskProfileAttributesPage(context);
    return;
  }

  // Check if this page matches any page in our initial setup page order
  for (int orderIndex = 0; orderIndex < pageOrder.length; orderIndex++) {
    final orderedPage = pageOrder[orderIndex];

    // Check if pages match by type
    if (currentPage.runtimeType == orderedPage.runtimeType) {
      // Found a match, navigate to next page
      final nextIndex = orderIndex + 1;

      if (nextIndex < pageOrder.length) {
        final nextPage = pageOrder[nextIndex];
        MyNavigator.push(context, nextPage);
        context.read<InitialSetupBloc>().add(SetCurrentPage(nextPage.nameForDb));
        return;
      }
    }
  }

  // This is not translated because users should not see this
  showSnackBar("Navigation error");
}

void navigateToNextInitialSetupPageFromFirstChatBackupPage(BuildContext context) {
  final attributes =
      context.read<ProfileAttributesBloc>().state.manager?.requiredAttributes() ?? [];
  final nextAttribute = attributes.firstOrNull;
  if (nextAttribute == null) {
    context.read<InitialSetupBloc>().add(CompleteInitialSetup());
    return;
  }

  final nextPage = AskProfileAttributesPage(attributeIndex: 0);
  MyNavigator.push(context, nextPage);
  context.read<InitialSetupBloc>().add(SetCurrentPage(nextPage.nameForDb));
}

void navigateToNextInitialSetupPageFromAskProfileAttributesPage(BuildContext context) {
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
    context.read<InitialSetupBloc>().add(CompleteInitialSetup());
    return;
  }

  final nextPage = AskProfileAttributesPage(attributeIndex: nextAttributeIndex);
  MyNavigator.push(context, nextPage);
  context.read<InitialSetupBloc>().add(SetCurrentPage(nextPage.nameForDb));
}
