import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final log = Logger("AttributeIcons");

class AttributeIcons {
  static IconData? iconResourceToMaterialIcon(String? iconResouce) {
    if (iconResouce == null) {
      return null;
    }
    const PREFIX = "material:";
    if (!iconResouce.startsWith(PREFIX)) {
      log.warning("Only material icons are supported");
      return null;
    }

    final identifier = iconResouce.substring(PREFIX.length);

    final IconData? iconObject = switch (identifier) {
      "celebration_rounded" => Icons.celebration_rounded,
      "close_rounded" => Icons.close_rounded,
      "color_lens_rounded" => Icons.color_lens_rounded,
      "favorite_rounded" => Icons.favorite_rounded,
      "location_city_rounded" => Icons.location_city_rounded,
      "question_mark_rounded" => Icons.question_mark_rounded,
      "search_rounded" => Icons.search_rounded,
      "waving_hand_rounded" => Icons.waving_hand_rounded,
      "star_rounded" => Icons.star_rounded,
      _ => null,
    };

    if (iconObject == null) {
      log.warning("Icon $identifier is not supported");
    }

    return iconObject;
  }
}
