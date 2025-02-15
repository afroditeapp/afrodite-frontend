
import 'package:app/data/login_repository.dart';
import 'package:app/logic/admin/content_decicion_stream.dart';
import 'package:app/ui/normal/settings/admin/content_decicion_stream.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

const double ROW_HEIGHT = 100;

class ProcessProfileNameReportsScreen extends ContentDecicionScreen<WrappedProfileNameReport> {
  ProcessProfileNameReportsScreen({
    super.key,
  }) : super(
    title: "Process profile name reports",
    infoMessageRowHeight: ROW_HEIGHT,
    io: ProfileNameReportIo(),
    builder: ProfileNameUiBuilder(),
  );
}

class WrappedProfileNameReport extends ProfileNameReportDetailed implements ContentInfoGetter {
  WrappedProfileNameReport({
    required super.info,
    required super.profileName,
  });

  @override
  AccountId get owner => info.creator;

  @override
  AccountId? get target => info.target;
}

class ProfileNameReportIo extends ContentIo<WrappedProfileNameReport> {
  final api = LoginRepository.getInstance().repositories.api;
  ProfileNameReportIo();

  @override
  Future<Result<List<WrappedProfileNameReport>, void>> getNextContent() async {
    return await api.profileAdmin((api) => api.getWaitingProfileNameReportPage())
      .mapOk((v) => v.values.map((v) => WrappedProfileNameReport(
        info: v.info,
        profileName: v.profileName,
      )).toList());
  }

  @override
  Future<void> sendToServer(WrappedProfileNameReport content, bool accept) async {
    final info = ProcessProfileNameReport(
      creator: content.info.creator,
      target: content.info.target,
      profileName: content.profileName ?? "",
    );
    await api.profileAdminAction((api) => api.postProcessProfileNameReport(info));
  }
}

class ProfileNameUiBuilder extends ContentUiBuilder<WrappedProfileNameReport> {
  @override
  bool get allowRejecting => false;

  @override
  Widget buildRowContent(BuildContext context, WrappedProfileNameReport content) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(content.profileName ?? ""),
    );
  }
}
