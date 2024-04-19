

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/media/current_moderation_request.dart';
import 'package:pihka_frontend/logic/media/image_processing.dart';
import 'package:pihka_frontend/logic/media/new_moderation_request.dart';
import 'package:pihka_frontend/model/freezed/logic/account/account.dart';
import 'package:pihka_frontend/model/freezed/logic/media/current_moderation_request.dart';
import 'package:pihka_frontend/model/freezed/logic/media/new_moderation_request.dart';
import 'package:pihka_frontend/model/freezed/logic/media/profile_pictures.dart';
import 'package:pihka_frontend/ui/initial_setup/profile_pictures.dart';
import 'package:pihka_frontend/ui/normal/settings/media/select_content.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';
import 'package:pihka_frontend/ui_utils/image.dart';
import 'package:pihka_frontend/ui_utils/image_processing.dart';
import 'package:pihka_frontend/ui_utils/view_image_screen.dart';
import 'package:pihka_frontend/utils/api.dart';
import 'package:pihka_frontend/utils/immutable_list.dart';


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
    final imgs = context.read<NewModerationRequestBloc>().state.selectedImgs.contentList().toList();
    if (imgs.isNotEmpty) {
      final accepted = await showConfirmDialog(context, context.strings.new_moderation_request_screen_send_content_confirm_dialog_title);
      if (!context.mounted) {
        return;
      }
      if (accepted == true) {
        Navigator.of(context).pop(imgs);
      } else {
        if (popOnCancel) {
          Navigator.of(context).pop();
        }
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
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
        body: Column(
          children: [
            BlocBuilder<AccountBloc, AccountBlocData>(
              builder: (context, aState) {
                return BlocBuilder<NewModerationRequestBloc, NewModerationRequestData>(
                  builder: (context, state) {
                    final accountId = aState.accountId;
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
                );
              }
            ),

            // Zero sized widgets
          ...imageProcessingUiWidgets<ProfilePicturesImageProcessingBloc>(
            onComplete: (context, processedImg) {
              context.read<NewModerationRequestBloc>().add(AddImg(processedImg.slot, processedImg.contentId));
            },
          ),
          ],
        )
      ),
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
      currentContent.contentList().indexed.map((e) =>
        Center(
          child: ImgWithCloseButton(
            onCloseButtonPressed: () => context.read<NewModerationRequestBloc>().add(RemoveImg(e.$1)),
            imgWidgetBuilder: (c, width, height) => ImgWithCloseButton.defaultImgWidgetBuilder(context, width, height, accountId, e.$2),
            maxWidth: SELECT_CONTENT_IMAGE_WIDTH + iconSize,
            maxHeight: SELECT_CONTENT_IMAGE_HEIGHT
          ),
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

    if (currentContent.contentList().isNotEmpty) {
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
