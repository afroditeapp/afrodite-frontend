
import 'package:app/data/login_repository.dart';
import 'package:app/logic/admin/content_decicion_stream.dart';
import 'package:app/ui/normal/settings/admin/content_decicion_stream.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

const double ROW_HEIGHT = 100;

class ModerateProfileTextsScreen extends ContentDecicionScreen<WrappedProfileTextModeration> {
  ModerateProfileTextsScreen({
    required bool showTextsWhichBotsCanModerate,
    super.key,
  }) : super(
    title: "Moderate profile texts",
    infoMessageRowHeight: ROW_HEIGHT,
    io: ProfileTextIo(showTextsWhichBotsCanModerate),
    builder: ProfileTextUiBuilder(),
  );
}

class WrappedProfileTextModeration extends ProfileStringPendingModeration implements ContentInfoGetter {
  WrappedProfileTextModeration({
    required super.id,
    required super.value
  });

  @override
  AccountId get owner => id;

  @override
  AccountId? get target => null;
}

class ProfileTextIo extends ContentIo<WrappedProfileTextModeration> {
  final api = LoginRepository.getInstance().repositories.api;
  final bool showTextsWhichBotsCanModerate;

  ProfileTextIo(this.showTextsWhichBotsCanModerate);

  @override
  Future<Result<List<WrappedProfileTextModeration>, void>> getNextContent() async {
    return await api.profileAdmin((api) => api.getProfileStringPendingModerationList(ProfileStringModerationContentType.profileText, showTextsWhichBotsCanModerate))
      .mapOk((v) => v.values.map((v) => WrappedProfileTextModeration(id: v.id, value: v.value)).toList());
  }

  @override
  Future<void> sendToServer(WrappedProfileTextModeration content, bool accept) async {
    final info = PostModerateProfileString(
      contentType: ProfileStringModerationContentType.profileText,
      accept: accept,
      id: content.id,
      value: content.value,
      rejectedDetails: ProfileStringModerationRejectedReasonDetails(value: ""),
    );
    await api.profileAdminAction((api) => api.postModerateProfileString(info));
  }
}

class ProfileTextUiBuilder extends ContentUiBuilder<WrappedProfileTextModeration> {
  @override
  Widget buildRowContent(BuildContext context, WrappedProfileTextModeration content) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(content.value),
    );
  }
}
