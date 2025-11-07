import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/menu.dart';
import 'package:app/ui/normal/profiles/view_profile.dart';
import 'package:app/ui/normal/settings/admin/account_admin/account_state.dart';
import 'package:app/ui/normal/settings/admin/account_admin/admin_content_management.dart';
import 'package:app/ui/normal/settings/admin/account_admin/ban_account.dart';
import 'package:app/ui/normal/settings/admin/account_admin/delete_account.dart';
import 'package:app/ui/normal/settings/admin/account_admin/edit_permissions.dart';
import 'package:app/ui/normal/settings/admin/account_admin/edit_profile_name.dart';
import 'package:app/ui/normal/settings/admin/account_admin/moderate_single_profile_string.dart';
import 'package:app/ui/normal/settings/admin/account_admin/view_api_usage.dart';
import 'package:app/ui/normal/settings/admin/account_admin/view_ip_address_usage.dart';
import 'package:app/ui/normal/settings/admin/account_admin/view_reports.dart';
import 'package:app/ui/normal/settings/data_export.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

Future<void> getAgeAndNameAndShowAdminSettings(
  BuildContext context,
  ApiManager api,
  AccountId account,
) async {
  final ageAndName = await api.profileAdmin((api) => api.getProfileAgeAndName(account.aid)).ok();

  if (ageAndName != null && context.mounted) {
    await MyNavigator.pushLimited(
      context,
      AccountAdminSettingsPage(
        accountId: account,
        initialAge: ageAndName.age,
        initialName: ageAndName.name ?? "",
      ),
    );
  } else if (ageAndName == null) {
    showSnackBar("Get profile age and name failed");
  }
}

class AccountAdminSettingsPage extends MyScreenPageLimited<()> {
  AccountAdminSettingsPage({
    required AccountId accountId,
    required String initialName,
    required int initialAge,
  }) : super(
         builder: (_) => AccountAdminSettingsScreen(
           accountId: accountId,
           initialName: initialName,
           initialAge: initialAge,
         ),
       );
}

/// This screen should be opened using getAgeAndNameAndShowAdminSettings
/// as profile name editing is possible and current UI might have old name data.
class AccountAdminSettingsScreen extends StatefulWidget {
  final AccountId accountId;
  final String initialName;
  final int initialAge;
  const AccountAdminSettingsScreen({
    required this.accountId,
    required this.initialName,
    required this.initialAge,
    super.key,
  });

  @override
  State<AccountAdminSettingsScreen> createState() => _AccountAdminSettingsScreenState();
}

class _AccountAdminSettingsScreenState extends State<AccountAdminSettingsScreen> {
  late String name;
  late int age;

  @override
  void initState() {
    super.initState();
    name = widget.initialName;
    age = widget.initialAge;
  }

