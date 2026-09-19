// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_with_management.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorSignInWithManagementBlocData = UnsupportedError(
    'Private constructor SignInWithManagementBlocData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$SignInWithManagementBlocData {
  bool get isLoading => throw _privateConstructorErrorSignInWithManagementBlocData;
  bool get isError => throw _privateConstructorErrorSignInWithManagementBlocData;
  bool get apple => throw _privateConstructorErrorSignInWithManagementBlocData;
  bool get google => throw _privateConstructorErrorSignInWithManagementBlocData;
  bool get emailLoginEnabled => throw _privateConstructorErrorSignInWithManagementBlocData;
  UpdateState get updateState => throw _privateConstructorErrorSignInWithManagementBlocData;

  SignInWithManagementBlocData copyWith({
    bool? isLoading,
    bool? isError,
    bool? apple,
    bool? google,
    bool? emailLoginEnabled,
    UpdateState? updateState,
  }) => throw _privateConstructorErrorSignInWithManagementBlocData;
}

/// @nodoc
abstract class _SignInWithManagementBlocData implements SignInWithManagementBlocData {
  factory _SignInWithManagementBlocData({
    bool isLoading,
    bool isError,
    bool apple,
    bool google,
    bool emailLoginEnabled,
    UpdateState updateState,
  }) = _$SignInWithManagementBlocDataImpl;
}

/// @nodoc
class _$SignInWithManagementBlocDataImpl with DiagnosticableTreeMixin implements _SignInWithManagementBlocData {
  static const bool _isLoadingDefaultValue = true;
  static const bool _isErrorDefaultValue = false;
  static const bool _appleDefaultValue = false;
  static const bool _googleDefaultValue = false;
  static const bool _emailLoginEnabledDefaultValue = true;
  static const UpdateState _updateStateDefaultValue = UpdateIdle();

  _$SignInWithManagementBlocDataImpl({
    this.isLoading = _isLoadingDefaultValue,
    this.isError = _isErrorDefaultValue,
    this.apple = _appleDefaultValue,
    this.google = _googleDefaultValue,
    this.emailLoginEnabled = _emailLoginEnabledDefaultValue,
    this.updateState = _updateStateDefaultValue,
  });

  @override
  final bool isLoading;
  @override
  final bool isError;
  @override
  final bool apple;
  @override
  final bool google;
  @override
  final bool emailLoginEnabled;
  @override
  final UpdateState updateState;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SignInWithManagementBlocData(isLoading: $isLoading, isError: $isError, apple: $apple, google: $google, emailLoginEnabled: $emailLoginEnabled, updateState: $updateState)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SignInWithManagementBlocData'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('apple', apple))
      ..add(DiagnosticsProperty('google', google))
      ..add(DiagnosticsProperty('emailLoginEnabled', emailLoginEnabled))
      ..add(DiagnosticsProperty('updateState', updateState));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$SignInWithManagementBlocDataImpl &&
        (identical(other.isLoading, isLoading) ||
          other.isLoading == isLoading) &&
        (identical(other.isError, isError) ||
          other.isError == isError) &&
        (identical(other.apple, apple) ||
          other.apple == apple) &&
        (identical(other.google, google) ||
          other.google == google) &&
        (identical(other.emailLoginEnabled, emailLoginEnabled) ||
          other.emailLoginEnabled == emailLoginEnabled) &&
        (identical(other.updateState, updateState) ||
          other.updateState == updateState)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isError,
    apple,
    google,
    emailLoginEnabled,
    updateState,
  );

  @override
  SignInWithManagementBlocData copyWith({
    Object? isLoading,
    Object? isError,
    Object? apple,
    Object? google,
    Object? emailLoginEnabled,
    Object? updateState,
  }) => _$SignInWithManagementBlocDataImpl(
    isLoading: (isLoading ?? this.isLoading) as bool,
    isError: (isError ?? this.isError) as bool,
    apple: (apple ?? this.apple) as bool,
    google: (google ?? this.google) as bool,
    emailLoginEnabled: (emailLoginEnabled ?? this.emailLoginEnabled) as bool,
    updateState: (updateState ?? this.updateState) as UpdateState,
  );
}
