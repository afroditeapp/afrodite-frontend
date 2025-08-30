import 'package:app/api/server_connection_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';

class ConfigureBackendPage extends StatefulWidget {
  final ApiManager api;
  const ConfigureBackendPage({required this.api, super.key});

  @override
  State<ConfigureBackendPage> createState() => _ConfigureBackendPageState();
}

class _ConfigureBackendPageState extends State<ConfigureBackendPage> {
  bool? _remoteBotLogin;
  int? _userBots;
  bool? _adminBotEnabled;
  final TextEditingController _userBotsController = TextEditingController();
  final _configFormKey = GlobalKey<FormState>();
  BackendConfig? _currentConfig;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    final data = await widget.api.commonAdmin((api) => api.getBackendConfig()).ok();

    setState(() {
      isLoading = false;
      _remoteBotLogin = data?.remoteBotLogin;
      _adminBotEnabled = data?.localBots?.admin;
      _userBots = data?.localBots?.users;
      _userBotsController.text = _userBots.toString();
      _currentConfig = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configure backend"),
        actions: [IconButton(onPressed: _refreshData, icon: const Icon(Icons.refresh))],
      ),
      body: displayState(context),
    );
  }

  Widget displayState(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
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
              state.permissions.adminServerMaintenanceViewBackendConfig
                  ? hPad(Text(_currentConfig.toString()))
                  : hPad(const Text("No permission for viewing backend configuration")),
              const Padding(padding: EdgeInsets.only(top: 8.0)),
              state.permissions.adminServerMaintenanceSaveBackendConfig
                  ? displaySaveConfig(context)
                  : hPad(const Text("No permission for saving backend config")),
            ],
          ),
        );
      },
    );
  }

  Widget displaySaveConfig(BuildContext context) {
    final remoteBotLogin = _remoteBotLogin;
    final adminBotEnabled = _adminBotEnabled;
    final userBots = _userBots;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hPad(Text("Bots", style: Theme.of(context).textTheme.titleSmall)),
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        remoteBotLogin != null
            ? remoteBotLoginSwitchTile(remoteBotLogin)
            : hPad(const Text("Remote bot login config disabled")),
        if (remoteBotLogin == null) const Padding(padding: EdgeInsets.only(top: 8.0)),
        adminBotEnabled != null
            ? adminBotSwitchTile(adminBotEnabled)
            : hPad(const Text("Admin bot config disabled")),
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        userBots != null ? hPad(userBotsTextField()) : hPad(const Text("User bot config disabled")),
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        hPad(saveBackendConfigButton()),
      ],
    );
  }

  Widget remoteBotLoginSwitchTile(bool currentValue) {
    return SwitchListTile(
      title: const Text("Remote bot login"),
      value: currentValue,
      onChanged: (bool value) => setState(() {
        _remoteBotLogin = value;
      }),
    );
  }

  Widget adminBotSwitchTile(bool currentValue) {
    return SwitchListTile(
      title: const Text("Admin bot"),
      value: currentValue,
      onChanged: (bool value) => setState(() {
        _adminBotEnabled = value;
      }),
    );
  }

  Widget userBotsTextField() {
    final userBots = TextFormField(
      decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'User bots'),
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

    return Form(key: _configFormKey, child: userBots);
  }

  Widget saveBackendConfigButton() {
    return ElevatedButton(
      onPressed: () {
        if (_configFormKey.currentState?.validate() == false) {
          return;
        }

        FocusScope.of(context).unfocus();

        final adminBotEnabled = _adminBotEnabled;
        final userBots = _userBots;

        final LocalBotsConfig? botConfig;
        if (adminBotEnabled != null && userBots != null) {
          botConfig = LocalBotsConfig(admin: adminBotEnabled, users: userBots);
        } else {
          botConfig = null;
        }

        final config = BackendConfig(remoteBotLogin: _remoteBotLogin, localBots: botConfig);
        showConfirmDialog(
          context,
          "Save backend config?",
          details: "New config: ${config.toString()}",
        ).then((value) async {
          if (value == true) {
            final result = await widget.api.commonAdminAction(
              (api) => api.postBackendConfig(config),
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

  @override
  void dispose() {
    _userBotsController.dispose();
    super.dispose();
  }
}
