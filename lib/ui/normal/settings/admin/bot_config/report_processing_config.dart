import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/bot_config/report_processing_messages_config.dart';
import 'package:app/ui/normal/settings/admin/bot_config/report_processing_profile_content_config.dart';
import 'package:app/ui/normal/settings/admin/bot_config/report_processing_profile_string_config.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class EditReportProcessingConfigPage extends MyScreenPageLimited<AdminBotReportProcessingConfig> {
  EditReportProcessingConfigPage(AdminBotReportProcessingConfig config)
    : super(builder: (closer) => EditReportProcessingConfigScreen(config, closer));
}

class EditReportProcessingConfigScreen extends StatefulWidget {
  final AdminBotReportProcessingConfig initialConfig;
  final PageCloser<AdminBotReportProcessingConfig> closer;
  const EditReportProcessingConfigScreen(this.initialConfig, this.closer, {super.key});

  @override
  State<EditReportProcessingConfigScreen> createState() => _EditReportProcessingConfigScreenState();
}

class _EditReportProcessingConfigScreenState extends State<EditReportProcessingConfigScreen> {
  late AdminBotReportProcessingConfig _config;

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
      appBar: AppBar(title: const Text("Report Processing Config")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Messages"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final result = await MyNavigator.pushLimited(
                context,
                EditReportProcessingMessagesConfigPage(_config.messages),
              );
              if (result != null) {
                setState(() => _config.messages = result);
              }
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Profile Content"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final result = await MyNavigator.pushLimited(
                context,
                EditReportProcessingProfileContentConfigPage(_config.profileContent),
              );
              if (result != null) {
                setState(() => _config.profileContent = result);
              }
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Profile Name"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final result = await MyNavigator.pushLimited(
                context,
                EditReportProcessingProfileStringConfigPage(_config.profileName),
              );
              if (result != null) {
                setState(() => _config.profileName = result);
              }
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Profile Text"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final result = await MyNavigator.pushLimited(
                context,
                EditReportProcessingProfileStringConfigPage(_config.profileText),
              );
              if (result != null) {
                setState(() => _config.profileText = result);
              }
            },
          ),
        ],
      ),
    );
  }
}
