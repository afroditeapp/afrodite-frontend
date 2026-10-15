import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

class ReportCustomReportStringPage extends MyScreenPageLimited<()> {
  ReportCustomReportStringPage({required AccountId accountId, required CustomReport report})
    : super(
        builder: (closer) =>
            ReportCustomReportStringScreen(accountId: accountId, report: report, closer: closer),
      );
}

class ReportCustomReportStringScreen extends StatefulWidget {
  final AccountId accountId;
  final CustomReport report;
  final PageCloser<()> closer;
  const ReportCustomReportStringScreen({
    required this.accountId,
    required this.report,
    required this.closer,
    super.key,
  });

  @override
  State<ReportCustomReportStringScreen> createState() => _ReportCustomReportStringScreenState();
}

class _ReportCustomReportStringScreenState extends State<ReportCustomReportStringScreen> {
  /// Maximum length of custom report string content in grapheme clusters.
  static const int _maxReportContentLength = 200;

  final TextEditingController _contentController = TextEditingController();
  bool _isSending = false;

  /// Report content with whitespace trimmed and consecutive newlines reduced.
  String get _processedContent {
    final text = _contentController.text.trim();
    return text.replaceAll(RegExp(r'\n{3,}'), '\n\n');
  }

  bool get _hasContent => _processedContent.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _contentController.addListener(_onContentChanged);
  }

  void _onContentChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _contentController.removeListener(_onContentChanged);
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _confirmDiscardUnsavedChanges() async {
    final r = await showConfirmDialog(
      context,
      context.strings.report_custom_report_string_screen_discard_changes_dialog_title,
      yesNoActions: true,
    );
    if (r == true && mounted) {
      widget.closer.close(context, ());
    }
  }

  Future<void> _sendReport() async {
    final r = await showConfirmDialog(
      context,
      context.strings.generic_report_verb_question,
      details: _processedContent,
      yesNoActions: true,
      scrollable: true,
    );
    if (!mounted || r != true) return;

    setState(() => _isSending = true);

    final repositories = context.read<RepositoryInstances>();
    final result = await repositories.api
        .account(
          (api) => api.postCustomReportString(
            UpdateCustomReportString(
              content: _processedContent,
              customReportId: widget.report.id,
              target: widget.accountId,
            ),
          ),
        )
        .ok();

    if (!mounted) return;

    if (result == null) {
      setState(() => _isSending = false);
      showSnackBar(R.strings.generic_error_occurred);
    } else if (result.errorOutdatedReportContent) {
      // Should not happen as the report is sent with user typed content.
      setState(() => _isSending = false);
      showSnackBar(R.strings.generic_error);
    } else if (result.errorTooManyReports) {
      setState(() => _isSending = false);
      showSnackBar(R.strings.report_screen_snackbar_too_many_reports_error);
    } else if (result.error) {
      setState(() => _isSending = false);
      showSnackBar(R.strings.generic_error_occurred);
    } else {
      showSnackBar(R.strings.report_screen_snackbar_report_successful);
      widget.closer.close(context, ());
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasContent && !_isSending,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (_isSending) {
          showSnackBar(R.strings.generic_previous_action_in_progress);
        } else if (_hasContent) {
          await _confirmDiscardUnsavedChanges();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.strings.generic_report_verb)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _contentController,
                minLines: 3,
                maxLines: null,
                maxLength: _maxReportContentLength,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: context.strings.report_custom_report_string_screen_text_field_label,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 8)),
              FilledButton(
                onPressed: (_isSending || !_hasContent) ? null : _sendReport,
                child: _isSending
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(context.strings.generic_report_verb),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
