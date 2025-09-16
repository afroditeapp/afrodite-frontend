import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/account_admin_settings.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:openapi/api.dart';

typedef ViewAdminsData = List<(AccountId, GetProfileAgeAndName, Permissions)>;

class ViewAdminsPage extends MyScreenPageLimited<()> {
  ViewAdminsPage(RepositoryInstances r) : super(builder: (_) => ViewAdminsScreen(r));
}

class ViewAdminsScreen extends StatefulWidget {
  final ApiManager api;
  ViewAdminsScreen(RepositoryInstances r, {super.key}) : api = r.api;

  @override
  State<ViewAdminsScreen> createState() => _ViewAdminsScreenState();
}

class _ViewAdminsScreenState extends State<ViewAdminsScreen> {
  Future<ViewAdminsData> _getData() async {
    final result = await widget.api.accountAdmin((api) => api.getAllAdmins()).ok();

    final ViewAdminsData data = [];

    final admins = result?.admins;
    if (admins == null) {
      showSnackBar("Get admins failed");
    } else {
      for (final a in admins) {
        final ageAndName = await widget.api
            .profileAdmin((api) => api.getProfileAgeAndName(a.aid.aid))
            .ok();

        if (ageAndName == null) {
          showSnackBar("Get profile age and name failed");
        } else {
          data.add((a.aid, ageAndName, a.permissions));
        }
      }
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View admins")),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    return FutureBuilder<ViewAdminsData>(
      future: _getData(),
      initialData: null,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active || ConnectionState.waiting:
            {
              return buildProgressIndicator();
            }
          case ConnectionState.none || ConnectionState.done:
            {
              final data = snapshot.data;
              if (data == null) {
                return Center(child: Text(context.strings.generic_error));
              } else {
                return showData(context, data);
              }
            }
        }
      },
    );
  }

  Widget buildProgressIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget openAccountAdminSettings(
    BuildContext context,
    AccountId accountId,
    GetProfileAgeAndName ageAndName,
  ) {
    return ElevatedButton(
      onPressed: () {
        getAgeAndNameAndShowAdminSettings(context, widget.api, accountId);
      },
      child: const Text("Open admin settings"),
    );
  }

  Widget showData(BuildContext context, ViewAdminsData data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, i) {
        final (accountId, ageAndName, permissions) = data[i];

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.all(8.0)),
            hPad(
              Row(
                children: [
                  Text(
                    "${ageAndName.name}, ${ageAndName.age}",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Spacer(),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  openAccountAdminSettings(context, accountId, ageAndName),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            hPad(Text(enabledPermissions(permissions))),
          ],
        );
      },
    );
  }
}

String enabledPermissions(Permissions permissions) {
  final permissionsMap = permissions.toJson();
  permissionsMap.removeWhere((name, value) => value is bool && !value);
  final permissionsList = permissionsMap.entries.toList();
  permissionsList.sortBy((v) => v.key);
  String text = "";
  for (final v in permissionsList) {
    text = "$text\n${v.key}";
  }
  return text.trim();
}
