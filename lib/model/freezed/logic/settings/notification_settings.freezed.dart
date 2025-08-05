// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_settings.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
class _DetectDefaultValueInCopyWith {
  const _DetectDefaultValueInCopyWith();
}

/// @nodoc
const _detectDefaultValueInCopyWith = _DetectDefaultValueInCopyWith();

/// @nodoc
final _privateConstructorErrorNotificationSettingsData = UnsupportedError(
    'Private constructor NotificationSettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$NotificationSettingsData {
  UpdateState get updateState => throw _privateConstructorErrorNotificationSettingsData;
  bool get areNotificationsEnabled => throw _privateConstructorErrorNotificationSettingsData;
  NotificationCategoryData get categories => throw _privateConstructorErrorNotificationSettingsData;
  NotificationCategoryData get systemCategories => throw _privateConstructorErrorNotificationSettingsData;
  EditedNotificationSettingsData get edited => throw _privateConstructorErrorNotificationSettingsData;

  NotificationSettingsData copyWith({
    UpdateState? updateState,
    bool? areNotificationsEnabled,
    NotificationCategoryData? categories,
    NotificationCategoryData? systemCategories,
    EditedNotificationSettingsData? edited,
  }) => throw _privateConstructorErrorNotificationSettingsData;
}

/// @nodoc
abstract class _NotificationSettingsData extends NotificationSettingsData {
  factory _NotificationSettingsData({
    UpdateState updateState,
    bool areNotificationsEnabled,
    required NotificationCategoryData categories,
    required NotificationCategoryData systemCategories,
    required EditedNotificationSettingsData edited,
  }) = _$NotificationSettingsDataImpl;
  _NotificationSettingsData._() : super._();
}

/// @nodoc
class _$NotificationSettingsDataImpl extends _NotificationSettingsData with DiagnosticableTreeMixin {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();
  static const bool _areNotificationsEnabledDefaultValue = false;
  
  _$NotificationSettingsDataImpl({
    this.updateState = _updateStateDefaultValue,
    this.areNotificationsEnabled = _areNotificationsEnabledDefaultValue,
    required this.categories,
    required this.systemCategories,
    required this.edited,
  }) : super._();

  @override
  final UpdateState updateState;
  @override
  final bool areNotificationsEnabled;
  @override
  final NotificationCategoryData categories;
  @override
  final NotificationCategoryData systemCategories;
  @override
  final EditedNotificationSettingsData edited;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NotificationSettingsData(updateState: $updateState, areNotificationsEnabled: $areNotificationsEnabled, categories: $categories, systemCategories: $systemCategories, edited: $edited)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NotificationSettingsData'))
      ..add(DiagnosticsProperty('updateState', updateState))
      ..add(DiagnosticsProperty('areNotificationsEnabled', areNotificationsEnabled))
      ..add(DiagnosticsProperty('categories', categories))
      ..add(DiagnosticsProperty('systemCategories', systemCategories))
      ..add(DiagnosticsProperty('edited', edited));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$NotificationSettingsDataImpl &&
        (identical(other.updateState, updateState) ||
          other.updateState == updateState) &&
        (identical(other.areNotificationsEnabled, areNotificationsEnabled) ||
          other.areNotificationsEnabled == areNotificationsEnabled) &&
        (identical(other.categories, categories) ||
          other.categories == categories) &&
        (identical(other.systemCategories, systemCategories) ||
          other.systemCategories == systemCategories) &&
        (identical(other.edited, edited) ||
          other.edited == edited)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    updateState,
    areNotificationsEnabled,
    categories,
    systemCategories,
    edited,
  );

  @override
  NotificationSettingsData copyWith({
    Object? updateState,
    Object? areNotificationsEnabled,
    Object? categories,
    Object? systemCategories,
    Object? edited,
  }) => _$NotificationSettingsDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    areNotificationsEnabled: (areNotificationsEnabled ?? this.areNotificationsEnabled) as bool,
    categories: (categories ?? this.categories) as NotificationCategoryData,
    systemCategories: (systemCategories ?? this.systemCategories) as NotificationCategoryData,
    edited: (edited ?? this.edited) as EditedNotificationSettingsData,
  );
}

