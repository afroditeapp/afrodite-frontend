
import 'package:async/async.dart';
import 'package:database_account_background/database_account_background.dart';
import 'package:database_converter/database_converter.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../schema.dart' as schema;

part 'notification.g.dart';

@DriftAccessor(
  tables: [
    schema.AdminNotification,
    schema.NotificationStatus,
    schema.UnreadMessagesCount,
    schema.NewMessageNotification,
    schema.NewReceivedLikesCount,
  ]
)
class DaoWriteNotification extends DatabaseAccessor<AccountBackgroundDatabase> with _$DaoWriteNotificationMixin {
  DaoWriteNotification(super.db);

  Future<void> _updateAdminNotificationInternal(api.AdminNotification? notification) async {
    await into(adminNotification).insertOnConflictUpdate(
      AdminNotificationCompanion.insert(
        id: SingleRowTable.ID,
        jsonViewedNotification: Value(notification?.toJsonObject()),
      ),
    );
  }

  Future<void> updateAdminNotification(api.AdminNotification notification) =>
    _updateAdminNotificationInternal(notification);

  Future<void> removeAdminNotification() =>
    _updateAdminNotificationInternal(null);

  late final UpdateNotificationStatus profilesFound = UpdateNotificationStatus(
    currentValueGetter: () async => await _watchNotificationStatusColumn((r) => r.jsonAutomaticProfileSearchFoundProfiles).firstOrNull,
    updateValue: (status) async => await into(notificationStatus).insertOnConflictUpdate(
      NotificationStatusCompanion.insert(
        id: SingleRowTable.ID,
        jsonAutomaticProfileSearchFoundProfiles: Value(status.toJsonObject()),
      ),
    ),
  );

  late final UpdateNotificationStatus mediaContentAccepted = UpdateNotificationStatus(
    currentValueGetter: () async => await _watchNotificationStatusColumn((r) => r.jsonMediaContentAccepted).firstOrNull,
    updateValue: (status) async => await into(notificationStatus).insertOnConflictUpdate(
      NotificationStatusCompanion.insert(
        id: SingleRowTable.ID,
        jsonMediaContentAccepted: Value(status.toJsonObject()),
      ),
    ),
  );

  late final UpdateNotificationStatus mediaContentRejected = UpdateNotificationStatus(
    currentValueGetter: () async => await _watchNotificationStatusColumn((r) => r.jsonMediaContentRejected).firstOrNull,
    updateValue: (status) async => await into(notificationStatus).insertOnConflictUpdate(
      NotificationStatusCompanion.insert(
        id: SingleRowTable.ID,
        jsonMediaContentRejected: Value(status.toJsonObject()),
      ),
    ),
  );

  late final UpdateNotificationStatus mediaContentDeleted = UpdateNotificationStatus(
    currentValueGetter: () async => await _watchNotificationStatusColumn((r) => r.jsonMediaContentDeleted).firstOrNull,
    updateValue: (status) async => await into(notificationStatus).insertOnConflictUpdate(
      NotificationStatusCompanion.insert(
        id: SingleRowTable.ID,
        jsonMediaContentDeleted: Value(status.toJsonObject()),
      ),
    ),
  );

  late final UpdateNotificationStatus profileNameAccepted = UpdateNotificationStatus(
    currentValueGetter: () async => await _watchNotificationStatusColumn((r) => r.jsonProfileNameAccepted).firstOrNull,
    updateValue: (status) async => await into(notificationStatus).insertOnConflictUpdate(
      NotificationStatusCompanion.insert(
        id: SingleRowTable.ID,
        jsonProfileNameAccepted: Value(status.toJsonObject()),
      ),
    ),
  );

  late final UpdateNotificationStatus profileNameRejected = UpdateNotificationStatus(
    currentValueGetter: () async => await _watchNotificationStatusColumn((r) => r.jsonProfileNameRejected).firstOrNull,
    updateValue: (status) async => await into(notificationStatus).insertOnConflictUpdate(
      NotificationStatusCompanion.insert(
        id: SingleRowTable.ID,
        jsonProfileNameRejected: Value(status.toJsonObject()),
      ),
    ),
  );

  late final UpdateNotificationStatus profileTextAccepted = UpdateNotificationStatus(
    currentValueGetter: () async => await _watchNotificationStatusColumn((r) => r.jsonProfileTextAccepted).firstOrNull,
    updateValue: (status) async => await into(notificationStatus).insertOnConflictUpdate(
      NotificationStatusCompanion.insert(
        id: SingleRowTable.ID,
        jsonProfileTextAccepted: Value(status.toJsonObject()),
      ),
    ),
  );

  late final UpdateNotificationStatus profileTextRejected = UpdateNotificationStatus(
    currentValueGetter: () async => await _watchNotificationStatusColumn((r) => r.jsonProfileTextRejected).firstOrNull,
    updateValue: (status) async => await into(notificationStatus).insertOnConflictUpdate(
      NotificationStatusCompanion.insert(
        id: SingleRowTable.ID,
        jsonProfileTextRejected: Value(status.toJsonObject()),
      ),
    ),
  );

  Stream<T?> _watchNotificationStatusColumn<T extends Object>(T? Function(NotificationStatusData) extractColumn) {
    return (select(notificationStatus)..where((t) => t.id.equals(SingleRowTable.ID.value)))
      .map(extractColumn)
      .watchSingleOrNull();
  }


  Future<void> setConversationId(api.AccountId accountId, api.ConversationId value) async {
    await into(newMessageNotification).insertOnConflictUpdate(
      NewMessageNotificationCompanion.insert(
        accountId: accountId,
        conversationId: Value(value),
      ),
    );
  }

  Future<void> setNewMessageNotificationShown(api.AccountId accountId, bool value) async {
    await into(newMessageNotification).insertOnConflictUpdate(
      NewMessageNotificationCompanion.insert(
        accountId: accountId,
        notificationShown: Value(value),
      ),
    );
  }
}

class UpdateNotificationStatus {
  final Future<JsonObject<api.NotificationStatus>?> Function() currentValueGetter;
  final Future<void> Function(api.NotificationStatus) updateValue;
  UpdateNotificationStatus({required this.currentValueGetter, required this.updateValue});

  /// Returns true when notification must be shown
  Future<bool> shouldBeShown(
    api.NotificationStatus newValue,
  ) async {
    final currentStatusJsonObject = await currentValueGetter();
    final currentStatus = currentStatusJsonObject?.value;
    await updateValue(newValue);
    return newValue.id.id != currentStatus?.id.id || newValue.viewed.id != currentStatus?.viewed.id;
  }

  Future<void> updateViewedId(
    api.NotificationIdViewed newValue,
  ) async {
    final currentStatusJsonObject = await currentValueGetter();
    final currentStatus = currentStatusJsonObject?.value ?? api.NotificationStatus(
        id: api.NotificationId(id: 0),
        viewed: api.NotificationIdViewed(id: 0),
      );
    currentStatus.viewed = newValue;
    await updateValue(currentStatus);
  }
}
