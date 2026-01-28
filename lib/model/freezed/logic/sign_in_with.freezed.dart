// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_with.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorSignInWithData = UnsupportedError(
    'Private constructor SignInWithData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$SignInWithData {
  bool get showProgress => throw _privateConstructorErrorSignInWithData;

  SignInWithData copyWith({
    bool? showProgress,
  }) => throw _privateConstructorErrorSignInWithData;
}

/// @nodoc
abstract class _SignInWithData implements SignInWithData {
  factory _SignInWithData({
    bool showProgress,
  }) = _$SignInWithDataImpl;
}

/// @nodoc
class _$SignInWithDataImpl with DiagnosticableTreeMixin implements _SignInWithData {
  static const bool _showProgressDefaultValue = false;

  _$SignInWithDataImpl({
    this.showProgress = _showProgressDefaultValue,
  });

  @override
  final bool showProgress;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SignInWithData(showProgress: $showProgress)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SignInWithData'))
      ..add(DiagnosticsProperty('showProgress', showProgress));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$SignInWithDataImpl &&
        (identical(other.showProgress, showProgress) ||
          other.showProgress == showProgress)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    showProgress,
  );

  @override
  SignInWithData copyWith({
    Object? showProgress,
  }) => _$SignInWithDataImpl(
    showProgress: (showProgress ?? this.showProgress) as bool,
  );
}