/// @nodoc
final _privateConstructorErrorNotificationCategoryData = UnsupportedError(
    'Private constructor NotificationCategoryData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$NotificationCategoryData {
  bool get messages => throw _privateConstructorErrorNotificationCategoryData;
  bool get likes => throw _privateConstructorErrorNotificationCategoryData;
  bool get mediaContentModerationCompleted => throw _privateConstructorErrorNotificationCategoryData;
  bool get profileStringModerationCompleted => throw _privateConstructorErrorNotificationCategoryData;
  bool get news => throw _privateConstructorErrorNotificationCategoryData;
  bool get automaticProfileSearch => throw _privateConstructorErrorNotificationCategoryData;

  NotificationCategoryData copyWith({
    bool? messages,
    bool? likes,
    bool? mediaContentModerationCompleted,
    bool? profileStringModerationCompleted,
    bool? news,
    bool? automaticProfileSearch,
  }) => throw _privateConstructorErrorNotificationCategoryData;
}

/// @nodoc
abstract class _NotificationCategoryData extends NotificationCategoryData {
  factory _NotificationCategoryData({
    bool messages,
    bool likes,
    bool mediaContentModerationCompleted,
    bool profileStringModerationCompleted,
    bool news,
    bool automaticProfileSearch,
  }) = _$NotificationCategoryDataImpl;
  _NotificationCategoryData._() : super._();
}

/// @nodoc
class _$NotificationCategoryDataImpl extends _NotificationCategoryData with DiagnosticableTreeMixin {
  static const bool _messagesDefaultValue = true;
  static const bool _likesDefaultValue = true;
  static const bool _mediaContentModerationCompletedDefaultValue = true;
  static const bool _profileStringModerationCompletedDefaultValue = true;
  static const bool _newsDefaultValue = true;
  static const bool _automaticProfileSearchDefaultValue = true;
  
  _$NotificationCategoryDataImpl({
    this.messages = _messagesDefaultValue,
    this.likes = _likesDefaultValue,
    this.mediaContentModerationCompleted = _mediaContentModerationCompletedDefaultValue,
    this.profileStringModerationCompleted = _profileStringModerationCompletedDefaultValue,
    this.news = _newsDefaultValue,
    this.automaticProfileSearch = _automaticProfileSearchDefaultValue,
  }) : super._();

  @override
  final bool messages;
  @override
  final bool likes;
  @override
  final bool mediaContentModerationCompleted;
  @override
  final bool profileStringModerationCompleted;
  @override
  final bool news;
  @override
  final bool automaticProfileSearch;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NotificationCategoryData(messages: $messages, likes: $likes, mediaContentModerationCompleted: $mediaContentModerationCompleted, profileStringModerationCompleted: $profileStringModerationCompleted, news: $news, automaticProfileSearch: $automaticProfileSearch)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NotificationCategoryData'))
      ..add(DiagnosticsProperty('messages', messages))
      ..add(DiagnosticsProperty('likes', likes))
      ..add(DiagnosticsProperty('mediaContentModerationCompleted', mediaContentModerationCompleted))
      ..add(DiagnosticsProperty('profileStringModerationCompleted', profileStringModerationCompleted))
      ..add(DiagnosticsProperty('news', news))
      ..add(DiagnosticsProperty('automaticProfileSearch', automaticProfileSearch));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$NotificationCategoryDataImpl &&
        (identical(other.messages, messages) ||
          other.messages == messages) &&
        (identical(other.likes, likes) ||
          other.likes == likes) &&
        (identical(other.mediaContentModerationCompleted, mediaContentModerationCompleted) ||
          other.mediaContentModerationCompleted == mediaContentModerationCompleted) &&
        (identical(other.profileStringModerationCompleted, profileStringModerationCompleted) ||
          other.profileStringModerationCompleted == profileStringModerationCompleted) &&
        (identical(other.news, news) ||
          other.news == news) &&
        (identical(other.automaticProfileSearch, automaticProfileSearch) ||
          other.automaticProfileSearch == automaticProfileSearch)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    messages,
    likes,
    mediaContentModerationCompleted,
    profileStringModerationCompleted,
    news,
    automaticProfileSearch,
  );

  @override
  NotificationCategoryData copyWith({
    Object? messages,
    Object? likes,
    Object? mediaContentModerationCompleted,
    Object? profileStringModerationCompleted,
    Object? news,
    Object? automaticProfileSearch,
  }) => _$NotificationCategoryDataImpl(
    messages: (messages ?? this.messages) as bool,
    likes: (likes ?? this.likes) as bool,
    mediaContentModerationCompleted: (mediaContentModerationCompleted ?? this.mediaContentModerationCompleted) as bool,
    profileStringModerationCompleted: (profileStringModerationCompleted ?? this.profileStringModerationCompleted) as bool,
    news: (news ?? this.news) as bool,
    automaticProfileSearch: (automaticProfileSearch ?? this.automaticProfileSearch) as bool,
  );
}

