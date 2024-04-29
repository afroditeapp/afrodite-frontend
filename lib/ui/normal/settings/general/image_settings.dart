

import 'package:flutter/material.dart';
import 'package:pihka_frontend/data/general/image_cache_settings.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/ui_utils/padding.dart';

class ImageSettingsScreen extends StatefulWidget {
  const ImageSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ImageSettingsScreen> createState() => _ImageSettingsScreenState();
}


class _ImageSettingsScreenState extends State<ImageSettingsScreen> {

  int cacheMaxBytes = 0;
  bool fullImgSize = false;
  int downscalingSize = 0;

  @override
  void initState() {
    super.initState();

    cacheMaxBytes = ImageCacheSettings.getInstance().imageCacheMaxBytesValue;
    fullImgSize = ImageCacheSettings.getInstance().cacheFullSizedImagesValue;
    downscalingSize = ImageCacheSettings.getInstance().cacheDownscalingSizeValue;
  }

  Future<void> saveSettings(BuildContext context) async {
    await ImageCacheSettings.getInstance().saveSettings(cacheMaxBytes, fullImgSize, downscalingSize);
    if (context.mounted) {
      MyNavigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        saveSettings(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.strings.image_quality_settings_screen_title),
        ),
        body: content(context),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.all(8)),
        hPad(Text(context.strings.image_quality_settings_screen_image_cache_max_size)),
        const Padding(padding: EdgeInsets.all(4)),
        imageCacheMaxSizeSlider(context),
        hPad(imageCacheMaxSizeCurrentValueDisplayer(context)),
      ],
    );
  }

  Widget imageCacheMaxSizeSlider(BuildContext context) {
    return Slider(
      min: CACHE_MIN_BYTES.toDouble(),
      max: CACHE_MAX_BYTES.toDouble(),
      value: cacheMaxBytes.toDouble(),
      onChanged: (value) {
        setState(() {
          cacheMaxBytes = value.toInt();
        });
      },
    );
  }

  Widget imageCacheMaxSizeCurrentValueDisplayer(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text('${cacheMibibytesValue()} MiB'),
    );
  }

  int cacheMibibytesValue() {
    return cacheMaxBytes ~/ 1024 ~/ 1024;
  }
}
