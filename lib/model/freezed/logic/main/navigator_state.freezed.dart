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
  UnmodifiableList<MyPage> get pages => throw _privateConstructorErrorNavigatorStateData;

  NavigatorStateData copyWith({
    UnmodifiableList<MyPage>? pages,
  }) => throw _privateConstructorErrorNavigatorStateData;
}

/// @nodoc
abstract class _NavigatorStateData extends NavigatorStateData {
  factory _NavigatorStateData({
    required UnmodifiableList<MyPage> pages,
  }) = _$NavigatorStateDataImpl;
  _NavigatorStateData._() : super._();
}

/// @nodoc
class _$NavigatorStateDataImpl extends _NavigatorStateData with DiagnosticableTreeMixin {
  _$NavigatorStateDataImpl({
    required this.pages,
  }) : super._();

  @override
  final UnmodifiableList<MyPage> pages;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NavigatorStateData(pages: $pages)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NavigatorStateData'))
      ..add(DiagnosticsProperty('pages', pages));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$NavigatorStateDataImpl &&
        (identical(other.pages, pages) ||
          other.pages == pages)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    pages,
  );

  @override
  NavigatorStateData copyWith({
    Object? pages,
  }) => _$NavigatorStateDataImpl(
    pages: (pages ?? this.pages) as UnmodifiableList<MyPage>,
  );
}
