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
  bool get searchDistance => throw _privateConstructorErrorNotificationSettingsData;
  bool get searchFilters => throw _privateConstructorErrorNotificationSettingsData;
  bool get searchNewProfiles => throw _privateConstructorErrorNotificationSettingsData;
  int get searchWeekdays => throw _privateConstructorErrorNotificationSettingsData;
  bool? get editedMessages => throw _privateConstructorErrorNotificationSettingsData;
  bool? get editedLikes => throw _privateConstructorErrorNotificationSettingsData;
  bool? get editedMediaContent => throw _privateConstructorErrorNotificationSettingsData;
  bool? get editedProfileText => throw _privateConstructorErrorNotificationSettingsData;
  bool? get editedNews => throw _privateConstructorErrorNotificationSettingsData;
  bool? get editedAutomaticProfileSearch => throw _privateConstructorErrorNotificationSettingsData;
  bool? get editedSearchDistance => throw _privateConstructorErrorNotificationSettingsData;
  bool? get editedSearchFilters => throw _privateConstructorErrorNotificationSettingsData;
  bool? get editedSearchNewProfiles => throw _privateConstructorErrorNotificationSettingsData;
  int? get editedSearchWeekdays => throw _privateConstructorErrorNotificationSettingsData;

  NotificationSettingsData copyWith({
    UpdateState? updateState,
    bool? areNotificationsEnabled,
    NotificationCategoryData? categories,
    NotificationCategoryData? systemCategories,
    bool? searchDistance,
    bool? searchFilters,
    bool? searchNewProfiles,
    int? searchWeekdays,
    bool? editedMessages,
    bool? editedLikes,
    bool? editedMediaContent,
    bool? editedProfileText,
    bool? editedNews,
    bool? editedAutomaticProfileSearch,
    bool? editedSearchDistance,
    bool? editedSearchFilters,
    bool? editedSearchNewProfiles,
    int? editedSearchWeekdays,
  }) => throw _privateConstructorErrorNotificationSettingsData;
}

