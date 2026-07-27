import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/account/association_membership.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/association_membership.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:openapi/api.dart';
import 'package:url_launcher/url_launcher_string.dart';

void openAssociationMembershipSettings(BuildContext context) {
  final r = context.read<RepositoryInstances>();
  MyNavigator.push(context, AssociationMembershipPage(r));
}

class AssociationMembershipPage extends MyScreenPage<()> {
  final RepositoryInstances r;
  AssociationMembershipPage(this.r)
    : super(builder: (_) => _AssociationMembershipScreenLoader(r: r));
}

class _AssociationMembershipScreenLoader extends StatefulWidget {
  final RepositoryInstances r;
  const _AssociationMembershipScreenLoader({required this.r});

  @override
  State<_AssociationMembershipScreenLoader> createState() =>
      _AssociationMembershipScreenLoaderState();
}

class _AssociationMembershipScreenLoaderState extends State<_AssociationMembershipScreenLoader> {
  @override
  void initState() {
    super.initState();
    context.read<AssociationMembershipBloc>().add(ReloadMembership());
  }

  @override
  Widget build(BuildContext context) {
    return AssociationMembershipScreen();
  }
}

class AssociationMembershipScreen extends StatelessWidget {
  const AssociationMembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return updateStateHandler<AssociationMembershipBloc, AssociationMembershipBlocData>(
      context: context,
      pageKey: null,
      child: Scaffold(
        appBar: AppBar(title: Text(context.strings.association_membership_screen_title)),
        body: BlocBuilder<AssociationMembershipBloc, AssociationMembershipBlocData>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            final config = state.config;
            if (state.isError || state.config == null || config == null) {
              return Center(child: Text(context.strings.generic_error));
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: AssociationMembershipContent(
                  config: config,
                  membership: state.membership,
                  membersOnlyInfo: state.membersOnlyInfo,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AssociationMembershipContent extends StatelessWidget {
  final AssociationConfig config;
  final AssociationMembership? membership;
  final GetAssociationMembersOnlyInfo? membersOnlyInfo;

  const AssociationMembershipContent({
    required this.config,
    this.membership,
    this.membersOnlyInfo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(context, config.associationName.toLocalizedText(context)),
        if (config.associationInfoMarkdown != null) ...[
          const Padding(padding: EdgeInsets.all(8)),
          MarkdownBody(
            data: config.associationInfoMarkdown!.toLocalizedText(context),
            onTapLink: (text, href, title) {
              if (href != null) launchUrlString(href);
            },
          ),
        ],
        if (membership != null && membersOnlyInfo?.infoMarkdown != null) ...[
          const Padding(padding: EdgeInsets.all(8)),
          MarkdownBody(
            data: membersOnlyInfo!.infoMarkdown!.toLocalizedText(context),
            onTapLink: (text, href, title) {
              if (href != null) launchUrlString(href);
            },
          ),
        ],
        const Divider(),
        if (membership == null) _buildJoinForm(context),
        if (membership != null) _buildMembershipInfo(context),
      ],
    );
  }

  Widget _buildJoinForm(BuildContext context) {
    if (!config.userCanJoinAssociation) {
      return const SizedBox.shrink();
    }

    final userTypes = config.membershipTypes.where((t) => !t.adminOnly).toList();
    if (userTypes.isEmpty) {
      return Text(context.strings.generic_error);
    }

    return _JoinForm(config: config, userSelectableTypes: userTypes);
  }

  Widget _buildMembershipInfo(BuildContext context) {
    if (!config.userCanViewExistingMembership) {
      return const SizedBox.shrink();
    }

    return _MembershipInfo(config: config, membership: membership!);
  }

  Widget _sectionTitle(BuildContext context, String text) {
    return Text(text, style: Theme.of(context).textTheme.titleLarge);
  }
}

class _JoinForm extends StatefulWidget {
  final AssociationConfig config;
  final List<MembershipType> userSelectableTypes;
  const _JoinForm({required this.config, required this.userSelectableTypes});

  @override
  State<_JoinForm> createState() => _JoinFormState();
}

class _JoinFormState extends State<_JoinForm> {
  final _fullNameController = TextEditingController();
  final _domicileController = TextEditingController();
  int _selectedMembershipType = 0;

  @override
  void initState() {
    super.initState();
    _selectedMembershipType = widget.userSelectableTypes.first.id;
    _fullNameController.addListener(_onFieldChanged);
    _domicileController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _fullNameController.removeListener(_onFieldChanged);
    _domicileController.removeListener(_onFieldChanged);
    _fullNameController.dispose();
    _domicileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.config.membershipInfoMarkdown != null) ...[
          MarkdownBody(
            data: widget.config.membershipInfoMarkdown!.toLocalizedText(context),
            onTapLink: (text, href, title) {
              if (href != null) launchUrlString(href);
            },
          ),
          const Padding(padding: EdgeInsets.all(8)),
        ],
        TextField(
          controller: _fullNameController,
          decoration: InputDecoration(
            labelText: context.strings.association_membership_screen_full_name_label,
          ),
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
        ),
        const Padding(padding: EdgeInsets.all(8)),
        TextField(
          controller: _domicileController,
          decoration: InputDecoration(
            labelText: context.strings.association_membership_screen_domicile_label,
          ),
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
        ),
        const Padding(padding: EdgeInsets.all(8)),
        DropdownButtonFormField<int>(
          initialValue: _selectedMembershipType,
          decoration: InputDecoration(
            labelText: context.strings.association_membership_screen_membership_type_label,
          ),
          items: widget.userSelectableTypes.map((t) {
            return DropdownMenuItem<int>(
              value: t.id,
              child: Text(t.title.toLocalizedText(context)),
            );
          }).toList(),
          onChanged: (v) {
            setState(() {
              if (v != null) _selectedMembershipType = v;
            });
          },
        ),
        const Padding(padding: EdgeInsets.all(16)),
        ElevatedButton(
          onPressed:
              _fullNameController.text.trim().isEmpty || _domicileController.text.trim().isEmpty
              ? null
              : () {
                  context.read<AssociationMembershipBloc>().add(
                    JoinAssociation(
                      _fullNameController.text.trim(),
                      _domicileController.text.trim(),
                      _selectedMembershipType,
                    ),
                  );
                },
          child: Text(context.strings.association_membership_screen_join_button),
        ),
      ],
    );
  }
}

class _MembershipInfo extends StatefulWidget {
  final AssociationConfig config;
  final AssociationMembership membership;
  const _MembershipInfo({required this.config, required this.membership});

