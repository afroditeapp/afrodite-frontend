import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/menu.dart';
import 'package:app/ui/normal/profiles/view_profile.dart';
import 'package:app/ui/normal/settings/admin/account_admin/account_private_info.dart';
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
    await MyNavigator.push(
      context,
      MaterialPage<void>(
        child: AccountAdminSettingsScreen(
          accountId: account,
          initialAge: ageAndName.age,
          initialName: ageAndName.name,
        ),
      ),
    );
  } else if (ageAndName == null) {
    showSnackBar("Get profile age and name failed");
  }
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
  final profile = LoginRepository.getInstance().repositories.profile;
  final api = LoginRepository.getInstance().repositories.api;

  late String name;
  late int age;

  @override
  void initState() {
    super.initState();
    name = widget.initialName;
    age = widget.initialAge;
  }

  Future<void> updateProfileAgeAndName() async {
    final ageAndName = await api
        .profileAdmin((api) => api.getProfileAgeAndName(widget.accountId.aid))
        .ok();
    if (ageAndName != null && context.mounted) {
      setState(() {
        age = ageAndName.age;
        name = ageAndName.name;
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

  Future<void> openProfile(BuildContext context) async {
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

    settings.add(Setting.createSetting(Icons.person, showProfileTitle, () => openProfile(context)));

    if (permissions.adminViewPrivateInfo) {
      settings.add(
        Setting.createSetting(
          Icons.person,
          "Account private info",
          () => MyNavigator.push(
            context,
            MaterialPage<void>(child: AccountPrivateInfoScreen(r, accountId: widget.accountId)),
          ),
        ),
      );
      const apiUsageStatistics = "API usage statistics";
      settings.add(
        Setting.createSetting(Icons.query_stats, apiUsageStatistics, () {
          openViewApiUsageScreen(context, apiUsageStatistics, api, widget.accountId);
        }),
      );
      settings.add(
        Setting.createSetting(
          Icons.public,
          "IP address usage",
          () => MyNavigator.push(
            context,
            MaterialPage<void>(child: ViewIpAddressUsageScreen(accountId: widget.accountId)),
          ),
        ),
      );
    }

    if (permissions.adminViewPermissions && permissions.adminModifyPermissions) {
      settings.add(
        Setting.createSetting(Icons.admin_panel_settings, "Edit permissions", () {
          final pageKey = PageKey();
          MyNavigator.pushWithKey(
            context,
            MaterialPage<void>(
              child: EditPermissionsScreen(api: r.api, pageKey: pageKey, account: widget.accountId),
            ),
            pageKey,
          );
        }),
      );
    }

    if (permissions.adminEditProfileName) {
      settings.add(
        Setting.createSetting(Icons.edit, "Edit profile name", () async {
          await MyNavigator.push(
            context,
            MaterialPage<void>(
              child: EditProfileNameScreen(accountId: widget.accountId, initialName: name),
            ),
          );
          await updateProfileAgeAndName();
        }),
      );
    }

    if (permissions.adminBanAccount) {
      settings.add(
        Setting.createSetting(
          Icons.block,
          "Ban account",
          () => MyNavigator.push(
            context,
            MaterialPage<void>(child: BanAccountScreen(accountId: widget.accountId)),
          ),
        ),
      );
    }

    if (permissions.adminDeleteAccount || permissions.adminRequestAccountDeletion) {
      settings.add(
        Setting.createSetting(
          Icons.delete,
          "Delete account",
          () => MyNavigator.push(
            context,
            MaterialPage<void>(child: DeleteAccountScreen(accountId: widget.accountId)),
          ),
        ),
      );
    }

    if (permissions.adminModerateMediaContent) {
      settings.add(
        Setting.createSetting(
          Icons.image,
          "Admin image management",
          () => MyNavigator.push(
            context,
            MaterialPage<void>(child: AdminContentManagementScreen(accountId: widget.accountId)),
          ),
        ),
      );
    }

    if (permissions.adminModerateProfileTexts) {
      settings.add(
        Setting.createSetting(
          Icons.text_fields,
          "Moderate profile text",
          () => MyNavigator.push(
            context,
            MaterialPage<void>(
              child: ModerateSingleProfileStringScreen(
                accountId: widget.accountId,
                contentType: ProfileStringModerationContentType.profileText,
              ),
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
          () => MyNavigator.push(
            context,
            MaterialPage<void>(
              child: ModerateSingleProfileStringScreen(
                accountId: widget.accountId,
                contentType: ProfileStringModerationContentType.profileName,
              ),
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
          () => MyNavigator.push(
            context,
            MaterialPage<void>(
              child: ViewReportsScreen(
                api: r.api,
                account: widget.accountId,
                mode: ReportIteratorMode.sent,
                title: sentReports,
              ),
            ),
          ),
        ),
      );

      const receivedReports = "View received reports";
      settings.add(
        Setting.createSetting(
          Icons.report,
          receivedReports,
          () => MyNavigator.push(
            context,
            MaterialPage<void>(
              child: ViewReportsScreen(
                api: r.api,
                account: widget.accountId,
                mode: ReportIteratorMode.received,
                title: receivedReports,
              ),
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
          () {
            openDataExportScreen(
              context,
              context.strings.data_export_screen_title_export_type_admin,
              widget.accountId,
              allowAdminDataExport: true,
            );
          },
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
  bool get adminViewPrivateInfo => _permissions.adminViewPrivateInfo;
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
        adminViewPrivateInfo;
  }
}
