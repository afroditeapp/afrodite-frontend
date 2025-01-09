

import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/media/select_content.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/moderation.dart';
import 'package:app/ui_utils/view_image_screen.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

class RequiredData {
  final AccountContent accountContent;
  RequiredData(this.accountContent);
}

class AdminContentManagementScreen extends StatefulWidget {
  final ProfileEntry entry;
  const AdminContentManagementScreen({
    required this.entry,
    super.key,
  });

  @override
  State<AdminContentManagementScreen> createState() => _AdminContentManagementScreenState();
}

class _AdminContentManagementScreenState extends State<AdminContentManagementScreen> {
  final api = LoginRepository.getInstance().repositories.api;
  final profile = LoginRepository.getInstance().repositories.profile;

  RequiredData? data;

  bool isLoading = true;
  bool isError = false;

  Future<void> _getData() async {
    final result = await api
      .media(
        (api) => api.getAllAccountMediaContent(widget.entry.uuid.aid)
      ).ok();

    if (!context.mounted) {
      return;
    }

    if (result == null) {
      showSnackBar(R.strings.generic_error);
      setState(() {
        isLoading = false;
        isError = true;
      });
    } else {
      setState(() {
        isLoading = false;
        data = RequiredData(result);
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
      appBar: AppBar(
        title: const Text("Admin image management"),
      ),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    final info = data;
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (isError || info == null) {
      return Center(child: Text(context.strings.generic_error));
    } else {
      return BlocBuilder<AccountBloc, AccountBlocData>(
        builder: (context, state) {
          return selectContentPage(context, widget.entry.uuid, info.accountContent, state.permissions);
        }
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
      content.data.reversed.map((e) => _buildAvailableImg(
        context,
        accountId,
        e,
        permissions.adminDeleteMediaContent ? deleteAction : null,
        changeModerationStateAction,
      ))
    );

    final listView = ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: listWidgets,
    );

    final List<Widget> widgets = [];

    widgets.add(Padding(
      padding: const EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING),
      child: Text(context.strings.select_content_screen_count(content.data.length.toString(), content.maxContentCount.toString())),
    ));

    widgets.add(listView);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      ),
    );
  }

  void deleteAction(AccountId account, ContentId content) async {
    final result = await api
      .mediaAction(
        (api) => api.deleteContent(account.aid, content.cid)
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
    final result = await api
      .mediaAdminAction(
        (api) => api.postModerateProfileContent(
          PostModerateProfileContent(accept: accepted, accountId: account, contentId: content)
        )
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
) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 4.0,
      bottom: 4.0,
      left: COMMON_SCREEN_EDGE_PADDING,
      right: COMMON_SCREEN_EDGE_PADDING
    ),
    child: Row(
      children: [
        SizedBox(
          width: SELECT_CONTENT_IMAGE_WIDTH,
          height: SELECT_CONTENT_IMAGE_HEIGHT,
          child: Material(
            child: InkWell(
              onTap: () {
                MyNavigator.push(
                  context,
                  MaterialPage<void>(
                    child: ViewImageScreen(ViewImageAccountContent(accountId, content.cid))
                  )
                );
              },
              child: accountImgWidgetInk(accountId, content.cid),
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
            ),
          )
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
) {
  final String moderationState = switch (content.state) {
    ContentModerationState.inSlot => "In slot",
    ContentModerationState.waitingBotOrHumanModeration => context.strings.moderation_state_waiting_bot_or_human_moderation,
    ContentModerationState.waitingHumanModeration => context.strings.moderation_state_waiting_human_moderation,
    ContentModerationState.acceptedByBot => "Accepted by bot",
    ContentModerationState.acceptedByHuman => "Accepted by human",
    ContentModerationState.rejectedByBot => context.strings.moderation_state_rejected_by_bot,
    ContentModerationState.rejectedByHuman => context.strings.moderation_state_rejected_by_human,
    _ => "null",
  };

  final List<String> stateTexts = [];
  stateTexts.add(moderationState);

  final Widget? moderationStateChangeButton;
  if (content.state == ContentModerationState.acceptedByBot || content.state == ContentModerationState.acceptedByHuman) {
    moderationStateChangeButton = _createModerationStateChangeButton(
      context,
      accountId,
      content.cid,
      "Reject",
      "Reject?",
      false,
      changeModerationStateAction,
    );
  } else if (content.state == ContentModerationState.rejectedByBot || content.state == ContentModerationState.rejectedByHuman) {
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

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(moderationState, textAlign: TextAlign.center),
      if (moderationStateChangeButton != null) const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
      if (moderationStateChangeButton != null) moderationStateChangeButton,
      if (deleteButton != null) const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
      if (deleteButton != null) deleteButton,
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
      final result = await _confirmDialogForImage(context, accountId, content, context.strings.generic_delete_question);
      if (result == true) {
        deleteImgAction(accountId, content);
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
      final result = await _confirmDialogForImage(context, accountId, content, dialogTitle);
      if (result == true) {
        action(accountId, content, accept);
      }
    },
  );
}

Future<bool?> _confirmDialogForImage(BuildContext context, AccountId account, ContentId content, String dialogTitle) async {
  Widget img = InkWell(
    onTap: () {
      MyNavigator.push(
        context,
        MaterialPage<void>(
          child: ViewImageScreen(ViewImageAccountContent(account, content))
        )
      );
    },
    // Width seems to prevent the dialog from expanding horizontaly
    child: accountImgWidget(account, content, height: 200, width: 150),
  );

  Widget dialog = AlertDialog(
    title: Text(dialogTitle),
    content: img,
    actions: [
      TextButton(
        onPressed: () {
          MyNavigator.pop(context, false);
        },
        child: Text(context.strings.generic_cancel),
      ),
      TextButton(
        onPressed: () {
          MyNavigator.pop(context, true);
        },
        child: Text(context.strings.generic_continue),
      ),
    ],
  );

  final pageKey = PageKey();
  return await MyNavigator.showDialog<bool?>(
    context: context,
    builder: (context) => dialog,
    pageKey: pageKey,
  );
}
