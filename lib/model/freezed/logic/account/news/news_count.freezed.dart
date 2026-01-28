// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_count.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorNewsCountData = UnsupportedError(
    'Private constructor NewsCountData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$NewsCountData {
  int get newsCount => throw _privateConstructorErrorNewsCountData;

  NewsCountData copyWith({
    int? newsCount,
  }) => throw _privateConstructorErrorNewsCountData;
}

/// @nodoc
abstract class _NewsCountData extends NewsCountData {
  factory _NewsCountData({
    int newsCount,
  }) = _$NewsCountDataImpl;
  const _NewsCountData._() : super._();
}

/// @nodoc
class _$NewsCountDataImpl extends _NewsCountData with DiagnosticableTreeMixin {
  static const int _newsCountDefaultValue = 0;

  _$NewsCountDataImpl({
    this.newsCount = _newsCountDefaultValue,
  }) : super._();

  @override
  final int newsCount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NewsCountData(newsCount: $newsCount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NewsCountData'))
      ..add(DiagnosticsProperty('newsCount', newsCount));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$NewsCountDataImpl &&
        (identical(other.newsCount, newsCount) ||
          other.newsCount == newsCount)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    newsCount,
  );

  @override
  NewsCountData copyWith({
    Object? newsCount,
  }) => _$NewsCountDataImpl(
    newsCount: (newsCount ?? this.newsCount) as int,
  );
}
