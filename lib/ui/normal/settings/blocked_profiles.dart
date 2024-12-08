import 'dart:async';

import 'package:app/ui_utils/profile_thumbnail_image_or_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/data/profile_repository.dart';
import 'package:database/database.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/settings/blocked_profiles.dart';
import 'package:app/logic/settings/user_interface.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/list.dart';

var log = Logger("BlockedProfilesScreen");

class BlockedProfilesScreen extends StatefulWidget {
  const BlockedProfilesScreen({Key? key}) : super(key: key);

  @override
  State<BlockedProfilesScreen> createState() => _BlockedProfilesScreen();
}

typedef BlockedProfileEntry = (AccountId account, ProfileEntry? profile);

const _IMG_SIZE = 100.0;

class _BlockedProfilesScreen extends State<BlockedProfilesScreen> {
  StreamSubscription<ProfileChange>? _profileChangesSubscription;
  PagingController<int, BlockedProfileEntry>? _pagingController =
    PagingController(firstPageKey: 0);

  final chat = LoginRepository.getInstance().repositories.chat;
  final profile = LoginRepository.getInstance().repositories.profile;

  @override
  void initState() {
    super.initState();
    _pagingController?.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = profile.profileChanges.listen((event) {
        handleProfileChange(event);
    });
  }

    void handleProfileChange(ProfileChange event) {
    switch (event) {
      case ProfileUnblocked():
        removeAccountIdFromList(event.profile);
      case ProfileNowPrivate() ||
        ProfileBlocked() ||
        ProfileFavoriteStatusChange() ||
        ConversationChanged() ||
        ReloadMainProfileView() ||
        ReceivedLikeRemoved(): {}
    }
  }

  void removeAccountIdFromList(AccountId accountId) {
    final controller = _pagingController;
    if (controller != null) {
      setState(() {
        controller.itemList?.removeWhere((item) => item.$1.aid == accountId.aid);
      });
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    if (pageKey == 0) {
      chat.sentBlocksIteratorReset();
    }

    final profileList = await chat.sentBlocksIteratorNext();

    if (profileList.isEmpty) {
      _pagingController?.appendLastPage([]);
    } else {
      _pagingController?.appendPage(profileList, pageKey + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.blocked_profiles_screen_title)),
      body: page(context),
    );
  }

  Widget page(BuildContext context) {
    return grid(context);
  }

  Widget grid(BuildContext context) {
    return PagedListView(
      pagingController: _pagingController!,
      builderDelegate: PagedChildBuilderDelegate<BlockedProfileEntry>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          final profileEntry = item.$2;
          final String name;
          final Widget imageWidget;
          if (profileEntry != null) {
            name = profileEntry.profileTitle(
              context.read<UserInterfaceSettingsBloc>().state.showNonAcceptedProfileNames,
            );
            imageWidget = ProfileThumbnailImageOrError.fromProfileEntry(
              entry: profileEntry,
              width: _IMG_SIZE,
              height: _IMG_SIZE,
              cacheSize: ImageCacheSize.sizeForListWithTextContent(),
            );
          } else {
            name = context.strings.blocked_profiles_screen_placeholder_for_private_profile;
            imageWidget = SizedBox(
              width: _IMG_SIZE,
              height: _IMG_SIZE,
              child: Container(
                color: Colors.grey,
              ),
            );
          }

          final textWidget = Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
          );
          final Widget rowWidget = Row(
            // Workaround for issue where unblocking profile does not update
            // list item contents. That happens at least when all the blocked
            // are bots.
            key: GlobalKey(),
            children: [
              imageWidget,
              Expanded(child: textWidget),
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING),
                  child: Icon(
                    Icons.undo_rounded,
                  ),
                ),
              )
            ],
          );

          return InkWell(
            onTap: () async {
              final bloc = context.read<BlockedProfilesBloc>();
              final accepted = await showConfirmDialog(
                context,
                context.strings.blocked_profiles_screen_unblock_profile_dialog_title,
                details: context.strings.blocked_profiles_screen_unblock_profile_dialog_description(name),
              );
              if (accepted == true) {
                bloc.add(UnblockProfile(item.$1));
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: _IMG_SIZE,
                child: rowWidget,
              ),
            ),
          );
        },
        noItemsFoundIndicatorBuilder: (context) {
          return buildListReplacementMessage(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.strings.blocked_profiles_screen_no_blocked_profiles,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        },
      ),

      // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,
      //   crossAxisSpacing: 4,
      //   mainAxisSpacing: 4,
      // ),
    );
  }

  @override
  void dispose() {
    _pagingController?.dispose();
    _pagingController = null;
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = null;
    super.dispose();
  }
}
