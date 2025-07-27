// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_name_moderation.dart';

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
final _privateConstructorErrorProfileNameModerationData = UnsupportedError(
    'Private constructor ProfileNameModerationData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ProfileNameModerationData {
  bool get isLoading => throw _privateConstructorErrorProfileNameModerationData;
  bool get isError => throw _privateConstructorErrorProfileNameModerationData;
  GetProfileStringPendingModerationList? get item => throw _privateConstructorErrorProfileNameModerationData;
  Set<ProfileStringPendingModeration> get selected => throw _privateConstructorErrorProfileNameModerationData;

  ProfileNameModerationData copyWith({
    bool? isLoading,
    bool? isError,
    GetProfileStringPendingModerationList? item,
    Set<ProfileStringPendingModeration>? selected,
  }) => throw _privateConstructorErrorProfileNameModerationData;
}

/// @nodoc
abstract class _ProfileNameModerationData implements ProfileNameModerationData {
  factory _ProfileNameModerationData({
    bool isLoading,
    bool isError,
    GetProfileStringPendingModerationList? item,
    Set<ProfileStringPendingModeration> selected,
  }) = _$ProfileNameModerationDataImpl;
}

/// @nodoc
class _$ProfileNameModerationDataImpl with DiagnosticableTreeMixin implements _ProfileNameModerationData {
  static const bool _isLoadingDefaultValue = true;
  static const bool _isErrorDefaultValue = false;
  static const Set<ProfileStringPendingModeration> _selectedDefaultValue = {};
  
  _$ProfileNameModerationDataImpl({
    this.isLoading = _isLoadingDefaultValue,
    this.isError = _isErrorDefaultValue,
    this.item,
    this.selected = _selectedDefaultValue,
  });

  @override
  final bool isLoading;
  @override
  final bool isError;
  @override
  final GetProfileStringPendingModerationList? item;
  @override
  final Set<ProfileStringPendingModeration> selected;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfileNameModerationData(isLoading: $isLoading, isError: $isError, item: $item, selected: $selected)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfileNameModerationData'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('item', item))
      ..add(DiagnosticsProperty('selected', selected));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ProfileNameModerationDataImpl &&
        (identical(other.isLoading, isLoading) ||
          other.isLoading == isLoading) &&
        (identical(other.isError, isError) ||
          other.isError == isError) &&
        (identical(other.item, item) ||
          other.item == item) &&
        (identical(other.selected, selected) ||
          other.selected == selected)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isError,
    item,
    selected,
  );

  @override
  ProfileNameModerationData copyWith({
    Object? isLoading,
    Object? isError,
    Object? item = _detectDefaultValueInCopyWith,
    Object? selected,
  }) => _$ProfileNameModerationDataImpl(
    isLoading: (isLoading ?? this.isLoading) as bool,
    isError: (isError ?? this.isError) as bool,
    item: (item == _detectDefaultValueInCopyWith ? this.item : item) as GetProfileStringPendingModerationList?,
    selected: (selected ?? this.selected) as Set<ProfileStringPendingModeration>,
  );
}
