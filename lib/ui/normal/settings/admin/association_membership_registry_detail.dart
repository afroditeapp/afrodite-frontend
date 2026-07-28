import 'package:app/api/server_connection_manager.dart';
import 'package:app/logic/account/client_features_config.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/ui_utils/time.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/ui_utils/extensions/locale.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

class AssociationMemberDetailPage extends MyScreenPageLimited<()> {
  final ApiManager api;
  final AccountId accountId;
  final bool canEdit;
  AssociationMemberDetailPage(this.api, this.accountId, {this.canEdit = false})
    : super(
        builder: (closer) =>
            _AssociationMemberDetailScreen(api, accountId, closer, canEdit: canEdit),
      );
}

class _AssociationMemberDetailScreen extends StatefulWidget {
  final ApiManager api;
  final AccountId accountId;
  final PageCloser<()> closer;
  final bool canEdit;
  const _AssociationMemberDetailScreen(
    this.api,
    this.accountId,
    this.closer, {
    this.canEdit = false,
  });

  @override
  State<_AssociationMemberDetailScreen> createState() => _AssociationMemberDetailScreenState();
}

class _AssociationMemberDetailScreenState extends State<_AssociationMemberDetailScreen> {
  bool _isLoading = true;
  bool _isError = false;
  bool _isSaving = false;
  AssociationMember? _member;
  List<MembershipType> _membershipTypes = [];
  int _selectedType = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    final data = await widget.api
        .accountAdmin((api) => api.postGetAssociationMember(widget.accountId))
        .ok();

    if (!mounted) return;

    if (data == null || data.member == null) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
      return;
    }

    final config = context.read<ClientFeaturesConfigBloc>().state.config.association;
    final types = config?.membershipTypes ?? [];

    setState(() {
      _isLoading = false;
      _member = data.member;
      _membershipTypes = types;
      _selectedType = data.member!.membershipType;
    });
  }

  Future<void> _updateMembershipType() async {
    if (_member == null || _selectedType == _member!.membershipType) return;

    final confirmed = await showConfirmDialog(context, "Update membership type?");
    if (confirmed != true) return;

    setState(() => _isSaving = true);

    await widget.api.accountAdminAction(
      (api) => api.postUpdateAssociationMembershipType(
        UpdateAssociationMembershipType(member: widget.accountId, membershipType: _selectedType),
      ),
    );

    if (!mounted) return;

    setState(() => _isSaving = false);
    showSnackBar("Membership type updated");
    await _load();
  }

  Future<void> _deleteMembership() async {
    final confirmed = await showConfirmDialog(
      context,
      "Delete this membership?",
      details: "This cannot be undone.",
    );
    if (confirmed != true) return;

    setState(() => _isSaving = true);

    await widget.api.accountAdminAction(
      (api) => api.postDeleteAssociationMembership(widget.accountId),
    );

    if (!mounted) return;

    setState(() => _isSaving = false);
    showSnackBar("Membership deleted");
    widget.closer.close(context, ());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Association member")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_isError || _member == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Failed to load member"),
            TextButton(onPressed: _load, child: const Text("Retry")),
          ],
        ),
      );
    }

    final m = _member!;
    final localeString = Localizations.localeOf(context).localeString();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow("Account ID", m.aidMember.aid),
          if (m.fullName != null) _infoRow("Full name", m.fullName!),
          if (m.domicile != null) _infoRow("Domicile", m.domicile!),
          if (m.email != null) _infoRow("Email", m.email!),
          _infoRow("Membership type", _membershipTypeTitle(context)),
          if (m.aidCreator != null) _infoRow("Created by", m.aidCreator!.aid),
          if (m.aidEditor != null) _infoRow("Last edited by", m.aidEditor!.aid),
          _infoRow("Created", fullTimeString(m.creationUnixTime.toUtcDateTime(), localeString)),
          _infoRow("Last edited", fullTimeString(m.editUnixTime.toUtcDateTime(), localeString)),
          if (widget.canEdit) ...[
            const Divider(),
            Text("Edit membership type", style: Theme.of(context).textTheme.titleMedium),
            const Padding(padding: EdgeInsets.all(8)),
            DropdownButtonFormField<int>(
              initialValue: _selectedType,
              decoration: const InputDecoration(
                labelText: "Membership type",
                border: OutlineInputBorder(),
              ),
              items: _membershipTypes.map((t) {
                return DropdownMenuItem<int>(
                  value: t.id,
                  child: Text(t.title.toLocalizedText(context)),
                );
              }).toList(),
              onChanged: (v) {
                if (v != null) {
                  setState(() => _selectedType = v);
                }
              },
            ),
            const Padding(padding: EdgeInsets.all(16)),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isSaving || _selectedType == _member!.membershipType
                    ? null
                    : _updateMembershipType,
                child: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("Save"),
              ),
            ),
            const Padding(padding: EdgeInsets.all(8)),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _isSaving ? null : _deleteMembership,
                style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                child: const Text("Delete membership"),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _membershipTypeTitle(BuildContext context) {
    if (_member == null) return "";
    final type = _membershipTypes.where((t) => t.id == _member!.membershipType).firstOrNull;
    return type?.title.toLocalizedText(context) ?? _member!.membershipType.toString();
  }
}
