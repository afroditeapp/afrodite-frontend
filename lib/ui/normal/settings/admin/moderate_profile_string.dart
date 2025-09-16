import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/admin/content_decicion_stream.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/content_decicion_stream.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

const double ROW_HEIGHT = 100;

class ModerateProfileStringsPage extends MyScreenPageLimited<()> {
  ModerateProfileStringsPage(
    RepositoryInstances r, {
    required ProfileStringModerationContentType contentType,
    required bool showTextsWhichBotsCanModerate,
  }) : super(
         builder: (_) => ModerateProfileStringsScreen(
           r,
           contentType: contentType,
           showTextsWhichBotsCanModerate: showTextsWhichBotsCanModerate,
         ),
       );
}

class ModerateProfileStringsScreen extends ContentDecicionScreen<WrappedProfileStringModeration> {
  ModerateProfileStringsScreen(
    RepositoryInstances r, {
    required ProfileStringModerationContentType contentType,
    required bool showTextsWhichBotsCanModerate,
    super.key,
  }) : super(
         api: r.api,
         title: "Moderate ${contentType.adminUiTextPlular()}",
         infoMessageRowHeight: ROW_HEIGHT,
         io: ProfileStringIo(r.api, contentType, showTextsWhichBotsCanModerate),
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
  final ApiManager api;
  final ProfileStringModerationContentType contentType;
  final bool showTextsWhichBotsCanModerate;

  ProfileStringIo(this.api, this.contentType, this.showTextsWhichBotsCanModerate);

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
