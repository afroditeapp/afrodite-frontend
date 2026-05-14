import 'dart:io';

import 'package:app/config.dart';
import 'package:app/localizations.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

bool isDirectUpdateActionSupportedForCurrentPlatform() {
  if (kIsWeb) {
    return false;
  }

  if (Platform.isAndroid) {
    return APP_AVAILABLE_FROM_GOOGLE_PLAY_STORE;
  }

  if (Platform.isIOS) {
    final appStoreId = APPLE_APP_STORE_APP_ID;
    return appStoreId != null && appStoreId > 0;
  }

  return false;
}

String updateAvailableDialogTextForCurrentPlatform(BuildContext context) {
  if (kIsWeb) {
    return context.strings.app_update_available_dialog_description_web_restart;
  }

  if (isDirectUpdateActionSupportedForCurrentPlatform()) {
    return context.strings.app_update_available_dialog_description_update_now;
  }

  return context.strings.app_update_available_dialog_description_manual_update;
}

Future<bool> openStorePageForCurrentApp() async {
  if (kIsWeb) {
    return false;
  }

  if (Platform.isAndroid) {
    if (!APP_AVAILABLE_FROM_GOOGLE_PLAY_STORE) {
      return false;
    }

    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName.trim();
    if (packageName.isEmpty) {
      return false;
    }

    final intent = AndroidIntent(
      action: 'action_view',
      data: 'https://play.google.com/store/apps/details?id=$packageName',
      package: 'com.android.vending',
    );

    try {
      await intent.launch();
      return true;
    } catch (_) {
      return false;
    }
  }

  if (Platform.isIOS) {
    final appStoreId = APPLE_APP_STORE_APP_ID;
    if (appStoreId == null || appStoreId <= 0) {
      return false;
    }

    final url = Uri.parse('https://apps.apple.com/app/id$appStoreId');
    return launchUrl(url, mode: LaunchMode.externalApplication);
  }

  return false;
}
