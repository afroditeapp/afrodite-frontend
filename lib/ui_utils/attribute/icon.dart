import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final _log = Logger("AttributeIcons");

sealed class AttributeIcon {
  const AttributeIcon();
}

class MaterialAttributeIcon extends AttributeIcon {
  final IconData iconData;
  const MaterialAttributeIcon(this.iconData);
}

class EmojiAttributeIcon extends AttributeIcon {
  final String emoji;
  const EmojiAttributeIcon(this.emoji);
}

class AttributeIcons {
  static const Map<String, IconData> materialIcons = {
    "celebration_rounded": Icons.celebration_rounded,
    "close_rounded": Icons.close_rounded,
    "color_lens_rounded": Icons.color_lens_rounded,
    "favorite_rounded": Icons.favorite_rounded,
    "location_city_rounded": Icons.location_city_rounded,
    "question_mark_rounded": Icons.question_mark_rounded,
    "search_rounded": Icons.search_rounded,
    "waving_hand_rounded": Icons.waving_hand_rounded,
    "star_rounded": Icons.star_rounded,
  };

  static AttributeIcon? parseIconResource(String? iconResource) {
    if (iconResource == null) {
      return null;
    }
    const MATERIAL_PREFIX = "material:";
    const EMOJI_PREFIX = "emoji:";

    if (iconResource.startsWith(MATERIAL_PREFIX)) {
      final identifier = iconResource.substring(MATERIAL_PREFIX.length);
      final iconObject = materialIcons[identifier];
      if (iconObject != null) {
        return MaterialAttributeIcon(iconObject);
      } else {
        _log.warning("Icon $identifier is not supported");
      }
    } else if (iconResource.startsWith(EMOJI_PREFIX)) {
      final emoji = iconResource.substring(EMOJI_PREFIX.length);
      return EmojiAttributeIcon(emoji);
    }

    return null;
  }
}

class AttributeIconWidget extends StatelessWidget {
  final AttributeIcon? icon;
  final Color? color;

  const AttributeIconWidget({required this.icon, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    const double SIZE = 24;
    final icon = this.icon;
    if (icon == null) {
      return const SizedBox.shrink();
    }
    return switch (icon) {
      MaterialAttributeIcon(iconData: final data) => Icon(data, color: color, size: SIZE),
      EmojiAttributeIcon(emoji: final emoji) => SizedBox(
        width: SIZE,
        height: SIZE,
        child: FittedBox(
          child: Text(emoji, style: TextStyle(color: color, height: 1.0)),
        ),
      ),
    };
  }
}
