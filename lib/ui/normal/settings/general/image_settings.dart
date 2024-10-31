

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:app/data/general/image_cache_settings.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';

final log = Logger("ImageSettingsScreen");

class ImageSettingsScreen extends StatefulWidget {
  const ImageSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ImageSettingsScreen> createState() => _ImageSettingsScreenState();
}


class _ImageSettingsScreenState extends State<ImageSettingsScreen> {
  final ImageCacheSettings imageCacheSettings = LoginRepository.getInstance().repositories.imageCacheSettings;

  int cacheMaxBytes = 0;
  bool fullImgSize = false;
  int downscalingSize = 0;

  @override
  void initState() {
    super.initState();

    cacheMaxBytes = imageCacheSettings.imageCacheMaxBytesValue;
    fullImgSize = imageCacheSettings.cacheFullSizedImagesValue;
    downscalingSize = imageCacheSettings.cacheDownscalingSizeValue;
  }

  Future<void> saveSettings() async {
    log.info("Saving image settings");
    await imageCacheSettings.saveSettings(cacheMaxBytes, fullImgSize, downscalingSize);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          saveSettings();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.strings.image_quality_settings_screen_title),
        ),
        body: SingleChildScrollView(
          child: content(context),
        ),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        maxImageQualityCheckbox(context),
        const Padding(padding: EdgeInsets.all(4)),
        hPad(Text(
          context.strings.image_quality_settings_screen_image_quality_setting,
          style: fullImgSize ? TextStyle(color: Theme.of(context).disabledColor) : null,
        )),
        const Padding(padding: EdgeInsets.all(8)),
        downscalingSizeDropdown(context),
        const Padding(padding: EdgeInsets.all(4)),
        ...imageQualitySlider(context),
        const Padding(padding: EdgeInsets.all(8)),
        hPad(Text(context.strings.image_quality_settings_screen_image_cache_max_size)),
        const Padding(padding: EdgeInsets.all(4)),
        ...imageCacheMaxSizeSlider(context),
        const Padding(padding: EdgeInsets.all(4)),
        resetToDefaults(),
      ],
    );
  }

  Widget maxImageQualityCheckbox(BuildContext context) {
    return CheckboxListTile(
      title: Text(context.strings.image_quality_settings_screen_max_image_quality),
      value: fullImgSize,
      onChanged: (value) {
        setState(() {
          fullImgSize = value!;
        });
      },
    );
  }

  Widget downscalingSizeDropdown(BuildContext context) {
    final void Function(int?)? onChanged = fullImgSize ? null : (value) {
      if (value != null) {
          setState(() {
            downscalingSize = value;
          });
        }
    };

    final items = [
      DropdownMenuItem(
        value: ImageCacheSizeSetting.maxQuality.getImgSize().maxSize,
        child: Text(context.strings.image_quality_settings_screen_image_quality_max),
      ),
      DropdownMenuItem(
        value: ImageCacheSizeSetting.high.getImgSize().maxSize,
        child: Text(context.strings.image_quality_settings_screen_image_quality_high),
      ),
      DropdownMenuItem(
        value: ImageCacheSizeSetting.medium.getImgSize().maxSize,
        child: Text(context.strings.image_quality_settings_screen_image_quality_medium),
      ),
      DropdownMenuItem(
        value: ImageCacheSizeSetting.low.getImgSize().maxSize,
        child: Text(context.strings.image_quality_settings_screen_image_quality_low),
      ),
      DropdownMenuItem(
        value: ImageCacheSizeSetting.tiny.getImgSize().maxSize,
        child: Text(context.strings.image_quality_settings_screen_image_quality_tiny),
      ),
    ];

    bool currentValueFound = false;
    for (final item in items) {
      if (item.value == downscalingSize) {
        currentValueFound = true;
        break;
      }
    }
    if (!currentValueFound) {
      items.add(DropdownMenuItem(
        value: downscalingSize,
        child: Text(context.strings.image_quality_settings_screen_image_quality_custom),
      ));
    }

    return DropdownButton<int>(
      value: fullImgSize ? ImageCacheSizeSetting.maxQuality.getImgSize().maxSize : downscalingSize,
      items: items,
      isExpanded: true,
      onChanged: onChanged,
      padding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }

  List<Widget> imageQualitySlider(BuildContext context) {
    final void Function(double)? onChanged = fullImgSize ? null : (value) {
      setState(() {
        downscalingSize = value.toInt();
      });
    };

    final selectedValueInt = fullImgSize ?
      ImageCacheSizeSetting.maxQuality.getImgSize().maxSize :
        downscalingSize;

    return [
      Slider(
        min: ImageCacheSizeSetting.tiny.getImgSize().maxSize.toDouble(),
        max: ImageCacheSizeSetting.maxQuality.getImgSize().maxSize.toDouble(),
        value: selectedValueInt.toDouble(),
        onChanged: onChanged,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: hPad(Text(
          context.strings.image_quality_settings_screen_image_quality_pixel_value(selectedValueInt.toString()),
          style: fullImgSize ? TextStyle(color: Theme.of(context).disabledColor) : null,
        )),
      )
    ];
  }

  List<Widget> imageCacheMaxSizeSlider(BuildContext context) {
    return [
      Slider(
        min: CACHE_MIN_BYTES.toDouble(),
        max: CACHE_MAX_BYTES.toDouble(),
        value: cacheMaxBytes.toDouble(),
        onChanged: (value) {
          setState(() {
            cacheMaxBytes = value.toInt();
          });
        },
      ),
      Align(
        alignment: Alignment.centerRight,
        child: hPad(Text('${cacheMibibytesValue()} MiB')),
      )
    ];
  }

  int cacheMibibytesValue() {
    return cacheMaxBytes ~/ 1024 ~/ 1024;
  }

  Widget resetToDefaults() {
    return ListTile(
      title: Text(context.strings.image_quality_settings_screen_reset_to_defaults),
      onTap: () async {
        final accepted = await showConfirmDialog(
          context,
          context.strings.image_quality_settings_screen_reset_to_defaults_dialog_title,
        );
        if (accepted == true) {
          setState(() {
            cacheMaxBytes = CACHE_DEFAULT_BYTES;
            fullImgSize = CACHE_FULL_SIZED_IMAGES_DEFAULT;
            downscalingSize = CACHE_DOWNSCALING_SIZE_DEFAULT;
          });
        }
      },
    );
  }
}
