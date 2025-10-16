import 'dart:convert';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/custom_reports_config.dart';
import 'package:app/logic/admin/content_decicion_stream.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/chat/message_row.dart';
import 'package:app/ui/normal/settings/admin/content_decicion_stream.dart';
import 'package:app/ui/normal/settings/admin/moderate_images.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/view_image_screen.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/app_error.dart';
import 'package:app/utils/list.dart';
import 'package:app/utils/result.dart';
import 'package:app/utils/time.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

const double ROW_HEIGHT = 100;

class ProcessReportsPage extends MyScreenPageLimited<()> {
  ProcessReportsPage(RepositoryInstances r) : super(builder: (_) => ProcessReportsScreen(r));
}

class ProcessReportsScreen extends ContentDecicionScreen<WrappedReportDetailed> {
  ProcessReportsScreen(RepositoryInstances r, {super.key})
    : super(
        api: r.api,
        title: "Process reports",
        screenInstructions: ReportUiBuilder.instructions,
        infoMessageRowHeight: ROW_HEIGHT,
        io: ReportIo(r.api),
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
  final ApiManager api;
  ReportIo(this.api);

  Set<ReportId> addedReports = {};

  @override
  Future<Result<List<WrappedReportDetailed>, ()>> getNextContent() async {
    return await api
        .commonAdmin((api) => api.getWaitingReportPage())
        .andThenEmptyErr(
          (v) => handleReportList(api, addedReports, v.values, onlyNotProcessed: true),
        );
  }

  @override
  Future<void> sendToServer(WrappedReportDetailed content, bool accept) async {
    final info = ProcessReport(
      creator: content.info.creator,
      target: content.info.target,
      reportType: content.info.reportType,
      content: content.content,
    );
    await api.commonAdminAction((api) => api.postProcessReport(info));
  }
}

Future<Result<List<WrappedReportDetailed>, ApiError>> handleReportList(
  ApiManager api,
  Set<ReportId> addedReports,
  List<ReportDetailed> reportList, {
  required bool onlyNotProcessed,
}) async {
  final detailedReports = <WrappedReportDetailed>[];
  for (final r in reportList) {
    if (addedReports.contains(r.info.id)) {
      continue;
    }

    if (r.content.chatMessage != null) {
      final apiResult = await api.commonAdmin(
        (api) => api.postGetChatMessageReports(
          GetChatMessageReports(
            creator: r.info.creator,
            target: r.info.target,
            onlyNotProcessed: onlyNotProcessed,
          ),
        ),
      );

      switch (apiResult) {
        case Err(:final e):
          return Err(e);
        case Ok(:final v):
          for (final chatReport in v.values) {
            if (addedReports.contains(chatReport.info.id)) {
              continue;
            }
            addedReports.add(chatReport.info.id);
            detailedReports.add(chatReport.toWrapped());
          }
      }
    } else {
      addedReports.add(r.info.id);
      detailedReports.add(r.toWrapped());
    }
  }
  return Ok(detailedReports);
}

class ReportUiBuilder extends ContentUiBuilder<WrappedReportDetailed> {
  @override
  bool get allowRejecting => false;

  static String instructions =
      "B = block received\nL = like received\nMnumber = match and sent messages count\n\nN = profile name\nT = profile text\nM = chat message\nC = custom report";

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

    final String infoText =
        "${creatorInfo.name}, ${creatorInfo.age}$creatorDetails -> ${targetInfo.name}, ${targetInfo.age}$targetDetails";

    const FIRST_CUSTOM_REPORT_TYPE_NUMBER = 64;

    final profileName = content.content.profileName;
    final profileText = content.content.profileText;
    final profileContent = content.content.profileContent;
    final chatMessage = content.content.chatMessage;
    final customReport = content.info.reportType.n >= FIRST_CUSTOM_REPORT_TYPE_NUMBER;
    final target = content.target;
    final Widget report;

    if (profileName != null) {
      report = Text("N: $profileName");
    } else if (profileText != null) {
      report = Text("T: $profileText");
    } else if (profileContent != null && target != null) {
      report = LayoutBuilder(
        builder: (context, constraints) {
          return buildImage(context, target, profileContent, constraints.maxWidth / 2);
        },
      );
    } else if (chatMessage != null) {
      final String senderReceiverInfo;
      if (chatMessage.sender == content.target) {
        senderReceiverInfo = "${targetInfo.name.toString()} -> ${creatorInfo.name.toString()}";
      } else {
        senderReceiverInfo = "${creatorInfo.name.toString()} -> ${targetInfo.name.toString()}";
      }
      final time = timeString(chatMessage.messageTime.toUtcDateTime());
      final message = Message.parseFromBytes(base64Decode(chatMessage.messageBase64));
      final String messageText = "\n${messageToText(context, message)}";
      report = Text("M: $senderReceiverInfo, ID: ${chatMessage.messageId.id}, $time$messageText");
    } else if (customReport) {
      report = BlocBuilder<CustomReportsConfigBloc, CustomReportsConfig>(
        builder: (context, config) {
          final reportId = content.info.reportType.n - FIRST_CUSTOM_REPORT_TYPE_NUMBER;
          final customReportInfo = config.reports.getAtOrNull(reportId);
          if (customReportInfo != null) {
            final text = customReportInfo.translatedName(context);
            return Text("C: $text");
          } else {
            return const Text("Matching custom report type not found from config");
          }
        },
      );
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

  Widget buildImage(BuildContext context, AccountId imageOwner, ContentId image, double width) {
    return InkWell(
      onTap: () => openViewImageScreenForAccountImage(context, imageOwner, image),
      child: accountImgWidget(
        context,
        imageOwner,
        image,
        width: width,
        height: IMAGE_MODERATION_ROW_HEIGHT,
        cacheSize: ImageCacheSize.constantHeight(context, IMAGE_MODERATION_ROW_HEIGHT),
      ),
    );
  }
}
