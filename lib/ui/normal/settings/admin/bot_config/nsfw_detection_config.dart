import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/bot_config/nsfw_thresholds.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class EditNsfwDetectionConfigPage extends MyScreenPageLimited<AdminNsfwDetectionConfig> {
  EditNsfwDetectionConfigPage(AdminNsfwDetectionConfig config)
    : super(builder: (closer) => EditNsfwDetectionConfigScreen(config, closer));
}

class EditNsfwDetectionConfigScreen extends StatefulWidget {
  final AdminNsfwDetectionConfig initialConfig;
  final PageCloser<AdminNsfwDetectionConfig> closer;
  const EditNsfwDetectionConfigScreen(this.initialConfig, this.closer, {super.key});

  @override
  State<EditNsfwDetectionConfigScreen> createState() => _EditNsfwDetectionConfigScreenState();
}

class _EditNsfwDetectionConfigScreenState extends State<EditNsfwDetectionConfigScreen> {
  late AdminNsfwDetectionConfig _config;

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
      appBar: AppBar(title: const Text("NSFW Detection Config")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _section(
              "Accept Thresholds",
              _config.accept,
              (v) => setState(() => _config.accept = v),
            ),
            _section(
              "Delete Thresholds",
              _config.delete,
              (v) => setState(() => _config.delete = v),
            ),
            _section(
              "Move to Human Thresholds",
              _config.moveToHuman,
              (v) => setState(() => _config.moveToHuman = v),
            ),
            _section(
              "Reject Thresholds",
              _config.reject,
              (v) => setState(() => _config.reject = v),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(
    String title,
    NsfwDetectionThresholds thresholds,
    void Function(NsfwDetectionThresholds) onChanged,
  ) {
    return ExpansionTile(
      title: Text(title),
      subtitle: ViewNsfwThresholds(thresholds: thresholds),
      children: [hPad(EditNsfwThresholds(thresholds: thresholds, onChanged: onChanged))],
    );
  }
}
