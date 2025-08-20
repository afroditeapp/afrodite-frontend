import 'package:app/localizations.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';

class ServerSoftwareUpdatePage extends StatefulWidget {
  const ServerSoftwareUpdatePage({super.key});

  @override
  State<ServerSoftwareUpdatePage> createState() => _ServerSoftwareUpdatePageState();
}

class _ServerSoftwareUpdatePageState extends State<ServerSoftwareUpdatePage> {
  BackendVersion? _runningVersion;
  ManagerInstanceNameList? _managers;
  List<ManagerInstanceRelatedState>? _currentData = [];
  final api = LoginRepository.getInstance().repositories.api;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    _managers ??= await api.commonAdmin((api) => api.getManagerInstanceNames()).ok();
    _runningVersion = await api.common((api) => api.getVersion()).ok();

    final managers = _managers?.names ?? [];
    final List<ManagerInstanceRelatedState> data = [];
    for (final m in managers) {
      final status = await api.commonAdmin((api) => api.getSoftwareUpdateStatus(m)).ok();
      if (status != null) {
        data.add(ManagerInstanceRelatedState(m, status));
      } else {
        data.add(ManagerInstanceRelatedState(m, null));
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
      appBar: AppBar(title: const Text("Server software update"), actions: actions),
      body: displayState(),
    );
  }

  Widget displayState() {
    final runningVersion = _runningVersion;
    final data = _currentData;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_managers == null || runningVersion == null || data == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return displayData(runningVersion, data);
    }
  }

  Widget displayData(BackendVersion runningVersion, List<ManagerInstanceRelatedState> statusList) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.builder(
        itemCount: statusList.length + 1,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, i) {
          if (i == 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Running backend: ${runningVersion.backendVersion} ${runningVersion.backendCodeVersion}",
              ),
            );
          } else {
            final data = statusList[i - 1];
            return displaySoftwareUpdate(context, data);
          }
        },
      ),
    );
  }

  Widget displaySoftwareUpdate(BuildContext context, ManagerInstanceRelatedState data) {
    final status = data.status;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            data.manager,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        if (status == null) hPad(Text(context.strings.generic_error)),
        if (status != null) displaySoftwareStatus(context, data, status),
      ],
    );
  }

  Widget displaySoftwareStatus(
    BuildContext context,
    ManagerInstanceRelatedState state,
    SoftwareUpdateStatus status,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hPad(Text("State", style: Theme.of(context).textTheme.titleSmall)),
        hPad(Text(status.state.toString())),
        const Padding(padding: EdgeInsets.all(8.0)),
        ...displaySoftware(context, state, status.installed, status.downloaded),
        const Padding(padding: EdgeInsets.all(8.0)),
        hPad(displayDownload(context, state)),
      ],
    );
  }

  List<Widget> displaySoftware(
    BuildContext context,
    ManagerInstanceRelatedState state,
    SoftwareInfo? installed,
    SoftwareInfo? downloaded,
  ) {
    final List<Widget> widgets = [];
    if (installed != null && downloaded != null && installed == downloaded) {
      widgets.add(displayBuildInfo(context, "Installed", installed));
      widgets.add(const Padding(padding: EdgeInsets.all(8.0)));
    } else {
      if (installed != null) {
        widgets.add(displayBuildInfo(context, "Installed", installed));
        widgets.add(const Padding(padding: EdgeInsets.all(8.0)));
      }
      if (downloaded != null) {
        widgets.add(displayBuildInfo(context, "Downloaded", downloaded));
        widgets.add(const Padding(padding: EdgeInsets.all(8.0)));
      }
    }

    if (installed != null && downloaded != null && downloaded.sha256 == installed.sha256) {
      widgets.add(hPad(const Text("No updates available")));
    } else if (downloaded != null) {
      widgets.add(hPad(const Text("Update available!")));
      widgets.add(hPad(displayUpdate(context, state, downloaded)));
    }

    return widgets;
  }

  Widget displayBuildInfo(BuildContext context, String title, SoftwareInfo info) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hPad(Text(title, style: Theme.of(context).textTheme.titleLarge)),
        const Padding(padding: EdgeInsets.all(8.0)),
        hPad(Text("Name", style: Theme.of(context).textTheme.titleSmall)),
        hPad(Text(info.name)),
        const Padding(padding: EdgeInsets.all(8.0)),
        hPad(Text("sha256", style: Theme.of(context).textTheme.titleSmall)),
        hPad(SelectableText(info.sha256)),
      ],
    );
  }

  Widget displayUpdate(
    BuildContext context,
    ManagerInstanceRelatedState state,
    SoftwareInfo downloaded,
  ) {
    final requestUpdateButton = ElevatedButton(
      onPressed: () {
        if (downloaded.sha256 != state.sha256Controller.text) {
          showSnackBar("Text field sha256 value does not match with the downloaded file");
          return;
        }

        showConfirmDialog(context, "Request update?").then((value) async {
          if (value == true) {
            final result = await api.commonAdminAction(
              (api) => api.postTriggerSoftwareUpdateInstall(
                state.manager,
                downloaded.name,
                downloaded.sha256,
              ),
            );
            if (result case Ok()) {
              showSnackBar("Update requested!");
            } else {
              showSnackBar("Update request failed!");
            }
            if (context.mounted) {
              await _refreshData();
            }
          }
        });
      },
      child: const Text("Request update"),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: state.sha256Controller,
          decoration: const InputDecoration(hintText: "sha256"),
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        requestUpdateButton,
      ],
    );
  }

  Widget displayDownload(BuildContext context, ManagerInstanceRelatedState state) {
    return ElevatedButton(
      onPressed: () {
        showConfirmDialog(context, "Check updates?").then((value) async {
          if (value == true) {
            final result = await api.commonAdminAction(
              (api) => api.postTriggerSoftwareUpdateDownload(state.manager),
            );
            if (result case Ok()) {
              showSnackBar("Check updates requested!");
            } else {
              showSnackBar("Check updates failed!");
            }
            if (context.mounted) {
              await _refreshData();
            }
          }
        });
      },
      child: const Text("Check updates"),
    );
  }
}

class ManagerInstanceRelatedState {
  String manager;
  SoftwareUpdateStatus? status;
  TextEditingController sha256Controller = TextEditingController();
  ManagerInstanceRelatedState(this.manager, this.status);
}
