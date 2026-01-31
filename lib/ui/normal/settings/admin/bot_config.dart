import 'dart:convert';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/bot_config/admin_bot_config.dart';
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
  BotConfigPage(RepositoryInstances r) : super(builder: (closer) => BotConfigScreen(r, closer));
}

class BotConfigScreen extends StatefulWidget {
  final ApiManager api;
  final PageCloser<()> closer;
  BotConfigScreen(RepositoryInstances r, this.closer, {super.key}) : api = r.api;

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

  BotConfig? _initialConfig;

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
      if (data != null) {
        // Copy BotConfig so that the same object is not edited
        _initialConfig = BotConfig.fromJson(jsonDecode(jsonEncode(data)));
        _remoteBotLogin = data.remoteBotLogin;
        _adminBotEnabled = data.adminBot;
        _adminBotConfig = data.adminBotConfig;
        _userBots = data.userBots;
        _userBotsController.text = _userBots.toString();
      }
    });
  }

  bool _hasUnsavedChanges() {
    if (_initialConfig == null || _adminBotConfig == null) return false;
    final currentConfig = BotConfig(
      remoteBotLogin: _remoteBotLogin,
      adminBot: _adminBotEnabled,
      adminBotConfig: _adminBotConfig!,
      userBots: _userBots,
    );
    return currentConfig != _initialConfig;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasUnsavedChanges(),
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        showConfirmDialog(
          context,
          context.strings.generic_save_confirmation_title,
          yesNoActions: true,
        ).then((value) {
          if (value == true && context.mounted) {
            _saveConfigAndCloseScreen();
          } else if (value == false && context.mounted) {
            widget.closer.close(context, ());
          }
        });
      },
      child: _scaffold(context),
    );
  }

  Widget _scaffold(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        final permissions = state.permissions;
        return Scaffold(
          appBar: AppBar(title: const Text("Bots")),
          body: displayState(context, permissions),
          floatingActionButton: permissions.adminServerEditBotConfig && _hasUnsavedChanges()
              ? FloatingActionButton(
                  onPressed: () {
                    showConfirmDialog(context, "Save bot config?").then((value) async {
                      if (value == true && context.mounted) {
                        await _saveConfigAndCloseScreen();
                      }
                    });
                  },
                  child: const Icon(Icons.save),
                )
              : null,
        );
      },
    );
  }

  Widget displayState(BuildContext context, Permissions permissions) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (isError) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return showContent(context, permissions);
    }
  }

  Widget showContent(BuildContext context, Permissions permissions) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [displayConfig(context, permissions)],
      ),
    );
  }

  Widget displayConfig(BuildContext context, Permissions permissions) {
    final canEditAdminBotConfig = _adminBotEnabled;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hPad(Text("Bots", style: Theme.of(context).textTheme.titleSmall)),
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        remoteBotLoginSwitchTile(_remoteBotLogin),
        adminBotSwitchTile(_adminBotEnabled),
        ListTile(
          title: const Text("Configure admin bot"),
          subtitle: Text(
            _adminBotConfig == null
                ? "Config missing"
                : _isAdminBotConfigEnabled(_adminBotConfig!)
                ? "Enabled"
                : "Disabled",
          ),
          trailing: const Icon(Icons.chevron_right),
          enabled: canEditAdminBotConfig,
          onTap: canEditAdminBotConfig
              ? () async {
                  final adminBotConfig = _adminBotConfig;
                  if (adminBotConfig == null) {
                    showSnackBar("Admin bot config missing");
                    return;
                  }
                  final result = await MyNavigator.pushLimited(
                    context,
                    EditAdminBotConfigPage(adminBotConfig),
                  );
                  if (result != null) {
                    setState(() => _adminBotConfig = result);
                  }
                }
              : null,
        ),
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        hPad(userBotsTextField()),
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        if (!permissions.adminServerEditBotConfig)
          hPad(const Text("No permission for editing bot config")),
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

  Future<bool> _saveConfigAndCloseScreen() async {
    if (_configFormKey.currentState?.validate() == false) {
      return false;
    }

    FocusScope.of(context).unfocus();

    final adminBotConfig = _adminBotConfig;
    if (adminBotConfig == null) {
      showSnackBar("Config not loaded");
      return false;
    }

    final config = BotConfig(
      remoteBotLogin: _remoteBotLogin,
      adminBot: _adminBotEnabled,
      adminBotConfig: adminBotConfig,
      userBots: _userBots,
    );

    final result = await widget.api.commonAdminAction((api) => api.postBotConfig(config));
    switch (result) {
      case Ok():
        showSnackBar("Config saved!");
      case Err():
        showSnackBar("Config save failed!");
        return false;
    }

    if (mounted) {
      widget.closer.close(context, ());
    }

    return true;
  }

  @override
  void dispose() {
    _userBotsController.dispose();
    super.dispose();
  }

  bool _isAdminBotConfigEnabled(AdminBotConfig config) {
    return config.contentModerationEnabled ||
        config.profileNameModerationEnabled ||
        config.profileTextModerationEnabled;
  }
}
