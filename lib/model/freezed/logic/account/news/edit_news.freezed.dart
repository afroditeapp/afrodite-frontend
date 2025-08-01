// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_news.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorEditNewsData = UnsupportedError(
    'Private constructor EditNewsData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EditNewsData {
  List<String> get supportedLocales => throw _privateConstructorErrorEditNewsData;
  Map<String, NewsContent> get editableTranslations => throw _privateConstructorErrorEditNewsData;
  Map<String, NewsContent> get currentTranslations => throw _privateConstructorErrorEditNewsData;
  bool get isLoading => throw _privateConstructorErrorEditNewsData;
  bool get isError => throw _privateConstructorErrorEditNewsData;
  bool get isVisibleToUsers => throw _privateConstructorErrorEditNewsData;

  EditNewsData copyWith({
    List<String>? supportedLocales,
    Map<String, NewsContent>? editableTranslations,
    Map<String, NewsContent>? currentTranslations,
    bool? isLoading,
    bool? isError,
    bool? isVisibleToUsers,
  }) => throw _privateConstructorErrorEditNewsData;
}

/// @nodoc
abstract class _EditNewsData extends EditNewsData {
  factory _EditNewsData({
    required List<String> supportedLocales,
    Map<String, NewsContent> editableTranslations,
    Map<String, NewsContent> currentTranslations,
    bool isLoading,
    bool isError,
    bool isVisibleToUsers,
  }) = _$EditNewsDataImpl;
  const _EditNewsData._() : super._();
}

/// @nodoc
class _$EditNewsDataImpl extends _EditNewsData with DiagnosticableTreeMixin {
  static const Map<String, NewsContent> _editableTranslationsDefaultValue = {};
  static const Map<String, NewsContent> _currentTranslationsDefaultValue = {};
  static const bool _isLoadingDefaultValue = true;
  static const bool _isErrorDefaultValue = false;
  static const bool _isVisibleToUsersDefaultValue = false;
  
  _$EditNewsDataImpl({
    required this.supportedLocales,
    this.editableTranslations = _editableTranslationsDefaultValue,
    this.currentTranslations = _currentTranslationsDefaultValue,
    this.isLoading = _isLoadingDefaultValue,
    this.isError = _isErrorDefaultValue,
    this.isVisibleToUsers = _isVisibleToUsersDefaultValue,
  }) : super._();

  @override
  final List<String> supportedLocales;
  @override
  final Map<String, NewsContent> editableTranslations;
  @override
  final Map<String, NewsContent> currentTranslations;
  @override
  final bool isLoading;
  @override
  final bool isError;
  @override
  final bool isVisibleToUsers;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditNewsData(supportedLocales: $supportedLocales, editableTranslations: $editableTranslations, currentTranslations: $currentTranslations, isLoading: $isLoading, isError: $isError, isVisibleToUsers: $isVisibleToUsers)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditNewsData'))
      ..add(DiagnosticsProperty('supportedLocales', supportedLocales))
      ..add(DiagnosticsProperty('editableTranslations', editableTranslations))
      ..add(DiagnosticsProperty('currentTranslations', currentTranslations))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('isVisibleToUsers', isVisibleToUsers));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EditNewsDataImpl &&
        (identical(other.supportedLocales, supportedLocales) ||
          other.supportedLocales == supportedLocales) &&
        (identical(other.editableTranslations, editableTranslations) ||
          other.editableTranslations == editableTranslations) &&
        (identical(other.currentTranslations, currentTranslations) ||
          other.currentTranslations == currentTranslations) &&
        (identical(other.isLoading, isLoading) ||
          other.isLoading == isLoading) &&
        (identical(other.isError, isError) ||
          other.isError == isError) &&
        (identical(other.isVisibleToUsers, isVisibleToUsers) ||
          other.isVisibleToUsers == isVisibleToUsers)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    supportedLocales,
    editableTranslations,
    currentTranslations,
    isLoading,
    isError,
    isVisibleToUsers,
  );

  @override
  EditNewsData copyWith({
    Object? supportedLocales,
    Object? editableTranslations,
    Object? currentTranslations,
    Object? isLoading,
    Object? isError,
    Object? isVisibleToUsers,
  }) => _$EditNewsDataImpl(
    supportedLocales: (supportedLocales ?? this.supportedLocales) as List<String>,
    editableTranslations: (editableTranslations ?? this.editableTranslations) as Map<String, NewsContent>,
    currentTranslations: (currentTranslations ?? this.currentTranslations) as Map<String, NewsContent>,
    isLoading: (isLoading ?? this.isLoading) as bool,
    isError: (isError ?? this.isError) as bool,
    isVisibleToUsers: (isVisibleToUsers ?? this.isVisibleToUsers) as bool,
  );
}
