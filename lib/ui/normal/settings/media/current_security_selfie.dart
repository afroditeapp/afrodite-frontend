import 'package:app/data/image_cache.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/logic/media/new_moderation_request.dart';
import 'package:app/logic/media/select_content.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/media/profile_pictures.dart';
import 'package:app/ui/normal/settings/media/select_content.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/moderation.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/media/content.dart';
import 'package:app/model/freezed/logic/media/content.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/view_image_screen.dart';

class CurrentSecuritySelfie extends StatefulWidget {
  final PageKey pageKey;
  const CurrentSecuritySelfie({required this.pageKey, super.key});

  @override
  State<CurrentSecuritySelfie> createState() => _CurrentSecuritySelfieState();
}

class _CurrentSecuritySelfieState extends State<CurrentSecuritySelfie> {
  final currentUser = LoginRepository.getInstance().repositories.accountId;

  MyContent? currentImg;
  AccountImageId? changedImg;
  bool backNavigationStarted = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentBloc, ContentData>(
      builder: (context, contentState) {
        if (!backNavigationStarted) {
          currentImg = contentState.securityContent;
        }

        final currentSecuritySelfie = currentImg;
        final editedSecuritySelfie = changedImg;

        String infoText = "";
        final ContentId? contentId;
        final bool saveRequired;
        if (editedSecuritySelfie != null &&
            currentSecuritySelfie?.id != editedSecuritySelfie.contentId) {
          if (!editedSecuritySelfie.faceDetected) {
            infoText = context.strings.initial_setup_screen_security_selfie_face_not_detected;
          }
          contentId = editedSecuritySelfie.contentId;
          saveRequired = true;
        } else if (currentSecuritySelfie != null) {
          infoText = addModerationStateRow(
            context,
            infoText,
            currentSecuritySelfie.state.toUiString(context),
          );
          infoText = addRejectedCategoryRow(
            context,
            infoText,
            currentSecuritySelfie.rejectedCategory?.value,
          );
          infoText = addRejectedDetailsRow(
            context,
            infoText,
            currentSecuritySelfie.rejectedDetails?.value,
          );
          infoText = infoText.trim();
          contentId = currentSecuritySelfie.id;
          saveRequired = false;
        } else {
          contentId = null;
          saveRequired = false;
        }

        return mainContent(context, contentId, infoText, saveRequired);
      },
    );
  }

  Widget mainContent(
    BuildContext context,
    ContentId? contentId,
    String infoText,
    bool saveRequired,
  ) {
    return PopScope(
      canPop: !saveRequired,
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
            MyNavigator.removePage(context, widget.pageKey);
          }
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.strings.current_security_selfie_screen_title),
          actions: [editSecuritySelfieButton(context)],
        ),
        body: content(context, contentId, infoText),
        floatingActionButton: saveRequired
            ? FloatingActionButton(
                onPressed: () => validateAndSaveData(context),
                child: const Icon(Icons.check),
              )
            : null,
      ),
    );
  }

  void validateAndSaveData(BuildContext context) {
    final editedContent = changedImg;

    if (editedContent == null) {
      // Should not happen
      Navigator.pop(context);
      return;
    }

    if (!editedContent.faceDetected) {
      showSnackBar(context.strings.initial_setup_screen_security_selfie_face_not_detected);
      return;
    }

    MyNavigator.removePage(context, widget.pageKey);
    backNavigationStarted = true;
    context.read<ContentBloc>().add(ChangeSecurityContent(editedContent.contentId));
  }

  Widget content(BuildContext context, ContentId? contentId, String infoText) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(top: 8)),
                if (contentId == null) Text(context.strings.generic_empty),
                if (contentId != null) securitySelfieWidget(currentUser, contentId),
                if (infoText.isNotEmpty) const Padding(padding: EdgeInsets.only(top: 8)),
                if (infoText.isNotEmpty) hPad(Text(infoText)),
                const Padding(padding: EdgeInsets.only(top: 8)),
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
        final selectContentBloc = context.read<SelectContentBloc>();
        final newModerationRequestBloc = context.read<NewModerationRequestBloc>();
        final selectedImg = await MyNavigator.push(
          context,
          MaterialPage<AccountImageId?>(
            child: SelectContentPage(
              selectContentBloc: selectContentBloc,
              newModerationRequestBloc: newModerationRequestBloc,
              identifyFaceImages: true,
              securitySelfieMode: true,
            ),
          ),
        );
        if (selectedImg != null && context.mounted) {
          setState(() {
            changedImg = selectedImg;
          });
        }
      },
      icon: const Icon(Icons.edit),
      tooltip: context.strings.generic_edit,
    );
  }

  Widget securitySelfieWidget(AccountId accountId, ContentId securitySelfie) {
    const double IMG_WIDTH = 150;
    const double IMG_HEIGHT = 200;
    return SizedBox(
      width: IMG_WIDTH,
      height: IMG_HEIGHT,
      child: Material(
        child: InkWell(
          onTap: () => MyNavigator.push(
            context,
            MaterialPage<void>(
              child: ViewImageScreen(ViewImageAccountContent(accountId, securitySelfie)),
            ),
          ),
          child: accountImgWidgetInk(
            accountId,
            securitySelfie,
            cacheSize: ImageCacheSize.constantWidthAndHeight(context, IMG_WIDTH, IMG_HEIGHT),
          ),
        ),
      ),
    );
  }
}
