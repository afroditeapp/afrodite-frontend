
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/menu.dart';
import 'package:app/ui/normal/settings/admin/account_admin/account_private_info.dart';
import 'package:app/ui/normal/settings/admin/account_admin/admin_content_management.dart';
import 'package:app/ui/normal/settings/admin/account_admin/ban_account.dart';
import 'package:app/ui/normal/settings/admin/account_admin/delete_account.dart';
import 'package:app/ui/normal/settings/admin/account_admin/edit_permissions.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

class AccountAdminSettingsScreen extends StatefulWidget {
  final ProfileEntry entry;
  const AccountAdminSettingsScreen({
    required this.entry,
    super.key,
  });

  @override
  State<AccountAdminSettingsScreen> createState() => _AccountAdminSettingsScreenState();
}

class _AccountAdminSettingsScreenState extends State<AccountAdminSettingsScreen> {

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
        final settings = settingsList(context, state.permissions);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.all(8.0)),
              hPad(Text(
                "${widget.entry.name}, ${widget.entry.age}",
                style: Theme.of(context).textTheme.titleMedium,
              )),
              const Padding(padding: EdgeInsets.all(4.0)),
              hPad(Text(
                "Account ID: ${widget.entry.uuid.aid}",
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

  List<Setting> settingsList(BuildContext context, Permissions permissions) {
    List<Setting> settings = [];

    if (permissions.adminViewPrivateInfo) {
      settings.add(Setting.createSetting(Icons.person, "Account private info", () =>
        MyNavigator.push(context, MaterialPage<void>(child: AccountPrivateInfoScreen(entry: widget.entry)))
      ));
    }

    if (permissions.adminModifyPermissions) {
      settings.add(Setting.createSetting(Icons.admin_panel_settings, "Edit permissions", () {
        final pageKey = PageKey();
        MyNavigator.pushWithKey(
          context,
          MaterialPage<void>(child: EditPermissionsScreen(
            pageKey: pageKey,
            account: widget.entry.uuid
          )),
          pageKey
        );
      }));
    }

    if (permissions.adminBanAccount) {
      settings.add(Setting.createSetting(Icons.block, "Ban account", () =>
        MyNavigator.push(context, MaterialPage<void>(child: BanAccountScreen(entry: widget.entry)))
      ));
    }

    if (permissions.adminDeleteAccount || permissions.adminRequestAccountDeletion) {
      settings.add(Setting.createSetting(Icons.delete, "Delete account", () =>
        MyNavigator.push(context, MaterialPage<void>(child: DeleteAccountScreen(entry: widget.entry)))
      ));
    }

    // TODO(prod): Change adminModerateProfileContent to
    // adminModerateMediaContent

    if (permissions.adminModerateProfileContent) {
      settings.add(Setting.createSetting(Icons.image, "Admin image management", () =>
        MyNavigator.push(context, MaterialPage<void>(child: AdminContentManagementScreen(entry: widget.entry)))
      ));
    }

    return settings;
  }
}