  Future<void> updateProfileAgeAndName(ApiManager api) async {
    final ageAndName = await api
        .profileAdmin((api) => api.getProfileAgeAndName(widget.accountId.aid))
        .ok();
    if (ageAndName != null && context.mounted) {
      setState(() {
        age = ageAndName.age;
        name = ageAndName.name ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account admin settings")),
      body: BlocBuilder<AccountBloc, AccountBlocData>(
        builder: (context, state) {
          return screenContent(context, state.permissions);
        },
      ),
    );
  }

  Widget screenContent(BuildContext context, Permissions permissions) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        final settings = settingsList(context, AccountAdminSettingsPermissions(state.permissions));
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.all(8.0)),
              hPad(Text("$name, $age", style: Theme.of(context).textTheme.titleMedium)),
              const Padding(padding: EdgeInsets.all(4.0)),
              hPad(
                SelectableText(
                  "Account ID: ${widget.accountId.aid}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              ...settings.map((setting) => setting.toListTile()),
            ],
          ),
        );
      },
    );
  }

  Future<void> openProfile(BuildContext context, ProfileRepository profile) async {
    final entry = await profile.downloadProfile(widget.accountId);

    if (!context.mounted) {
      return;
    }

    if (entry == null) {
      showSnackBar(R.strings.generic_error);
      return;
    }

    await openProfileView(context, entry, null, ProfileRefreshPriority.low);
  }

  List<Setting> settingsList(BuildContext context, AccountAdminSettingsPermissions permissions) {
    final r = context.read<RepositoryInstances>();
    List<Setting> settings = [];

    String showProfileTitle;
    if (permissions.adminViewAllProfiles) {
      showProfileTitle = "Show profile";
    } else {
      showProfileTitle = "Show profile (if public)";
    }

    settings.add(
      Setting.createSetting(Icons.person, showProfileTitle, () => openProfile(context, r.profile)),
    );

    if (permissions.adminViewAccountState) {
      settings.add(
        Setting.createSetting(
          Icons.person,
          "Account state",
          () => MyNavigator.pushLimited(context, AccountStatePage(r, widget.accountId)),
        ),
      );
    }

    if (permissions.adminViewAccountApiUsage) {
      const apiUsageStatistics = "API usage statistics";
      settings.add(
        Setting.createSetting(Icons.query_stats, apiUsageStatistics, () {
          openViewApiUsageScreen(context, apiUsageStatistics, r.api, widget.accountId);
        }),
      );
    }

    if (permissions.adminViewAccountIpAddressUsage) {
      settings.add(
        Setting.createSetting(
          Icons.public,
          "IP address usage",
          () => MyNavigator.pushLimited(context, ViewIpAddressUsagePage(r, widget.accountId)),
        ),
      );
    }

    if (permissions.adminViewPermissions && permissions.adminModifyPermissions) {
      settings.add(
        Setting.createSetting(Icons.admin_panel_settings, "Edit permissions", () {
          MyNavigator.pushLimited(context, EditPermissionsPage(r, widget.accountId));
        }),
      );
    }

    if (permissions.adminEditProfileName) {
      settings.add(
        Setting.createSetting(Icons.edit, "Edit profile name", () async {
          await MyNavigator.pushLimited(
            context,
            EditProfileNamePage(r, widget.accountId, initialName: name),
          );
          await updateProfileAgeAndName(r.api);
        }),
      );
    }

    if (permissions.adminBanAccount) {
      settings.add(
        Setting.createSetting(
          Icons.block,
          "Ban account",
          () => MyNavigator.pushLimited(context, BanAccountPage(r, widget.accountId)),
        ),
      );
    }

    if (permissions.adminDeleteAccount || permissions.adminRequestAccountDeletion) {
      settings.add(
        Setting.createSetting(
          Icons.delete,
          "Delete account",
          () => MyNavigator.pushLimited(context, DeleteAccountPage(r, widget.accountId)),
        ),
      );
    }

    if (permissions.adminModerateMediaContent) {
      settings.add(
        Setting.createSetting(
          Icons.image,
          "Admin image management",
          () => MyNavigator.pushLimited(context, AdminContentManagementPage(r, widget.accountId)),
        ),
      );
    }

    if (permissions.adminModerateProfileTexts) {
      settings.add(
        Setting.createSetting(
          Icons.text_fields,
          "Moderate profile text",
          () => MyNavigator.pushLimited(
            context,
            ModerateSingleProfileStringPage(
              r,
              widget.accountId,
              contentType: ProfileStringModerationContentType.profileText,
            ),
          ),
        ),
      );
    }

    if (permissions.adminModerateProfileNames) {
      settings.add(
        Setting.createSetting(
          Icons.text_fields,
          "Moderate profile name",
          () => MyNavigator.pushLimited(
            context,
            ModerateSingleProfileStringPage(
              r,
              widget.accountId,
              contentType: ProfileStringModerationContentType.profileName,
            ),
          ),
        ),
      );
    }

    if (permissions.adminProcessReports) {
      const sentReports = "View sent reports";
      settings.add(
        Setting.createSetting(
          Icons.report,
          sentReports,
          () => MyNavigator.pushLimited(
            context,
            ViewReportsPage(r, widget.accountId, mode: ReportIteratorMode.sent, title: sentReports),
          ),
        ),
      );

      const receivedReports = "View received reports";
      settings.add(
        Setting.createSetting(
          Icons.report,
          receivedReports,
          () => MyNavigator.pushLimited(
            context,
            ViewReportsPage(
              r,
              widget.accountId,
              mode: ReportIteratorMode.received,
              title: receivedReports,
            ),
          ),
        ),
      );
    }

    if (permissions.adminExportData) {
      settings.add(
        Setting.createSetting(
          Icons.cloud_download,
          context.strings.data_export_screen_title_export_type_admin,
          () => MyNavigator.pushLimited(context, DataExportPageAdmin(widget.accountId)),
        ),
      );
    }

    return settings;
  }
}

class AccountAdminSettingsPermissions {
  final Permissions _permissions;
  bool get adminModifyPermissions => _permissions.adminEditPermissions;
  bool get adminExportData => _permissions.adminExportData;
  bool get adminEditProfileName => _permissions.adminEditProfileName;
  bool get adminModerateMediaContent => _permissions.adminModerateMediaContent;
  bool get adminModerateProfileTexts => _permissions.adminModerateProfileTexts;
  bool get adminModerateProfileNames => _permissions.adminModerateProfileNames;
  bool get adminProcessReports => _permissions.adminProcessReports;
  bool get adminDeleteAccount => _permissions.adminDeleteAccount;
  bool get adminRequestAccountDeletion => _permissions.adminRequestAccountDeletion;
  bool get adminBanAccount => _permissions.adminBanAccount;
  bool get adminViewAllProfiles => _permissions.adminViewAllProfiles;
  bool get adminViewPermissions => _permissions.adminViewPermissions;
  bool get adminViewAccountState => _permissions.adminViewAccountState;
  bool get adminViewAccountApiUsage => _permissions.adminViewAccountApiUsage;
  bool get adminViewAccountIpAddressUsage => _permissions.adminViewAccountIpAddressUsage;
  AccountAdminSettingsPermissions(this._permissions);

  bool somePermissionEnabled() {
    return adminModifyPermissions ||
        adminEditProfileName ||
        adminExportData ||
        adminModerateMediaContent ||
        adminModerateProfileTexts ||
        adminModerateProfileNames ||
        adminProcessReports ||
        adminDeleteAccount ||
        adminRequestAccountDeletion ||
        adminBanAccount ||
        adminViewAllProfiles ||
        adminViewPermissions ||
        adminViewAccountState ||
        adminViewAccountApiUsage ||
        adminViewAccountIpAddressUsage;
  }
}
