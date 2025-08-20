import 'package:app/data/image_cache.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/logic/admin/content_decicion_stream.dart';
import 'package:app/ui/normal/settings/admin/content_decicion_stream.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/view_image_screen.dart';

const ROW_HEIGHT = 300.0;

class ModerateImagesScreen extends ContentDecicionScreen<WrappedMediaContentPendingModeration> {
  final ModerationQueueType queueType;
  final bool showContentWhichBotsCanModerate;
  ModerateImagesScreen({
    required this.queueType,
    required this.showContentWhichBotsCanModerate,
    super.key,
  }) : super(
         title: "Moderate profile images",
         infoMessageRowHeight: ROW_HEIGHT,
         io: MediaContentIo(showContentWhichBotsCanModerate, queueType),
         builder: MediaContentUiBuilder(),
       );
}

class WrappedMediaContentPendingModeration extends MediaContentPendingModeration
    implements ContentInfoGetter {
  final ContentId? securitySelfie;
  WrappedMediaContentPendingModeration({
    required this.securitySelfie,
    required super.accountId,
    required super.contentId,
  });

  @override
  AccountId get owner => accountId;

  @override
  AccountId? get target => null;
}

class MediaContentIo extends ContentIo<WrappedMediaContentPendingModeration> {
  final media = LoginRepository.getInstance().repositories.media;
  final api = LoginRepository.getInstance().repositories.api;
  final bool showContentWhichBotsCanModerate;
  final ModerationQueueType queue;

  MediaContentIo(this.showContentWhichBotsCanModerate, this.queue);

  @override
  Future<Result<List<WrappedMediaContentPendingModeration>, ()>> getNextContent() async {
    final r = await api.mediaAdmin(
      (api) => api.getMediaContentPendingModerationList(
        MediaContentType.jpegImage,
        queue,
        showContentWhichBotsCanModerate,
      ),
    );

    final GetMediaContentPendingModerationList list;
    switch (r) {
      case Err():
        return const Err(());
      case Ok():
        list = r.v;
    }

    List<WrappedMediaContentPendingModeration> newList = [];
    for (final v in list.values) {
      var securitySelfie = await media.getSecuritySelfie(v.accountId);

      newList.add(
        WrappedMediaContentPendingModeration(
          securitySelfie: securitySelfie,
          accountId: v.accountId,
          contentId: v.contentId,
        ),
      );
    }

    return Ok(newList);
  }

  @override
  Future<void> sendToServer(WrappedMediaContentPendingModeration content, bool accept) async {
    final info = PostModerateMediaContent(
      accept: accept,
      accountId: content.accountId,
      contentId: content.contentId,
      rejectedDetails: MediaContentModerationRejectedReasonDetails(value: ""),
    );
    await api.mediaAdminAction((api) => api.postModerateMediaContent(info));
  }
}

class MediaContentUiBuilder extends ContentUiBuilder<WrappedMediaContentPendingModeration> {
  @override
  Widget buildRowContent(BuildContext context, WrappedMediaContentPendingModeration content) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return buildRow(context, content, constraints.maxWidth.toInt());
      },
    );
  }

  Widget buildRow(
    BuildContext context,
    WrappedMediaContentPendingModeration content,
    int maxWidth,
  ) {
    final securitySelfie = content.securitySelfie;
    final Widget securitySelfieWidget;
    if (securitySelfie != null) {
      securitySelfieWidget = buildImage(
        context,
        content.accountId,
        securitySelfie,
        maxWidth / 2,
        ROW_HEIGHT,
      );
    } else {
      securitySelfieWidget = SizedBox(
        width: maxWidth / 2,
        height: ROW_HEIGHT,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(context.strings.generic_empty)],
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        securitySelfieWidget,
        buildImage(context, content.accountId, content.contentId, maxWidth / 2, ROW_HEIGHT),
      ],
    );
  }

  Widget buildImage(
    BuildContext context,
    AccountId imageOwner,
    ContentId image,
    double width,
    double height,
  ) {
    return InkWell(
      onTap: () {
        MyNavigator.push(
          context,
          MaterialPage<void>(child: ViewImageScreen(ViewImageAccountContent(imageOwner, image))),
        );
      },
      child: accountImgWidget(
        imageOwner,
        image,
        width: width,
        height: height,
        cacheSize: ImageCacheSize.halfScreen(context),
      ),
    );
  }
}
