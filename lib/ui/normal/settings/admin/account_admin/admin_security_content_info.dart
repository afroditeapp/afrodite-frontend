import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/moderation.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/ui_utils/view_image_screen.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

class AdminSecurityContentInfoPage extends MyScreenPageLimited<()> {
  AdminSecurityContentInfoPage(RepositoryInstances r, AccountId accountId)
    : super(builder: (_) => AdminSecurityContentInfoScreen(r, accountId));
}

class AdminSecurityContentInfoScreen extends StatefulWidget {
  final ApiManager api;
  final AccountId accountId;
  AdminSecurityContentInfoScreen(RepositoryInstances r, this.accountId, {super.key}) : api = r.api;

  @override
  State<AdminSecurityContentInfoScreen> createState() => _AdminSecurityContentInfoScreenState();
}

class _AdminSecurityContentInfoScreenState extends State<AdminSecurityContentInfoScreen> {
  SecurityContentAdminInfo? data;

  bool isLoading = true;
  bool isError = false;

  Future<void> _getData() async {
    final result = await widget.api
        .mediaAdmin((api) => api.getSecurityContentInfo(widget.accountId.aid))
        .ok();

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
        isError = false;
        data = result;
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
      appBar: AppBar(title: const Text("Security selfie info")),
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
          return Align(
            alignment: AlignmentGeometry.topCenter,
            child: showData(context, info, state.permissions),
          );
        },
      );
    }
  }

  Widget showData(BuildContext context, SecurityContentAdminInfo info, Permissions permissions) {
    final content = info.content;
    String moderationInfo = "";
    if (content != null) {
      moderationInfo = addModerationStateRow(
        context,
        moderationInfo,
        content.state.toUiString(context),
      );
      moderationInfo = addRejectedCategoryRow(
        context,
        moderationInfo,
        content.rejectedReasonCategory?.value,
      );
      moderationInfo = addRejectedDetailsRow(
        context,
        moderationInfo,
        content.rejectedReasonDetails?.value,
      );
      moderationInfo = moderationInfo.trim();
    }

    final verificationText = _verificationText(info);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.only(top: 8)),
          if (content == null) hPad(Text(context.strings.generic_empty)),
          if (content != null) _securitySelfieWidget(context, widget.accountId, content.cid),
          if (moderationInfo.isNotEmpty) const Padding(padding: EdgeInsets.only(top: 8)),
          if (moderationInfo.isNotEmpty) hPad(Text(moderationInfo, textAlign: TextAlign.center)),
          const Padding(padding: EdgeInsets.only(top: 8)),
          hPad(Text(verificationText, textAlign: TextAlign.center)),
          if (content != null && permissions.adminEditSecurityContentVerifiedValue)
            const Padding(padding: EdgeInsets.only(top: 8)),
          if (content != null && permissions.adminEditSecurityContentVerifiedValue)
            _verificationButtons(context, content.cid, info.securityContentVerifiedManual),
          const Padding(padding: EdgeInsets.only(top: 8)),
        ],
      ),
    );
  }

  String _verificationText(SecurityContentAdminInfo info) {
    if (info.securityContentVerifiedManual != null) {
      return info.securityContentVerifiedManual!
          ? "Security selfie verified (manual)"
          : "Security selfie not verified (manual)";
    }

    if (info.securityContentVerified != null) {
      return info.securityContentVerified!
          ? "Security selfie verified (auto)"
          : "Security selfie not verified (auto)";
    }

    return "Security selfie verification pending";
  }

  Widget _verificationButtons(
    BuildContext context,
    ContentId securityContent,
    bool? currentManualValue,
  ) {
    final List<Widget> buttons = [];

    if (currentManualValue != true) {
      buttons.add(
        _createVerificationChangeButton(
          context,
          securityContent,
          "Verify security selfie",
          "Verify security selfie?",
          true,
        ),
      );
    }

    if (currentManualValue != false) {
      buttons.add(
        _createVerificationChangeButton(
          context,
          securityContent,
          "Unverify security selfie",
          "Unverify security selfie?",
          false,
        ),
      );
    }

    if (currentManualValue != null) {
      buttons.add(
        _createVerificationChangeButton(
          context,
          securityContent,
          "Clear security selfie verification override",
          "Clear security selfie verification override?",
          null,
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final button in buttons) ...[button, const Padding(padding: EdgeInsets.only(top: 8))],
      ],
    );
  }

  Widget _createVerificationChangeButton(
    BuildContext context,
    ContentId securityContent,
    String buttonText,
    String dialogTitle,
    bool? value,
  ) {
    return ElevatedButton(
      onPressed: () async {
        final result = await confirmDialogForImage(
          context,
          widget.accountId,
          securityContent,
          dialogTitle,
        );
        if (result == true) {
          await _changeSecurityContentVerifiedValue(securityContent, value);
        }
      },
      child: Text(buttonText),
    );
  }

  Future<void> _changeSecurityContentVerifiedValue(ContentId securityContent, bool? value) async {
    final result = await widget.api.mediaAdminAction(
      (api) => api.postSecurityContentVerifiedValue(
        PostSecurityContentVerifiedValue(
          accountId: widget.accountId,
          securityContent: securityContent,
          value: value,
        ),
      ),
    );

    if (!context.mounted) {
      return;
    }

    if (result.isErr()) {
      showSnackBar(R.strings.generic_error);
      return;
    }

    await _getData();
  }

  Widget _securitySelfieWidget(
    BuildContext context,
    AccountId accountId,
    ContentId securitySelfie,
  ) {
    const double imgWidth = 150;
    const double imgHeight = 200;

    return SizedBox(
      width: imgWidth,
      height: imgHeight,
      child: Material(
        child: InkWell(
          onTap: () => openViewImageScreenForAccountImage(context, accountId, securitySelfie),
          child: accountImgWidgetInk(
            context,
            accountId,
            securitySelfie,
            cacheSize: ImageCacheSize.constantWidthAndHeight(context, imgWidth, imgHeight),
          ),
        ),
      ),
    );
  }
}
