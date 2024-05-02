

class NotificationId {
  final int value;
  const NotificationId(this.value);
}

enum NotificationIdStatic {
  likeReceived(id: NotificationId(0)),
  moderationRequestStatus(id: NotificationId(1));

  final NotificationId id;
  const NotificationIdStatic({
    required this.id,
  });
}

enum NotificationIdDynamic {
  messageReceived(range: IdRange(min: 10000, max: 19999));

  final IdRange range;
  const NotificationIdDynamic({
    required this.range,
  });
}

class IdRange {
  final int min;
  final int max;

  const IdRange({
    required this.min,
    required this.max,
  });
}

class NotificationIdAndState<S> {
  final NotificationId id;
  final S state;
  const NotificationIdAndState({
    required this.id,
    required this.state,
  });
}

/// K must be work in Map as a key.
class DynamicNotificationIdMap<K, S> {
  final IdRange range;
  final Map<K, NotificationIdAndState<S>> currentStates = {};

  DynamicNotificationIdMap({
    required this.range,
  });

  NotificationIdAndState<S> getState(K key, {required S defaultValue}) {
    final currentState = currentStates[key];
    if (currentState != null) {
      return currentState;
    } else {
      final id = nextAvailableNotificationId();
      final state = NotificationIdAndState(id: NotificationId(id), state: defaultValue);
      currentStates[key] = state;
      return state;
    }
  }

  NotificationIdAndState<S>? removeState(K key) {
    return currentStates.remove(key);
  }

  int nextAvailableNotificationId() {
    final Set<int> currentNotificationIds = currentStates.values.map((e) => e.id.value).toSet();
    int nextId = range.max; // fallback to last ID
    for (int i = range.min; i <= range.max; i++) {
      if (!currentNotificationIds.contains(i)) {
        nextId = i;
        break;
      }
    }
    return nextId;
  }
}
