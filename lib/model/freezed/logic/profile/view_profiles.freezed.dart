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
  bool get showAddToFavoritesCompleted => throw _privateConstructorErrorViewProfilesData;
  bool get showRemoveFromFavoritesCompleted => throw _privateConstructorErrorViewProfilesData;
  bool get showLikeCompleted => throw _privateConstructorErrorViewProfilesData;
  bool get showLikeFailedBecauseAlreadyLiked => throw _privateConstructorErrorViewProfilesData;
  bool get showLikeFailedBecauseOfLimit => throw _privateConstructorErrorViewProfilesData;
  bool get showRemoveLikeCompleted => throw _privateConstructorErrorViewProfilesData;
  bool get showRemoveLikeFailedBecauseOfDoneBefore => throw _privateConstructorErrorViewProfilesData;
  bool get showGenericError => throw _privateConstructorErrorViewProfilesData;

  ViewProfilesData copyWith({
    ProfileEntry? profile,
    FavoriteState? isFavorite,
    ProfileActionState? profileActionState,
    bool? isNotAvailable,
    bool? isBlocked,
    bool? showAddToFavoritesCompleted,
    bool? showRemoveFromFavoritesCompleted,
    bool? showLikeCompleted,
    bool? showLikeFailedBecauseAlreadyLiked,
    bool? showLikeFailedBecauseOfLimit,
    bool? showRemoveLikeCompleted,
    bool? showRemoveLikeFailedBecauseOfDoneBefore,
    bool? showGenericError,
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
    bool showAddToFavoritesCompleted,
    bool showRemoveFromFavoritesCompleted,
    bool showLikeCompleted,
    bool showLikeFailedBecauseAlreadyLiked,
    bool showLikeFailedBecauseOfLimit,
    bool showRemoveLikeCompleted,
    bool showRemoveLikeFailedBecauseOfDoneBefore,
    bool showGenericError,
  }) = _$ViewProfilesDataImpl;
}

/// @nodoc
class _$ViewProfilesDataImpl with DiagnosticableTreeMixin implements _ViewProfilesData {
  static const FavoriteState _isFavoriteDefaultValue = FavoriteStateIdle(false);
  static const ProfileActionState _profileActionStateDefaultValue = ProfileActionState.like;
  static const bool _isNotAvailableDefaultValue = false;
  static const bool _isBlockedDefaultValue = false;
  static const bool _showAddToFavoritesCompletedDefaultValue = false;
  static const bool _showRemoveFromFavoritesCompletedDefaultValue = false;
  static const bool _showLikeCompletedDefaultValue = false;
  static const bool _showLikeFailedBecauseAlreadyLikedDefaultValue = false;
  static const bool _showLikeFailedBecauseOfLimitDefaultValue = false;
  static const bool _showRemoveLikeCompletedDefaultValue = false;
  static const bool _showRemoveLikeFailedBecauseOfDoneBeforeDefaultValue = false;
  static const bool _showGenericErrorDefaultValue = false;
  
