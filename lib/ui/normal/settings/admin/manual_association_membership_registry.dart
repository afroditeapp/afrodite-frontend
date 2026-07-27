import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class ManualAssociationMembershipRegistryPage extends MyScreenPageLimited<()> {
  final bool canEdit;
  ManualAssociationMembershipRegistryPage(RepositoryInstances r, {this.canEdit = false})
    : super(builder: (_) => ManualAssociationMembershipRegistryScreen(r.api, canEdit: canEdit));
}

class ManualAssociationMembershipRegistryScreen extends StatefulWidget {
  final ApiManager api;
  final bool canEdit;
  const ManualAssociationMembershipRegistryScreen(this.api, {super.key, this.canEdit = false});

  @override
  State<ManualAssociationMembershipRegistryScreen> createState() =>
      _ManualAssociationMembershipRegistryScreenState();
}

class _ManualAssociationMembershipRegistryScreenState
    extends State<ManualAssociationMembershipRegistryScreen> {
  final _controller = TextEditingController();
  String _originalValue = '';
  bool _isLoading = true;
  bool _isSaving = false;
  bool _isError = false;

  bool get _hasUnsavedChanges => _controller.text != _originalValue;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (_isSaving) return;
    setState(() {});
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    final data = await widget.api
        .accountAdmin((api) => api.getManualAssociationMembershipRegistry())
        .ok();

    if (!mounted) return;

    if (data == null) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    } else {
      setState(() {
        _isLoading = false;
        _controller.text = data.registry;
        _originalValue = data.registry;
      });
    }
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);

    final result = await widget.api
        .accountAdminAction(
          (api) => api.postManualAssociationMembershipRegistry(
            ManualAssociationMembershipRegistryInput(registry: _controller.text),
          ),
        )
        .ok();

    if (!mounted) return;

    setState(() => _isSaving = false);

    if (result == null) {
      showSnackBar("Failed to save registry");
    } else {
      _originalValue = _controller.text;
      showSnackBar("Registry saved");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Association membership registry (manual)")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_isError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Failed to load registry"),
            TextButton(onPressed: _load, child: const Text("Retry")),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: const InputDecoration(
                hintText: "Enter registry data...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        if (widget.canEdit)
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: (_isSaving || !_hasUnsavedChanges) ? null : _save,
                child: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("Save"),
              ),
            ),
          ),
      ],
    );
  }
}
