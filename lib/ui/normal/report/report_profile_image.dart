
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/data/login_repository.dart';
import 'package:database/database.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/dialog.dart';

class ReportProfileImageScreen extends StatefulWidget {
  final ProfileEntry profileEntry;
  final bool isMatch;
  const ReportProfileImageScreen({
    required this.profileEntry,
    required this.isMatch,
    super.key,
  });

  @override
  State<ReportProfileImageScreen> createState() => _ReportProfileImageScreen();
}

const _IMG_SIZE = 100.0;

class _ReportProfileImageScreen extends State<ReportProfileImageScreen> {
  final api = LoginRepository.getInstance().repositories.api;
  final chat = LoginRepository.getInstance().repositories.chat;
  final profile = LoginRepository.getInstance().repositories.profile;

  List<(int, ContentIdAndAccepted)> images = [];

  @override
  void initState() {
    super.initState();
    images = widget.profileEntry.content.indexed.where((v) => v.$2.accepted).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.report_screen_title)),
      body: list(context),
    );
  }

  Widget list(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        final (i, img) = images[index];
        final imageNumber = i + 1;
        return imageRow(context, img.id, context.strings.report_profile_image_screen_image_title(imageNumber.toString()));
      }
    );
  }

  Widget imageRow(BuildContext context, ContentId content, String imageName) {
    final Widget imageWidget = accountImgWidget(
      widget.profileEntry.uuid,
      content,
      isMatch: widget.isMatch,
      width: _IMG_SIZE,
      height: _IMG_SIZE,
    );

    final textWidget = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        imageName,
        style: Theme.of(context).textTheme.titleMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );
    final Widget rowWidget = Row(
      children: [
        imageWidget,
        Expanded(child: textWidget),
      ],
    );

    return InkWell(
      onTap: () async {
        final r = await showConfirmDialog(
          context,
          context.strings.report_profile_image_screen_confirm_dialog_title,
          details: imageName,
          yesNoActions: true,
          scrollable: true,
        );
        if (context.mounted && r == true) {
          final result = await api.media((api) => api.postProfileContentReport(UpdateProfileContentReport(
            target: widget.profileEntry.uuid,
            content: content,
          ))).ok();

          if (result == null) {
            showSnackBar(R.strings.generic_error_occurred);
          } else if (result.errorOutdatedReportContent) {
            showSnackBar(R.strings.report_profile_image_screen_profile_image_changed_error);
          } else if (result.errorTooManyReports) {
            showSnackBar(R.strings.report_screen_snackbar_too_many_reports_error);
          } else {
            showSnackBar(R.strings.report_screen_snackbar_report_successful);

            if (context.mounted) {
              setState(() {
                images = images.where((v) => v.$2.id != content).toList();
              });
              await profile.downloadProfileToDatabase(chat, widget.profileEntry.uuid);
            }
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: _IMG_SIZE,
          child: rowWidget,
        ),
      ),
    );
  }
}
