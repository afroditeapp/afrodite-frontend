import 'package:app/api/server_connection_manager.dart';
import 'package:app/config.dart';
import 'package:app/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openapi/api.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:app/utils/result.dart';

class ServerSystemInfoPage extends StatefulWidget {
  final ApiManager api;
  const ServerSystemInfoPage(this.api, {super.key});

  @override
  State<ServerSystemInfoPage> createState() => _ServerSystemInfoPageState();
}

class _ServerSystemInfoPageState extends State<ServerSystemInfoPage> {
  ManagerInstanceNameList? _managers;
  List<ManagerSystemInfo>? _currentData = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Allow landscape mode if allowed by system
    SystemChrome.setPreferredOrientations([]);

    _refreshData();
  }

  Future<void> _refreshData() async {
    _managers ??= await widget.api.commonAdmin((api) => api.getManagerInstanceNames()).ok();

    final managers = _managers?.names ?? [];
    final List<ManagerSystemInfo> data = [];
    for (final m in managers) {
      final info = await widget.api.commonAdmin((api) => api.getSystemInfo(m)).ok();
      if (info != null) {
        data.add(ManagerSystemInfo(m, info));
      } else {
        data.add(ManagerSystemInfo(m, null));
      }
    }

    setState(() {
      isLoading = false;
      _currentData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];
    actions.add(IconButton(onPressed: _refreshData, icon: const Icon(Icons.refresh)));

    return Scaffold(
      appBar: AppBar(title: const Text("Server system info"), actions: actions),
      body: displayState(),
    );
  }

  Widget displayState() {
    final data = _currentData;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_managers == null || data == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return displayData(data);
    }
  }

  Widget displayData(List<ManagerSystemInfo> infoList) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.builder(
        itemCount: infoList.length,
        itemBuilder: (context, index) {
          final info = infoList[index];

          final List<Widget> widgets = <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                info.name,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ];

          final cmdList = info.info;
          if (cmdList == null) {
            widgets.add(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(context.strings.generic_error, textAlign: TextAlign.left),
              ),
            );
          } else {
            widgets.addAll(displayCommandList(cmdList.info));
          }

          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
        },
      ),
    );
  }

  List<Widget> displayCommandList(List<CommandOutput> commands) {
    List<Widget> list = [];

    for (var command in commands) {
      list.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            command.name,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      );

      Widget output = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(command.output, style: GoogleFonts.robotoMono()),
        ),
      );
      list.add(output);
    }

    return list;
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DEFAULT_ORIENTATIONS);
    super.dispose();
  }
}

class ManagerSystemInfo {
  String name;
  SystemInfo? info;
  ManagerSystemInfo(this.name, this.info);
}
