// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'association_membership.dart';

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
final _privateConstructorErrorAssociationMembershipBlocData = UnsupportedError(
    'Private constructor AssociationMembershipBlocData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$AssociationMembershipBlocData {
  bool get isLoading => throw _privateConstructorErrorAssociationMembershipBlocData;
  bool get isError => throw _privateConstructorErrorAssociationMembershipBlocData;
  AssociationMembership? get membership => throw _privateConstructorErrorAssociationMembershipBlocData;
  AssociationConfig? get config => throw _privateConstructorErrorAssociationMembershipBlocData;
  GetAssociationMembersOnlyInfo? get membersOnlyInfo => throw _privateConstructorErrorAssociationMembershipBlocData;
  UpdateState get updateState => throw _privateConstructorErrorAssociationMembershipBlocData;

  AssociationMembershipBlocData copyWith({
    bool? isLoading,
    bool? isError,
    AssociationMembership? membership,
    AssociationConfig? config,
    GetAssociationMembersOnlyInfo? membersOnlyInfo,
    UpdateState? updateState,
  }) => throw _privateConstructorErrorAssociationMembershipBlocData;
}

/// @nodoc
abstract class _AssociationMembershipBlocData implements AssociationMembershipBlocData {
  factory _AssociationMembershipBlocData({
    bool isLoading,
    bool isError,
    AssociationMembership? membership,
    AssociationConfig? config,
    GetAssociationMembersOnlyInfo? membersOnlyInfo,
    UpdateState updateState,
  }) = _$AssociationMembershipBlocDataImpl;
}

/// @nodoc
class _$AssociationMembershipBlocDataImpl with DiagnosticableTreeMixin implements _AssociationMembershipBlocData {
  static const bool _isLoadingDefaultValue = false;
  static const bool _isErrorDefaultValue = false;
  static const UpdateState _updateStateDefaultValue = UpdateIdle();

  _$AssociationMembershipBlocDataImpl({
    this.isLoading = _isLoadingDefaultValue,
    this.isError = _isErrorDefaultValue,
    this.membership,
    this.config,
    this.membersOnlyInfo,
    this.updateState = _updateStateDefaultValue,
  });

  @override
  final bool isLoading;
  @override
  final bool isError;
  @override
  final AssociationMembership? membership;
  @override
  final AssociationConfig? config;
  @override
  final GetAssociationMembersOnlyInfo? membersOnlyInfo;
  @override
  final UpdateState updateState;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AssociationMembershipBlocData(isLoading: $isLoading, isError: $isError, membership: $membership, config: $config, membersOnlyInfo: $membersOnlyInfo, updateState: $updateState)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AssociationMembershipBlocData'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('membership', membership))
      ..add(DiagnosticsProperty('config', config))
      ..add(DiagnosticsProperty('membersOnlyInfo', membersOnlyInfo))
      ..add(DiagnosticsProperty('updateState', updateState));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$AssociationMembershipBlocDataImpl &&
        (identical(other.isLoading, isLoading) ||
          other.isLoading == isLoading) &&
        (identical(other.isError, isError) ||
          other.isError == isError) &&
        (identical(other.membership, membership) ||
          other.membership == membership) &&
        (identical(other.config, config) ||
          other.config == config) &&
        (identical(other.membersOnlyInfo, membersOnlyInfo) ||
          other.membersOnlyInfo == membersOnlyInfo) &&
        (identical(other.updateState, updateState) ||
          other.updateState == updateState)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isError,
    membership,
    config,
    membersOnlyInfo,
    updateState,
  );

  @override
  AssociationMembershipBlocData copyWith({
    Object? isLoading,
    Object? isError,
    Object? membership = _detectDefaultValueInCopyWith,
    Object? config = _detectDefaultValueInCopyWith,
    Object? membersOnlyInfo = _detectDefaultValueInCopyWith,
    Object? updateState,
  }) => _$AssociationMembershipBlocDataImpl(
    isLoading: (isLoading ?? this.isLoading) as bool,
    isError: (isError ?? this.isError) as bool,
    membership: (membership == _detectDefaultValueInCopyWith ? this.membership : membership) as AssociationMembership?,
    config: (config == _detectDefaultValueInCopyWith ? this.config : config) as AssociationConfig?,
    membersOnlyInfo: (membersOnlyInfo == _detectDefaultValueInCopyWith ? this.membersOnlyInfo : membersOnlyInfo) as GetAssociationMembersOnlyInfo?,
    updateState: (updateState ?? this.updateState) as UpdateState,
  );
}
