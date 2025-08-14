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

  ClientFeaturesConfigData copyWith({
    ClientFeaturesConfig? config,
    RegExp? profileNameRegex,
    int? dailyLikesLeft,
  }) => throw _privateConstructorErrorClientFeaturesConfigData;
}

/// @nodoc
abstract class _ClientFeaturesConfigData extends ClientFeaturesConfigData {
  factory _ClientFeaturesConfigData({
    required ClientFeaturesConfig config,
    RegExp? profileNameRegex,
    int? dailyLikesLeft,
  }) = _$ClientFeaturesConfigDataImpl;
  _ClientFeaturesConfigData._() : super._();
}

/// @nodoc
class _$ClientFeaturesConfigDataImpl extends _ClientFeaturesConfigData with DiagnosticableTreeMixin {
  _$ClientFeaturesConfigDataImpl({
    required this.config,
    this.profileNameRegex,
    this.dailyLikesLeft,
  }) : super._();

  @override
  final ClientFeaturesConfig config;
  @override
  final RegExp? profileNameRegex;
  @override
  final int? dailyLikesLeft;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClientFeaturesConfigData(config: $config, profileNameRegex: $profileNameRegex, dailyLikesLeft: $dailyLikesLeft)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ClientFeaturesConfigData'))
      ..add(DiagnosticsProperty('config', config))
      ..add(DiagnosticsProperty('profileNameRegex', profileNameRegex))
      ..add(DiagnosticsProperty('dailyLikesLeft', dailyLikesLeft));
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
          other.dailyLikesLeft == dailyLikesLeft)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    config,
    profileNameRegex,
    dailyLikesLeft,
  );

  @override
  ClientFeaturesConfigData copyWith({
    Object? config,
    Object? profileNameRegex = _detectDefaultValueInCopyWith,
    Object? dailyLikesLeft = _detectDefaultValueInCopyWith,
  }) => _$ClientFeaturesConfigDataImpl(
    config: (config ?? this.config) as ClientFeaturesConfig,
    profileNameRegex: (profileNameRegex == _detectDefaultValueInCopyWith ? this.profileNameRegex : profileNameRegex) as RegExp?,
    dailyLikesLeft: (dailyLikesLeft == _detectDefaultValueInCopyWith ? this.dailyLikesLeft : dailyLikesLeft) as int?,
  );
}
