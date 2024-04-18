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
  UnmodifiableList<ContentId> get pendingModeration => throw _privateConstructorErrorSelectContentData;
  bool get initialModerationOngoing => throw _privateConstructorErrorSelectContentData;
  bool get showMakeNewModerationRequest => throw _privateConstructorErrorSelectContentData;
  bool get isLoading => throw _privateConstructorErrorSelectContentData;
  bool get isError => throw _privateConstructorErrorSelectContentData;

  SelectContentData copyWith({
    UnmodifiableList<ContentId>? availableContent,
    UnmodifiableList<ContentId>? pendingModeration,
    bool? initialModerationOngoing,
    bool? showMakeNewModerationRequest,
    bool? isLoading,
    bool? isError,
  }) => throw _privateConstructorErrorSelectContentData;
}

/// @nodoc
abstract class _SelectContentData implements SelectContentData {
  factory _SelectContentData({
    UnmodifiableList<ContentId> availableContent,
    UnmodifiableList<ContentId> pendingModeration,
    bool initialModerationOngoing,
    bool showMakeNewModerationRequest,
    bool isLoading,
    bool isError,
  }) = _$SelectContentDataImpl;
}

/// @nodoc
class _$SelectContentDataImpl implements _SelectContentData {
  static const UnmodifiableList<ContentId> _availableContentDefaultValue = UnmodifiableList<ContentId>.empty();
  static const UnmodifiableList<ContentId> _pendingModerationDefaultValue = UnmodifiableList<ContentId>.empty();
  static const bool _initialModerationOngoingDefaultValue = false;
  static const bool _showMakeNewModerationRequestDefaultValue = false;
  static const bool _isLoadingDefaultValue = false;
  static const bool _isErrorDefaultValue = false;
  
  _$SelectContentDataImpl({
    this.availableContent = _availableContentDefaultValue,
    this.pendingModeration = _pendingModerationDefaultValue,
    this.initialModerationOngoing = _initialModerationOngoingDefaultValue,
    this.showMakeNewModerationRequest = _showMakeNewModerationRequestDefaultValue,
    this.isLoading = _isLoadingDefaultValue,
    this.isError = _isErrorDefaultValue,
  });

  @override
  final UnmodifiableList<ContentId> availableContent;
  @override
  final UnmodifiableList<ContentId> pendingModeration;
  @override
  final bool initialModerationOngoing;
  @override
  final bool showMakeNewModerationRequest;
  @override
  final bool isLoading;
  @override
  final bool isError;

  @override
  String toString() {
    return 'SelectContentData(availableContent: $availableContent, pendingModeration: $pendingModeration, initialModerationOngoing: $initialModerationOngoing, showMakeNewModerationRequest: $showMakeNewModerationRequest, isLoading: $isLoading, isError: $isError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$SelectContentDataImpl &&
        (identical(other.availableContent, availableContent) ||
          other.availableContent == availableContent) &&
        (identical(other.pendingModeration, pendingModeration) ||
          other.pendingModeration == pendingModeration) &&
        (identical(other.initialModerationOngoing, initialModerationOngoing) ||
          other.initialModerationOngoing == initialModerationOngoing) &&
        (identical(other.showMakeNewModerationRequest, showMakeNewModerationRequest) ||
          other.showMakeNewModerationRequest == showMakeNewModerationRequest) &&
        (identical(other.isLoading, isLoading) ||
          other.isLoading == isLoading) &&
        (identical(other.isError, isError) ||
          other.isError == isError)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    availableContent,
    pendingModeration,
    initialModerationOngoing,
    showMakeNewModerationRequest,
    isLoading,
    isError,
  );

  @override
  SelectContentData copyWith({
    Object? availableContent,
    Object? pendingModeration,
    Object? initialModerationOngoing,
    Object? showMakeNewModerationRequest,
    Object? isLoading,
    Object? isError,
  }) => _$SelectContentDataImpl(
    availableContent: (availableContent ?? this.availableContent) as UnmodifiableList<ContentId>,
    pendingModeration: (pendingModeration ?? this.pendingModeration) as UnmodifiableList<ContentId>,
    initialModerationOngoing: (initialModerationOngoing ?? this.initialModerationOngoing) as bool,
    showMakeNewModerationRequest: (showMakeNewModerationRequest ?? this.showMakeNewModerationRequest) as bool,
    isLoading: (isLoading ?? this.isLoading) as bool,
    isError: (isError ?? this.isError) as bool,
  );
}
