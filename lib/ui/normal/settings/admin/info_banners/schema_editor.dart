import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/info_banners/add_banner.dart';
import 'package:app/ui/normal/settings/admin/info_banners/banner_editor.dart';
import 'package:app/ui_utils/app_bar/menu_actions.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:intl/intl.dart';
import 'package:openapi/api.dart';

class InfoBannersSchemaPage extends MyScreenPageLimited<()> {
  InfoBannersSchemaPage(RepositoryInstances r)
    : super(builder: (closer) => InfoBannersSchemaScreen(r, closer));
}

class InfoBannersSchemaScreen extends StatefulWidget {
  final ApiManager api;
  final PageCloser<()> closer;
  InfoBannersSchemaScreen(RepositoryInstances r, this.closer, {super.key}) : api = r.api;

  @override
  State<InfoBannersSchemaScreen> createState() => _InfoBannersSchemaScreenState();
}

class _InfoBannersSchemaScreenState extends State<InfoBannersSchemaScreen> {
  bool isLoading = true;
  bool isError = false;

  InfoBannersConfig? _initialConfig;
  InfoBannersConfig? _currentConfig;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    final clientConfig = await widget.api.common((api) => api.getClientConfig()).ok();
    if (clientConfig == null) {
      if (mounted) {
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
      return;
    }

    final hash = clientConfig.dynamicClientFeatures;

    final InfoBannersConfig? latestConfig;
    if (hash != null) {
      final serverResult = await widget.api
          .account((api) => api.postGetDynamicClientFeaturesConfig(hash))
          .ok();
      if (serverResult == null) {
        if (mounted) {
          setState(() {
            isLoading = false;
            isError = true;
          });
        }
        return;
      } else {
        latestConfig = serverResult.config?.infoBanners;
      }
    } else {
      latestConfig = null;
    }

    final config = latestConfig ?? InfoBannersConfig(banners: {});
    if (mounted) {
      setState(() {
        isLoading = false;
        isError = false;
        _initialConfig = _cloneConfig(config);
        _currentConfig = _cloneConfig(config);
      });
    }
  }

