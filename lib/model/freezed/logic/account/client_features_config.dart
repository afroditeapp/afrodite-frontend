
import "package:app/localizations.dart";
import "package:app/utils/list.dart";
import "package:flutter/widgets.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import "package:intl/intl.dart";
import "package:openapi/api.dart";
import "package:utils/utils.dart";

part 'client_features_config.freezed.dart';

@freezed
class ClientFeaturesConfigData with _$ClientFeaturesConfigData {
  ClientFeaturesConfigData._();
  factory ClientFeaturesConfigData({
    required ClientFeaturesConfig config,
    RegExp? profileNameRegex,
    int? dailyLikesLeft,
  }) = _ClientFeaturesConfigData;

  Time? unlimitedLikesResetTime() {
    final timeString = config.limits.likes.unlimitedLikesDisablingTime;
    if (timeString == null) {
      return null;
    }

    final resetTime = Time.fromString(timeString);
    if (resetTime == null) {
      return null;
    }

    return resetTime;
  }

  Time? dailyLikesResetTime() {
    final limitConfig = config.limits.likes.likeSending;
    if (limitConfig == null) {
      return null;
    }

    final resetTime = Time.fromString(limitConfig.resetTime);
    if (resetTime == null) {
      return null;
    }

    return resetTime;
  }

  int valueDailyLikesLeft() {
    return dailyLikesLeft ?? 0;
  }

  bool dailyLikesLimitEnabled() {
    return config.limits.likes.likeSending != null;
  }

  List<String> newsLocales() {
    final locales = [
      ...?config.news?.locales,
    ];

    // Make sure that first item is "default" locale.
    final defaultLocale = "default";
    locales.remove(defaultLocale);
    locales.insert(0, defaultLocale);

    return locales;
  }

  String? aboutDialogAttribution(BuildContext context) {
    final locale = context.strings.localeName;
    return config.attribution.generic?.translations[locale] ?? config.attribution.generic?.default_;
  }

  String? ipCountryDataAttribution(BuildContext context) {
    final locale = context.strings.localeName;
    return config.attribution.ipCountry?.translations[locale] ?? config.attribution.ipCountry?.default_;
  }
}

class Time {
  final int hour;
  final int minute;
  Time(this.hour, this.minute);

  static Time? fromString(String time) {
    final values = time.split(":");
    final hourString = values.getAtOrNull(0);
    final minuteString = values.getAtOrNull(1);
    if (hourString == null || minuteString == null) {
      return null;
    }
    final hour = int.tryParse(hourString);
    final minute = int.tryParse(minuteString);
    if (hour == null || minute == null) {
      return null;
    }
    return Time(hour, minute);
  }

  String uiString() {
    final currentTime = UtcDateTime.now();
    return DateFormat('HH:mm').format(currentDayTime(currentTime, this).dateTime.toLocal());
  }

  @override
  bool operator ==(Object other) {
    return other is Time && hour == other.hour && minute == other.minute;
  }

  @override
  int get hashCode => Object.hash(hour, minute);
}

UtcDateTime currentDayTime(UtcDateTime currentTime, Time time) {
  return UtcDateTime.fromDateTime(currentTime.dateTime.copyWith(
    hour: time.hour,
    minute: time.minute,
    second: 0,
    millisecond: 0,
    microsecond: 0,
  ));
}
