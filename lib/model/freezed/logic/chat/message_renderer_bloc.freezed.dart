// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_renderer_bloc.dart';

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
final _privateConstructorErrorMessageRendererData = UnsupportedError(
    'Private constructor MessageRendererData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$MessageRendererData {
  bool get completed => throw _privateConstructorErrorMessageRendererData;
  double get totalHeight => throw _privateConstructorErrorMessageRendererData;
  MessageEntry? get currentlyRendering => throw _privateConstructorErrorMessageRendererData;
  UnmodifiableList<MessageEntry> get toBeRendered => throw _privateConstructorErrorMessageRendererData;

  MessageRendererData copyWith({
    bool? completed,
    double? totalHeight,
    MessageEntry? currentlyRendering,
    UnmodifiableList<MessageEntry>? toBeRendered,
  }) => throw _privateConstructorErrorMessageRendererData;
}

/// @nodoc
abstract class _MessageRendererData implements MessageRendererData {
  factory _MessageRendererData({
    bool completed,
    double totalHeight,
    MessageEntry? currentlyRendering,
    UnmodifiableList<MessageEntry> toBeRendered,
  }) = _$MessageRendererDataImpl;
}

/// @nodoc
class _$MessageRendererDataImpl with DiagnosticableTreeMixin implements _MessageRendererData {
  static const bool _completedDefaultValue = false;
  static const double _totalHeightDefaultValue = 0.0;
  static const UnmodifiableList<MessageEntry> _toBeRenderedDefaultValue = UnmodifiableList<MessageEntry>.empty();
  
  _$MessageRendererDataImpl({
    this.completed = _completedDefaultValue,
    this.totalHeight = _totalHeightDefaultValue,
    this.currentlyRendering,
    this.toBeRendered = _toBeRenderedDefaultValue,
  });

  @override
  final bool completed;
  @override
  final double totalHeight;
  @override
  final MessageEntry? currentlyRendering;
  @override
  final UnmodifiableList<MessageEntry> toBeRendered;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessageRendererData(completed: $completed, totalHeight: $totalHeight, currentlyRendering: $currentlyRendering, toBeRendered: $toBeRendered)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MessageRendererData'))
      ..add(DiagnosticsProperty('completed', completed))
      ..add(DiagnosticsProperty('totalHeight', totalHeight))
      ..add(DiagnosticsProperty('currentlyRendering', currentlyRendering))
      ..add(DiagnosticsProperty('toBeRendered', toBeRendered));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$MessageRendererDataImpl &&
        (identical(other.completed, completed) ||
          other.completed == completed) &&
        (identical(other.totalHeight, totalHeight) ||
          other.totalHeight == totalHeight) &&
        (identical(other.currentlyRendering, currentlyRendering) ||
          other.currentlyRendering == currentlyRendering) &&
        (identical(other.toBeRendered, toBeRendered) ||
          other.toBeRendered == toBeRendered)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    completed,
    totalHeight,
    currentlyRendering,
    toBeRendered,
  );

  @override
  MessageRendererData copyWith({
    Object? completed,
    Object? totalHeight,
    Object? currentlyRendering = _detectDefaultValueInCopyWith,
    Object? toBeRendered,
  }) => _$MessageRendererDataImpl(
    completed: (completed ?? this.completed) as bool,
    totalHeight: (totalHeight ?? this.totalHeight) as double,
    currentlyRendering: (currentlyRendering == _detectDefaultValueInCopyWith ? this.currentlyRendering : currentlyRendering) as MessageEntry?,
    toBeRendered: (toBeRendered ?? this.toBeRendered) as UnmodifiableList<MessageEntry>,
  );
}
