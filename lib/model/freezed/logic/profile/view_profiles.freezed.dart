// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_profiles.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorViewProfilesData = UnsupportedError(
    'Private constructor ViewProfilesData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ViewProfilesData {
  ProfileEntry get profile => throw _privateConstructorErrorViewProfilesData;
  FavoriteState get isFavorite => throw _privateConstructorErrorViewProfilesData;
  ProfileActionState get profileActionState => throw _privateConstructorErrorViewProfilesData;
  bool get isNotAvailable => throw _privateConstructorErrorViewProfilesData;
  bool get isBlocked => throw _privateConstructorErrorViewProfilesData;
  bool get showLikeCompleted => throw _privateConstructorErrorViewProfilesData;
  bool get showLikeFailedBecauseOfLimit => throw _privateConstructorErrorViewProfilesData;
  bool get showRemoveLikeCompleted => throw _privateConstructorErrorViewProfilesData;
  bool get showRemoveLikeFailedBecauseOfLimit => throw _privateConstructorErrorViewProfilesData;

  ViewProfilesData copyWith({
    ProfileEntry? profile,
    FavoriteState? isFavorite,
    ProfileActionState? profileActionState,
    bool? isNotAvailable,
    bool? isBlocked,
    bool? showLikeCompleted,
    bool? showLikeFailedBecauseOfLimit,
    bool? showRemoveLikeCompleted,
    bool? showRemoveLikeFailedBecauseOfLimit,
  }) => throw _privateConstructorErrorViewProfilesData;
}

/// @nodoc
abstract class _ViewProfilesData implements ViewProfilesData {
  factory _ViewProfilesData({
    required ProfileEntry profile,
    FavoriteState isFavorite,
    ProfileActionState profileActionState,
    bool isNotAvailable,
    bool isBlocked,
    bool showLikeCompleted,
    bool showLikeFailedBecauseOfLimit,
    bool showRemoveLikeCompleted,
    bool showRemoveLikeFailedBecauseOfLimit,
  }) = _$ViewProfilesDataImpl;
}

/// @nodoc
class _$ViewProfilesDataImpl with DiagnosticableTreeMixin implements _ViewProfilesData {
  static const FavoriteState _isFavoriteDefaultValue = FavoriteStateIdle(false);
  static const ProfileActionState _profileActionStateDefaultValue = ProfileActionState.like;
  static const bool _isNotAvailableDefaultValue = false;
  static const bool _isBlockedDefaultValue = false;
  static const bool _showLikeCompletedDefaultValue = false;
  static const bool _showLikeFailedBecauseOfLimitDefaultValue = false;
  static const bool _showRemoveLikeCompletedDefaultValue = false;
  static const bool _showRemoveLikeFailedBecauseOfLimitDefaultValue = false;
  
  _$ViewProfilesDataImpl({
    required this.profile,
    this.isFavorite = _isFavoriteDefaultValue,
    this.profileActionState = _profileActionStateDefaultValue,
    this.isNotAvailable = _isNotAvailableDefaultValue,
    this.isBlocked = _isBlockedDefaultValue,
    this.showLikeCompleted = _showLikeCompletedDefaultValue,
    this.showLikeFailedBecauseOfLimit = _showLikeFailedBecauseOfLimitDefaultValue,
    this.showRemoveLikeCompleted = _showRemoveLikeCompletedDefaultValue,
    this.showRemoveLikeFailedBecauseOfLimit = _showRemoveLikeFailedBecauseOfLimitDefaultValue,
  });

