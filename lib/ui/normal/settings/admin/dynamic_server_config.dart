import 'dart:convert';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

class DynamicServerConfigPage extends MyScreenPageLimited<()> {
  DynamicServerConfigPage(RepositoryInstances r)
    : super(builder: (closer) => DynamicServerConfigScreen(r, closer));
}

class DynamicServerConfigScreen extends StatefulWidget {
  final ApiManager api;
  final PageCloser<()> closer;
  DynamicServerConfigScreen(RepositoryInstances r, this.closer, {super.key}) : api = r.api;

  @override
  State<DynamicServerConfigScreen> createState() => _DynamicServerConfigScreenState();
}

class _DynamicServerConfigScreenState extends State<DynamicServerConfigScreen> {
  DynamicServerConfig? _config;
  DynamicServerConfig? _initialConfig;

  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    final data = await widget.api.commonAdmin((api) => api.getDynamicServerConfig()).ok();

    setState(() {
      isLoading = false;
      isError = data == null;
      if (data != null) {
        final json = jsonDecode(jsonEncode(data));
        _initialConfig = DynamicServerConfig.fromJson(json);
        _config = DynamicServerConfig.fromJson(json);
      }
    });
  }

  bool _hasUnsavedChanges() {
    if (_config == null || _initialConfig == null) {
      return false;
    }
    return _config != _initialConfig;
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
          appBar: AppBar(title: const Text("Server config")),
          body: _displayState(context),
          floatingActionButton: permissions.adminServerEditServerConfig && _hasUnsavedChanges()
              ? FloatingActionButton(
                  onPressed: () {
                    showConfirmDialog(context, "Save server config?").then((value) async {
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

  Widget _displayState(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (isError || _config == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return _showContent(context);
    }
  }

  Widget _showContent(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, state) {
        return SingleChildScrollView(child: _displayConfig(context, state.permissions));
      },
    );
  }

  Widget _displayConfig(BuildContext context, Permissions permissions) {
    final platforms = _config?.accountRegistrationPlatforms;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            "Account Registration Platforms",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          subtitle: const Text("Enable or disable account registration by platform."),
        ),
        SwitchListTile(
          title: const Text("Android"),
          value: platforms?.android ?? false,
          onChanged: (value) => setState(() {
            if (platforms != null) {
              platforms.android = value;
            }
          }),
        ),
        SwitchListTile(
          title: const Text("iOS"),
          value: platforms?.ios ?? false,
          onChanged: (value) => setState(() {
            if (platforms != null) {
              platforms.ios = value;
            }
          }),
        ),
        SwitchListTile(
          title: const Text("Web"),
          value: platforms?.web ?? false,
          onChanged: (value) => setState(() {
            if (platforms != null) {
              platforms.web = value;
            }
          }),
        ),
        if (!permissions.adminServerEditServerConfig)
          const ListTile(title: Text("No permission for editing server config")),
      ],
    );
  }

  Future<bool> _saveConfigAndCloseScreen() async {
    FocusScope.of(context).unfocus();

    final config = _config;
    if (config == null) {
      showSnackBar("Config not loaded");
      return false;
    }

    final result = await widget.api.commonAdminAction((api) => api.postDynamicServerConfig(config));
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
}
