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
  bool get searchDistance => throw _privateConstructorErrorNotificationSettingsData;
  bool get searchFilters => throw _privateConstructorErrorNotificationSettingsData;
  bool get searchNewProfiles => throw _privateConstructorErrorNotificationSettingsData;
  int get searchWeekdays => throw _privateConstructorErrorNotificationSettingsData;

  NotificationSettingsData copyWith({
    UpdateState? updateState,
    bool? areNotificationsEnabled,
    NotificationCategoryData? categories,
    NotificationCategoryData? systemCategories,
    EditedNotificationSettingsData? edited,
    bool? searchDistance,
    bool? searchFilters,
    bool? searchNewProfiles,
    int? searchWeekdays,
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
    bool searchDistance,
    bool searchFilters,
    bool searchNewProfiles,
    int searchWeekdays,
  }) = _$NotificationSettingsDataImpl;
  _NotificationSettingsData._() : super._();
}

/// @nodoc
class _$NotificationSettingsDataImpl extends _NotificationSettingsData with DiagnosticableTreeMixin {
  static const UpdateState _updateStateDefaultValue = UpdateIdle();
  static const bool _areNotificationsEnabledDefaultValue = false;
  static const bool _searchDistanceDefaultValue = ProfileAppNotificationSettingsDefaults.distanceDefault;
  static const bool _searchFiltersDefaultValue = ProfileAppNotificationSettingsDefaults.filtersDefault;
  static const bool _searchNewProfilesDefaultValue = ProfileAppNotificationSettingsDefaults.newProfilesDefault;
  static const int _searchWeekdaysDefaultValue = ProfileAppNotificationSettingsDefaults.weekdaysDefault;
  
  _$NotificationSettingsDataImpl({
    this.updateState = _updateStateDefaultValue,
    this.areNotificationsEnabled = _areNotificationsEnabledDefaultValue,
    required this.categories,
    required this.systemCategories,
    required this.edited,
    this.searchDistance = _searchDistanceDefaultValue,
    this.searchFilters = _searchFiltersDefaultValue,
    this.searchNewProfiles = _searchNewProfilesDefaultValue,
    this.searchWeekdays = _searchWeekdaysDefaultValue,
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
  final bool searchDistance;
  @override
  final bool searchFilters;
  @override
  final bool searchNewProfiles;
  @override
  final int searchWeekdays;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NotificationSettingsData(updateState: $updateState, areNotificationsEnabled: $areNotificationsEnabled, categories: $categories, systemCategories: $systemCategories, edited: $edited, searchDistance: $searchDistance, searchFilters: $searchFilters, searchNewProfiles: $searchNewProfiles, searchWeekdays: $searchWeekdays)';
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
      ..add(DiagnosticsProperty('edited', edited))
      ..add(DiagnosticsProperty('searchDistance', searchDistance))
      ..add(DiagnosticsProperty('searchFilters', searchFilters))
      ..add(DiagnosticsProperty('searchNewProfiles', searchNewProfiles))
      ..add(DiagnosticsProperty('searchWeekdays', searchWeekdays));
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
          other.edited == edited) &&
        (identical(other.searchDistance, searchDistance) ||
          other.searchDistance == searchDistance) &&
        (identical(other.searchFilters, searchFilters) ||
          other.searchFilters == searchFilters) &&
        (identical(other.searchNewProfiles, searchNewProfiles) ||
          other.searchNewProfiles == searchNewProfiles) &&
        (identical(other.searchWeekdays, searchWeekdays) ||
          other.searchWeekdays == searchWeekdays)
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
    searchDistance,
    searchFilters,
    searchNewProfiles,
    searchWeekdays,
  );

  @override
  NotificationSettingsData copyWith({
    Object? updateState,
    Object? areNotificationsEnabled,
    Object? categories,
    Object? systemCategories,
    Object? edited,
    Object? searchDistance,
    Object? searchFilters,
    Object? searchNewProfiles,
    Object? searchWeekdays,
  }) => _$NotificationSettingsDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    areNotificationsEnabled: (areNotificationsEnabled ?? this.areNotificationsEnabled) as bool,
    categories: (categories ?? this.categories) as NotificationCategoryData,
    systemCategories: (systemCategories ?? this.systemCategories) as NotificationCategoryData,
    edited: (edited ?? this.edited) as EditedNotificationSettingsData,
    searchDistance: (searchDistance ?? this.searchDistance) as bool,
    searchFilters: (searchFilters ?? this.searchFilters) as bool,
    searchNewProfiles: (searchNewProfiles ?? this.searchNewProfiles) as bool,
    searchWeekdays: (searchWeekdays ?? this.searchWeekdays) as int,
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
  bool get profileTextModerationCompleted => throw _privateConstructorErrorNotificationCategoryData;
  bool get news => throw _privateConstructorErrorNotificationCategoryData;
  bool get automaticProfileSearch => throw _privateConstructorErrorNotificationCategoryData;

