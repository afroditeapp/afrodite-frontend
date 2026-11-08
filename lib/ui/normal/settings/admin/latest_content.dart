import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/admin/content_decision_stream.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui/normal/settings/admin/content_decision_stream.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/ui_utils/extensions/locale.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/time.dart';
import 'package:app/ui_utils/view_image_screen.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

const double LATEST_PROFILE_STRING_ROW_HEIGHT = 100;
const double LATEST_MEDIA_CONTENT_ROW_HEIGHT = 200;

/// Iteration origin point for the latest content APIs.
UnixTime latestContentOrigin() {
  return UnixTime(ut: DateTime.now().millisecondsSinceEpoch ~/ 1000 - 1);
}

class LatestContentPage extends MyScreenPageLimited<()> {
  LatestContentPage(RepositoryInstances r) : super(builder: (_) => LatestContentScreen(r));
}

class LatestContentScreen extends StatelessWidget {
  final RepositoryInstances r;
  const LatestContentScreen(this.r, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Latest content")),
      body: BlocBuilder<AccountBloc, AccountBlocData>(
        builder: (context, state) {
          final permissions = state.permissions;
          final widgets = <Widget>[];

          void addCategory(String title, List<Setting> settings) {
            if (settings.isEmpty) return;
            widgets.add(settingsCategoryTitle(context, title));
            widgets.addAll(settings.map((setting) => setting.toListTile()));
          }

          addCategory("Profile", [
            if (permissions.adminModerateProfileNames)
              Setting.createSetting(
                Icons.badge,
                "Profile names",
                () => MyNavigator.pushLimited(
                  context,
                  LatestProfileStringsPage(
                    r,
                    contentType: ProfileStringModerationContentType.profileName,
                  ),
                ),
              ),
            if (permissions.adminModerateProfileTexts)
              Setting.createSetting(
                Icons.notes,
                "Profile texts",
                () => MyNavigator.pushLimited(
                  context,
                  LatestProfileStringsPage(
                    r,
                    contentType: ProfileStringModerationContentType.profileText,
                  ),
                ),
              ),
          ]);

          addCategory("Media content", [
            if (permissions.adminModerateMediaContent) ...[
              Setting.createSetting(
                Icons.photo_camera_front,
                "Media content (security content)",
                () => MyNavigator.pushLimited(
                  context,
                  LatestMediaContentPage(r, onlySecurityContent: true),
                ),
              ),
              Setting.createSetting(
                Icons.photo_library,
                "Media content (all)",
                () => MyNavigator.pushLimited(
                  context,
                  LatestMediaContentPage(r, onlySecurityContent: false),
                ),
              ),
            ],
          ]);

          return SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets),
          );
        },
      ),
    );
  }
}

// Profile strings

class LatestProfileStringsPage extends MyScreenPageLimited<()> {
  LatestProfileStringsPage(
    RepositoryInstances r, {
    required ProfileStringModerationContentType contentType,
  }) : super(builder: (_) => LatestProfileStringsScreen(r, contentType: contentType));
}

class LatestProfileStringsScreen extends ContentDecisionScreen<WrappedProfileStringIteration> {
  LatestProfileStringsScreen(
    RepositoryInstances r, {
    required ProfileStringModerationContentType contentType,
    super.key,
  }) : super(
         api: r.api,
         title: "Latest ${contentType.adminUiTextPlural()}",
         infoMessageRowHeight: LATEST_PROFILE_STRING_ROW_HEIGHT,
         io: ProfileStringIterationIo(r.api, contentType),
         builder: LatestProfileStringUiBuilder(),
       );
}

class WrappedProfileStringIteration implements ContentInfoGetter {
  final AccountId id;
  final String value;
  final UnixTime editedTime;

  WrappedProfileStringIteration({required this.id, required this.value, required this.editedTime});

  @override
  AccountId get owner => id;

  @override
  AccountId? get target => null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WrappedProfileStringIteration &&
          other.id == id &&
          other.value == value &&
          other.editedTime == editedTime;

  @override
  int get hashCode => Object.hash(id, value, editedTime);
}

class ProfileStringIterationIo extends ContentIo<WrappedProfileStringIteration> {
  final ApiManager api;
  final ProfileStringModerationContentType contentType;
  final UnixTime origin;
  int page = 0;

  ProfileStringIterationIo(this.api, this.contentType, {UnixTime? origin})
    : origin = origin ?? latestContentOrigin();

  @override
  Future<Result<List<WrappedProfileStringIteration>, ()>> getNextContent() async {
    final result = await api.profileAdmin(
      (api) => api.getProfileStringIterationPage(contentType, page, origin.ut),
    );

    switch (result) {
      case Err():
        return const Err(());
      case Ok():
        page += 1;
        return Ok(
          result.v.values
              .map(
                (v) => WrappedProfileStringIteration(
                  id: v.id,
                  value: v.value,
                  editedTime: v.editedTime,
                ),
              )
              .toList(),
        );
    }
  }

