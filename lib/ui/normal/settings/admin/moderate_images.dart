import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/admin/content_decicion_stream.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/admin/content_decicion_stream.dart';
import 'package:app/ui_utils/moderation.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/view_image_screen.dart';

const IMAGE_MODERATION_ROW_HEIGHT = 300.0;

class ModerateImagesPage extends MyScreenPageLimited<()> {
  ModerateImagesPage(
    RepositoryInstances r, {
    required ModerationQueueType queueType,
    required bool showContentWhichBotsCanModerate,
  }) : super(
         builder: (_) => ModerateImagesScreen(
           r,
           queueType: queueType,
           showContentWhichBotsCanModerate: showContentWhichBotsCanModerate,
         ),
       );
}

class ModerateImagesScreen extends ContentDecicionScreen<WrappedMediaContentPendingModeration> {
  final ModerationQueueType queueType;
  final bool showContentWhichBotsCanModerate;
  ModerateImagesScreen(
    RepositoryInstances r, {
    required this.queueType,
    required this.showContentWhichBotsCanModerate,
    super.key,
  }) : super(
         api: r.api,
         title: "Moderate profile images",
         infoMessageRowHeight: IMAGE_MODERATION_ROW_HEIGHT,
         io: MediaContentIo(r.api, r.media, showContentWhichBotsCanModerate, queueType),
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
    super.rejectedCategory,
    super.rejectedDetails,
  });

  @override
  AccountId get owner => accountId;

  @override
  AccountId? get target => null;
}

class MediaContentIo extends ContentIo<WrappedMediaContentPendingModeration> {
  final ApiManager api;
  final MediaRepository media;
  final bool showContentWhichBotsCanModerate;
  final ModerationQueueType queue;

  MediaContentIo(this.api, this.media, this.showContentWhichBotsCanModerate, this.queue);

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
          rejectedCategory: v.rejectedCategory,
          rejectedDetails: v.rejectedDetails,
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
      rejectedDetails: null,
    );
    await api.mediaAdminAction((api) => api.postModerateMediaContent(info));
  }
}

class MediaContentUiBuilder extends ContentUiBuilder<WrappedMediaContentPendingModeration> {
  @override
  Widget buildRowContent(BuildContext context, WrappedMediaContentPendingModeration content) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildRow(context, content, constraints.maxWidth.toInt()),
            rejectionDetailsText(
              context,
              category: content.rejectedCategory?.value,
              details: content.rejectedDetails?.value,
              containerColor: Colors.transparent,
              textColor: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        );
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
      securitySelfieWidget = buildImage(context, content.accountId, securitySelfie, maxWidth / 2);
    } else {
      securitySelfieWidget = SizedBox(
        width: maxWidth / 2,
        height: IMAGE_MODERATION_ROW_HEIGHT,
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
        buildImage(context, content.accountId, content.contentId, maxWidth / 2),
      ],
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
