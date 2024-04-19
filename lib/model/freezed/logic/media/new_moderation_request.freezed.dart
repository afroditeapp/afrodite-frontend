// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_moderation_request.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorNewModerationRequestData = UnsupportedError(
    'Private constructor NewModerationRequestData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$NewModerationRequestData {
  AddedImages get selectedImgs => throw _privateConstructorErrorNewModerationRequestData;

  NewModerationRequestData copyWith({
    AddedImages? selectedImgs,
  }) => throw _privateConstructorErrorNewModerationRequestData;
}

/// @nodoc
abstract class _NewModerationRequestData implements NewModerationRequestData {
  factory _NewModerationRequestData({
    AddedImages selectedImgs,
  }) = _$NewModerationRequestDataImpl;
}

/// @nodoc
class _$NewModerationRequestDataImpl implements _NewModerationRequestData {
  static const AddedImages _selectedImgsDefaultValue = AddedImages();
  
  _$NewModerationRequestDataImpl({
    this.selectedImgs = _selectedImgsDefaultValue,
  });

  @override
  final AddedImages selectedImgs;

  @override
  String toString() {
    return 'NewModerationRequestData(selectedImgs: $selectedImgs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$NewModerationRequestDataImpl &&
        (identical(other.selectedImgs, selectedImgs) ||
          other.selectedImgs == selectedImgs)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    selectedImgs,
  );

  @override
  NewModerationRequestData copyWith({
    Object? selectedImgs,
  }) => _$NewModerationRequestDataImpl(
    selectedImgs: (selectedImgs ?? this.selectedImgs) as AddedImages,
  );
}
