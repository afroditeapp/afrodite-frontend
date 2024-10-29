// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_interface.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorUserInterfaceSettingsData = UnsupportedError(
    'Private constructor UserInterfaceSettingsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$UserInterfaceSettingsData {
  bool get showNonAcceptedProfileNames => throw _privateConstructorErrorUserInterfaceSettingsData;

  UserInterfaceSettingsData copyWith({
    bool? showNonAcceptedProfileNames,
  }) => throw _privateConstructorErrorUserInterfaceSettingsData;
}

/// @nodoc
abstract class _UserInterfaceSettingsData extends UserInterfaceSettingsData {
  factory _UserInterfaceSettingsData({
    bool showNonAcceptedProfileNames,
  }) = _$UserInterfaceSettingsDataImpl;
  _UserInterfaceSettingsData._() : super._();
}

/// @nodoc
class _$UserInterfaceSettingsDataImpl extends _UserInterfaceSettingsData with DiagnosticableTreeMixin {
  static const bool _showNonAcceptedProfileNamesDefaultValue = false;
  
  _$UserInterfaceSettingsDataImpl({
    this.showNonAcceptedProfileNames = _showNonAcceptedProfileNamesDefaultValue,
  }) : super._();

  @override
  final bool showNonAcceptedProfileNames;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserInterfaceSettingsData(showNonAcceptedProfileNames: $showNonAcceptedProfileNames)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserInterfaceSettingsData'))
      ..add(DiagnosticsProperty('showNonAcceptedProfileNames', showNonAcceptedProfileNames));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$UserInterfaceSettingsDataImpl &&
        (identical(other.showNonAcceptedProfileNames, showNonAcceptedProfileNames) ||
          other.showNonAcceptedProfileNames == showNonAcceptedProfileNames)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    showNonAcceptedProfileNames,
  );

  @override
  UserInterfaceSettingsData copyWith({
    Object? showNonAcceptedProfileNames,
  }) => _$UserInterfaceSettingsDataImpl(
    showNonAcceptedProfileNames: (showNonAcceptedProfileNames ?? this.showNonAcceptedProfileNames) as bool,
  );
}
