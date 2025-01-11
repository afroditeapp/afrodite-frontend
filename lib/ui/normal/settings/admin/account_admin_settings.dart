
import 'package:app/data/login_repository.dart';
import 'package:app/data/profile_repository.dart';
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
import 'package:app/ui/normal/settings/admin/account_admin/moderate_single_profile_text.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

class AccountAdminSettingsScreen extends StatefulWidget {
  final AccountId accountId;
  final String name;
  final int age;
  const AccountAdminSettingsScreen({
    required this.accountId,
    required this.name,
    required this.age,
    super.key,
  });

  @override
  State<AccountAdminSettingsScreen> createState() => _AccountAdminSettingsScreenState();
}

class _AccountAdminSettingsScreenState extends State<AccountAdminSettingsScreen> {

  final profile = LoginRepository.getInstance().repositories.profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account admin settings"),
      ),
      body: BlocBuilder<AccountBloc, AccountBlocData>(
        builder: (context, state) {
          return screenContent(context, state.permissions);
        }
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
              hPad(Text(
                "${widget.name}, ${widget.age}",
                style: Theme.of(context).textTheme.titleMedium,
              )),
              const Padding(padding: EdgeInsets.all(4.0)),
              hPad(Text(
                "Account ID: ${widget.accountId.aid}",
                style: Theme.of(context).textTheme.bodySmall,
              )),
              const Padding(padding: EdgeInsets.all(8.0)),
              ...settings.map((setting) => setting.toListTile()),
            ],
          ),
        );
      }
    );
  }

  Future<void> openProfile(BuildContext context) async {
    final entry = await profile.getProfile(widget.accountId);

    if (!context.mounted) {
      return;
    }

    if (entry == null) {
      showSnackBar(R.strings.generic_error);
      return;
    }

    openProfileView(context, entry, null, ProfileRefreshPriority.low);
  }

  List<Setting> settingsList(BuildContext context, AccountAdminSettingsPermissions permissions) {
    List<Setting> settings = [];

    String showProfileTitle;
    if (permissions.adminViewAllProfiles) {
      showProfileTitle = "Show profile";
    } else {
      showProfileTitle = "Show profile (if public)";
    }

    settings.add(Setting.createSetting(Icons.person, showProfileTitle, () => openProfile(context)));

    if (permissions.adminViewPrivateInfo) {
      settings.add(Setting.createSetting(Icons.person, "Account private info", () =>
        MyNavigator.push(context, MaterialPage<void>(child: AccountPrivateInfoScreen(accountId: widget.accountId)))
      ));
    }

    if (permissions.adminViewPermissions && permissions.adminModifyPermissions) {
      settings.add(Setting.createSetting(Icons.admin_panel_settings, "Edit permissions", () {
        final pageKey = PageKey();
        MyNavigator.pushWithKey(
          context,
          MaterialPage<void>(child: EditPermissionsScreen(
            pageKey: pageKey,
            account: widget.accountId
          )),
          pageKey
        );
      }));
    }

    if (permissions.adminBanAccount) {
      settings.add(Setting.createSetting(Icons.block, "Ban account", () =>
        MyNavigator.push(context, MaterialPage<void>(child: BanAccountScreen(accountId: widget.accountId)))
      ));
    }

    if (permissions.adminDeleteAccount || permissions.adminRequestAccountDeletion) {
      settings.add(Setting.createSetting(Icons.delete, "Delete account", () =>
        MyNavigator.push(context, MaterialPage<void>(child: DeleteAccountScreen(accountId: widget.accountId)))
      ));
    }

    if (permissions.adminModerateMediaContent) {
      settings.add(Setting.createSetting(Icons.image, "Admin image management", () =>
        MyNavigator.push(context, MaterialPage<void>(child: AdminContentManagementScreen(accountId: widget.accountId)))
      ));
    }

    if (permissions.adminModerateProfileTexts) {
      settings.add(Setting.createSetting(Icons.text_fields, "Moderate profile text", () =>
        MyNavigator.push(context, MaterialPage<void>(child: ModerateSingleProfileTextScreen(accountId: widget.accountId)))
      ));
    }

    return settings;
  }
}

class AccountAdminSettingsPermissions {
  final Permissions _permissions;
  bool get adminModifyPermissions => _permissions.adminModifyPermissions;
  bool get adminModerateMediaContent => _permissions.adminModerateMediaContent;
  bool get adminModerateProfileTexts => _permissions.adminModerateProfileTexts;
  bool get adminDeleteAccount => _permissions.adminDeleteAccount;
  bool get adminRequestAccountDeletion => _permissions.adminRequestAccountDeletion;
  bool get adminBanAccount => _permissions.adminBanAccount;
  bool get adminViewAllProfiles => _permissions.adminViewAllProfiles;
  bool get adminViewPermissions => _permissions.adminViewPermissions;
  bool get adminViewPrivateInfo => _permissions.adminViewPrivateInfo;
  AccountAdminSettingsPermissions(this._permissions);

  bool somePermissionEnabled() {
    return adminModifyPermissions ||
      adminModerateMediaContent ||
      adminModerateProfileTexts ||
      adminDeleteAccount ||
      adminRequestAccountDeletion ||
      adminBanAccount ||
      adminViewAllProfiles ||
      adminViewPermissions ||
      adminViewPrivateInfo;
  }
}
