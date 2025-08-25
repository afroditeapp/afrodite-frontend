import 'package:app/data/login_repository.dart';
import 'package:app/logic/admin/content_decicion_stream.dart';
import 'package:app/ui/normal/settings/admin/content_decicion_stream.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

const double ROW_HEIGHT = 100;

class ModerateProfileStringsScreen extends ContentDecicionScreen<WrappedProfileStringModeration> {
  ModerateProfileStringsScreen({
    required ProfileStringModerationContentType contentType,
    required bool showTextsWhichBotsCanModerate,
    super.key,
  }) : super(
         title: "Moderate ${contentType.adminUiTextPlular()}",
         infoMessageRowHeight: ROW_HEIGHT,
         io: ProfileStringIo(contentType, showTextsWhichBotsCanModerate),
         builder: ProfileTextUiBuilder(),
       );
}

class WrappedProfileStringModeration extends ProfileStringPendingModeration
    implements ContentInfoGetter {
  WrappedProfileStringModeration({required super.id, required super.value});

  @override
  AccountId get owner => id;

  @override
  AccountId? get target => null;
}

class ProfileStringIo extends ContentIo<WrappedProfileStringModeration> {
  final api = LoginRepository.getInstance().repositories.api;
  final ProfileStringModerationContentType contentType;
  final bool showTextsWhichBotsCanModerate;

  ProfileStringIo(this.contentType, this.showTextsWhichBotsCanModerate);

  @override
  Future<Result<List<WrappedProfileStringModeration>, ()>> getNextContent() async {
    return await api
        .profileAdmin(
          (api) =>
              api.getProfileStringPendingModerationList(contentType, showTextsWhichBotsCanModerate),
        )
        .mapOk(
          (v) => v.values
              .map((v) => WrappedProfileStringModeration(id: v.id, value: v.value))
              .toList(),
        )
        .emptyErr();
  }

  @override
  Future<void> sendToServer(WrappedProfileStringModeration content, bool accept) async {
    final info = PostModerateProfileString(
      contentType: contentType,
      accept: accept,
      id: content.id,
      value: content.value,
      rejectedDetails: ProfileStringModerationRejectedReasonDetails(value: ""),
    );
    await api.profileAdminAction((api) => api.postModerateProfileString(info));
  }
}

class ProfileTextUiBuilder extends ContentUiBuilder<WrappedProfileStringModeration> {
  @override
  Widget buildRowContent(BuildContext context, WrappedProfileStringModeration content) {
    return Padding(padding: const EdgeInsets.all(16.0), child: Text(content.value));
  }
}