  _$ViewProfilesDataImpl({
    required this.profile,
    this.isFavorite = _isFavoriteDefaultValue,
    this.profileActionState = _profileActionStateDefaultValue,
    this.isNotAvailable = _isNotAvailableDefaultValue,
    this.isBlocked = _isBlockedDefaultValue,
    this.showAddToFavoritesCompleted = _showAddToFavoritesCompletedDefaultValue,
    this.showRemoveFromFavoritesCompleted = _showRemoveFromFavoritesCompletedDefaultValue,
    this.showLikeCompleted = _showLikeCompletedDefaultValue,
    this.showLikeFailedBecauseAlreadyLiked = _showLikeFailedBecauseAlreadyLikedDefaultValue,
    this.showLikeFailedBecauseOfLimit = _showLikeFailedBecauseOfLimitDefaultValue,
    this.showRemoveLikeCompleted = _showRemoveLikeCompletedDefaultValue,
    this.showRemoveLikeFailedBecauseOfDoneBefore = _showRemoveLikeFailedBecauseOfDoneBeforeDefaultValue,
    this.showGenericError = _showGenericErrorDefaultValue,
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
  final bool showAddToFavoritesCompleted;
  @override
  final bool showRemoveFromFavoritesCompleted;
  @override
  final bool showLikeCompleted;
  @override
  final bool showLikeFailedBecauseAlreadyLiked;
  @override
  final bool showLikeFailedBecauseOfLimit;
  @override
  final bool showRemoveLikeCompleted;
  @override
  final bool showRemoveLikeFailedBecauseOfDoneBefore;
  @override
  final bool showGenericError;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ViewProfilesData(profile: $profile, isFavorite: $isFavorite, profileActionState: $profileActionState, isNotAvailable: $isNotAvailable, isBlocked: $isBlocked, showAddToFavoritesCompleted: $showAddToFavoritesCompleted, showRemoveFromFavoritesCompleted: $showRemoveFromFavoritesCompleted, showLikeCompleted: $showLikeCompleted, showLikeFailedBecauseAlreadyLiked: $showLikeFailedBecauseAlreadyLiked, showLikeFailedBecauseOfLimit: $showLikeFailedBecauseOfLimit, showRemoveLikeCompleted: $showRemoveLikeCompleted, showRemoveLikeFailedBecauseOfDoneBefore: $showRemoveLikeFailedBecauseOfDoneBefore, showGenericError: $showGenericError)';
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
      ..add(DiagnosticsProperty('showAddToFavoritesCompleted', showAddToFavoritesCompleted))
      ..add(DiagnosticsProperty('showRemoveFromFavoritesCompleted', showRemoveFromFavoritesCompleted))
      ..add(DiagnosticsProperty('showLikeCompleted', showLikeCompleted))
      ..add(DiagnosticsProperty('showLikeFailedBecauseAlreadyLiked', showLikeFailedBecauseAlreadyLiked))
      ..add(DiagnosticsProperty('showLikeFailedBecauseOfLimit', showLikeFailedBecauseOfLimit))
      ..add(DiagnosticsProperty('showRemoveLikeCompleted', showRemoveLikeCompleted))
      ..add(DiagnosticsProperty('showRemoveLikeFailedBecauseOfDoneBefore', showRemoveLikeFailedBecauseOfDoneBefore))
      ..add(DiagnosticsProperty('showGenericError', showGenericError));
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
        (identical(other.showAddToFavoritesCompleted, showAddToFavoritesCompleted) ||
          other.showAddToFavoritesCompleted == showAddToFavoritesCompleted) &&
        (identical(other.showRemoveFromFavoritesCompleted, showRemoveFromFavoritesCompleted) ||
          other.showRemoveFromFavoritesCompleted == showRemoveFromFavoritesCompleted) &&
        (identical(other.showLikeCompleted, showLikeCompleted) ||
          other.showLikeCompleted == showLikeCompleted) &&
        (identical(other.showLikeFailedBecauseAlreadyLiked, showLikeFailedBecauseAlreadyLiked) ||
          other.showLikeFailedBecauseAlreadyLiked == showLikeFailedBecauseAlreadyLiked) &&
        (identical(other.showLikeFailedBecauseOfLimit, showLikeFailedBecauseOfLimit) ||
          other.showLikeFailedBecauseOfLimit == showLikeFailedBecauseOfLimit) &&
        (identical(other.showRemoveLikeCompleted, showRemoveLikeCompleted) ||
          other.showRemoveLikeCompleted == showRemoveLikeCompleted) &&
        (identical(other.showRemoveLikeFailedBecauseOfDoneBefore, showRemoveLikeFailedBecauseOfDoneBefore) ||
          other.showRemoveLikeFailedBecauseOfDoneBefore == showRemoveLikeFailedBecauseOfDoneBefore) &&
        (identical(other.showGenericError, showGenericError) ||
          other.showGenericError == showGenericError)
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
    showAddToFavoritesCompleted,
    showRemoveFromFavoritesCompleted,
    showLikeCompleted,
    showLikeFailedBecauseAlreadyLiked,
    showLikeFailedBecauseOfLimit,
    showRemoveLikeCompleted,
    showRemoveLikeFailedBecauseOfDoneBefore,
    showGenericError,
  );

  @override
  ViewProfilesData copyWith({
    Object? profile,
    Object? isFavorite,
    Object? profileActionState,
    Object? isNotAvailable,
    Object? isBlocked,
    Object? showAddToFavoritesCompleted,
    Object? showRemoveFromFavoritesCompleted,
    Object? showLikeCompleted,
    Object? showLikeFailedBecauseAlreadyLiked,
    Object? showLikeFailedBecauseOfLimit,
    Object? showRemoveLikeCompleted,
    Object? showRemoveLikeFailedBecauseOfDoneBefore,
    Object? showGenericError,
  }) => _$ViewProfilesDataImpl(
    profile: (profile ?? this.profile) as ProfileEntry,
    isFavorite: (isFavorite ?? this.isFavorite) as FavoriteState,
    profileActionState: (profileActionState ?? this.profileActionState) as ProfileActionState,
    isNotAvailable: (isNotAvailable ?? this.isNotAvailable) as bool,
    isBlocked: (isBlocked ?? this.isBlocked) as bool,
    showAddToFavoritesCompleted: (showAddToFavoritesCompleted ?? this.showAddToFavoritesCompleted) as bool,
    showRemoveFromFavoritesCompleted: (showRemoveFromFavoritesCompleted ?? this.showRemoveFromFavoritesCompleted) as bool,
    showLikeCompleted: (showLikeCompleted ?? this.showLikeCompleted) as bool,
    showLikeFailedBecauseAlreadyLiked: (showLikeFailedBecauseAlreadyLiked ?? this.showLikeFailedBecauseAlreadyLiked) as bool,
    showLikeFailedBecauseOfLimit: (showLikeFailedBecauseOfLimit ?? this.showLikeFailedBecauseOfLimit) as bool,
    showRemoveLikeCompleted: (showRemoveLikeCompleted ?? this.showRemoveLikeCompleted) as bool,
    showRemoveLikeFailedBecauseOfDoneBefore: (showRemoveLikeFailedBecauseOfDoneBefore ?? this.showRemoveLikeFailedBecauseOfDoneBefore) as bool,
    showGenericError: (showGenericError ?? this.showGenericError) as bool,
  );
}
