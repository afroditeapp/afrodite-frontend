
import 'package:openapi/api.dart';

class AttributeTranslation {
  static String getTranslatedString(
    String locale,
    String key,
    String englishString,
    List<Language> languages,
  ) {
    if (locale == "en") {
      return englishString;
    }

    final translations = languages.where((element) => element.lang == locale).firstOrNull;
    if (translations == null) {
      return englishString;
    }

    for (final translation in translations.values) {
      if (translation.key == key) {
        return translation.value;
      }
    }

    return englishString;
  }
}
