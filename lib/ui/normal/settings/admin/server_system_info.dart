

import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';



import 'package:google_fonts/google_fonts.dart';


class ServerSystemInfoPage extends StatefulWidget {
  const ServerSystemInfoPage({Key? key}) : super(key: key);

  @override
  _ServerSystemInfoPageState createState() => _ServerSystemInfoPageState();
}

class _ServerSystemInfoPageState extends State<ServerSystemInfoPage> {

  var _selectedServer = Server.account;
  SystemInfoList? _currentData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions;
    if (ApiManager.getInstance().inMicroserviceMode()) {
      actions = [buildPopUpMenuButtons()];
    } else {
      actions = [];
    }
    actions.add(IconButton(onPressed: () async {
        final data = await ApiManager.getInstance().mediaCommonAdmin((api) => api.getSystemInfo());
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
        title: Text("Server system info: ${_selectedServer.name}"),
        actions: actions,
      ),
      body: body,
    );
  }

  Widget buildPopUpMenuButtons() {
    return PopupMenuButton<Server>(
      onSelected: (Server result) {
        setState(() {
          _selectedServer = result;
        });
      },
      itemBuilder: (BuildContext context) {
        final list = <PopupMenuEntry<Server>>[
          const PopupMenuItem<Server>(
            value: Server.account,
            child: Text('Account server'),
          )
        ];

        if (ApiManager.getInstance().mediaInMicroserviceMode()) {
          list.add(const PopupMenuItem<Server>(
            value: Server.media,
            child: Text('Media server'),
          ));
        }

        if (ApiManager.getInstance().profileInMicroserviceMode()) {
          list.add(const PopupMenuItem<Server>(
            value: Server.profile,
            child: Text('Profile server'),
          ));
        }

        return list;
      }
    );
  }

  Widget loadInitialData() {
    return FutureBuilder(
      future: ApiManager.getInstance().mediaCommonAdmin((api) => api.getSystemInfo()),
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
        final data = await ApiManager.getInstance().mediaCommonAdmin((api) => api.getSystemInfo());

        setState(() {
          _currentData = data;
        });
      },
      child: ListView.builder(
        itemCount: _currentData?.info.length ?? 1,
        itemBuilder: (context, index) {
          final data = _currentData;
          if (data == null) {
            return const Text("Error");
          }

          final info = data.info[index];
          final widgets = <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  info.name,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ];
          widgets.addAll(displayCommandList(info.info));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          );
        },
      ),
    );
  }

  List<Widget> displayCommandList(List<CommandOutput> commands) {
    List<Widget> list = [];

    for (var command in commands) {
      list.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          command.name,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.headlineSmall,
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
