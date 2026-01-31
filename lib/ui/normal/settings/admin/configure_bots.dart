import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';

class ConfigureBotsPage extends MyScreenPageLimited<()> {
  ConfigureBotsPage(RepositoryInstances r) : super(builder: (_) => ConfigureBotsScreen(r));
}

class ConfigureBotsScreen extends StatefulWidget {
  final ApiManager api;
  ConfigureBotsScreen(RepositoryInstances r, {super.key}) : api = r.api;

  @override
  State<ConfigureBotsScreen> createState() => _ConfigureBotsScreenState();
}

class _ConfigureBotsScreenState extends State<ConfigureBotsScreen> {
  bool? _remoteBotLogin;
  int? _userBots;
  bool? _adminBotEnabled;
  final TextEditingController _userBotsController = TextEditingController();
  final _configFormKey = GlobalKey<FormState>();
  BotConfig? _currentConfig;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    final data = await widget.api.commonAdmin((api) => api.getBotConfig()).ok();

    setState(() {
      isLoading = false;
      _remoteBotLogin = data?.remoteBotLogin;
      _adminBotEnabled = data?.adminBot;
      _userBots = data?.userBots;
      _userBotsController.text = _userBots.toString();
      _currentConfig = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bots"),
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
              state.permissions.adminServerMaintenanceViewBotConfig
                  ? hPad(Text(_currentConfig.toString()))
                  : hPad(const Text("No permission for viewing bot config")),
              const Padding(padding: EdgeInsets.only(top: 8.0)),
              state.permissions.adminServerMaintenanceEditBotConfig
                  ? displaySaveConfig(context)
                  : hPad(const Text("No permission for editing bot config")),
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
        hPad(saveBotConfigButton()),
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

  Widget saveBotConfigButton() {
    return ElevatedButton(
      onPressed: () {
        if (_configFormKey.currentState?.validate() == false) {
          return;
        }

        FocusScope.of(context).unfocus();

        final config = BotConfig(
          remoteBotLogin: _remoteBotLogin ?? false,
          adminBot: _adminBotEnabled ?? false,
          userBots: _userBots ?? 0,
        );
        showConfirmDialog(
          context,
          "Save bot config?",
          details: "New config: ${config.toString()}",
        ).then((value) async {
          if (value == true) {
            final result = await widget.api.commonAdminAction((api) => api.postBotConfig(config));
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
      child: const Text("Save bot config"),
    );
  }

  @override
  void dispose() {
    _userBotsController.dispose();
    super.dispose();
  }
}
