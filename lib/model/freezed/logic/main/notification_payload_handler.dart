
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:pihka_frontend/data/general/notification/utils/notification_payload.dart';
import 'package:pihka_frontend/utils/immutable_list.dart';

part 'notification_payload_handler.freezed.dart';

@freezed
class NotificationPayloadHandlerData with _$NotificationPayloadHandlerData {
  factory NotificationPayloadHandlerData({
    @Default(UnmodifiableList<NotificationPayload>.empty())
      UnmodifiableList<NotificationPayload> toBeHandled,
  }) = _NotificationPayloadHandlerData;
}
