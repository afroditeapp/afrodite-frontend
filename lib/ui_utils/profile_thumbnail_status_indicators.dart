import 'package:app/data/image_cache.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/logic/settings/privacy_settings.dart';
import 'package:app/model/freezed/logic/settings/privacy_settings.dart';
import 'package:app/ui_utils/consts/colors.dart';
import 'package:app/ui_utils/consts/corners.dart';
import 'package:app/ui_utils/consts/icons.dart';
import 'package:app/ui_utils/consts/size.dart';
import 'package:app/ui_utils/profile_thumbnail_image_or_error.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

class UpdatingProfileThumbnailWithInfo extends StatefulWidget {
  final AccountDatabaseManager db;
  final ProfileThumbnail initialData;
  final GridSettings settings;
  final bool showNewLikeMarker;
  final double maxItemWidth;
  final void Function(BuildContext, ProfileThumbnail)? onTap;

  /// Show only profile thumbnail with smaller online indicator
  final bool appBarMode;

  const UpdatingProfileThumbnailWithInfo({
    required this.db,
    required this.initialData,
    this.settings = const GridSettings(),
    this.showNewLikeMarker = false,
    required this.maxItemWidth,
    this.onTap,
    this.appBarMode = false,
    super.key,
  });

  @override
  State<UpdatingProfileThumbnailWithInfo> createState() => _UpdatingProfileThumbnailWithInfoState();
}

class _UpdatingProfileThumbnailWithInfoState extends State<UpdatingProfileThumbnailWithInfo> {
  late final Stream<ProfileThumbnail> stream;

  @override
  void initState() {
    super.initState();
    stream = widget.db
        .accountStream((db) => db.profile.watchProfileThumbnail(widget.initialData.entry.accountId))
        .whereNotNull();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, data) {
        final onTap = widget.onTap;
        final e = data.data ?? widget.initialData;
        return ProfileThumbnailImageOrError.fromProfileEntry(
          entry: e.entry,
          borderRadius: BorderRadius.circular(widget.settings.valueProfileThumbnailBorderRadius()),
          cacheSize: ImageCacheSize.squareImageForGrid(context, widget.maxItemWidth),
          child: Stack(
            children: [
              if (!widget.appBarMode)
                ProfileThumbnailStatusIndicatorsTop(
                  showNewLikeMarker: widget.showNewLikeMarker,
                  newLikeInfoReceivedTime: e.entry.newLikeInfoReceivedTime,
                  isFavorite: e.isFavorite,
                ),
              ProfileThumbnailStatusIndicatorsBottom(
                profile: e.entry,
                appBarMode: widget.appBarMode,
              ),
              if (onTap != null)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      onTap(context, e);
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class ProfileThumbnailStatusIndicatorsBottom extends StatelessWidget {
  final ProfileEntry profile;
  final bool appBarMode;

  const ProfileThumbnailStatusIndicatorsBottom({
    required this.profile,
    this.appBarMode = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final onlineIndicatorSize = appBarMode
        ? PROFILE_CURRENTLY_ONLINE_SIZE / 2
        : PROFILE_CURRENTLY_ONLINE_SIZE;
    final onlineIndicatorRadius = appBarMode
        ? PROFILE_CURRENTLY_ONLINE_RADIUS / 2
        : PROFILE_CURRENTLY_ONLINE_RADIUS;
    final containerHeight = appBarMode ? onlineIndicatorSize + 8 : onlineIndicatorSize + 16;
    final padding = appBarMode ? 4.0 : 8.0;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: containerHeight,
        child: Row(
          children: [
            if (profile.lastSeenTimeValue == -1)
              BlocBuilder<PrivacySettingsBloc, PrivacySettingsData>(
                builder: (context, privacyState) {
                  if (privacyState.onlineStatus) {
                    return Padding(
                      padding: EdgeInsets.only(left: padding),
                      child: Container(
                        width: onlineIndicatorSize,
                        height: onlineIndicatorSize,
                        decoration: BoxDecoration(
                          color: PROFILE_CURRENTLY_ONLINE_COLOR,
                          borderRadius: BorderRadius.circular(onlineIndicatorRadius),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            if (!appBarMode && profile.unlimitedLikes) const Spacer(),
            if (!appBarMode && profile.unlimitedLikes)
              Padding(
                padding: const EdgeInsets.only(right: 7.0),
                child: Icon(UNLIMITED_LIKES_ICON, color: getUnlimitedLikesColor(context)),
              ),
          ],
        ),
      ),
    );
  }
}

class ProfileThumbnailStatusIndicatorsTop extends StatelessWidget {
  final bool showNewLikeMarker;
  final UtcDateTime? newLikeInfoReceivedTime;
  final bool isFavorite;

  const ProfileThumbnailStatusIndicatorsTop({
    required this.showNewLikeMarker,
    required this.newLikeInfoReceivedTime,
    required this.isFavorite,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentTime = UtcDateTime.now();
    final receivedTime = newLikeInfoReceivedTime;
    final showNewLikeIcon =
        showNewLikeMarker &&
        receivedTime != null &&
        currentTime.difference(receivedTime).inHours < 24;

    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showNewLikeIcon)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.auto_awesome, color: Colors.amber),
            ),
          if (isFavorite)
            Padding(
              padding: showNewLikeIcon ? const EdgeInsets.all(0) : const EdgeInsets.all(4.0),
              child: const Icon(Icons.star_rounded, color: Colors.orange),
            ),
        ],
      ),
    );
  }
}