  @override
  State<_MembershipInfo> createState() => _MembershipInfoState();
}

class _MembershipInfoState extends State<_MembershipInfo> {
  late TextEditingController _fullNameController;
  late TextEditingController _domicileController;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.membership.fullName);
    _domicileController = TextEditingController(text: widget.membership.domicile);
    _fullNameController.addListener(_onFieldChanged);
    _domicileController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    final changed =
        _fullNameController.text.trim() != (widget.membership.fullName ?? "") ||
        _domicileController.text.trim() != (widget.membership.domicile ?? "");
    if (changed != _hasChanges) {
      setState(() => _hasChanges = changed);
    }
  }

  @override
  void dispose() {
    _fullNameController.removeListener(_onFieldChanged);
    _domicileController.removeListener(_onFieldChanged);
    _fullNameController.dispose();
    _domicileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editable = widget.config.userCanEditExistingMembership;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.strings.association_membership_screen_current_membership_title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Padding(padding: EdgeInsets.all(8)),
        if (editable)
          TextField(
            controller: _fullNameController,
            decoration: InputDecoration(
              labelText: context.strings.association_membership_screen_full_name_label,
            ),
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
          )
        else
          Text(
            '${context.strings.association_membership_screen_full_name_label}: ${widget.membership.fullName ?? ""}',
          ),
        const Padding(padding: EdgeInsets.all(8)),
        if (editable)
          TextField(
            controller: _domicileController,
            decoration: InputDecoration(
              labelText: context.strings.association_membership_screen_domicile_label,
            ),
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
          )
        else
          Text(
            '${context.strings.association_membership_screen_domicile_label}: ${widget.membership.domicile ?? ""}',
          ),
        const Padding(padding: EdgeInsets.all(8)),
        Text(
          '${context.strings.association_membership_screen_membership_type_label}: ${_membershipTypeTitle(context)}',
        ),
        if (editable) ...[
          const Padding(padding: EdgeInsets.all(16)),
          ElevatedButton(
            onPressed: _hasChanges
                ? () {
                    context.read<AssociationMembershipBloc>().add(
                      UpdateMembership(
                        _fullNameController.text.trim(),
                        _domicileController.text.trim(),
                      ),
                    );
                  }
                : null,
            child: Text(context.strings.generic_save),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          ElevatedButton(
            onPressed: () async {
              final confirmed = await showConfirmDialog(
                context,
                context.strings.association_membership_screen_end_membership_confirm_title,
              );
              if (context.mounted && confirmed == true) {
                context.read<AssociationMembershipBloc>().add(EndMembership());
              }
            },
            child: Text(context.strings.association_membership_screen_end_membership_button),
          ),
        ],
      ],
    );
  }

  String _membershipTypeTitle(BuildContext context) {
    final type = widget.config.membershipTypes
        .where((t) => t.id == widget.membership.membershipType)
        .firstOrNull;
    return type?.title.toLocalizedText(context) ?? widget.membership.membershipType.toString();
  }
}
