import 'package:openapi/api.dart';

abstract class PublicContentProvider {
  List<ContentIdAndAccepted> get content;
}

class ContentIdAndAccepted {
  final ContentId id;
  final bool accepted;
  final bool faceDetected;
  ContentIdAndAccepted(this.id, this.accepted, this.faceDetected);

  @override
  bool operator ==(Object other) {
    return other is ContentIdAndAccepted &&
        id == other.id &&
        accepted == other.accepted &&
        faceDetected == other.faceDetected;
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, accepted, faceDetected);
}

abstract class MyContentProvider {
  List<MyContent> get myContent;
}

class MyContent extends ContentIdAndAccepted {
  final ContentModerationState state;
  final MediaContentModerationRejectedReasonCategory? rejectedCategory;
  final MediaContentModerationRejectedReasonDetails? rejectedDetails;
  MyContent(
    ContentId id,
    bool faceDetected,
    this.state,
    this.rejectedCategory,
    this.rejectedDetails,
  ) : super(
        id,
        state == ContentModerationState.acceptedByBot ||
            state == ContentModerationState.acceptedByHuman,
        faceDetected,
      );

  @override
  bool operator ==(Object other) {
    return other is MyContent &&
        super == other &&
        state == other.state &&
        rejectedCategory == other.rejectedCategory &&
        rejectedDetails == other.rejectedDetails;
  }

  @override
  int get hashCode => Object.hash(super.hashCode, state, rejectedCategory, rejectedDetails);
}

class PrimaryProfileContent {
  final MyContent? content0;
  final double? gridCropSize;
  final double? gridCropX;
  final double? gridCropY;
  const PrimaryProfileContent({
    required this.content0,
    required this.gridCropSize,
    required this.gridCropX,
    required this.gridCropY,
  });
}