  @override
  final ProfileEntry profile;
  @override
  final FavoriteState isFavorite;
  @override
  final ProfileActionState profileActionState;
  @override
  final bool isNotAvailable;
  @override
  final bool isBlocked;
  @override
  final bool showLikeCompleted;
  @override
  final bool showLikeFailedBecauseOfLimit;
  @override
  final bool showRemoveLikeCompleted;
  @override
  final bool showRemoveLikeFailedBecauseOfLimit;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ViewProfilesData(profile: $profile, isFavorite: $isFavorite, profileActionState: $profileActionState, isNotAvailable: $isNotAvailable, isBlocked: $isBlocked, showLikeCompleted: $showLikeCompleted, showLikeFailedBecauseOfLimit: $showLikeFailedBecauseOfLimit, showRemoveLikeCompleted: $showRemoveLikeCompleted, showRemoveLikeFailedBecauseOfLimit: $showRemoveLikeFailedBecauseOfLimit)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ViewProfilesData'))
      ..add(DiagnosticsProperty('profile', profile))
      ..add(DiagnosticsProperty('isFavorite', isFavorite))
      ..add(DiagnosticsProperty('profileActionState', profileActionState))
      ..add(DiagnosticsProperty('isNotAvailable', isNotAvailable))
      ..add(DiagnosticsProperty('isBlocked', isBlocked))
      ..add(DiagnosticsProperty('showLikeCompleted', showLikeCompleted))
      ..add(DiagnosticsProperty('showLikeFailedBecauseOfLimit', showLikeFailedBecauseOfLimit))
      ..add(DiagnosticsProperty('showRemoveLikeCompleted', showRemoveLikeCompleted))
      ..add(DiagnosticsProperty('showRemoveLikeFailedBecauseOfLimit', showRemoveLikeFailedBecauseOfLimit));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ViewProfilesDataImpl &&
        (identical(other.profile, profile) ||
          other.profile == profile) &&
        (identical(other.isFavorite, isFavorite) ||
          other.isFavorite == isFavorite) &&
        (identical(other.profileActionState, profileActionState) ||
          other.profileActionState == profileActionState) &&
        (identical(other.isNotAvailable, isNotAvailable) ||
          other.isNotAvailable == isNotAvailable) &&
        (identical(other.isBlocked, isBlocked) ||
          other.isBlocked == isBlocked) &&
        (identical(other.showLikeCompleted, showLikeCompleted) ||
          other.showLikeCompleted == showLikeCompleted) &&
        (identical(other.showLikeFailedBecauseOfLimit, showLikeFailedBecauseOfLimit) ||
          other.showLikeFailedBecauseOfLimit == showLikeFailedBecauseOfLimit) &&
        (identical(other.showRemoveLikeCompleted, showRemoveLikeCompleted) ||
          other.showRemoveLikeCompleted == showRemoveLikeCompleted) &&
        (identical(other.showRemoveLikeFailedBecauseOfLimit, showRemoveLikeFailedBecauseOfLimit) ||
          other.showRemoveLikeFailedBecauseOfLimit == showRemoveLikeFailedBecauseOfLimit)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    profile,
    isFavorite,
    profileActionState,
    isNotAvailable,
    isBlocked,
    showLikeCompleted,
    showLikeFailedBecauseOfLimit,
    showRemoveLikeCompleted,
    showRemoveLikeFailedBecauseOfLimit,
  );

  @override
  ViewProfilesData copyWith({
    Object? profile,
    Object? isFavorite,
    Object? profileActionState,
    Object? isNotAvailable,
    Object? isBlocked,
    Object? showLikeCompleted,
    Object? showLikeFailedBecauseOfLimit,
    Object? showRemoveLikeCompleted,
    Object? showRemoveLikeFailedBecauseOfLimit,
  }) => _$ViewProfilesDataImpl(
    profile: (profile ?? this.profile) as ProfileEntry,
    isFavorite: (isFavorite ?? this.isFavorite) as FavoriteState,
    profileActionState: (profileActionState ?? this.profileActionState) as ProfileActionState,
    isNotAvailable: (isNotAvailable ?? this.isNotAvailable) as bool,
    isBlocked: (isBlocked ?? this.isBlocked) as bool,
    showLikeCompleted: (showLikeCompleted ?? this.showLikeCompleted) as bool,
    showLikeFailedBecauseOfLimit: (showLikeFailedBecauseOfLimit ?? this.showLikeFailedBecauseOfLimit) as bool,
    showRemoveLikeCompleted: (showRemoveLikeCompleted ?? this.showRemoveLikeCompleted) as bool,
    showRemoveLikeFailedBecauseOfLimit: (showRemoveLikeFailedBecauseOfLimit ?? this.showRemoveLikeFailedBecauseOfLimit) as bool,
  );
}
