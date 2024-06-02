// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigator_state.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorNavigatorStateData = UnsupportedError(
    'Private constructor NavigatorStateData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$NavigatorStateData {
  UnmodifiableList<PageAndChannel> get pages => throw _privateConstructorErrorNavigatorStateData;
  bool get disableAnimation => throw _privateConstructorErrorNavigatorStateData;

  NavigatorStateData copyWith({
    UnmodifiableList<PageAndChannel>? pages,
    bool? disableAnimation,
  }) => throw _privateConstructorErrorNavigatorStateData;
}

/// @nodoc
abstract class _NavigatorStateData extends NavigatorStateData {
  factory _NavigatorStateData({
    required UnmodifiableList<PageAndChannel> pages,
    bool disableAnimation,
  }) = _$NavigatorStateDataImpl;
  _NavigatorStateData._() : super._();
}

/// @nodoc
class _$NavigatorStateDataImpl extends _NavigatorStateData with DiagnosticableTreeMixin {
  static const bool _disableAnimationDefaultValue = false;
  
  _$NavigatorStateDataImpl({
    required this.pages,
    this.disableAnimation = _disableAnimationDefaultValue,
  }) : super._();

  @override
  final UnmodifiableList<PageAndChannel> pages;
  @override
  final bool disableAnimation;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NavigatorStateData(pages: $pages, disableAnimation: $disableAnimation)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NavigatorStateData'))
      ..add(DiagnosticsProperty('pages', pages))
      ..add(DiagnosticsProperty('disableAnimation', disableAnimation));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$NavigatorStateDataImpl &&
        (identical(other.pages, pages) ||
          other.pages == pages) &&
        (identical(other.disableAnimation, disableAnimation) ||
          other.disableAnimation == disableAnimation)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    pages,
    disableAnimation,
  );

  @override
  NavigatorStateData copyWith({
    Object? pages,
    Object? disableAnimation,
  }) => _$NavigatorStateDataImpl(
    pages: (pages ?? this.pages) as UnmodifiableList<PageAndChannel>,
    disableAnimation: (disableAnimation ?? this.disableAnimation) as bool,
  );
}