  bool _hasUnsavedChanges() {
    if (_initialConfig == null || _currentConfig == null) {
      return false;
    }
    return jsonEncode(_initialConfig) != jsonEncode(_currentConfig);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info banners"),
        actions: [
          menuActions([
            MenuItemButton(
              onPressed: _currentConfig == null
                  ? null
                  : () async {
                      await _addBanner(context);
                    },
              child: const Text("Add banner"),
            ),
            MenuItemButton(
              onPressed: _currentConfig == null ? null : _exportSchema,
              child: const Text("Export"),
            ),
            MenuItemButton(onPressed: _importSchema, child: const Text("Import")),
          ]),
        ],
      ),
      body: _displayState(context),
      floatingActionButton: _hasUnsavedChanges()
          ? FloatingActionButton(
              onPressed: () {
                showConfirmDialog(context, "Save info banners?").then((value) async {
                  if (value == true && context.mounted) {
                    await _saveConfigAndCloseScreen();
                  }
                });
              },
              child: const Icon(Icons.save),
            )
          : null,
    );
  }

  Widget _displayState(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (isError) {
      return Center(child: Text(context.strings.generic_error));
    }

    return _showContent(context);
  }

  Widget _showContent(BuildContext context) {
    final config = _currentConfig;
    final entries = config?.banners.entries.toList() ?? const <MapEntry<String, InfoBanner>>[];
    entries.sort((a, b) => a.key.compareTo(b.key));

    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.info_outline),
              SizedBox(width: 12),
              Expanded(child: Text("Note: Removing info banners is not supported.")),
            ],
          ),
        ),
        ...entries.map((entry) {
          final key = entry.key;
          final banner = entry.value;
          final text = banner.text;
          final bodyText = text?.body.default_ ?? "<empty>";
          final visibility = _visibilitySummary(banner.visibility);
          final platforms = _platformSummary(banner.platform);

          return ListTile(
            title: Text(key),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(bodyText),
                Text("Visibility: $visibility"),
                Text("Platforms: $platforms"),
                Text("Version: ${banner.version}"),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final updated = await MyNavigator.pushLimited(
                context,
                EditInfoBannerPage(key, banner),
              );
              if (updated == null) {
                return;
              }

              setState(() {
                _currentConfig?.banners[updated.$1] = updated.$2;
              });
            },
          );
        }),
      ],
    );
  }

  String _visibilitySummary(BannerVisibility visibility) {
    final locations = <String>[];
    if (visibility.profiles) locations.add("profiles");
    if (visibility.likes) locations.add("likes");
    if (visibility.chats) locations.add("chats");
    if (visibility.menu) locations.add("menu");
    if (visibility.conversation) locations.add("conversation");
    if (locations.isEmpty) {
      return "none";
    }
    return locations.join(", ");
  }

  String _platformSummary(BannerPlatform platform) {
    final values = <String>[];
    if (platform.android) values.add("android");
    if (platform.ios) values.add("ios");
    if (platform.web) values.add("web");
    if (values.isEmpty) {
      return "none";
    }
    return values.join(", ");
  }

  Future<void> _addBanner(BuildContext context) async {
    final config = _currentConfig;
    if (config == null) {
      return;
    }

    final created = await MyNavigator.pushLimited(context, AddInfoBannerPage());
    if (created == null) {
      return;
    }

    final key = created.$1;
    if (config.banners.containsKey(key)) {
      showSnackBar("Banner key already exists.");
      return;
    }

    setState(() {
      config.banners[key] = created.$2;
    });
  }

  Future<void> _exportSchema() async {
    final config = _currentConfig;
    if (config == null) {
      return;
    }

    final jsonString = jsonEncode(config);
    final bytes = Uint8List.fromList(utf8.encode(jsonString));

    final timestamp = DateFormat('yyyy-MM-dd_HH-mm').format(DateTime.now());
    final fileName = "info_banners_$timestamp.json";

    try {
      await FlutterFileSaver().writeFileAsBytes(fileName: fileName, bytes: bytes);
      if (mounted) {
        showSnackBar("Info banners exported!");
      }
    } catch (_) {
      if (mounted) {
        showSnackBar("Export failed!");
      }
    }
  }

  Future<void> _importSchema() async {
    const typeGroup = XTypeGroup(label: 'JSON', extensions: <String>['json']);
    final XFile? file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    if (file == null || !mounted) {
      return;
    }

    final confirm = await showConfirmDialog(
      context,
      "Import info banners?",
      details: "This will overwrite your unsaved changes with the contents of ${file.name}.",
      yesNoActions: true,
    );

    if (confirm != true || !mounted) {
      return;
    }

    try {
      final jsonString = await File(file.path).readAsString();
      final data = jsonDecode(jsonString);
      final newConfig = InfoBannersConfig.fromJson(data);
      if (newConfig == null) {
        showSnackBar("Import failed! Invalid schema format.");
        return;
      }

      setState(() {
        _currentConfig = newConfig;
      });
      showSnackBar("Info banners imported!");
    } catch (_) {
      showSnackBar("Import failed! Invalid JSON or schema format.");
    }
  }

  Future<bool> _saveConfigAndCloseScreen() async {
    if (_currentConfig == null) {
      return false;
    }

    final update = SaveInfoBanners(current: _initialConfig, new_: _currentConfig!);
    final result = await widget.api.accountAdminAction((api) => api.postSaveInfoBanners(update));

    switch (result) {
      case Ok():
        showSnackBar("Info banners saved!");
      case Err():
        showSnackBar("Info banners save failed!");
        return false;
    }

    if (mounted) {
      widget.closer.close(context, ());
    }

    return true;
  }

  InfoBannersConfig _cloneConfig(InfoBannersConfig config) {
    final copied = InfoBannersConfig.fromJson(jsonDecode(jsonEncode(config)));
    if (copied == null) {
      return config;
    }
    return copied;
  }
}
