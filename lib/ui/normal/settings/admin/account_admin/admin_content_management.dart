import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/media/select_content.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/moderation.dart';
import 'package:app/ui_utils/view_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

class RequiredData {
  final AccountContent accountContent;
  final ContentId? securityContent;
  RequiredData(this.accountContent, this.securityContent);
}

class AdminContentManagementPage extends MyScreenPageLimited<()> {
  AdminContentManagementPage(RepositoryInstances r, AccountId accountId)
    : super(builder: (_) => AdminContentManagementScreen(r, accountId));
}

class AdminContentManagementScreen extends StatefulWidget {
  final ApiManager api;
  final ProfileRepository profile;
  final ChatRepository chat;
  final AccountId accountId;
  AdminContentManagementScreen(RepositoryInstances r, this.accountId, {super.key})
    : api = r.api,
      profile = r.profile,
      chat = r.chat;

  @override
  State<AdminContentManagementScreen> createState() => _AdminContentManagementScreenState();
}

class _AdminContentManagementScreenState extends State<AdminContentManagementScreen> {
  RequiredData? data;

  bool isLoading = true;
  bool isError = false;

  Future<void> _getData() async {
    final result = await widget.api
        .media((api) => api.getAllAccountMediaContent(widget.accountId.aid))
        .ok();

    final securityContent = await widget.api
        .media((api) => api.getSecurityContentInfo(widget.accountId.aid))
        .ok();

    if (!context.mounted) {
      return;
    }

    if (result == null || securityContent == null) {
      showSnackBar(R.strings.generic_error);
      setState(() {
        isLoading = false;
        isError = true;
      });
    } else {
      setState(() {
        isLoading = false;
        data = RequiredData(result, securityContent.c?.cid);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin image management")),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    final info = data;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (isError || info == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return BlocBuilder<AccountBloc, AccountBlocData>(
        builder: (context, state) {
          return selectContentPage(
            context,
            widget.accountId,
            info.accountContent,
            state.permissions,
          );
        },
      );
    }
  }

  Widget selectContentPage(
    BuildContext context,
    AccountId accountId,
    AccountContent content,
    Permissions permissions,
  ) {
    final List<Widget> listWidgets = [];

    listWidgets.addAll(
      content.data.reversed.map(
        (e) => _buildAvailableImg(
          context,
          accountId,
          e,
          permissions.adminDeleteMediaContent ? deleteAction : null,
          changeModerationStateAction,
          permissions.adminEditMediaContentFaceDetectedValue ? changeFaceDetectedValue : null,
          permissions.adminEditMediaContentFaceVerifiedValue ? changeFaceVerifiedValue : null,
        ),
      ),
    );

    final listView = ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: listWidgets,
    );

    final List<Widget> widgets = [];

    widgets.add(
      Padding(
        padding: const EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING),
        child: Text(
          context.strings.select_content_screen_count(
            content.data.length.toString(),
            content.maxContentCount.toString(),
          ),
        ),
      ),
    );

    widgets.add(listView);

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: widgets),
    );
  }

  void deleteAction(AccountId account, ContentId content) async {
    final result = await widget.api.mediaAction(
      (api) => api.deleteContent(account.aid, content.cid),
    );

    if (!context.mounted) {
      return;
    }

    if (result.isErr()) {
      showSnackBar(R.strings.generic_error);
    }

    await _getData();
  }

  void changeModerationStateAction(AccountId account, ContentId content, bool accepted) async {
    final result = await widget.api.mediaAdminAction(
      (api) => api.postModerateMediaContent(
        PostModerateMediaContent(
          accept: accepted,
          accountId: account,
          contentId: content,
          rejectedDetails: null,
        ),
      ),
    );

    if (!context.mounted) {
      return;
    }

    if (result.isErr()) {
      showSnackBar(R.strings.generic_error);
    }

    await _getData();

    await widget.profile.downloadProfileToDatabase(widget.chat, account);
  }

  void changeFaceDetectedValue(AccountId account, ContentId content, bool? value) async {
    final result = await widget.api.mediaAdminAction(
      (api) => api.postMediaContentFaceDetectedValue(
        PostMediaContentFaceDetectedValue(accountId: account, contentId: content, value: value),
      ),
    );

    if (!context.mounted) {
      return;
    }

    if (result.isErr()) {
      showSnackBar(R.strings.generic_error);
    }

    await _getData();
  }

  void changeFaceVerifiedValue(AccountId account, ContentId content, bool? value) async {
    final securityContent = data?.securityContent;

    if (securityContent == null) {
      showSnackBar("Error: security content empty");
      return;
    }

    final result = await widget.api.mediaAdminAction(
      (api) => api.postMediaContentFaceVerifiedValue(
        PostMediaContentFaceVerifiedValue(
          accountId: account,
          securityContent: securityContent,
          values: [PostMediaContentFaceVerifiedValueItem(contentId: content, value: value)],
        ),
      ),
    );

    if (!context.mounted) {
      return;
    }

    if (result.isErr()) {
      showSnackBar(R.strings.generic_error);
    }

    await _getData();
  }
}

