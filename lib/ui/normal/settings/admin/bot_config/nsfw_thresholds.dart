import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class EditNsfwThresholds extends StatefulWidget {
  final NsfwDetectionThresholds thresholds;
  final void Function(NsfwDetectionThresholds) onChanged;
  const EditNsfwThresholds({required this.thresholds, required this.onChanged, super.key});

  @override
  State<EditNsfwThresholds> createState() => _EditNsfwThresholdsState();
}

class _EditNsfwThresholdsState extends State<EditNsfwThresholds> {
  late TextEditingController drawingsController;
  late TextEditingController hentaiController;
  late TextEditingController neutralController;
  late TextEditingController pornController;
  late TextEditingController sexyController;

  @override
  void initState() {
    super.initState();
    drawingsController = TextEditingController(text: widget.thresholds.drawings?.toString() ?? "");
    hentaiController = TextEditingController(text: widget.thresholds.hentai?.toString() ?? "");
    neutralController = TextEditingController(text: widget.thresholds.neutral?.toString() ?? "");
    pornController = TextEditingController(text: widget.thresholds.porn?.toString() ?? "");
    sexyController = TextEditingController(text: widget.thresholds.sexy?.toString() ?? "");
  }

  @override
  void didUpdateWidget(EditNsfwThresholds oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.thresholds != oldWidget.thresholds) {
      if (drawingsController.text != (widget.thresholds.drawings?.toString() ?? "")) {
        drawingsController.text = widget.thresholds.drawings?.toString() ?? "";
      }
      if (hentaiController.text != (widget.thresholds.hentai?.toString() ?? "")) {
        hentaiController.text = widget.thresholds.hentai?.toString() ?? "";
      }
      if (neutralController.text != (widget.thresholds.neutral?.toString() ?? "")) {
        neutralController.text = widget.thresholds.neutral?.toString() ?? "";
      }
      if (pornController.text != (widget.thresholds.porn?.toString() ?? "")) {
        pornController.text = widget.thresholds.porn?.toString() ?? "";
      }
      if (sexyController.text != (widget.thresholds.sexy?.toString() ?? "")) {
        sexyController.text = widget.thresholds.sexy?.toString() ?? "";
      }
    }
  }

  @override
  void dispose() {
    drawingsController.dispose();
    hentaiController.dispose();
    neutralController.dispose();
    pornController.dispose();
    sexyController.dispose();
    super.dispose();
  }

  void _notifyChanges() {
    widget.onChanged(
      NsfwDetectionThresholds(
        drawings: double.tryParse(drawingsController.text),
        hentai: double.tryParse(hentaiController.text),
        neutral: double.tryParse(neutralController.text),
        porn: double.tryParse(pornController.text),
        sexy: double.tryParse(sexyController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _thresholdField("Drawings", drawingsController),
        _thresholdField("Hentai", hentaiController),
        _thresholdField("Neutral", neutralController),
        _thresholdField("Porn", pornController),
        _thresholdField("Sexy", sexyController),
      ],
    );
  }

  Widget _thresholdField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: (_) => _notifyChanges(),
      ),
    );
  }
}

class ViewNsfwThresholds extends StatelessWidget {
  final NsfwDetectionThresholds? thresholds;
  const ViewNsfwThresholds({this.thresholds, super.key});

  @override
  Widget build(BuildContext context) {
    if (thresholds == null) {
      return const Text("No thresholds defined");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (thresholds?.drawings != null) Text("Drawings: ${thresholds?.drawings}"),
        if (thresholds?.hentai != null) Text("Hentai: ${thresholds?.hentai}"),
        if (thresholds?.neutral != null) Text("Neutral: ${thresholds?.neutral}"),
        if (thresholds?.porn != null) Text("Porn: ${thresholds?.porn}"),
        if (thresholds?.sexy != null) Text("Sexy: ${thresholds?.sexy}"),
      ],
    );
  }
}
