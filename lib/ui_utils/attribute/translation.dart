
import 'package:openapi/api.dart';

class AttributeTranslation {
  static String getTranslatedString(
    String? locale,
    String key,
    String defaultString,
    List<Language> languages,
  ) {
    final translations = languages.where((element) => element.lang == locale).firstOrNull;
    if (translations == null) {
      return defaultString;
    }

    for (final translation in translations.values) {
      if (translation.key == key) {
        return translation.name;
      }
    }

    return defaultString;
  }
}
