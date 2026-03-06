import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openapi/api.dart';

String _normalizeBannerKeyValue(String value) {
  return value.toLowerCase().replaceAll(RegExp(r'\s'), '_');
}

class _BannerKeyTextInputFormatter extends TextInputFormatter {
  const _BannerKeyTextInputFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final normalized = _normalizeBannerKeyValue(newValue.text);

    final selectionEnd = newValue.selection.end.clamp(0, newValue.text.length);
    final prefix = newValue.text.substring(0, selectionEnd);
    final normalizedPrefix = _normalizeBannerKeyValue(prefix);

    return TextEditingValue(
      text: normalized,
      selection: TextSelection.collapsed(offset: normalizedPrefix.length),
      composing: TextRange.empty,
    );
  }
}

class AddInfoBannerPage extends MyScreenPageLimited<(String, InfoBanner)> {
  AddInfoBannerPage() : super(builder: (closer) => AddInfoBannerScreen(closer));
}

class AddInfoBannerScreen extends StatefulWidget {
  final PageCloser<(String, InfoBanner)> closer;

  const AddInfoBannerScreen(this.closer, {super.key});

  @override
  State<AddInfoBannerScreen> createState() => _AddInfoBannerScreenState();
}

class _AddInfoBannerScreenState extends State<AddInfoBannerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _keyController = TextEditingController();
  final _bodyController = TextEditingController();

  Future<void> _saveAndClose() async {
    if (_formKey.currentState?.validate() != true) {
      showSnackBar("Please fix the errors in the form before saving.");
      return;
    }

    final key = _normalizeBannerKeyValue(_keyController.text.trim());

    final banner = InfoBanner(
      mode: InfoBannerMode.text,
      platform: BannerPlatform(android: true, ios: true, web: true),
      text: TextInfoBanner(
        body: StringResource(default_: _bodyController.text.trim(), translations: {}),
        icon: null,
        urlButton: null,
      ),
      version: 0,
      visibility: BannerVisibility(
        chats: true,
        conversation: true,
        likes: true,
        menu: true,
        profiles: true,
      ),
    );

    widget.closer.close(context, (key, banner));
  }

  Future<void> _confirmCancel() async {
    final confirmed = await showConfirmDialog(context, "Discard changes?");
    if (confirmed == true && mounted) {
      MyNavigator.removePage(context, widget.closer.key, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) {
          return;
        }
        await _confirmCancel();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add info banner"),
          actions: [
            IconButton(onPressed: _confirmCancel, icon: const Icon(Icons.close)),
            IconButton(onPressed: _saveAndClose, icon: const Icon(Icons.check)),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              TextFormField(
                controller: _keyController,
                decoration: const InputDecoration(labelText: "Key", border: OutlineInputBorder()),
                inputFormatters: const [_BannerKeyTextInputFormatter()],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  labelText: "Body (default)",
                  border: OutlineInputBorder(),
                ),
                minLines: 2,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _keyController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}
