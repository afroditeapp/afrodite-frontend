import 'package:database/database.dart';
import 'package:flutter/foundation.dart';

/// Controller for managing the selected reply target in a chat conversation.
/// Provides observable state for the reply target that can be used by widgets
/// to display and animate reply UI elements.
class ReplyTargetController extends ChangeNotifier {
  final ProfileEntry? profileEntry;
  MessageEntry? _replyTarget;

  ReplyTargetController({this.profileEntry});

  /// The current reply target message, or null if no message is selected for reply.
  MessageEntry? get replyTarget => _replyTarget;

  /// Sets the reply target to the specified message entry.
  /// Notifies listeners when the target changes.
  void setReplyTarget(MessageEntry? entry) {
    if (_replyTarget != entry) {
      _replyTarget = entry;
      notifyListeners();
    }
  }

  /// Clears the current reply target.
  /// Notifies listeners when the target is cleared.
  void clearReplyTarget() {
    if (_replyTarget != null) {
      _replyTarget = null;
      notifyListeners();
    }
  }
}
