
import 'package:app/data/login_repository.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/admin/content_decicion_stream.dart';
import 'package:app/ui/normal/settings/admin/content_decicion_stream.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

const double ROW_HEIGHT = 100;

class ProcessReportsScreen extends ContentDecicionScreen<WrappedReportDetailed> {
  ProcessReportsScreen({
    super.key,
  }) : super(
    title: "Process reports",
    screenInstructions: ReportUiBuilder.instructions,
    infoMessageRowHeight: ROW_HEIGHT,
    io: ReportIo(),
    builder: ReportUiBuilder(),
  );
}

class WrappedReportDetailed extends ReportDetailed implements ContentInfoGetter {
  WrappedReportDetailed({
    required super.content,
    required super.info,
    required super.creatorInfo,
    required super.targetInfo,
    required super.chatInfo,
  });

  @override
  AccountId get owner => info.creator;

  @override
  AccountId? get target => info.target;
}

class ReportIo extends ContentIo<WrappedReportDetailed> {
  final api = LoginRepository.getInstance().repositories.api;
  ReportIo();

  @override
  Future<Result<List<WrappedReportDetailed>, void>> getNextContent() async {
    return await api.accountCommonAdmin((api) => api.getWaitingReportPage())
      .mapOk((v) => v.values.map((v) => WrappedReportDetailed(
        info: v.info,
        content: v.content,
        creatorInfo: v.creatorInfo,
        targetInfo: v.targetInfo,
        chatInfo: v.chatInfo,
      )).toList());
  }

  @override
  Future<void> sendToServer(WrappedReportDetailed content, bool accept) async {
    final info = ProcessReport(
      creator: content.info.creator,
      target: content.info.target,
      reportType: content.info.reportType,
      content: content.content,
    );
    await api.accountCommonAdminAction((api) => api.postProcessReport(info));
  }
}

class ReportUiBuilder extends ContentUiBuilder<WrappedReportDetailed> {
  @override
  bool get allowRejecting => false;

  static String instructions = "B = block received, L = like received, Mnumber = match and sent messages count";

  @override
  Widget buildRowContent(BuildContext context, WrappedReportDetailed content) {
    final creatorInfo = content.creatorInfo;
    final targetInfo = content.targetInfo;
    final chatInfo = content.chatInfo;

    final String creatorDetails;
    final String targetDetails;
    if (chatInfo != null) {
      final String creatorMessages;
      if (chatInfo.creatorSentMessagesCount == 0) {
        creatorMessages = "";
      } else {
        creatorMessages = chatInfo.creatorSentMessagesCount.toString();
      }
      final infoCreator = [
        if (chatInfo.targetBlockedCreator) "B",
        if (chatInfo.state == ReportChatInfoInteractionState.targetLiked) "L",
        if (chatInfo.state == ReportChatInfoInteractionState.match) "M$creatorMessages",
      ];
      if (infoCreator.isNotEmpty) {
        creatorDetails = ", ${infoCreator.join("")}";
      } else {
        creatorDetails = "";
      }
      final String targetMessages;
      if (chatInfo.targetSentMessagesCount == 0) {
        targetMessages = "";
      } else {
        targetMessages = chatInfo.targetSentMessagesCount.toString();
      }
      final infoTarget = [
        if (chatInfo.creatorBlockedTarget) "B",
        if (chatInfo.state == ReportChatInfoInteractionState.creatorLiked) "L",
        if (chatInfo.state == ReportChatInfoInteractionState.match) "M$targetMessages",
      ];
      if (infoTarget.isNotEmpty) {
        targetDetails = ", ${infoTarget.join("")}";
      } else {
        targetDetails = "";
      }
    } else {
      creatorDetails = "";
      targetDetails = "";
    }

    final String infoText;
    if (creatorInfo != null && targetInfo != null) {
      infoText = "${creatorInfo.name}, ${creatorInfo.age}$creatorDetails -> ${targetInfo.name}, ${targetInfo.age}$targetDetails";
    } else {
      infoText = "";
    }

    final profileName = content.content.profileName;
    final profileText = content.content.profileText;
    final Widget report;

    if (profileName != null) {
      report = Text(profileName);
    } else if (profileText != null) {
      report = Text(profileText);
    } else {
      report = Text(context.strings.generic_error);
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(infoText),
          const Padding(padding: EdgeInsets.only(top: 8)),
          report,
        ],
      ),
    );
  }
}
