import 'package:app/logic/account/dynamic_client_features_config.dart';
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
        final banners = _visibleTextBanners(
          state.infoBanners?.banners.values ?? const <InfoBanner>[],
          location,
        );

        if (location == InfoBannerLocation.menu) {
          return BlocBuilder<ServerMaintenanceBloc, ServerMaintenanceInfo>(
            builder: (context, maintenanceInfo) {
              return _bannerList(context, banners, maintenanceInfo);
            },
          );
        }

        return _bannerList(context, banners, null);
      },
    );
  }

  Widget _bannerList(
    BuildContext context,
    List<TextInfoBanner> banners,
    ServerMaintenanceInfo? maintenanceInfo,
  ) {
    final maintenanceBody = _maintenanceBody(context, maintenanceInfo);
    if (maintenanceBody == null && banners.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (maintenanceBody != null)
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

  String? _maintenanceBody(BuildContext context, ServerMaintenanceInfo? state) {
    final startTime = state?.startTime;
    if (startTime == null) {
      return null;
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

    final title = state?.maintenanceTarget == 1
        ? context.strings.menu_screen_admin_bot_maintenance_title
        : context.strings.menu_screen_server_maintenance_title;
    return "$title\n$startTimeString$endTimeString";
  }

  List<TextInfoBanner> _visibleTextBanners(
    Iterable<InfoBanner> source,
    InfoBannerLocation location,
  ) {
    final visible = <TextInfoBanner>[];
    for (final banner in source) {
      if (!_isVisibleForCurrentPlatform(banner.platform)) {
        continue;
      }
      if (!_isVisibleInLocation(banner.visibility, location)) {
        continue;
      }
      if (banner.mode != InfoBannerMode.text) {
        continue;
      }
      final text = banner.text;
      if (text == null) {
        continue;
      }

      visible.add(text);
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

class _InfoBannerItem extends StatelessWidget {
  final TextInfoBanner banner;
  const _InfoBannerItem({required this.banner});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final icon = AttributeIcons.parseIconResource(banner.icon);
    final button = banner.urlButton;
    final urlButton = button == null
        ? null
        : _InfoBannerUrlButton(text: button.text.toLocalizedText(context), url: button.url);

    return _InfoBannerItemLayout(
      icon: icon == null
          ? null
          : AttributeIconWidget(icon: icon, color: colorScheme.onPrimaryContainer),
      body: banner.body.toLocalizedText(context),
      urlButton: urlButton,
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

  const _InfoBannerItemLayout({required this.body, this.icon, this.urlButton});

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
          ],
        ),
      ),
    );
  }
}
