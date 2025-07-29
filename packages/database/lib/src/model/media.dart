


import 'package:openapi/api.dart';

abstract class PublicContentProvider {
  List<ContentIdAndAccepted> get content;
}

class ContentIdAndAccepted {
  final ContentId id;
  final bool accepted;
  final bool primary;
  ContentIdAndAccepted(this.id, this.accepted, this.primary);

  @override
  bool operator ==(Object other) {
    return other is ContentIdAndAccepted &&
      id == other.id &&
      accepted == other.accepted &&
      primary == other.primary;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    accepted,
    primary,
  );
}

abstract class MyContentProvider {
  List<MyContent> get myContent;
}

class MyContent extends ContentIdAndAccepted {
  final bool faceDetected;
  final ContentModerationState state;
  final MediaContentModerationRejectedReasonCategory? rejectedCategory;
  final MediaContentModerationRejectedReasonDetails? rejectedDetails;
  MyContent(
    ContentId id,
    this.faceDetected,
    this.state,
    this.rejectedCategory,
    this.rejectedDetails,
    {
      required bool primaryContent,
    }
  ) : super(
    id,
    state == ContentModerationState.acceptedByBot || state == ContentModerationState.acceptedByHuman,
    primaryContent,
  );

  @override
  bool operator ==(Object other) {
    return other is MyContent &&
      id == other.id &&
      accepted == other.accepted &&
      faceDetected == other.faceDetected &&
      state == other.state &&
      rejectedCategory == other.rejectedCategory &&
      rejectedDetails == other.rejectedDetails;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    accepted,
    state,
    rejectedCategory,
    rejectedDetails,
  );
}
