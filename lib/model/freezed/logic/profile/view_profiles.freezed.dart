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
  bool get showRemoveLikeCompleted => throw _privateConstructorErrorViewProfilesData;

  ViewProfilesData copyWith({
    ProfileEntry? profile,
    FavoriteState? isFavorite,
    ProfileActionState? profileActionState,
    bool? isNotAvailable,
    bool? isBlocked,
    bool? showLikeCompleted,
    bool? showRemoveLikeCompleted,
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
    bool showRemoveLikeCompleted,
  }) = _$ViewProfilesDataImpl;
}

/// @nodoc
class _$ViewProfilesDataImpl with DiagnosticableTreeMixin implements _ViewProfilesData {
  static const FavoriteState _isFavoriteDefaultValue = FavoriteStateIdle(false);
  static const ProfileActionState _profileActionStateDefaultValue = ProfileActionState.like;
  static const bool _isNotAvailableDefaultValue = false;
  static const bool _isBlockedDefaultValue = false;
  static const bool _showLikeCompletedDefaultValue = false;
  static const bool _showRemoveLikeCompletedDefaultValue = false;
  
  _$ViewProfilesDataImpl({
    required this.profile,
    this.isFavorite = _isFavoriteDefaultValue,
    this.profileActionState = _profileActionStateDefaultValue,
    this.isNotAvailable = _isNotAvailableDefaultValue,
    this.isBlocked = _isBlockedDefaultValue,
    this.showLikeCompleted = _showLikeCompletedDefaultValue,
    this.showRemoveLikeCompleted = _showRemoveLikeCompletedDefaultValue,
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
  final bool showRemoveLikeCompleted;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ViewProfilesData(profile: $profile, isFavorite: $isFavorite, profileActionState: $profileActionState, isNotAvailable: $isNotAvailable, isBlocked: $isBlocked, showLikeCompleted: $showLikeCompleted, showRemoveLikeCompleted: $showRemoveLikeCompleted)';
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
      ..add(DiagnosticsProperty('showRemoveLikeCompleted', showRemoveLikeCompleted));
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
        (identical(other.showRemoveLikeCompleted, showRemoveLikeCompleted) ||
          other.showRemoveLikeCompleted == showRemoveLikeCompleted)
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
    showRemoveLikeCompleted,
  );

  @override
  ViewProfilesData copyWith({
    Object? profile,
    Object? isFavorite,
    Object? profileActionState,
    Object? isNotAvailable,
    Object? isBlocked,
    Object? showLikeCompleted,
    Object? showRemoveLikeCompleted,
  }) => _$ViewProfilesDataImpl(
    profile: (profile ?? this.profile) as ProfileEntry,
    isFavorite: (isFavorite ?? this.isFavorite) as FavoriteState,
    profileActionState: (profileActionState ?? this.profileActionState) as ProfileActionState,
    isNotAvailable: (isNotAvailable ?? this.isNotAvailable) as bool,
    isBlocked: (isBlocked ?? this.isBlocked) as bool,
    showLikeCompleted: (showLikeCompleted ?? this.showLikeCompleted) as bool,
    showRemoveLikeCompleted: (showRemoveLikeCompleted ?? this.showRemoveLikeCompleted) as bool,
  );
}
