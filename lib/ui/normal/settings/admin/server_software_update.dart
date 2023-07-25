

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/admin/image_moderation.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/utils.dart';


import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pihka_frontend/ui/utils/image_page.dart';



class ServerSoftwareUpdatePage extends StatefulWidget {
  const ServerSoftwareUpdatePage({Key? key}) : super(key: key);

  @override
  _ServerSoftwareUpdatePageState createState() => _ServerSoftwareUpdatePageState();
}

class _ServerSoftwareUpdatePageState extends State<ServerSoftwareUpdatePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update server software")),
      body: Text("TODO"),
    );
  }
}
