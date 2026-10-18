import 'package:app/data/image_cache.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/media/select_content.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/moderation.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/media/security_selfie.dart';
import 'package:app/model/freezed/logic/media/security_selfie.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/view_image_screen.dart';

const SECURITY_SELFIE_ICON = Icons.image_rounded;

class CurrentSecuritySelfiePage extends MyScreenPage<()>
    with SimpleUrlParser<CurrentSecuritySelfiePage> {
  CurrentSecuritySelfiePage()
    : super(builder: (closer) => CurrentSecuritySelfieScreenOpener(closer: closer));

  @override
  CurrentSecuritySelfiePage create() => CurrentSecuritySelfiePage();
}

class CurrentSecuritySelfieScreenOpener extends StatelessWidget {
  final PageCloser<()> closer;
  const CurrentSecuritySelfieScreenOpener({required this.closer, super.key});

  @override
  Widget build(BuildContext context) {
    return CurrentSecuritySelfieScreen(
      closer: closer,
      securitySelfieBloc: context.read<SecuritySelfieBloc>(),
      currentUser: context.read<RepositoryInstances>().accountId,
    );
  }
}

class CurrentSecuritySelfieScreen extends StatefulWidget {
  final PageCloser<()> closer;
  final SecuritySelfieBloc securitySelfieBloc;
  final AccountId currentUser;
  const CurrentSecuritySelfieScreen({
    required this.closer,
    required this.securitySelfieBloc,
    required this.currentUser,
    super.key,
  });

  @override
  State<CurrentSecuritySelfieScreen> createState() => _CurrentSecuritySelfieScreenState();
}

class _CurrentSecuritySelfieScreenState extends State<CurrentSecuritySelfieScreen> {
  @override
  void initState() {
    super.initState();
    widget.securitySelfieBloc.add(ResetEditedValues());
    widget.securitySelfieBloc.add(RefreshDataConsentSettingsSilently());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecuritySelfieBloc, SecuritySelfieData>(
      bloc: widget.securitySelfieBloc,
      builder: (context, contentState) {
        return mainContent(context, contentState);
      },
    );
  }

  Widget mainContent(BuildContext context, SecuritySelfieData contentState) {
    final unsavedChanges = contentState.unsavedChanges();
    return updateStateHandler<SecuritySelfieBloc, SecuritySelfieData>(
      context: context,
      pageKey: widget.closer.key,
      child: PopScope(
        canPop: !unsavedChanges,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) {
            return;
          }
          showConfirmDialog(
            context,
            context.strings.generic_save_confirmation_title,
            yesNoActions: true,
          ).then((value) {
            if (!context.mounted) {
              return;
            }
            if (value == true) {
              validateAndSaveData(context);
            } else if (value == false) {
              widget.closer.close(context, ());
              widget.securitySelfieBloc.add(ResetEditedValues());
            }
          });
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(context.strings.generic_security_selfie),
            actions: [editSecuritySelfieButton(context)],
          ),
          body: content(context, contentState),
          floatingActionButton: unsavedChanges
              ? FloatingActionButton(
                  onPressed: () => validateAndSaveData(context),
                  child: const Icon(Icons.check),
                )
              : null,
        ),
      ),
    );
  }

  void validateAndSaveData(BuildContext context) {
    final editedContent = widget.securitySelfieBloc.state.valueSecurityContent(widget.currentUser);

    if (editedContent != null && !editedContent.faceDetected) {
      showSnackBar(context.strings.initial_setup_screen_security_selfie_face_not_detected);
      return;
    }

    widget.securitySelfieBloc.add(SaveSecurityContentScreenChanges());
  }

  Widget content(BuildContext context, SecuritySelfieData contentState) {
    final selectedContent = contentState.valueSecurityContent(widget.currentUser);
    String infoText = "";
    final ContentId? contentId;
    if (selectedContent != null && !selectedContent.faceDetected) {
      infoText = context.strings.initial_setup_screen_security_selfie_face_not_detected;
      contentId = selectedContent.contentId;
    } else if (selectedContent != null) {
      infoText = addModerationStateRow(
        context,
        infoText,
        selectedContent.moderationState?.toUiString(context),
      );
      infoText = addRejectedCategoryRow(context, infoText, selectedContent.rejectedCategory?.value);
      infoText = addRejectedDetailsRow(context, infoText, selectedContent.rejectedDetails?.value);
      infoText = infoText.trim();
      contentId = selectedContent.contentId;
    } else {
      contentId = null;
    }

    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(top: 16)),
                if (contentId == null) Text(context.strings.generic_empty),
                if (contentId != null) securitySelfieWidget(context, contentId),
                if (infoText.isNotEmpty) const Padding(padding: EdgeInsets.only(top: 16)),
                if (infoText.isNotEmpty) hPad(Text(infoText)),
                const Padding(padding: EdgeInsets.only(top: 16)),
                aiFaceVerificationSwitchTile(context, contentState.valueAllowFaceVerification()),
                const Padding(padding: EdgeInsets.only(top: FLOATING_ACTION_BUTTON_EMPTY_AREA)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget editSecuritySelfieButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final selectedImg = await MyNavigator.showFullScreenDialog(
          context: context,
          page: SelectContentPage(identifyFaceImages: true, securitySelfieMode: true),
        );
        if (selectedImg != null && context.mounted) {
          widget.securitySelfieBloc.add(EditSecurityContent(selectedImg));
        }
      },
      icon: const Icon(Icons.edit),
      tooltip: context.strings.generic_edit,
    );
  }

  Widget aiFaceVerificationSwitchTile(BuildContext context, bool allowFaceVerification) {
    return createAiFaceVerificationSwitchTile(
      context: context,
      value: allowFaceVerification,
      onChanged: (value) {
        widget.securitySelfieBloc.add(EditAllowFaceVerification(value));
      },
    );
  }

  Widget securitySelfieWidget(BuildContext context, ContentId securitySelfie) {
    const double IMG_WIDTH = 150;
    const double IMG_HEIGHT = 200;
    return SizedBox(
      width: IMG_WIDTH,
      height: IMG_HEIGHT,
      child: Material(
        child: InkWell(
          onTap: () =>
              openViewImageScreenForAccountImage(context, widget.currentUser, securitySelfie),
          child: accountImgWidgetInk(
            context,
            widget.currentUser,
            securitySelfie,
            cacheSize: ImageCacheSize.constantWidthAndHeight(context, IMG_WIDTH, IMG_HEIGHT),
          ),
        ),
      ),
    );
  }
}

Widget createAiFaceVerificationSwitchTile({
  required BuildContext context,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  return SwitchListTile(
    title: Text(context.strings.current_security_selfie_screen_ai_face_verification),
    subtitle: Text(
      value
          ? context.strings.current_security_selfie_screen_ai_face_verification_description_enabled
          : context
                .strings
                .current_security_selfie_screen_ai_face_verification_description_disabled,
    ),
    value: value,
    secondary: const Icon(Icons.verified_user_outlined),
    onChanged: onChanged,
  );
}