  @override
  Future<void> sendToServer(
    WrappedProfileStringIteration content,
    bool accept, {
    String? rejectedDetails,
  }) async {
    // Decision making is disabled on this screen.
  }
}

class LatestProfileStringUiBuilder extends ContentUiBuilder<WrappedProfileStringIteration> {
  @override
  bool get allowAccepting => false;

  @override
  bool get allowRejecting => false;

  @override
  bool get rejectionDetailsSupported => false;

  @override
  Widget buildRowContent(
    BuildContext context,
    WrappedProfileStringIteration content, {
    String? rejectedDetails,
  }) {
    final localeString = Localizations.localeOf(context).localeString();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(content.value),
          const SizedBox(height: 4),
          Text(
            fullTimeString(content.editedTime.toUtcDateTime(), localeString),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

// Media content

class LatestMediaContentPage extends MyScreenPageLimited<()> {
  LatestMediaContentPage(RepositoryInstances r, {required bool onlySecurityContent})
    : super(builder: (_) => LatestMediaContentScreen(r, onlySecurityContent: onlySecurityContent));
}

class LatestMediaContentScreen extends ContentDecisionScreen<WrappedMediaContentIteration> {
  LatestMediaContentScreen(RepositoryInstances r, {required bool onlySecurityContent, super.key})
    : super(
        api: r.api,
        title: onlySecurityContent
            ? "Latest media content (security content)"
            : "Latest media content (all)",
        infoMessageRowHeight: LATEST_MEDIA_CONTENT_ROW_HEIGHT,
        io: MediaContentIterationIo(r.api, onlySecurityContent: onlySecurityContent),
        builder: LatestMediaContentUiBuilder(),
      );
}

class WrappedMediaContentIteration implements ContentInfoGetter {
  final AccountId accountId;
  final ContentId contentId;
  final bool faceDetected;
  final bool secureCapture;
  final UnixTime uploadedTime;

  WrappedMediaContentIteration({
    required this.accountId,
    required this.contentId,
    required this.faceDetected,
    required this.secureCapture,
    required this.uploadedTime,
  });

  @override
  AccountId get owner => accountId;

  @override
  AccountId? get target => null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WrappedMediaContentIteration &&
          other.accountId == accountId &&
          other.contentId == contentId &&
          other.faceDetected == faceDetected &&
          other.secureCapture == secureCapture &&
          other.uploadedTime == uploadedTime;

  @override
  int get hashCode => Object.hash(accountId, contentId, faceDetected, secureCapture, uploadedTime);
}

class MediaContentIterationIo extends ContentIo<WrappedMediaContentIteration> {
  final ApiManager api;
  final bool onlySecurityContent;
  final UnixTime origin;
  int page = 0;

  MediaContentIterationIo(this.api, {required this.onlySecurityContent, UnixTime? origin})
    : origin = origin ?? latestContentOrigin();

  @override
  Future<Result<List<WrappedMediaContentIteration>, ()>> getNextContent() async {
    final result = await api.mediaAdmin(
      (api) => api.getMediaContentIterationPage(
        page,
        origin.ut,
        onlySecurityContent: onlySecurityContent,
      ),
    );

    switch (result) {
      case Err():
        return const Err(());
      case Ok():
        page += 1;
        return Ok(
          result.v.values
              .map(
                (v) => WrappedMediaContentIteration(
                  accountId: v.accountId,
                  contentId: v.contentId,
                  faceDetected: v.faceDetected,
                  secureCapture: v.secureCapture,
                  uploadedTime: v.uploadedTime,
                ),
              )
              .toList(),
        );
    }
  }

  @override
  Future<void> sendToServer(
    WrappedMediaContentIteration content,
    bool accept, {
    String? rejectedDetails,
  }) async {
    // Decision making is disabled on this screen.
  }
}

class LatestMediaContentUiBuilder extends ContentUiBuilder<WrappedMediaContentIteration> {
  @override
  bool get allowAccepting => false;

  @override
  bool get allowRejecting => false;

  @override
  bool get rejectionDetailsSupported => false;

  @override
  Widget buildRowContent(
    BuildContext context,
    WrappedMediaContentIteration content, {
    String? rejectedDetails,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageWidth = constraints.maxWidth / 2;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () =>
                  openViewImageScreenForAccountImage(context, content.accountId, content.contentId),
              child: accountImgWidget(
                context,
                content.accountId,
                content.contentId,
                width: imageWidth,
                height: LATEST_MEDIA_CONTENT_ROW_HEIGHT,
                cacheSize: ImageCacheSize.constantHeight(context, LATEST_MEDIA_CONTENT_ROW_HEIGHT),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _infoWidget(context, content),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _infoWidget(BuildContext context, WrappedMediaContentIteration content) {
    final localeString = Localizations.localeOf(context).localeString();
    final style = Theme.of(context).textTheme.bodySmall;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fullTimeString(content.uploadedTime.toUtcDateTime(), localeString), style: style),
        if (content.secureCapture) Text("secure capture", style: style),
        if (content.faceDetected) Text("face detected", style: style),
      ],
    );
  }
}
