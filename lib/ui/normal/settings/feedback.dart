import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/settings/feedback.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/settings/feedback.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/ui_utils/list.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void openFeedbackScreen(BuildContext context) {
  MyNavigator.push(context, FeedbackPage());
}

class FeedbackPage extends MyScreenPage<()> with SimpleUrlParser<FeedbackPage> {
  FeedbackPage() : super(builder: (closer) => FeedbackScreenOpener(closer: closer));

  @override
  FeedbackPage create() => FeedbackPage();
}

class FeedbackScreenOpener extends StatelessWidget {
  final PageCloser<()> closer;
  const FeedbackScreenOpener({required this.closer, super.key});

  @override
  Widget build(BuildContext context) {
    return FeedbackScreen(feedbackBloc: context.read<FeedbackBloc>(), closer: closer);
  }
}

class FeedbackScreen extends StatefulWidget {
  final FeedbackBloc feedbackBloc;
  final PageCloser<()> closer;
  const FeedbackScreen({required this.feedbackBloc, required this.closer, super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bodyController.addListener(_onBodyChanged);
    // The bloc is provided globally so that the loading dialog can access it.
    // Reset the form and load the config every time the screen opens.
    widget.feedbackBloc.add(ResetFeedback());
    widget.feedbackBloc.add(LoadFeedbackConfig());
  }

  void _onBodyChanged() {
    widget.feedbackBloc.add(UpdateFeedbackBody(_bodyController.text));
  }

  @override
  void dispose() {
    _bodyController.removeListener(_onBodyChanged);
    _bodyController.dispose();
    super.dispose();
  }

  void _submit() {
    final state = widget.feedbackBloc.state;
    if (state.body.trim().isEmpty) {
      showSnackBar(context.strings.feedback_screen_body_required);
      return;
    }
    widget.feedbackBloc.add(SubmitFeedback());
  }

  @override
  Widget build(BuildContext context) {
    return updateStateHandler<FeedbackBloc, FeedbackData>(
      context: context,
      pageKey: widget.closer.key,
      child: BlocBuilder<FeedbackBloc, FeedbackData>(
        builder: (context, data) {
          final dataEditingDetected = data.unsavedChanges();

          return PopScope(
            canPop: !dataEditingDetected,
            onPopInvokedWithResult: (didPop, _) {
              if (didPop) {
                return;
              }
              showConfirmDialog(
                context,
                context.strings.feedback_screen_send_confirmation_title,
                yesNoActions: true,
              ).then((value) {
                if (!context.mounted) {
                  return;
                }
                if (value == true) {
                  _submit();
                  // updateStateHandler closes FeedbackScreen
                } else if (value == false) {
                  widget.closer.close(context, ());
                }
              });
            },
            child: Scaffold(
              appBar: AppBar(title: Text(context.strings.settings_screen_send_feedback_title)),
              body: content(context, data),
            ),
          );
        },
      ),
    );
  }

  Widget content(BuildContext context, FeedbackData data) {
    final config = data.config;
    // Keep showing the form when a reload is in progress or fails if the
    // config has been loaded at least once.
    if (config.config == null) {
      if (config.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (config.isError) {
        return buildListReplacementMessageSimple(context, context.strings.generic_error_occurred);
      }
    }
    if (!config.available()) {
      return buildListReplacementMessageSimple(
        context,
        context.strings.feedback_screen_sending_disabled,
      );
    }
    return form(context, data);
  }

  Widget form(BuildContext context, FeedbackData data) {
    final categories = data.categories();
    final selectedKey = categories.any((c) => c.key == data.categoryKey) ? data.categoryKey : null;
    final maxLength = data.bodyMaxLength();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<String>(
            // Recreate the field when the selection changes outside of the
            // dropdown (e.g. the selected category was removed from the server
            // config) so that the shown value stays valid.
            key: ValueKey(selectedKey),
            initialValue: selectedKey,
            hint: Text(context.strings.feedback_screen_category_hint),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: context.strings.feedback_screen_category_label,
            ),
            items: [
              for (final c in categories)
                DropdownMenuItem(value: c.key, child: Text(c.name.toLocalizedText(context))),
            ],
            onChanged: (value) {
              if (value != null) {
                widget.feedbackBloc.add(SelectFeedbackCategory(value));
              }
            },
          ),
          const Padding(padding: EdgeInsets.only(top: 16)),
          TextField(
            controller: _bodyController,
            enabled: selectedKey != null,
            minLines: 5,
            maxLines: null,
            maxLength: maxLength > 0 ? maxLength : null,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: context.strings.feedback_screen_body_label,
              helperText: selectedKey == null
                  ? context.strings.feedback_screen_category_required
                  : null,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 16)),
          FilledButton(
            onPressed: data.unsavedChanges() ? _submit : null,
            child: Text(context.strings.feedback_screen_send_button),
          ),
        ],
      ),
    );
  }
}
