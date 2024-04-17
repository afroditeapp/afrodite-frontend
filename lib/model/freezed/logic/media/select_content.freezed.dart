// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_content.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorSelectContentData = UnsupportedError(
    'Private constructor SelectContentData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$SelectContentData {
  UnmodifiableList<ContentId> get availableContent => throw _privateConstructorErrorSelectContentData;
  bool get isLoading => throw _privateConstructorErrorSelectContentData;

  SelectContentData copyWith({
    UnmodifiableList<ContentId>? availableContent,
    bool? isLoading,
  }) => throw _privateConstructorErrorSelectContentData;
}

/// @nodoc
abstract class _SelectContentData implements SelectContentData {
  factory _SelectContentData({
    UnmodifiableList<ContentId> availableContent,
    bool isLoading,
  }) = _$SelectContentDataImpl;
}

/// @nodoc
class _$SelectContentDataImpl implements _SelectContentData {
  static const UnmodifiableList<ContentId> _availableContentDefaultValue = UnmodifiableList<ContentId>.empty();
  static const bool _isLoadingDefaultValue = false;
  
  _$SelectContentDataImpl({
    this.availableContent = _availableContentDefaultValue,
    this.isLoading = _isLoadingDefaultValue,
  });

  @override
  final UnmodifiableList<ContentId> availableContent;
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'SelectContentData(availableContent: $availableContent, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$SelectContentDataImpl &&
        (identical(other.availableContent, availableContent) ||
          other.availableContent == availableContent) &&
        (identical(other.isLoading, isLoading) ||
          other.isLoading == isLoading)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    availableContent,
    isLoading,
  );

  @override
  SelectContentData copyWith({
    Object? availableContent,
    Object? isLoading,
  }) => _$SelectContentDataImpl(
    availableContent: (availableContent ?? this.availableContent) as UnmodifiableList<ContentId>,
    isLoading: (isLoading ?? this.isLoading) as bool,
  );
}
