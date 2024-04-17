

import 'package:openapi/api.dart';

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
