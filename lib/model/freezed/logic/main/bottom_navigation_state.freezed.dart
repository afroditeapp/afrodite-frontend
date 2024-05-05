// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_navigation_state.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorBottomNavigationStateData = UnsupportedError(
    'Private constructor BottomNavigationStateData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$BottomNavigationStateData {
  BottomNavigationScreenId get screen => throw _privateConstructorErrorBottomNavigationStateData;
  bool get isScrolledProfile => throw _privateConstructorErrorBottomNavigationStateData;
  bool get isScrolledLikes => throw _privateConstructorErrorBottomNavigationStateData;
  bool get isScrolledChats => throw _privateConstructorErrorBottomNavigationStateData;
  bool get isScrolledSettings => throw _privateConstructorErrorBottomNavigationStateData;

  BottomNavigationStateData copyWith({
    BottomNavigationScreenId? screen,
    bool? isScrolledProfile,
    bool? isScrolledLikes,
    bool? isScrolledChats,
    bool? isScrolledSettings,
  }) => throw _privateConstructorErrorBottomNavigationStateData;
}

/// @nodoc
abstract class _BottomNavigationStateData implements BottomNavigationStateData {
  factory _BottomNavigationStateData({
    BottomNavigationScreenId screen,
    bool isScrolledProfile,
    bool isScrolledLikes,
    bool isScrolledChats,
    bool isScrolledSettings,
  }) = _$BottomNavigationStateDataImpl;
}

/// @nodoc
class _$BottomNavigationStateDataImpl with DiagnosticableTreeMixin implements _BottomNavigationStateData {
  static const BottomNavigationScreenId _screenDefaultValue = BottomNavigationScreenId.profiles;
  static const bool _isScrolledProfileDefaultValue = false;
  static const bool _isScrolledLikesDefaultValue = false;
  static const bool _isScrolledChatsDefaultValue = false;
  static const bool _isScrolledSettingsDefaultValue = false;
  
  _$BottomNavigationStateDataImpl({
    this.screen = _screenDefaultValue,
    this.isScrolledProfile = _isScrolledProfileDefaultValue,
    this.isScrolledLikes = _isScrolledLikesDefaultValue,
    this.isScrolledChats = _isScrolledChatsDefaultValue,
    this.isScrolledSettings = _isScrolledSettingsDefaultValue,
  });

  @override
  final BottomNavigationScreenId screen;
  @override
  final bool isScrolledProfile;
  @override
  final bool isScrolledLikes;
  @override
  final bool isScrolledChats;
  @override
  final bool isScrolledSettings;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BottomNavigationStateData(screen: $screen, isScrolledProfile: $isScrolledProfile, isScrolledLikes: $isScrolledLikes, isScrolledChats: $isScrolledChats, isScrolledSettings: $isScrolledSettings)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BottomNavigationStateData'))
      ..add(DiagnosticsProperty('screen', screen))
      ..add(DiagnosticsProperty('isScrolledProfile', isScrolledProfile))
      ..add(DiagnosticsProperty('isScrolledLikes', isScrolledLikes))
      ..add(DiagnosticsProperty('isScrolledChats', isScrolledChats))
      ..add(DiagnosticsProperty('isScrolledSettings', isScrolledSettings));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$BottomNavigationStateDataImpl &&
        (identical(other.screen, screen) ||
          other.screen == screen) &&
        (identical(other.isScrolledProfile, isScrolledProfile) ||
          other.isScrolledProfile == isScrolledProfile) &&
        (identical(other.isScrolledLikes, isScrolledLikes) ||
          other.isScrolledLikes == isScrolledLikes) &&
        (identical(other.isScrolledChats, isScrolledChats) ||
          other.isScrolledChats == isScrolledChats) &&
        (identical(other.isScrolledSettings, isScrolledSettings) ||
          other.isScrolledSettings == isScrolledSettings)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    screen,
    isScrolledProfile,
    isScrolledLikes,
    isScrolledChats,
    isScrolledSettings,
  );

  @override
  BottomNavigationStateData copyWith({
    Object? screen,
    Object? isScrolledProfile,
    Object? isScrolledLikes,
    Object? isScrolledChats,
    Object? isScrolledSettings,
  }) => _$BottomNavigationStateDataImpl(
    screen: (screen ?? this.screen) as BottomNavigationScreenId,
    isScrolledProfile: (isScrolledProfile ?? this.isScrolledProfile) as bool,
    isScrolledLikes: (isScrolledLikes ?? this.isScrolledLikes) as bool,
    isScrolledChats: (isScrolledChats ?? this.isScrolledChats) as bool,
    isScrolledSettings: (isScrolledSettings ?? this.isScrolledSettings) as bool,
  );
}