  NotificationCategoryData copyWith({
    bool? messages,
    bool? likes,
    bool? mediaContentModerationCompleted,
    bool? profileTextModerationCompleted,
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
    bool profileTextModerationCompleted,
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
  static const bool _profileTextModerationCompletedDefaultValue = true;
  static const bool _newsDefaultValue = true;
  static const bool _automaticProfileSearchDefaultValue = true;
  
  _$NotificationCategoryDataImpl({
    this.messages = _messagesDefaultValue,
    this.likes = _likesDefaultValue,
    this.mediaContentModerationCompleted = _mediaContentModerationCompletedDefaultValue,
    this.profileTextModerationCompleted = _profileTextModerationCompletedDefaultValue,
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
  final bool profileTextModerationCompleted;
  @override
  final bool news;
  @override
  final bool automaticProfileSearch;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NotificationCategoryData(messages: $messages, likes: $likes, mediaContentModerationCompleted: $mediaContentModerationCompleted, profileTextModerationCompleted: $profileTextModerationCompleted, news: $news, automaticProfileSearch: $automaticProfileSearch)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NotificationCategoryData'))
      ..add(DiagnosticsProperty('messages', messages))
      ..add(DiagnosticsProperty('likes', likes))
      ..add(DiagnosticsProperty('mediaContentModerationCompleted', mediaContentModerationCompleted))
      ..add(DiagnosticsProperty('profileTextModerationCompleted', profileTextModerationCompleted))
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
        (identical(other.profileTextModerationCompleted, profileTextModerationCompleted) ||
          other.profileTextModerationCompleted == profileTextModerationCompleted) &&
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
    profileTextModerationCompleted,
    news,
    automaticProfileSearch,
  );

  @override
  NotificationCategoryData copyWith({
    Object? messages,
    Object? likes,
    Object? mediaContentModerationCompleted,
    Object? profileTextModerationCompleted,
    Object? news,
    Object? automaticProfileSearch,
  }) => _$NotificationCategoryDataImpl(
    messages: (messages ?? this.messages) as bool,
    likes: (likes ?? this.likes) as bool,
    mediaContentModerationCompleted: (mediaContentModerationCompleted ?? this.mediaContentModerationCompleted) as bool,
    profileTextModerationCompleted: (profileTextModerationCompleted ?? this.profileTextModerationCompleted) as bool,
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
  bool? get profileText => throw _privateConstructorErrorEditedNotificationSettingsData;
  bool? get news => throw _privateConstructorErrorEditedNotificationSettingsData;
  bool? get automaticProfileSearch => throw _privateConstructorErrorEditedNotificationSettingsData;

  EditedNotificationSettingsData copyWith({
    bool? messages,
    bool? likes,
    bool? mediaContent,
    bool? profileText,
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
    bool? profileText,
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
    this.profileText,
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
  final bool? profileText;
  @override
  final bool? news;
  @override
  final bool? automaticProfileSearch;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditedNotificationSettingsData(messages: $messages, likes: $likes, mediaContent: $mediaContent, profileText: $profileText, news: $news, automaticProfileSearch: $automaticProfileSearch)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditedNotificationSettingsData'))
      ..add(DiagnosticsProperty('messages', messages))
      ..add(DiagnosticsProperty('likes', likes))
      ..add(DiagnosticsProperty('mediaContent', mediaContent))
      ..add(DiagnosticsProperty('profileText', profileText))
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
        (identical(other.profileText, profileText) ||
          other.profileText == profileText) &&
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
    profileText,
    news,
    automaticProfileSearch,
  );

  @override
  EditedNotificationSettingsData copyWith({
    Object? messages = _detectDefaultValueInCopyWith,
    Object? likes = _detectDefaultValueInCopyWith,
    Object? mediaContent = _detectDefaultValueInCopyWith,
    Object? profileText = _detectDefaultValueInCopyWith,
    Object? news = _detectDefaultValueInCopyWith,
    Object? automaticProfileSearch = _detectDefaultValueInCopyWith,
  }) => _$EditedNotificationSettingsDataImpl(
    messages: (messages == _detectDefaultValueInCopyWith ? this.messages : messages) as bool?,
    likes: (likes == _detectDefaultValueInCopyWith ? this.likes : likes) as bool?,
    mediaContent: (mediaContent == _detectDefaultValueInCopyWith ? this.mediaContent : mediaContent) as bool?,
    profileText: (profileText == _detectDefaultValueInCopyWith ? this.profileText : profileText) as bool?,
    news: (news == _detectDefaultValueInCopyWith ? this.news : news) as bool?,
    automaticProfileSearch: (automaticProfileSearch == _detectDefaultValueInCopyWith ? this.automaticProfileSearch : automaticProfileSearch) as bool?,
  );
}
