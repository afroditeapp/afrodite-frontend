
import 'package:app/data/login_repository.dart';
import 'package:app/logic/admin/content_decicion_stream.dart';
import 'package:app/ui/normal/settings/admin/content_decicion_stream.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

const double ROW_HEIGHT = 100;

class ProcessProfileTextReportsScreen extends ContentDecicionScreen<WrappedProfileTextReport> {
  ProcessProfileTextReportsScreen({
    super.key,
  }) : super(
    title: "Process profile text reports",
    infoMessageRowHeight: ROW_HEIGHT,
    io: ProfileTextReportIo(),
    builder: ProfileTextUiBuilder(),
  );
}

class WrappedProfileTextReport extends ProfileTextReportDetailed implements ContentInfoGetter {
  WrappedProfileTextReport({
    required super.info,
    required super.profileText,
  });

  @override
  AccountId get owner => info.creator;

  @override
  AccountId? get target => info.target;
}

class ProfileTextReportIo extends ContentIo<WrappedProfileTextReport> {
  final api = LoginRepository.getInstance().repositories.api;
  ProfileTextReportIo();

  @override
  Future<Result<List<WrappedProfileTextReport>, void>> getNextContent() async {
    return await api.profileAdmin((api) => api.getWaitingProfileTextReportPage())
      .mapOk((v) => v.values.map((v) => WrappedProfileTextReport(
        info: v.info,
        profileText: v.profileText,
      )).toList());
  }

  @override
  Future<void> sendToServer(WrappedProfileTextReport content, bool accept) async {
    final info = ProcessProfileTextReport(
      creator: content.info.creator,
      target: content.info.target,
      profileText: content.profileText ?? "",
    );
    await api.profileAdminAction((api) => api.postProcessProfileTextReport(info));
  }
}

class ProfileTextUiBuilder extends ContentUiBuilder<WrappedProfileTextReport> {
  @override
  bool get allowRejecting => false;

  @override
  Widget buildRowContent(BuildContext context, WrappedProfileTextReport content) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(content.profileText ?? ""),
    );
  }
}
