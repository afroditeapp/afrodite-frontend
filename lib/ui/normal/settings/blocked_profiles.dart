import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:database/database.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/settings/blocked_profiles.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';
import 'package:pihka_frontend/ui_utils/image.dart';
import 'package:pihka_frontend/ui_utils/list.dart';

var log = Logger("BlockedProfilesScreen");

class BlockedProfilesScreen extends StatefulWidget {
  const BlockedProfilesScreen({Key? key}) : super(key: key);

  @override
  State<BlockedProfilesScreen> createState() => _BlockedProfilesScreen();
}

typedef BlockedProfileEntry = (AccountId account, ProfileEntry? profile);

class _BlockedProfilesScreen extends State<BlockedProfilesScreen> {
  StreamSubscription<ProfileChange>? _profileChangesSubscription;
  PagingController<int, BlockedProfileEntry>? _pagingController =
    PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController?.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = ProfileRepository.getInstance().profileChanges.listen((event) {
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
        MatchesChanged() ||
        ReloadMainProfileView() ||
        LikesChanged(): {}
    }
  }

  void removeAccountIdFromList(AccountId accountId) {
    final controller = _pagingController;
    if (controller != null) {
      setState(() {
        controller.itemList?.removeWhere((item) => item.$1.accountId == accountId.accountId);
      });
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    if (pageKey == 0) {
      ChatRepository.getInstance().sentBlocksIteratorReset();
    }

    final profileList = await ChatRepository.getInstance().sentBlocksIteratorNext();

    final newList = List<BlockedProfileEntry>.empty(growable: true);
    for (final dataRow in profileList) {
      final profile = dataRow.$2;
      if (profile == null) {
        newList.add((dataRow.$1, null));
        continue;
      }
      final file = await ImageCacheData.getInstance().getImage(profile.uuid, profile.imageUuid);
      if (file == null) {
        log.warning("Skipping one profile because image loading failed");
        newList.add((dataRow.$1, null));
        continue;
      }
      newList.add((dataRow.$1, profile));
    }

    if (profileList.isEmpty) {
      _pagingController?.appendLastPage([]);
    } else {
      _pagingController?.appendPage(newList, pageKey + 1);
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
    return RefreshIndicator(
      onRefresh: () async {
        await ProfileRepository.getInstance().refreshProfileIterator();
        // This might be disposed after resetProfileIterator completes.
        _pagingController?.refresh();
      },
      child: grid(context),
    );
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
            name = profileEntry.profileTitle();
            imageWidget = accountImgWidget(
              profileEntry.uuid,
              profileEntry.imageUuid,
              width: 100,
            );
          } else {
            name = context.strings.blocked_profiles_screen_placeholder_for_private_profile;
            imageWidget = SizedBox(
              width: 100,
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
            ),
          );
          final Widget rowWidget = Row(
            children: [
              imageWidget,
              textWidget,
              const Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING),
                    child: Icon(
                      Icons.undo_rounded,
                    ),
                  ),
                )
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
                height: 125,
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