Widget _buildAvailableImg(
  BuildContext context,
  AccountId accountId,
  ContentInfoDetailed content,
  void Function(AccountId, ContentId)? deleteImgAction,
  void Function(AccountId, ContentId, bool accepted) changeModerationStateAction,
  void Function(AccountId, ContentId, bool? accepted)? changeFaceDetectedValueAction,
  void Function(AccountId, ContentId, bool? accepted)? changeFaceVerifiedValueAction,
) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 4.0,
      bottom: 4.0,
      left: COMMON_SCREEN_EDGE_PADDING,
      right: COMMON_SCREEN_EDGE_PADDING,
    ),
    child: Row(
      children: [
        SizedBox(
          width: SELECT_CONTENT_IMAGE_WIDTH,
          height: SELECT_CONTENT_IMAGE_HEIGHT,
          child: Material(
            child: InkWell(
              onTap: () => openViewImageScreenForAccountImage(context, accountId, content.cid),
              child: accountImgWidgetInk(
                context,
                accountId,
                content.cid,
                cacheSize: ImageCacheSize.constantWidthAndHeight(
                  context,
                  SELECT_CONTENT_IMAGE_WIDTH,
                  SELECT_CONTENT_IMAGE_HEIGHT,
                ),
              ),
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
        Expanded(
          child: Center(
            child: _statusInfo(
              context,
              accountId,
              content,
              deleteImgAction,
              changeModerationStateAction,
              changeFaceDetectedValueAction,
              changeFaceVerifiedValueAction,
            ),
          ),
        ),
        _rejectionDetailsInfo(context, content),
      ],
    ),
  );
}

Widget _statusInfo(
  BuildContext context,
  AccountId accountId,
  ContentInfoDetailed content,
  void Function(AccountId, ContentId)? deleteImgAction,
  void Function(AccountId, ContentId, bool accepted) changeModerationStateAction,
  void Function(AccountId, ContentId, bool? accepted)? changeFaceDetectedValueAction,
  void Function(AccountId, ContentId, bool? accepted)? changeFaceVerifiedValueAction,
) {
  final String moderationState = switch (content.state) {
    ContentModerationState.inSlot => "In slot",
    ContentModerationState.waitingBotOrHumanModeration =>
      context.strings.moderation_state_waiting_bot_or_human_moderation,
    ContentModerationState.waitingHumanModeration =>
      context.strings.moderation_state_waiting_human_moderation,
    ContentModerationState.acceptedByBot => "Accepted by bot",
    ContentModerationState.acceptedByHuman => "Accepted by human",
    ContentModerationState.rejectedByBot => context.strings.moderation_state_rejected_by_bot,
    ContentModerationState.rejectedByHuman => context.strings.moderation_state_rejected_by_human,
    _ => "null",
  };

  final Widget? moderationStateChangeButton;
  if (content.state == ContentModerationState.acceptedByBot ||
      content.state == ContentModerationState.acceptedByHuman) {
    moderationStateChangeButton = _createModerationStateChangeButton(
      context,
      accountId,
      content.cid,
      "Reject",
      "Reject?",
      false,
      changeModerationStateAction,
    );
  } else if (content.state == ContentModerationState.rejectedByBot ||
      content.state == ContentModerationState.rejectedByHuman) {
    moderationStateChangeButton = _createModerationStateChangeButton(
      context,
      accountId,
      content.cid,
      "Accept",
      "Accept?",
      true,
      changeModerationStateAction,
    );
  } else {
    moderationStateChangeButton = null;
  }

  final Widget? deleteButton;
  if (deleteImgAction != null) {
    deleteButton = _createDeleteButton(context, accountId, content.cid, deleteImgAction);
  } else {
    deleteButton = null;
  }

  final List<Widget> faceDetectedButtons = [];
  if (changeFaceDetectedValueAction != null) {
    if (content.faceDetectedManual != true) {
      faceDetectedButtons.add(
        _createFaceDetectedValueChangeButton(
          context,
          accountId,
          content.cid,
          "Detect face",
          "Detect face?",
          true,
          changeFaceDetectedValueAction,
        ),
      );
    }
    if (content.faceDetectedManual != false) {
      faceDetectedButtons.add(
        _createFaceDetectedValueChangeButton(
          context,
          accountId,
          content.cid,
          "Undetect face",
          "Undetect face?",
          false,
          changeFaceDetectedValueAction,
        ),
      );
    }
    if (content.faceDetectedManual != null) {
      faceDetectedButtons.add(
        _createFaceDetectedValueChangeButton(
          context,
          accountId,
          content.cid,
          "Clear face override",
          "Clear face override?",
          null,
          changeFaceDetectedValueAction,
        ),
      );
    }
  }

  final String faceDetectedText;
  if (content.faceDetectedManual != null) {
    faceDetectedText = content.faceDetectedManual!
        ? "Face detected (manual)"
        : "Face not detected (manual)";
  } else {
    faceDetectedText = content.faceDetected ? "Face detected (auto)" : "Face not detected (auto)";
  }

  final faceDetected = content.faceDetectedManual ?? content.faceDetected;
  final List<Widget> faceVerifiedButtons = [];
  if (faceDetected && changeFaceVerifiedValueAction != null) {
    if (content.faceVerifiedManual != true) {
      faceVerifiedButtons.add(
        _createFaceVerifiedValueChangeButton(
          context,
          accountId,
          content.cid,
          "Verify face",
          "Verify face?",
          true,
          changeFaceVerifiedValueAction,
        ),
      );
    }
    if (content.faceVerifiedManual != false) {
      faceVerifiedButtons.add(
        _createFaceVerifiedValueChangeButton(
          context,
          accountId,
          content.cid,
          "Unverify face",
          "Unverify face?",
          false,
          changeFaceVerifiedValueAction,
        ),
      );
    }
    if (content.faceVerifiedManual != null) {
      faceVerifiedButtons.add(
        _createFaceVerifiedValueChangeButton(
          context,
          accountId,
          content.cid,
          "Clear face verification override",
          "Clear face verification override?",
          null,
          changeFaceVerifiedValueAction,
        ),
      );
    }
  }

  final String? faceVerifiedText;
  if (faceDetected && content.faceVerifiedManual != null) {
    faceVerifiedText = content.faceVerifiedManual!
        ? "Face verified (manual)"
        : "Face not verified (manual)";
  } else if (faceDetected && content.faceVerified != null) {
    faceVerifiedText = content.faceVerified! ? "Face verified (auto)" : "Face not verified (auto)";
  } else if (faceDetected) {
    faceVerifiedText = "Face verification pending";
  } else {
    faceVerifiedText = null;
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(moderationState, textAlign: TextAlign.center),
      const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
      Text(faceDetectedText, textAlign: TextAlign.center),
      if (faceVerifiedText != null) const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
      if (faceVerifiedText != null) Text(faceVerifiedText, textAlign: TextAlign.center),
      if (moderationStateChangeButton != null)
        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
      if (moderationStateChangeButton != null) moderationStateChangeButton,
      if (deleteButton != null) const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
      if (deleteButton != null) deleteButton,
      for (final button in faceDetectedButtons) ...[
        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        button,
      ],
      for (final button in faceVerifiedButtons) ...[
        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        button,
      ],
    ],
  );
}

