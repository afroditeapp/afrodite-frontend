import 'dart:convert';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/bot_config/nsfw_thresholds.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';

class ImageProcessingConfigPage extends MyScreenPageLimited<()> {
  ImageProcessingConfigPage(RepositoryInstances r)
    : super(builder: (closer) => ImageProcessingConfigScreen(r, closer));
}

class ImageProcessingConfigScreen extends StatefulWidget {
  final ApiManager api;
  final PageCloser<()> closer;
  ImageProcessingConfigScreen(RepositoryInstances r, this.closer, {super.key}) : api = r.api;

  @override
  State<ImageProcessingConfigScreen> createState() => _ImageProcessingConfigScreenState();
}

class _ImageProcessingConfigScreenState extends State<ImageProcessingConfigScreen> {
  ImageProcessingDynamicConfig? _config;
  ImageProcessingDynamicConfig? _initialConfig;
  final TextEditingController _seetafaceThresholdController = TextEditingController();

  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    final data = await widget.api.mediaAdmin((api) => api.getImageProcessingConfig()).ok();

    setState(() {
      isLoading = false;
      isError = data == null;
      if (data != null) {
        final json = jsonDecode(jsonEncode(data));
        _initialConfig = ImageProcessingDynamicConfig.fromJson(json);
        _config = ImageProcessingDynamicConfig.fromJson(json);
        _seetafaceThresholdController.text = _config?.seetafaceThreshold?.toString() ?? "";
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
          appBar: AppBar(title: const Text("Image Processing Config")),
          body: displayState(context),
          floatingActionButton:
              permissions.adminServerEditImageProcessingConfig && _hasUnsavedChanges()
              ? FloatingActionButton(
                  onPressed: () {
                    showConfirmDialog(context, "Save image processing config?").then((value) async {
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

  Widget displayState(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (isError || _config == null) {
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
        hPad(Text("NSFW Thresholds", style: Theme.of(context).textTheme.titleSmall)),
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        hPad(
          EditNsfwThresholds(
            thresholds: _config?.nsfwThresholds ?? NsfwDetectionThresholds(),
            onChanged: (v) => setState(() => _config?.nsfwThresholds = v),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 16.0)),
        hPad(Text("Face Detection", style: Theme.of(context).textTheme.titleSmall)),
        hPad(
          TextFormField(
            controller: _seetafaceThresholdController,
            decoration: const InputDecoration(labelText: "Seetaface Threshold"),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (v) => setState(() {
              _config?.seetafaceThreshold = double.tryParse(v);
            }),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 16.0)),
        if (!permissions.adminServerEditImageProcessingConfig)
          hPad(const Text("No permission for editing image processing config")),
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

    final result = await widget.api.mediaAdminAction(
      (api) => api.postImageProcessingConfig(config),
    );
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
    _seetafaceThresholdController.dispose();
    super.dispose();
  }
}
