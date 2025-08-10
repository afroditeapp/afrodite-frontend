

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
    final data = await api.commonAdmin((api) => api.getBackendConfig()).ok();

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configure backend"),
        actions: [
          IconButton(
            onPressed: _refreshData,
            icon: const Icon(Icons.refresh)
          ),
        ],
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
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state.permissions.adminServerMaintenanceViewBackendConfig ?
                hPad(Text(_currentConfig.toString())) :
                hPad(const Text("No permission for viewing backend configuration")),
              const Padding(padding: EdgeInsets.all(8.0)),
              state.permissions.adminServerMaintenanceSaveBackendConfig ?
                displaySaveConfig(context) :
                const Text("No permission for saving backend config"),
            ],
          ),
        );
      }
    );
  }

  Widget displaySaveConfig(BuildContext context) {
    final widgets = [
      Text("Bots"),
      const Padding(padding: EdgeInsets.all(8.0)),
      SwitchListTile(
        title: const Text("Admin bot"),
        value: _adminBotEnabled,
        onChanged: (bool value) =>
          setState(() {
            _adminBotEnabled = value;
          })
      ),
      const Padding(padding: EdgeInsets.all(8.0)),
      hPad(userBotsTextField()),
      const Padding(padding: EdgeInsets.all(8.0)),
      saveBackendConfigButton(),
    ];

    return Column(
      children: widgets,
    );
  }

  Widget userBotsTextField() {
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

    return Form(
      key: _configFormKey,
      child: userBots,
    );
  }

  Widget saveBackendConfigButton() {
    return ElevatedButton(
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
                .commonAdminAction(
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
  }
}
