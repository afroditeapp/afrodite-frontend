import 'package:app/data/image_cache.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/ui_utils/consts/colors.dart';
import 'package:app/ui_utils/consts/corners.dart';
import 'package:app/ui_utils/consts/icons.dart';
import 'package:app/ui_utils/consts/size.dart';
import 'package:app/ui_utils/profile_thumbnail_image_or_error.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

class UpdatingProfileThumbnailWithInfo extends StatefulWidget {
  final AccountDatabaseManager db;
  final ProfileThumbnail initialData;
  final GridSettings settings;
  final bool showNewLikeMarker;
  final double maxItemWidth;
  final void Function(BuildContext, ProfileThumbnail)? onTap;
  const UpdatingProfileThumbnailWithInfo({
    required this.db,
    required this.initialData,
    required this.settings,
    this.showNewLikeMarker = false,
    required this.maxItemWidth,
    required this.onTap,
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
              ProfileThumbnailStatusIndicatorsTop(
                showNewLikeMarker: widget.showNewLikeMarker,
                newLikeInfoReceivedTime: e.entry.newLikeInfoReceivedTime,
                isFavorite: e.isFavorite,
              ),
              ProfileThumbnailStatusIndicatorsBottom(profile: e.entry),
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

  const ProfileThumbnailStatusIndicatorsBottom({required this.profile, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: PROFILE_CURRENTLY_ONLINE_SIZE + 16,
        child: Row(
          children: [
            if (profile.lastSeenTimeValue == -1)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: PROFILE_CURRENTLY_ONLINE_SIZE,
                  height: PROFILE_CURRENTLY_ONLINE_SIZE,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(PROFILE_CURRENTLY_ONLINE_RADIUS),
                  ),
                ),
              ),
            const Spacer(),
            if (profile.unlimitedLikes)
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
