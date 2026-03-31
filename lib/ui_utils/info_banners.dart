import 'package:app/logic/account/dynamic_client_features_config.dart';
import 'package:app/logic/account/info_banners.dart';
import 'package:app/logic/server/maintenance.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/attribute/icon.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/utils/time.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:url_launcher/url_launcher_string.dart';

enum InfoBannerLocation { profiles, likes, chats, menu, conversation }

const int _MAX_BANNERS = 3;

class InfoBannersWidget extends StatelessWidget {
  final InfoBannerLocation location;
  const InfoBannersWidget({required this.location, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DynamicClientFeaturesConfigBloc, DynamicClientFeaturesConfig>(
      builder: (context, state) {
        return BlocBuilder<InfoBannersBloc, Map<String, InfoBannerDismissState>>(
          builder: (context, dismissedBanners) {
            final allBanners = state.infoBanners?.banners ?? const <String, InfoBanner>{};
            final banners = _visibleTextBanners(allBanners, dismissedBanners, location);

            if (location == InfoBannerLocation.menu) {
              return BlocBuilder<ServerMaintenanceBloc, ServerMaintenanceInfo>(
                builder: (context, maintenanceInfo) {
                  return _bannerList(context, allBanners, banners, maintenanceInfo);
                },
              );
            }

            return _bannerList(context, allBanners, banners, null);
          },
        );
      },
    );
  }

  Widget _bannerList(
    BuildContext context,
    Map<String, InfoBanner> allBanners,
    List<_VisibleTextInfoBanner> banners,
    ServerMaintenanceInfo? maintenanceInfo,
  ) {
    final maintenanceBodies = _maintenanceBodies(context, allBanners, maintenanceInfo);
    if (maintenanceBodies.isEmpty && banners.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final maintenanceBody in maintenanceBodies)
              _InfoBannerItemLayout(
                icon: Icon(Icons.info, color: Theme.of(context).colorScheme.onPrimaryContainer),
                body: maintenanceBody,
              ),
            for (var i = 0; i < banners.length; i++) ...[_InfoBannerItem(banner: banners[i])],
          ],
        ),
      ),
    );
  }

  List<String> _maintenanceBodies(
    BuildContext context,
    Map<String, InfoBanner> allBanners,
    ServerMaintenanceInfo? state,
  ) {
    final bodies = <String>[];

    final hideAdminBotOfflineBanner = allBanners.values.any(
      (b) => b.overridePredefinedBanner == PredefinedBanner.adminBotOffline,
    );
    if (state?.adminBotOffline == true && !hideAdminBotOfflineBanner) {
      bodies.add(context.strings.menu_screen_admin_offline_title);
    }

    final hideServerMaintenanceBanner = allBanners.values.any(
      (b) => b.overridePredefinedBanner == PredefinedBanner.serverMaintenance,
    );
    final startTime = state?.startTime;
    if (startTime == null || hideServerMaintenanceBanner) {
      return bodies;
    }

    final startTimeString = fullTimeString(startTime);
    final endTime = state?.endTime;
    String endTimeString;
    if (endTime == null) {
      endTimeString = "";
    } else {
      endTimeString = fullTimeString(endTime);
      final startDate = startTimeString.split(" ").firstOrNull;
      if (startDate != null && endTimeString.startsWith(startDate)) {
        endTimeString = endTimeString.replaceFirst(startDate, "").trimLeft();
      }
      endTimeString = " - $endTimeString";
    }

    final title = context.strings.menu_screen_server_maintenance_title;
    bodies.add("$title\n$startTimeString$endTimeString");
    return bodies;
  }

  List<_VisibleTextInfoBanner> _visibleTextBanners(
    Map<String, InfoBanner> source,
    Map<String, InfoBannerDismissState> dismissedBanners,
    InfoBannerLocation location,
  ) {
    final visible = <_VisibleTextInfoBanner>[];
    for (final entry in source.entries) {
      final bannerKey = entry.key;
      final banner = entry.value;
      if (!_isVisibleForCurrentPlatform(banner.platform)) {
        continue;
      }
      if (!_isVisibleInLocation(banner.visibility, location)) {
        continue;
      }
      if (banner.mode != InfoBannerMode.text) {
        continue;
      }

      final dismissedState = dismissedBanners[bannerKey];
      if (dismissedState != null &&
          dismissedState.dismissed &&
          dismissedState.bannerVersion == banner.version) {
        continue;
      }

      final text = banner.text;
      if (text == null) {
        continue;
      }

      visible.add(
        _VisibleTextInfoBanner(bannerKey: bannerKey, bannerVersion: banner.version, banner: text),
      );
      if (visible.length >= _MAX_BANNERS) {
        break;
      }
    }
    return visible;
  }

  bool _isVisibleForCurrentPlatform(BannerPlatform platform) {
    if (kIsWeb) {
      return platform.web;
    }
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => platform.android,
      TargetPlatform.iOS => platform.ios,
      TargetPlatform.fuchsia ||
      TargetPlatform.linux ||
      TargetPlatform.macOS ||
      TargetPlatform.windows => false,
    };
  }

  bool _isVisibleInLocation(BannerVisibility visibility, InfoBannerLocation location) {
    return switch (location) {
      InfoBannerLocation.profiles => visibility.profiles,
      InfoBannerLocation.likes => visibility.likes,
      InfoBannerLocation.chats => visibility.chats,
      InfoBannerLocation.menu => visibility.menu,
      InfoBannerLocation.conversation => visibility.conversation,
    };
  }
}

