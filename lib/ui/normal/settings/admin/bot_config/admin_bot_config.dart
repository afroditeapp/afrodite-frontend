import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/bot_config/content_moderation_config.dart';
import 'package:app/ui/normal/settings/admin/bot_config/profile_string_moderation_config.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class EditAdminBotConfigPage extends MyScreenPageLimited<AdminBotConfig> {
  EditAdminBotConfigPage(AdminBotConfig config)
    : super(builder: (closer) => EditAdminBotConfigScreen(config, closer));
}

class EditAdminBotConfigScreen extends StatefulWidget {
  final AdminBotConfig initialConfig;
  final PageCloser<AdminBotConfig> closer;
  const EditAdminBotConfigScreen(this.initialConfig, this.closer, {super.key});

  @override
  State<EditAdminBotConfigScreen> createState() => _EditAdminBotConfigScreenState();
}

class _EditAdminBotConfigScreenState extends State<EditAdminBotConfigScreen> {
  late AdminBotConfig _config;

  @override
  void initState() {
    super.initState();
    _config = widget.initialConfig;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        widget.closer.close(context, _config);
      },
      child: _scaffold(context),
    );
  }

  Widget _scaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Bot Config")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Content Moderation"),
            value: _config.contentModerationEnabled,
            onChanged: (v) => setState(() => _config.contentModerationEnabled = v),
          ),
          ListTile(
            title: const Text("Configure content moderation"),
            trailing: const Icon(Icons.chevron_right),
            enabled: _config.contentModerationEnabled,
            onTap: _config.contentModerationEnabled
                ? () async {
                    final result = await MyNavigator.pushLimited(
                      context,
                      EditContentModerationConfigPage(_config.contentModeration),
                    );
                    if (result != null) {
                      setState(() => _config.contentModeration = result);
                    }
                  }
                : null,
          ),
          const Divider(),
          SwitchListTile(
            title: const Text("Profile Name Moderation"),
            value: _config.profileNameModerationEnabled,
            onChanged: (v) => setState(() => _config.profileNameModerationEnabled = v),
          ),
          ListTile(
            title: const Text("Configure profile name moderation"),
            trailing: const Icon(Icons.chevron_right),
            enabled: _config.profileNameModerationEnabled,
            onTap: _config.profileNameModerationEnabled
                ? () async {
                    final result = await MyNavigator.pushLimited(
                      context,
                      EditProfileStringModerationConfigPage(_config.profileNameModeration),
                    );

                    if (result != null) {
                      setState(() => _config.profileNameModeration = result);
                    }
                  }
                : null,
          ),
          const Divider(),
          SwitchListTile(
            title: const Text("Profile Text Moderation"),
            value: _config.profileTextModerationEnabled,
            onChanged: (v) => setState(() => _config.profileTextModerationEnabled = v),
          ),
          ListTile(
            title: const Text("Configure profile text moderation"),
            trailing: const Icon(Icons.chevron_right),
            enabled: _config.profileTextModerationEnabled,
            onTap: _config.profileTextModerationEnabled
                ? () async {
                    final result = await MyNavigator.pushLimited(
                      context,
                      EditProfileStringModerationConfigPage(_config.profileTextModeration),
                    );

                    if (result != null) {
                      setState(() => _config.profileTextModeration = result);
                    }
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