/// @nodoc
abstract class _NotificationSettingsData extends NotificationSettingsData {
  factory _NotificationSettingsData({
    UpdateState updateState,
    bool areNotificationsEnabled,
    required NotificationCategoryData categories,
    required NotificationCategoryData systemCategories,
    bool searchDistance,
    bool searchFilters,
    bool searchNewProfiles,
    int searchWeekdays,
    bool? editedMessages,
    bool? editedLikes,
    bool? editedMediaContent,
    bool? editedProfileText,
    bool? editedNews,
    bool? editedAutomaticProfileSearch,
    bool? editedSearchDistance,
    bool? editedSearchFilters,
    bool? editedSearchNewProfiles,
    int? editedSearchWeekdays,
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
    this.searchDistance = _searchDistanceDefaultValue,
    this.searchFilters = _searchFiltersDefaultValue,
    this.searchNewProfiles = _searchNewProfilesDefaultValue,
    this.searchWeekdays = _searchWeekdaysDefaultValue,
    this.editedMessages,
    this.editedLikes,
    this.editedMediaContent,
    this.editedProfileText,
    this.editedNews,
    this.editedAutomaticProfileSearch,
    this.editedSearchDistance,
    this.editedSearchFilters,
    this.editedSearchNewProfiles,
    this.editedSearchWeekdays,
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
  final bool searchDistance;
  @override
  final bool searchFilters;
  @override
  final bool searchNewProfiles;
  @override
  final int searchWeekdays;
  @override
  final bool? editedMessages;
  @override
  final bool? editedLikes;
  @override
  final bool? editedMediaContent;
  @override
  final bool? editedProfileText;
  @override
  final bool? editedNews;
  @override
  final bool? editedAutomaticProfileSearch;
  @override
  final bool? editedSearchDistance;
  @override
  final bool? editedSearchFilters;
  @override
  final bool? editedSearchNewProfiles;
  @override
  final int? editedSearchWeekdays;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NotificationSettingsData(updateState: $updateState, areNotificationsEnabled: $areNotificationsEnabled, categories: $categories, systemCategories: $systemCategories, searchDistance: $searchDistance, searchFilters: $searchFilters, searchNewProfiles: $searchNewProfiles, searchWeekdays: $searchWeekdays, editedMessages: $editedMessages, editedLikes: $editedLikes, editedMediaContent: $editedMediaContent, editedProfileText: $editedProfileText, editedNews: $editedNews, editedAutomaticProfileSearch: $editedAutomaticProfileSearch, editedSearchDistance: $editedSearchDistance, editedSearchFilters: $editedSearchFilters, editedSearchNewProfiles: $editedSearchNewProfiles, editedSearchWeekdays: $editedSearchWeekdays)';
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
      ..add(DiagnosticsProperty('searchDistance', searchDistance))
      ..add(DiagnosticsProperty('searchFilters', searchFilters))
      ..add(DiagnosticsProperty('searchNewProfiles', searchNewProfiles))
      ..add(DiagnosticsProperty('searchWeekdays', searchWeekdays))
      ..add(DiagnosticsProperty('editedMessages', editedMessages))
      ..add(DiagnosticsProperty('editedLikes', editedLikes))
      ..add(DiagnosticsProperty('editedMediaContent', editedMediaContent))
      ..add(DiagnosticsProperty('editedProfileText', editedProfileText))
      ..add(DiagnosticsProperty('editedNews', editedNews))
      ..add(DiagnosticsProperty('editedAutomaticProfileSearch', editedAutomaticProfileSearch))
      ..add(DiagnosticsProperty('editedSearchDistance', editedSearchDistance))
      ..add(DiagnosticsProperty('editedSearchFilters', editedSearchFilters))
      ..add(DiagnosticsProperty('editedSearchNewProfiles', editedSearchNewProfiles))
      ..add(DiagnosticsProperty('editedSearchWeekdays', editedSearchWeekdays));
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
        (identical(other.searchDistance, searchDistance) ||
          other.searchDistance == searchDistance) &&
        (identical(other.searchFilters, searchFilters) ||
          other.searchFilters == searchFilters) &&
        (identical(other.searchNewProfiles, searchNewProfiles) ||
          other.searchNewProfiles == searchNewProfiles) &&
        (identical(other.searchWeekdays, searchWeekdays) ||
          other.searchWeekdays == searchWeekdays) &&
        (identical(other.editedMessages, editedMessages) ||
          other.editedMessages == editedMessages) &&
        (identical(other.editedLikes, editedLikes) ||
          other.editedLikes == editedLikes) &&
        (identical(other.editedMediaContent, editedMediaContent) ||
          other.editedMediaContent == editedMediaContent) &&
        (identical(other.editedProfileText, editedProfileText) ||
          other.editedProfileText == editedProfileText) &&
        (identical(other.editedNews, editedNews) ||
          other.editedNews == editedNews) &&
        (identical(other.editedAutomaticProfileSearch, editedAutomaticProfileSearch) ||
          other.editedAutomaticProfileSearch == editedAutomaticProfileSearch) &&
        (identical(other.editedSearchDistance, editedSearchDistance) ||
          other.editedSearchDistance == editedSearchDistance) &&
        (identical(other.editedSearchFilters, editedSearchFilters) ||
          other.editedSearchFilters == editedSearchFilters) &&
        (identical(other.editedSearchNewProfiles, editedSearchNewProfiles) ||
          other.editedSearchNewProfiles == editedSearchNewProfiles) &&
        (identical(other.editedSearchWeekdays, editedSearchWeekdays) ||
          other.editedSearchWeekdays == editedSearchWeekdays)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    updateState,
    areNotificationsEnabled,
    categories,
    systemCategories,
    searchDistance,
    searchFilters,
    searchNewProfiles,
    searchWeekdays,
    editedMessages,
    editedLikes,
    editedMediaContent,
    editedProfileText,
    editedNews,
    editedAutomaticProfileSearch,
    editedSearchDistance,
    editedSearchFilters,
    editedSearchNewProfiles,
    editedSearchWeekdays,
  );

  @override
  NotificationSettingsData copyWith({
    Object? updateState,
    Object? areNotificationsEnabled,
    Object? categories,
    Object? systemCategories,
    Object? searchDistance,
    Object? searchFilters,
    Object? searchNewProfiles,
    Object? searchWeekdays,
    Object? editedMessages = _detectDefaultValueInCopyWith,
    Object? editedLikes = _detectDefaultValueInCopyWith,
    Object? editedMediaContent = _detectDefaultValueInCopyWith,
    Object? editedProfileText = _detectDefaultValueInCopyWith,
    Object? editedNews = _detectDefaultValueInCopyWith,
    Object? editedAutomaticProfileSearch = _detectDefaultValueInCopyWith,
    Object? editedSearchDistance = _detectDefaultValueInCopyWith,
    Object? editedSearchFilters = _detectDefaultValueInCopyWith,
    Object? editedSearchNewProfiles = _detectDefaultValueInCopyWith,
    Object? editedSearchWeekdays = _detectDefaultValueInCopyWith,
  }) => _$NotificationSettingsDataImpl(
    updateState: (updateState ?? this.updateState) as UpdateState,
    areNotificationsEnabled: (areNotificationsEnabled ?? this.areNotificationsEnabled) as bool,
    categories: (categories ?? this.categories) as NotificationCategoryData,
    systemCategories: (systemCategories ?? this.systemCategories) as NotificationCategoryData,
    searchDistance: (searchDistance ?? this.searchDistance) as bool,
    searchFilters: (searchFilters ?? this.searchFilters) as bool,
    searchNewProfiles: (searchNewProfiles ?? this.searchNewProfiles) as bool,
    searchWeekdays: (searchWeekdays ?? this.searchWeekdays) as int,
    editedMessages: (editedMessages == _detectDefaultValueInCopyWith ? this.editedMessages : editedMessages) as bool?,
    editedLikes: (editedLikes == _detectDefaultValueInCopyWith ? this.editedLikes : editedLikes) as bool?,
    editedMediaContent: (editedMediaContent == _detectDefaultValueInCopyWith ? this.editedMediaContent : editedMediaContent) as bool?,
    editedProfileText: (editedProfileText == _detectDefaultValueInCopyWith ? this.editedProfileText : editedProfileText) as bool?,
    editedNews: (editedNews == _detectDefaultValueInCopyWith ? this.editedNews : editedNews) as bool?,
    editedAutomaticProfileSearch: (editedAutomaticProfileSearch == _detectDefaultValueInCopyWith ? this.editedAutomaticProfileSearch : editedAutomaticProfileSearch) as bool?,
    editedSearchDistance: (editedSearchDistance == _detectDefaultValueInCopyWith ? this.editedSearchDistance : editedSearchDistance) as bool?,
    editedSearchFilters: (editedSearchFilters == _detectDefaultValueInCopyWith ? this.editedSearchFilters : editedSearchFilters) as bool?,
    editedSearchNewProfiles: (editedSearchNewProfiles == _detectDefaultValueInCopyWith ? this.editedSearchNewProfiles : editedSearchNewProfiles) as bool?,
    editedSearchWeekdays: (editedSearchWeekdays == _detectDefaultValueInCopyWith ? this.editedSearchWeekdays : editedSearchWeekdays) as int?,
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