class _VisibleTextInfoBanner {
  final String bannerKey;
  final int bannerVersion;
  final TextInfoBanner banner;

  const _VisibleTextInfoBanner({
    required this.bannerKey,
    required this.bannerVersion,
    required this.banner,
  });
}

class _InfoBannerItem extends StatelessWidget {
  final _VisibleTextInfoBanner banner;
  const _InfoBannerItem({required this.banner});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final infoBanner = banner.banner;
    final icon = AttributeIcons.parseIconResource(infoBanner.icon);
    final button = infoBanner.urlButton;
    final urlButton = button == null
        ? null
        : _InfoBannerUrlButton(text: button.text.toLocalizedText(context), url: button.url);
    final onClose = infoBanner.dismissible
        ? () => context.read<InfoBannersBloc>().add(
            DismissInfoBanner(bannerKey: banner.bannerKey, bannerVersion: banner.bannerVersion),
          )
        : null;

    return _InfoBannerItemLayout(
      icon: icon == null
          ? null
          : AttributeIconWidget(icon: icon, color: colorScheme.onPrimaryContainer),
      body: infoBanner.body.toLocalizedText(context),
      urlButton: urlButton,
      onClose: onClose,
    );
  }
}

class _InfoBannerUrlButton {
  final String text;
  final String url;

  const _InfoBannerUrlButton({required this.text, required this.url});
}

class _InfoBannerItemLayout extends StatelessWidget {
  final Widget? icon;
  final String body;
  final _InfoBannerUrlButton? urlButton;
  final VoidCallback? onClose;

  const _InfoBannerItemLayout({required this.body, this.icon, this.urlButton, this.onClose});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final verticalPadding = EdgeInsets.symmetric(vertical: 4);

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) Padding(padding: verticalPadding, child: icon),
            if (icon != null) const Padding(padding: EdgeInsets.only(left: 8)),
            Expanded(
              child: Padding(
                padding: verticalPadding,
                child: Text(
                  body,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimaryContainer),
                ),
              ),
            ),
            if (urlButton != null) const Padding(padding: EdgeInsets.only(left: 8)),
            if (urlButton != null)
              TextButton(
                onPressed: () => launchUrlString(urlButton!.url),
                child: Text(urlButton!.text),
              ),
            if (onClose != null) const Padding(padding: EdgeInsets.only(left: 4)),
            if (onClose != null) IconButton(onPressed: onClose, icon: Icon(Icons.close)),
          ],
        ),
      ),
    );
  }
}