/// @nodoc
final _privateConstructorErrorEditedNotificationSettingsData = UnsupportedError(
    'Private constructor EditedNotificationSettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EditedNotificationSettingsData {
  bool? get messages => throw _privateConstructorErrorEditedNotificationSettingsData;
  bool? get likes => throw _privateConstructorErrorEditedNotificationSettingsData;
  bool? get mediaContent => throw _privateConstructorErrorEditedNotificationSettingsData;
  bool? get profileString => throw _privateConstructorErrorEditedNotificationSettingsData;
  bool? get news => throw _privateConstructorErrorEditedNotificationSettingsData;
  bool? get automaticProfileSearch => throw _privateConstructorErrorEditedNotificationSettingsData;

  EditedNotificationSettingsData copyWith({
    bool? messages,
    bool? likes,
    bool? mediaContent,
    bool? profileString,
    bool? news,
    bool? automaticProfileSearch,
  }) => throw _privateConstructorErrorEditedNotificationSettingsData;
}

/// @nodoc
abstract class _EditedNotificationSettingsData extends EditedNotificationSettingsData {
  factory _EditedNotificationSettingsData({
    bool? messages,
    bool? likes,
    bool? mediaContent,
    bool? profileString,
    bool? news,
    bool? automaticProfileSearch,
  }) = _$EditedNotificationSettingsDataImpl;
  _EditedNotificationSettingsData._() : super._();
}

/// @nodoc
class _$EditedNotificationSettingsDataImpl extends _EditedNotificationSettingsData with DiagnosticableTreeMixin {
  _$EditedNotificationSettingsDataImpl({
    this.messages,
    this.likes,
    this.mediaContent,
    this.profileString,
    this.news,
    this.automaticProfileSearch,
  }) : super._();

  @override
  final bool? messages;
  @override
  final bool? likes;
  @override
  final bool? mediaContent;
  @override
  final bool? profileString;
  @override
  final bool? news;
  @override
  final bool? automaticProfileSearch;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditedNotificationSettingsData(messages: $messages, likes: $likes, mediaContent: $mediaContent, profileString: $profileString, news: $news, automaticProfileSearch: $automaticProfileSearch)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditedNotificationSettingsData'))
      ..add(DiagnosticsProperty('messages', messages))
      ..add(DiagnosticsProperty('likes', likes))
      ..add(DiagnosticsProperty('mediaContent', mediaContent))
      ..add(DiagnosticsProperty('profileString', profileString))
      ..add(DiagnosticsProperty('news', news))
      ..add(DiagnosticsProperty('automaticProfileSearch', automaticProfileSearch));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EditedNotificationSettingsDataImpl &&
        (identical(other.messages, messages) ||
          other.messages == messages) &&
        (identical(other.likes, likes) ||
          other.likes == likes) &&
        (identical(other.mediaContent, mediaContent) ||
          other.mediaContent == mediaContent) &&
        (identical(other.profileString, profileString) ||
          other.profileString == profileString) &&
        (identical(other.news, news) ||
          other.news == news) &&
        (identical(other.automaticProfileSearch, automaticProfileSearch) ||
          other.automaticProfileSearch == automaticProfileSearch)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    messages,
    likes,
    mediaContent,
    profileString,
    news,
    automaticProfileSearch,
  );

  @override
  EditedNotificationSettingsData copyWith({
    Object? messages = _detectDefaultValueInCopyWith,
    Object? likes = _detectDefaultValueInCopyWith,
    Object? mediaContent = _detectDefaultValueInCopyWith,
    Object? profileString = _detectDefaultValueInCopyWith,
    Object? news = _detectDefaultValueInCopyWith,
    Object? automaticProfileSearch = _detectDefaultValueInCopyWith,
  }) => _$EditedNotificationSettingsDataImpl(
    messages: (messages == _detectDefaultValueInCopyWith ? this.messages : messages) as bool?,
    likes: (likes == _detectDefaultValueInCopyWith ? this.likes : likes) as bool?,
    mediaContent: (mediaContent == _detectDefaultValueInCopyWith ? this.mediaContent : mediaContent) as bool?,
    profileString: (profileString == _detectDefaultValueInCopyWith ? this.profileString : profileString) as bool?,
    news: (news == _detectDefaultValueInCopyWith ? this.news : news) as bool?,
    automaticProfileSearch: (automaticProfileSearch == _detectDefaultValueInCopyWith ? this.automaticProfileSearch : automaticProfileSearch) as bool?,
  );
}
