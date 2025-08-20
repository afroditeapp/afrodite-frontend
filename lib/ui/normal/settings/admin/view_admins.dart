import 'package:app/localizations.dart';
import 'package:app/ui/normal/settings/admin/account_admin_settings.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:openapi/api.dart';

typedef ViewAdminsData = List<(AccountId, GetProfileAgeAndName, Permissions)>;

class ViewAdminsScreen extends StatefulWidget {
  const ViewAdminsScreen({super.key});

  @override
  State<ViewAdminsScreen> createState() => _ViewAdminsScreenState();
}

class _ViewAdminsScreenState extends State<ViewAdminsScreen> {
  final api = LoginRepository.getInstance().repositories.api;

  Future<ViewAdminsData> _getData() async {
    final result = await api.accountAdmin((api) => api.getAllAdmins()).ok();

    final ViewAdminsData data = [];

    final admins = result?.admins;
    if (admins == null) {
      showSnackBar("Get admins failed");
    } else {
      for (final a in admins) {
        final ageAndName = await api
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
        getAgeAndNameAndShowAdminSettings(context, api, accountId);
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
