import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/custom_reports_config.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui/normal/report/report_chat_message.dart';
import 'package:app/ui/normal/report/report_profile_image.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

Widget showReportAction(BuildContext context, ProfileEntry profile) {
  return MenuItemButton(
    onPressed: () async {
      final chat = context.read<RepositoryInstances>().chat;
      final isMatch = await chat.isInMatches(profile.accountId);
      final messages = await chat.getAllMessages(profile.accountId);
      if (!context.mounted) {
        return;
      }
      await MyNavigator.push(
        context,
        MaterialPage<void>(
          child: ReportScreen(profile: profile, isMatch: isMatch, messages: messages),
        ),
      );
    },
    child: Text(context.strings.report_screen_title),
  );
}

class ReportScreen extends StatefulWidget {
  final ProfileEntry profile;
  final bool isMatch;
  final List<MessageEntry> messages;
  const ReportScreen({
    required this.profile,
    required this.isMatch,
    required this.messages,
    super.key,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.report_screen_title)),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<CustomReportsConfigBloc, CustomReportsConfig>(
        builder: (context, state) {
          final settings = reportList(context, state);
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [...settings]);
        },
      ),
    );
  }

  List<Widget> reportList(BuildContext context, CustomReportsConfig config) {
    List<Widget> settings = [];

    final repositories = context.read<RepositoryInstances>();

    if (widget.profile.name.isNotEmpty) {
      settings.add(
        reportListTile(context.strings.report_screen_profile_name_action, () async {
          final r = await showConfirmDialog(
            context,
            context.strings.report_screen_profile_name_dialog_title,
            details: widget.profile.profileNameOrFirstCharacterProfileName(),
            yesNoActions: true,
            scrollable: true,
          );
          if (context.mounted && r == true) {
            final result = await repositories.api
                .profile(
                  (api) => api.postReportProfileName(
                    UpdateProfileNameReport(
                      target: widget.profile.accountId,
                      profileName: widget.profile.name,
                    ),
                  ),
                )
                .ok();

            if (result == null) {
              showSnackBar(R.strings.generic_error_occurred);
            } else if (result.errorOutdatedReportContent) {
              showSnackBar(R.strings.report_screen_profile_name_changed_error);
            } else if (result.errorTooManyReports) {
              showSnackBar(R.strings.report_screen_snackbar_too_many_reports_error);
            } else {
              showSnackBar(R.strings.report_screen_snackbar_report_successful);
              await repositories.profile.downloadProfileToDatabase(
                repositories.chat,
                widget.profile.accountId,
              );
            }
          }
        }),
      );
    }

    if (widget.profile.profileText.isNotEmpty) {
      settings.add(
        reportListTile(context.strings.report_screen_profile_text_action, () async {
          final r = await showConfirmDialog(
            context,
            context.strings.report_screen_profile_text_dialog_title,
            details: widget.profile.profileTextOrFirstCharacterProfileText(),
            yesNoActions: true,
            scrollable: true,
          );
          if (context.mounted && r == true) {
            final result = await repositories.api
                .profile(
                  (api) => api.postReportProfileText(
                    UpdateProfileTextReport(
                      target: widget.profile.accountId,
                      profileText: widget.profile.profileText,
                    ),
                  ),
                )
                .ok();

            if (result == null) {
              showSnackBar(R.strings.generic_error_occurred);
            } else if (result.errorOutdatedReportContent) {
              showSnackBar(R.strings.report_screen_profile_text_changed_error);
            } else if (result.errorTooManyReports) {
              showSnackBar(R.strings.report_screen_snackbar_too_many_reports_error);
            } else {
              showSnackBar(R.strings.report_screen_snackbar_report_successful);
              await repositories.profile.downloadProfileToDatabase(
                repositories.chat,
                widget.profile.accountId,
              );
            }
          }
        }),
      );
    }

    final acceptedContent = widget.profile.content.where((v) => v.accepted);
    if (acceptedContent.isNotEmpty) {
      settings.add(
        reportListTile(context.strings.report_screen_profile_image_action, () {
          MyNavigator.push(
            context,
            MaterialPage<void>(
              child: ReportProfileImageScreen(
                profileEntry: widget.profile,
                isMatch: widget.isMatch,
              ),
            ),
          );
        }),
      );
    }

    if (widget.messages.isNotEmpty) {
      settings.add(
        reportListTile(context.strings.report_screen_chat_message_action, () {
          MyNavigator.push(
            context,
            MaterialPage<void>(
              child: ReportChatMessageScreen(
                profileEntry: widget.profile,
                messages: widget.messages,
              ),
            ),
          );
        }),
      );
    }

    final availableReports = [
      ...config.report.where((v) => v.reportType == CustomReportType.empty && v.visible),
    ];

    availableReports.sort((a, b) => a.orderNumber.compareTo(b.orderNumber));

    for (final report in availableReports) {
      final name = report.translatedName(context);
      settings.add(
        reportListTile(report.translatedName(context), () async {
          final r = await showConfirmDialog(
            context,
            context.strings.report_screen_custom_report_boolean_dialog_title,
            details: context.strings.report_screen_custom_report_boolean_dialog_description(name),
            yesNoActions: true,
          );
          if (context.mounted && r == true) {
            final result = await repositories.api
                .account(
                  (api) => api.postCustomReportEmpty(
                    UpdateCustomReportEmpty(
                      customReportId: report.id,
                      target: widget.profile.accountId,
                    ),
                  ),
                )
                .ok();

            if (result == null) {
              showSnackBar(R.strings.generic_error_occurred);
            } else if (result.errorOutdatedReportContent) {
              // Should not happen as the report value is a boolean.
              showSnackBar(R.strings.generic_error);
            } else if (result.errorTooManyReports) {
              // Should not happen as the report is ignored when sending
              // again the same boolean report with the same value.
              showSnackBar(R.strings.report_screen_snackbar_too_many_reports_error);
            } else {
              showSnackBar(R.strings.report_screen_snackbar_report_successful);
            }
          }
        }),
      );
    }

    return settings;
  }

  Widget reportListTile(String text, void Function() action) {
    return ListTile(onTap: action, title: Text(text));
  }
}