Widget _rejectionDetailsInfo(BuildContext context, ContentInfoDetailed content) {
  String infoText = "";
  infoText = addRejectedCategoryRow(context, infoText, content.rejectedReasonCategory?.value);
  infoText = addRejectedDetailsRow(context, infoText, content.rejectedReasonDetails?.value);
  infoText = infoText.trim();

  if (infoText.isNotEmpty) {
    return IconButton(
      onPressed: () {
        showInfoDialog(context, infoText);
      },
      icon: const Icon(Icons.info),
    );
  } else {
    return const SizedBox.shrink();
  }
}

Widget _createDeleteButton(
  BuildContext context,
  AccountId accountId,
  ContentId content,
  void Function(AccountId, ContentId) deleteImgAction,
) {
  return ElevatedButton(
    child: Text(context.strings.generic_delete),
    onPressed: () async {
      final result = await confirmDialogForImage(
        context,
        accountId,
        content,
        context.strings.generic_delete_question,
      );
      if (result == true) {
        deleteImgAction(accountId, content);
      }
    },
  );
}

Widget _createFaceDetectedValueChangeButton(
  BuildContext context,
  AccountId accountId,
  ContentId content,
  String buttonText,
  String dialogTitle,
  bool? value,
  void Function(AccountId, ContentId, bool?) action,
) {
  return ElevatedButton(
    child: Text(buttonText),
    onPressed: () async {
      final result = await confirmDialogForImage(context, accountId, content, dialogTitle);
      if (result == true) {
        action(accountId, content, value);
      }
    },
  );
}

Widget _createFaceVerifiedValueChangeButton(
  BuildContext context,
  AccountId accountId,
  ContentId content,
  String buttonText,
  String dialogTitle,
  bool? value,
  void Function(AccountId, ContentId, bool?) action,
) {
  return ElevatedButton(
    child: Text(buttonText),
    onPressed: () async {
      final result = await confirmDialogForImage(context, accountId, content, dialogTitle);
      if (result == true) {
        action(accountId, content, value);
      }
    },
  );
}

Widget _createModerationStateChangeButton(
  BuildContext context,
  AccountId accountId,
  ContentId content,
  String buttonText,
  String dialogTitle,
  bool accept,
  void Function(AccountId, ContentId, bool) action,
) {
  return ElevatedButton(
    child: Text(buttonText),
    onPressed: () async {
      final result = await confirmDialogForImage(context, accountId, content, dialogTitle);
      if (result == true) {
        action(accountId, content, accept);
      }
    },
  );
}
