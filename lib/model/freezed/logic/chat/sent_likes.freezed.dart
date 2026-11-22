// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sent_likes.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorSentLikesData = UnsupportedError(
    'Private constructor SentLikesData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$SentLikesData {
  bool get blockOngoing => throw _privateConstructorErrorSentLikesData;

  SentLikesData copyWith({
    bool? blockOngoing,
  }) => throw _privateConstructorErrorSentLikesData;
}

/// @nodoc
abstract class _SentLikesData extends SentLikesData {
  factory _SentLikesData({
    bool blockOngoing,
  }) = _$SentLikesDataImpl;
  _SentLikesData._() : super._();
}

/// @nodoc
class _$SentLikesDataImpl extends _SentLikesData with DiagnosticableTreeMixin {
  static const bool _blockOngoingDefaultValue = false;

  _$SentLikesDataImpl({
    this.blockOngoing = _blockOngoingDefaultValue,
  }) : super._();

  @override
  final bool blockOngoing;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SentLikesData(blockOngoing: $blockOngoing)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SentLikesData'))
      ..add(DiagnosticsProperty('blockOngoing', blockOngoing));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$SentLikesDataImpl &&
        (identical(other.blockOngoing, blockOngoing) ||
          other.blockOngoing == blockOngoing)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    blockOngoing,
  );

  @override
  SentLikesData copyWith({
    Object? blockOngoing,
  }) => _$SentLikesDataImpl(
    blockOngoing: (blockOngoing ?? this.blockOngoing) as bool,
  );
}
