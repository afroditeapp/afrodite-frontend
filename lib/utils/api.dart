

import 'package:openapi/api.dart';
import 'package:pihka_frontend/utils/list.dart';

extension ModerationExtensions on Moderation {
  List<ContentId> contentList() {
    final l = [
      content.content0,
    ];
    _addNotNull(l, content.content1);
    _addNotNull(l, content.content2);
    _addNotNull(l, content.content3);
    _addNotNull(l, content.content4);
    _addNotNull(l, content.content5);
    _addNotNull(l, content.content6);
    return l;
  }
}

void _addNotNull<T>(List<T> l, T? e) {
  if (e != null) l.add(e);
}

extension ProfileVisibilityExtensions on ProfileVisibility {
  bool isInitialModerationOngoing() {
    return this == ProfileVisibility.pendingPrivate ||
      this == ProfileVisibility.pendingPublic;
  }
}

extension ModerationRequestStateExtensions on ModerationRequest {
  bool isOngoing() {
    return state == ModerationRequestState.waiting ||
      state == ModerationRequestState.inProgress;
  }

  List<ContentId> contentList() {
    final l = [
      content.content0,
    ];
    _addNotNull(l, content.content1);
    _addNotNull(l, content.content2);
    _addNotNull(l, content.content3);
    _addNotNull(l, content.content4);
    _addNotNull(l, content.content5);
    _addNotNull(l, content.content6);
    return l;
  }
}

extension ModerationRequestContentExtensions on ModerationRequestContent {
  static ModerationRequestContent? fromList(List<ContentId> content) {
    if (content.isEmpty) {
      return null;
    }
    return ModerationRequestContent(
      content0: content[0],
      content1: content.getAtOrNull(1),
      content2: content.getAtOrNull(2),
      content3: content.getAtOrNull(3),
      content4: content.getAtOrNull(4),
      content5: content.getAtOrNull(5),
      content6: content.getAtOrNull(6),
    );
  }
}

extension AttributeExtensions on Attribute {
  bool isBitflagAttributeWhenFiltering() {
    return mode == AttributeMode.selectMultipleFilterMultiple ||
      mode == AttributeMode.selectSingleFilterMultiple;
  }
}
