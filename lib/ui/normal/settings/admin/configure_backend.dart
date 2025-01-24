

import 'package:app/localizations.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';

class ConfigureBackendPage extends StatefulWidget {
  const ConfigureBackendPage({super.key});

  @override
  State<ConfigureBackendPage> createState() => _ConfigureBackendPageState();
}

class _ConfigureBackendPageState extends State<ConfigureBackendPage> {
  int _userBots = 0;
  bool _adminBotEnabled = false;
  final TextEditingController _userBotsController = TextEditingController(text: "0");
  final _configFormKey = GlobalKey<FormState>();
  BackendConfig? _currentConfig;
  final api = LoginRepository.getInstance().repositories.api;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    final data = await api.accountCommonAdmin((api) => api.getBackendConfig()).ok();

    setState(() {
      isLoading = false;
      _adminBotEnabled = data?.bots?.admin ?? false;
      _userBots = data?.bots?.users ?? 0;
      _userBotsController.text = _userBots.toString();
      _currentConfig = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];
    actions.add(IconButton(
      onPressed: _refreshData,
      icon: const Icon(Icons.refresh)
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Configure backend"),
        actions: actions,
      ),
      body: displayState(context),
    );
  }

  Widget displayState(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (_currentConfig == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return showContent(context);
    }
  }

  Widget showContent(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        final Widget currentConfig;
        if (state.permissions.adminServerMaintenanceViewBackendConfig) {
          currentConfig = showBackendConfiguration();
        } else {
          currentConfig = const Text("No permission for viewing backend configuration");
        }

        final Widget configureBackend;
        if (state.permissions.adminServerMaintenanceSaveBackendConfig) {
          configureBackend = displaySaveConfig(context);
        } else {
          configureBackend = const Text("No permission for saving backend config");
        }

        final widgets = [
          hPad(currentConfig),
          const Padding(padding: EdgeInsets.all(8.0)),
          configureBackend,
        ];

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          ),
        );
      }
    );
  }

  Widget showBackendConfiguration() {
    final currentConfig = _currentConfig;
    if (currentConfig == null) {
      return Text(currentConfig.toString());
    } else {
      return Text(currentConfig.toString());
    }
  }

  Widget displaySaveConfig(BuildContext context) {
    const text = Text("Bots");

    final adminBotEnabled = SwitchListTile(
      title: const Text("Admin bot"),
      value: _adminBotEnabled,
      onChanged: (bool value) =>
        setState(() {
          _adminBotEnabled = value;
        })
    );

    final userBots = TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'User bots',
      ),
      validator: (value) {
        final number = int.tryParse(value ?? "");
        if (number == null) {
          return "Not a number";
        }
        return null;
      },
      onChanged: (value) {
        final number = int.tryParse(value);
        if (number != null) {
          setState(() {
            _userBots = number;
          });
        }
      },
      controller: _userBotsController,
    );

    final form = Form(
      key: _configFormKey,
      child: userBots,
    );

    final button = ElevatedButton(
      onPressed: () {
        if (_configFormKey.currentState?.validate() == false) {
          return;
        }

        FocusScope.of(context).unfocus();

        final bots = BotConfig(admin: _adminBotEnabled, users: _userBots);
        final config = BackendConfig(bots: bots);
        showConfirmDialog(context, "Save backend config?", details: "New config: ${config.toString()}")
          .then((value) async {
            if (value == true) {
              final result = await api
                .accountCommonAdminAction(
                  (api) => api.postBackendConfig(config)
                );
              switch (result) {
                case Ok():
                  showSnackBar("Config saved!");
                case Err():
                  showSnackBar("Config save failed!");
              }
            }
            if (context.mounted) {
              await _refreshData();
            }
          });
      },
      child: const Text("Save backend config"),
    );

    final widgets = [
      text,
      const Padding(padding: EdgeInsets.all(8.0)),
      adminBotEnabled,
      const Padding(padding: EdgeInsets.all(8.0)),
      hPad(form),
      const Padding(padding: EdgeInsets.all(8.0)),
      button,
    ];

    return Column(
      children: widgets,
    );
  }
}
