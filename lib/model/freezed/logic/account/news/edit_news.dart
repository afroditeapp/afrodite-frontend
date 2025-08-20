import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';

part 'edit_news.freezed.dart';

@freezed
class EditNewsData with _$EditNewsData {
  const EditNewsData._();

  factory EditNewsData({
    required List<String> supportedLocales,
    @Default({}) Map<String, NewsContent> editableTranslations,
    @Default({}) Map<String, NewsContent> currentTranslations,
    @Default(true) bool isLoading,
    @Default(false) bool isError,
    @Default(false) bool isVisibleToUsers,
  }) = _EditNewsData;

  NewsContent editedOrCurrentlNewsContent(String locale) {
    return editableTranslations[locale] ??
        currentTranslations[locale] ??
        (title: "", body: "", version: null);
  }

  NewsContent currentlNewsContent(String locale) {
    return currentTranslations[locale] ?? (title: "", body: "", version: null);
  }

  Map<String, NewsContent> currentTranslationsWith(String locale, NewsContent content) {
    return {
      ...currentTranslations,
      locale: (title: content.title, body: content.body, version: content.version),
    };
  }

  Map<String, NewsContent> editableTranslationsWith(String locale, NewsContent content) {
    return {
      ...editableTranslations,
      locale: (title: content.title, body: content.body, version: null),
    };
  }

  bool unsavedChanges() {
    for (final l in supportedLocales) {
      if (translationContainsUnsavedChanges(l)) {
        return true;
      }
    }
    return false;
  }

  bool translationContainsUnsavedChanges(String locale) {
    final current = currentTranslations[locale];
    final edited = editableTranslations[locale];
    return current?.title != edited?.title || current?.body != edited?.body;
  }
}

typedef NewsContent = ({String title, String body, NewsTranslationVersion? version});
