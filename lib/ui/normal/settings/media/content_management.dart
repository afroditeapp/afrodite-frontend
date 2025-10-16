import 'package:app/data/image_cache.dart';
import 'package:app/logic/media/content.dart';
import 'package:app/logic/media/select_content.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/media/content.dart';
import 'package:app/model/freezed/logic/media/select_content.dart';
import 'package:app/model/freezed/logic/profile/my_profile.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/moderation.dart';
import 'package:app/utils/time.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui/normal/settings/media/select_content.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/view_image_screen.dart';
import 'package:app/utils/api.dart';
import 'package:utils/utils.dart';

void openContentManagementScreen(BuildContext context) {
  MyNavigator.push(context, ContentManagementPage());
}

class ContentManagementPage extends MyScreenPage<()> with SimpleUrlParser<ContentManagementPage> {
  ContentManagementPage() : super(builder: (_) => ContentManagementScreenOpener());

  @override
  ContentManagementPage create() => ContentManagementPage();
}

class ContentManagementScreenOpener extends StatelessWidget {
  const ContentManagementScreenOpener({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentManagementScreen(selectContentBloc: context.read<SelectContentBloc>());
  }
}

class ContentManagementScreen extends StatefulWidget {
  final SelectContentBloc selectContentBloc;
  const ContentManagementScreen({required this.selectContentBloc, super.key});

  @override
  State<ContentManagementScreen> createState() => _ContentManagementScreenState();
}

class _ContentManagementScreenState extends State<ContentManagementScreen> {
  @override
  void initState() {
    super.initState();
    widget.selectContentBloc.add(ReloadAvailableContent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.content_management_screen_title)),
      body: BlocBuilder<ContentBloc, ContentData>(
        builder: (context, contentState) {
          final securityContent = contentState.currentSecurityContent;
          return BlocBuilder<MyProfileBloc, MyProfileData>(
            builder: (context, myProfileState) {
              final myProfile = myProfileState.profile;
              return BlocBuilder<SelectContentBloc, SelectContentData>(
                builder: (context, state) {
                  final content = state.accountContent;
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (content == null || securityContent == null || myProfile == null) {
                    return Center(child: Text(context.strings.generic_error));
                  } else {
                    return selectContentPage(context, content, securityContent, myProfile);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget selectContentPage(
    BuildContext context,
    AccountContent content,
    ContentId securityContent,
    MyProfileEntry myProfile,
  ) {
    final List<Widget> listWidgets = [];

    listWidgets.addAll(
      content.data.reversed.map(
        (e) => _buildAvailableImg(
          context,
          myProfile.accountId,
          e,
          content.unusedContentWaitSeconds,
          securityContent,
          myProfile,
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
}

Widget _buildAvailableImg(
  BuildContext context,
  AccountId accountId,
  ContentInfoDetailed content,
  int unusedContentWaitSeconds,
  ContentId securityContent,
  MyProfileEntry myProfile,
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
              unusedContentWaitSeconds,
              securityContent,
              myProfile,
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
  int unusedContentWaitSeconds,
  ContentId securityContent,
  MyProfileEntry myProfile,
) {
  final String? moderationState = content.state.toUiString(context);

  final List<String> stateTexts = [];
  if (moderationState != null) {
    stateTexts.add(moderationState);
  }

  final Widget? deleteButton;
  final usageStart = content.usageStartTime;
  final usageEnd = content.usageEndTime;
  if (usageStart != null) {
    if (content.cid == securityContent) {
      stateTexts.add(context.strings.content_management_screen_content_security_content);
    }
    for (final (i, c) in myProfile.content.indexed) {
      if (content.cid == c.id) {
        final contentNumber = i + 1;
        stateTexts.add(
          context.strings.content_management_screen_content_profile_content(
            contentNumber.toString(),
          ),
        );
      }
    }
    deleteButton = null;
  } else if (usageEnd != null) {
    final currentTime = UtcDateTime.now();
    final deletionAllowed = UnixTime(ut: usageEnd.ut + unusedContentWaitSeconds).toUtcDateTime();
    if (currentTime.difference(deletionAllowed).inSeconds >= 0) {
      deleteButton = _createDeleteButton(context, accountId, content.cid);
    } else {
      final timeString = fullTimeString(deletionAllowed);
      stateTexts.add(
        context.strings.content_management_screen_content_deletion_allowed_wait_time(timeString),
      );
      deleteButton = null;
    }
  } else {
    deleteButton = _createDeleteButton(context, accountId, content.cid);
  }

  final String totalText = stateTexts.join(", ");
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      if (totalText.isNotEmpty) Text(totalText, textAlign: TextAlign.center),
      if (totalText.isNotEmpty && deleteButton != null)
        const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
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

Widget _createDeleteButton(BuildContext context, AccountId accountId, ContentId content) {
  return ElevatedButton(
    child: Text(context.strings.generic_delete),
    onPressed: () async {
      final bloc = context.read<SelectContentBloc>();
      final result = await confirmDialogForImage(
        context,
        accountId,
        content,
        context.strings.generic_delete_question,
      );
      if (result == true && !bloc.isClosed) {
        bloc.add(DeleteContent(accountId, content));
      }
    },
  );
}
