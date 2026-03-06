import 'package:app/logic/account/dynamic_client_features_config.dart';
import 'package:app/ui_utils/attribute/icon.dart';
import 'package:app/ui_utils/extensions/api.dart';
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
        if (banners.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < banners.length; i++) ...[_InfoBannerItem(banner: banners[i])],
              ],
            ),
          ),
        );
      },
    );
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
    final urlButton = banner.urlButton;
    final verticalPadding = EdgeInsets.symmetric(vertical: 4);

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: verticalPadding,
                child: AttributeIconWidget(icon: icon, color: colorScheme.onPrimaryContainer),
              ),
            if (icon != null) const Padding(padding: EdgeInsets.only(left: 8)),
            Expanded(
              child: Padding(
                padding: verticalPadding,
                child: Text(
                  banner.body.toLocalizedText(context),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimaryContainer),
                ),
              ),
            ),
            if (urlButton != null) const Padding(padding: EdgeInsets.only(left: 8)),
            if (urlButton != null)
              TextButton(
                onPressed: () => launchUrlString(urlButton.url),
                child: Text(urlButton.text.toLocalizedText(context)),
              ),
          ],
        ),
      ),
    );
  }
}
