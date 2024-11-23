

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/login.dart';
import 'package:app/logic/media/image_processing.dart';
import 'package:app/logic/media/new_moderation_request.dart';
import 'package:app/model/freezed/logic/login.dart';
import 'package:app/model/freezed/logic/media/new_moderation_request.dart';
import 'package:app/ui/initial_setup/profile_pictures.dart';
import 'package:app/ui/normal/settings/media/select_content.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/image_processing.dart';

/// Returns [List<ContentId>?]
class NewModerationRequestScreen extends StatefulWidget {
  final NewModerationRequestBloc newModerationRequestBloc;
  const NewModerationRequestScreen({
    required this.newModerationRequestBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<NewModerationRequestScreen> createState() => _NewModerationRequestScreenState();
}

class _NewModerationRequestScreenState extends State<NewModerationRequestScreen> {

  @override
  void initState() {
    super.initState();
    widget.newModerationRequestBloc.add(Reset());
  }

  void closeScreen(BuildContext context, {bool popOnCancel = true}) async {
    final imgs = context.read<NewModerationRequestBloc>().state.selectedImgs.addedImgs.toList();
    if (imgs.isNotEmpty) {
      final accepted = await showConfirmDialog(context, context.strings.new_moderation_request_screen_send_content_confirm_dialog_title, yesNoActions: true);
      if (!context.mounted) {
        return;
      }
      if (accepted == true) {
        MyNavigator.pop(context, imgs);
      } else if (accepted == false) {
        if (popOnCancel) {
          MyNavigator.pop(context);
        }
      }
    } else {
      MyNavigator.pop(context);
    }
  }

  bool unsavedData(NewModerationRequestData data) {
    return data.selectedImgs.addedImgs.toList().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<NewModerationRequestBloc, NewModerationRequestData>(
            builder: (context, state) {
              final unsavedDataDetected = unsavedData(state);
              return PopScope(
                canPop: !unsavedDataDetected,
                onPopInvoked: (didPop) async {
                  if (didPop) {
                    return;
                  }
                  closeScreen(context);
                },
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(context.strings.new_moderation_request_screen_title),
                  ),
                  body: BlocBuilder<LoginBloc, LoginBlocData>(
                    builder: (context, lState) {
                      final accountId = lState.accountId;
                      if (accountId == null) {
                        return Center(child: Text(context.strings.generic_error));
                      } else {
                        return addContentPage(
                          context,
                          accountId,
                          state.selectedImgs,
                        );
                      }
                    }
                  ),
                ),
              );
            }
          ),
        ),

        // Zero sized widgets
        ...imageProcessingUiWidgets<ProfilePicturesImageProcessingBloc>(
          onComplete: (context, processedImg) {
            context.read<NewModerationRequestBloc>().add(AddImg(processedImg.slot, processedImg.contentId, processedImg.faceDetected));
          },
        ),
      ],
    );
  }

  Widget addContentPage(
    BuildContext context,
    AccountId accountId,
    AddedImages currentContent,
  ) {
    final List<Widget> gridWidgets = [];
    final iconSize = IconTheme.of(context).size ?? 24.0;

    gridWidgets.addAll(
      currentContent.addedImgs.indexed.map((e) =>
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImgWithCloseButton(
              onCloseButtonPressed: () => context.read<NewModerationRequestBloc>().add(RemoveImg(e.$1)),
              imgWidgetBuilder: (c, width, height) => ImgWithCloseButton.defaultImgWidgetBuilder(context, width, height, accountId, e.$2.content),
              maxWidth: SELECT_CONTENT_IMAGE_WIDTH + iconSize,
              maxHeight: SELECT_CONTENT_IMAGE_HEIGHT - 30,
            ),
            if (e.$2.faceDetected) Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(context.strings.new_moderation_request_screen_face_detected),
            ),
          ],
        )
      )
    );

    final availableSlot = currentContent.nextAvailableSlot();
    if (availableSlot != null) {
      gridWidgets.add(
        buildAddNewButton(context, onTap: () {
          openSelectPictureDialog(context, serverSlotIndex: availableSlot);
        })
      );
    }

    final grid = GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: gridWidgets,
    );

    final List<Widget> widgets = [grid];

    if (currentContent.addedImgs.isNotEmpty) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(
            left: COMMON_SCREEN_EDGE_PADDING,
            right: COMMON_SCREEN_EDGE_PADDING,
            top: 16,
            bottom: 16,
          ),
          child: ElevatedButton.icon(
            onPressed: () => closeScreen(context, popOnCancel: false),
            icon: const Icon(Icons.send_rounded),
            label: Text(context.strings.new_moderation_request_screen_send_content_button),
          ),
        )
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      ),
    );
  }
}
