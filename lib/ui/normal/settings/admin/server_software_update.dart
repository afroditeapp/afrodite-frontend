

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/data/login_repository.dart';


import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';



class ServerSoftwareUpdatePage extends StatefulWidget {
  const ServerSoftwareUpdatePage({Key? key}) : super(key: key);

  @override
  _ServerSoftwareUpdatePageState createState() => _ServerSoftwareUpdatePageState();
}

class _ServerSoftwareUpdatePageState extends State<ServerSoftwareUpdatePage> {

  final Server _selectedServer = Server.account;
  bool _reboot = false;
  bool _reset_data = false;
  SoftwareData? _currentData;
  final api = LoginRepository.getInstance().repositories.api;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions;
    if (api.inMicroserviceMode()) {
      actions = [];
    } else {
      actions = [];
    }
    actions.add(IconButton(onPressed: () async {
        final data = await _getData(_selectedServer, api);
        setState(() {
          _currentData = data;
        });
    }, icon: const Icon(Icons.refresh)));

    Widget body;
    if (_currentData == null) {
      body = loadInitialData();
    } else {
      body = displayData();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Server software: ${_selectedServer.name}"),
        actions: actions,
      ),
      body: body,
    );
  }


  Widget loadInitialData() {
    return FutureBuilder(
      future: _getData(_selectedServer, api),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active || ConnectionState.waiting: {
            return buildProgressIndicator();
          }
          case ConnectionState.none || ConnectionState.done: {
            final data = snapshot.data;
            if (data != null) {
              _currentData = data;
              return displayData();
            }
            return const Text("Error");
          }
        }
      }
    );
  }

  Widget buildProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget displayData() {
    return RefreshIndicator(
      onRefresh: () async {
        final data = await _getData(_selectedServer, api);

        setState(() {
          _currentData = data;
        });
      },
      child: ListView(
        scrollDirection: Axis.vertical,
        // children: displaySoftwareData(context, _currentData!),
        children: [],
      ),
    );
  }

  // List<Widget> displaySoftwareData(BuildContext context, SoftwareData data) {
  //   var widgets = <Widget>[];

  //   final currentVersion = Text("Running backend: ${data.runningVersion.backendVersion} ${data.runningVersion.backendCodeVersion}");
  //   widgets.add(currentVersion);

  //   data.installedSoftware.currentSoftware.sort((a, b) => a.name.compareTo(b.name));
  //   for (final buildInfo in data.installedSoftware.currentSoftware) {
  //     switch (buildInfo.name) {
  //       case "backend": {
  //         displaySoftware(context, widgets, buildInfo, data.latestAvailableBackend, SoftwareOptions.backend);
  //       }
  //       default: {
  //         widgets.add(Text("Unknown build: ${buildInfo.name}"));
  //       }
  //     }
  //   }

  //   final paddedWidgets = <Widget>[];
  //   for (var widget in widgets) {
  //     paddedWidgets.add(Padding(
  //       padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
  //       child: widget
  //     ));
  //   }

  //   paddedWidgets.addAll(displaySystemInfo(context, data.systemInfo));

  //   return paddedWidgets;
  // }

  // void displaySoftware(
  //   BuildContext context,
  //   List<Widget> widgets,
  //   BuildInfo buildInfo,
  //   BuildInfo? latestAvailable,
  //   SoftwareOptions softwareOptions,
  // ) {
  //   widgets.add(Text(
  //     buildInfo.name,
  //     textAlign: TextAlign.left,
  //     style: Theme.of(context).textTheme.headlineSmall,
  //   ));
  //   widgets.add(displayBuildInfo(context, "Installed: ", buildInfo));
  //   if (latestAvailable != null) {
  //     widgets.add(displayBuildInfo(context, "Available: ", latestAvailable));
  //     if (latestAvailable.commitSha == buildInfo.commitSha) {
  //       widgets.add(Text("No updates available (${buildInfo.name})"));
  //     } else {
  //       widgets.add(Text("Update available! (${buildInfo.name})"));
  //       widgets.add(displayUpdate(context, softwareOptions));
  //     }
  //   } else {
  //     widgets.add(const Text("No info about latest software"));
  //   }
  // }

  // Widget displayBuildInfo(BuildContext context, String startText, BuildInfo buildInfo) {
  //   final details = "$startText\nname: ${buildInfo.name}\ntime: ${buildInfo.timestamp}\n${buildInfo.buildInfo}";
  //   final shortCommit = buildInfo.commitSha.substring(0, 7);
  //   final buildInfoLines = buildInfo.buildInfo.split("\n");
  //   var version = "";
  //   for (final line in buildInfoLines) {
  //     if (line.startsWith("version:")) {
  //       version = line.substring(9);
  //       break;
  //     }
  //   }
  //   return Row(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //         child: Text("$startText$version $shortCommit"),
  //       ),
  //       ElevatedButton(
  //         onPressed: () {
  //           showInfoDialog(context, details);
  //         },
  //         child: const Text("Info"),
  //       ),
  //     ],
  //   );
  // }

  Widget displayUpdate(BuildContext context) {

    final rebootCheckbox = IntrinsicHeight(
      child: CheckboxListTile(
        title: const Text("Reboot"),
        value: _reboot,
        onChanged: (value) {
          setState(() {
            _reboot = value ?? false;
          });
        },
      ),
    );

    final resetData = IntrinsicHeight(
      child: CheckboxListTile(
        title: const Text("Reset data"),
        value: _reset_data,
        onChanged: (value) {
          setState(() {
            _reset_data = value ?? false;
          });
        },
      ),
    );

    final requestUpdateButton = ElevatedButton(
      onPressed: () {
        showConfirmDialog(context, "Request update?", details: "Reboot: $_reboot \nReset data: $_reset_data")
          .then((value) async {
            if (value == true) {
              // final result = await api
              //   .commonAdminAction(
              //     _selectedServer, (api) =>
              //       api.postRequestUpdateSoftware(softwareOptions, _reboot, _reset_data)
              //   );
              // if (result case Ok()) {
              //   showSnackBar("Update requested!");
              // } else {
              //   showSnackBar("Update request failed!");
              // }
            }
          });
      },
      child: const Text("Request update"),
    );

    var options = <Widget>[
      rebootCheckbox,
      resetData,
    ];

    return Row(
      children: [
        Expanded(
          child: Column(
            children: options,
          ),
        ),
        requestUpdateButton,
      ],
    );
  }

  List<Widget> displaySystemInfo(BuildContext context, SystemInfo data) {
    var widgets = <Widget>[];
    widgets.addAll(displayCommandList(data.info));
    return widgets;
  }

  List<Widget> displayCommandList(List<CommandOutput> commands) {
    List<Widget> list = [];

    for (var command in commands) {
      if (!command.name.contains("-manager")) {
        continue;
      }

      list.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          command.name,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ));

      Widget output = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            command.output,
            style: GoogleFonts.robotoMono(),
          ),
        ),
      );
      list.add(output);
    }

    return list;
  }
}


Future<SoftwareData?> _getData(Server server, ApiManager api) async {
  final version = await api.common(server, (api) => api.getVersion()).ok();
  final managers = await api.commonAdmin(server, (api) => api.getManagerInstanceNames()).ok();
  final managerName = managers?.names.firstOrNull;
  if (managerName == null) {
    return null;
  }
  final updateStatus = await api.commonAdmin(server, (api) => api.getSoftwareUpdateStatus(managerName)).ok();
  final systemInfo = await api.commonAdmin(server, (api) => api.getSystemInfo(managerName)).ok();


  if (version == null) {
    return null;
  }

  if (updateStatus == null) {
    return null;
  }

  if (systemInfo == null) {
    return null;
  }

  return SoftwareData(version, updateStatus.downloaded, updateStatus.installed, systemInfo);
}

class SoftwareData {
  final BackendVersion runningVersion;
  final SoftwareInfo? downloadedSoftware;
  final SoftwareInfo? installedSoftware;
  final SystemInfo systemInfo;

  SoftwareData(
    this.runningVersion,
    this.downloadedSoftware,
    this.installedSoftware,
    this.systemInfo,
  );
}
