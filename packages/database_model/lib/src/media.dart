import 'package:openapi/api.dart';

abstract class PublicContentProvider {
  List<ContentIdAndAccepted> get content;
}

class ContentIdAndAccepted {
  final ContentId id;
  final bool accepted;
  final bool faceDetected;
  final bool? faceVerified;
  ContentIdAndAccepted(this.id, this.accepted, this.faceDetected, {this.faceVerified});

  @override
  bool operator ==(Object other) {
    return other is ContentIdAndAccepted &&
        id == other.id &&
        accepted == other.accepted &&
        faceDetected == other.faceDetected &&
        faceVerified == other.faceVerified;
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, accepted, faceDetected, faceVerified);
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
    bool? faceVerified,
    this.state,
    this.rejectedCategory,
    this.rejectedDetails,
  ) : super(
        id,
        state == ContentModerationState.acceptedByBot ||
            state == ContentModerationState.acceptedByHuman,
        faceDetected,
        faceVerified: faceVerified,
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
