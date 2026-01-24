// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_features_config.dart';

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
final _privateConstructorErrorClientFeaturesConfigData = UnsupportedError(
    'Private constructor ClientFeaturesConfigData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ClientFeaturesConfigData {
  ClientFeaturesConfig get config => throw _privateConstructorErrorClientFeaturesConfigData;
  RegExp? get profileNameRegex => throw _privateConstructorErrorClientFeaturesConfigData;
  int? get dailyLikesLeft => throw _privateConstructorErrorClientFeaturesConfigData;
  bool get loadingComplete => throw _privateConstructorErrorClientFeaturesConfigData;

  ClientFeaturesConfigData copyWith({
    ClientFeaturesConfig? config,
    RegExp? profileNameRegex,
    int? dailyLikesLeft,
    bool? loadingComplete,
  }) => throw _privateConstructorErrorClientFeaturesConfigData;
}

/// @nodoc
abstract class _ClientFeaturesConfigData extends ClientFeaturesConfigData {
  factory _ClientFeaturesConfigData({
    required ClientFeaturesConfig config,
    RegExp? profileNameRegex,
    int? dailyLikesLeft,
    bool loadingComplete,
  }) = _$ClientFeaturesConfigDataImpl;
  _ClientFeaturesConfigData._() : super._();
}

/// @nodoc
class _$ClientFeaturesConfigDataImpl extends _ClientFeaturesConfigData with DiagnosticableTreeMixin {
  static const bool _loadingCompleteDefaultValue = false;
  
  _$ClientFeaturesConfigDataImpl({
    required this.config,
    this.profileNameRegex,
    this.dailyLikesLeft,
    this.loadingComplete = _loadingCompleteDefaultValue,
  }) : super._();

  @override
  final ClientFeaturesConfig config;
  @override
  final RegExp? profileNameRegex;
  @override
  final int? dailyLikesLeft;
  @override
  final bool loadingComplete;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClientFeaturesConfigData(config: $config, profileNameRegex: $profileNameRegex, dailyLikesLeft: $dailyLikesLeft, loadingComplete: $loadingComplete)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ClientFeaturesConfigData'))
      ..add(DiagnosticsProperty('config', config))
      ..add(DiagnosticsProperty('profileNameRegex', profileNameRegex))
      ..add(DiagnosticsProperty('dailyLikesLeft', dailyLikesLeft))
      ..add(DiagnosticsProperty('loadingComplete', loadingComplete));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ClientFeaturesConfigDataImpl &&
        (identical(other.config, config) ||
          other.config == config) &&
        (identical(other.profileNameRegex, profileNameRegex) ||
          other.profileNameRegex == profileNameRegex) &&
        (identical(other.dailyLikesLeft, dailyLikesLeft) ||
          other.dailyLikesLeft == dailyLikesLeft) &&
        (identical(other.loadingComplete, loadingComplete) ||
          other.loadingComplete == loadingComplete)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    config,
    profileNameRegex,
    dailyLikesLeft,
    loadingComplete,
  );

  @override
  ClientFeaturesConfigData copyWith({
    Object? config,
    Object? profileNameRegex = _detectDefaultValueInCopyWith,
    Object? dailyLikesLeft = _detectDefaultValueInCopyWith,
    Object? loadingComplete,
  }) => _$ClientFeaturesConfigDataImpl(
    config: (config ?? this.config) as ClientFeaturesConfig,
    profileNameRegex: (profileNameRegex == _detectDefaultValueInCopyWith ? this.profileNameRegex : profileNameRegex) as RegExp?,
    dailyLikesLeft: (dailyLikesLeft == _detectDefaultValueInCopyWith ? this.dailyLikesLeft : dailyLikesLeft) as int?,
    loadingComplete: (loadingComplete ?? this.loadingComplete) as bool,
  );
}
