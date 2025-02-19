
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

  @override
  Widget buildRowContent(BuildContext context, WrappedReportDetailed content) {
    final creatorInfo = content.creatorInfo;
    final targetInfo = content.targetInfo;

    final String infoText;
    if (creatorInfo != null && targetInfo != null) {
      infoText = "${creatorInfo.name}, ${creatorInfo.age} -> ${targetInfo.name}, ${targetInfo.age}";
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
