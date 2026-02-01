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

class BotConfigPage extends MyScreenPageLimited<()> {
  BotConfigPage(RepositoryInstances r) : super(builder: (_) => BotConfigScreen(r));
}

class BotConfigScreen extends StatefulWidget {
  final ApiManager api;
  BotConfigScreen(RepositoryInstances r, {super.key}) : api = r.api;

  @override
  State<BotConfigScreen> createState() => _BotConfigScreenState();
}

class _BotConfigScreenState extends State<BotConfigScreen> {
  bool _remoteBotLogin = false;
  int _userBots = 0;
  bool _adminBotEnabled = false;
  AdminBotConfig? _adminBotConfig;
  final TextEditingController _userBotsController = TextEditingController();
  final _configFormKey = GlobalKey<FormState>();

  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    final data = await widget.api.commonAdmin((api) => api.getBotConfig()).ok();

    setState(() {
      isLoading = false;
      isError = data == null;
      _remoteBotLogin = data?.remoteBotLogin ?? _remoteBotLogin;
      _adminBotEnabled = data?.adminBot ?? _adminBotEnabled;
      _userBots = data?.userBots ?? _userBots;
      _adminBotConfig = data?.adminBotConfig ?? _adminBotConfig;
      _userBotsController.text = _userBots.toString();
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
    } else if (isError) {
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
            children: [displayConfig(context, state.permissions)],
          ),
        );
      },
    );
  }

  Widget displayConfig(BuildContext context, Permissions permissions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hPad(Text("Bots", style: Theme.of(context).textTheme.titleSmall)),
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        remoteBotLoginSwitchTile(_remoteBotLogin),
        adminBotSwitchTile(_adminBotEnabled),
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        hPad(userBotsTextField()),
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        permissions.adminServerEditBotConfig
            ? hPad(saveBotConfigButton())
            : hPad(const Text("No permission for editing bot config")),
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

        final adminBotConfig = _adminBotConfig;
        if (adminBotConfig == null) {
          showSnackBar("Config not loaded");
          return;
        }

        final config = BotConfig(
          remoteBotLogin: _remoteBotLogin,
          adminBot: _adminBotEnabled,
          userBots: _userBots,
          adminBotConfig: adminBotConfig,
        );
        showConfirmDialog(context, "Save bot config?").then((value) async {
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
