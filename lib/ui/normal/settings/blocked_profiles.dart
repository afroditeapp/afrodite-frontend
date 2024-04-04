import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/database/profile_database.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:pihka_frontend/ui_utils/dialog.dart';
import 'package:pihka_frontend/ui_utils/image.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';

var log = Logger("BlockedProfilesPage");

class BlockedProfilesPage extends StatefulWidget {
  const BlockedProfilesPage({Key? key}) : super(key: key);

  @override
  _BlockedProfilesPage createState() => _BlockedProfilesPage();
}

typedef BlockedProfileEntry = (AccountId account, ProfileEntry? profile, XFile? img);

class _BlockedProfilesPage extends State<BlockedProfilesPage> {
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
        newList.add((dataRow.$1, null, null));
        continue;
      }
      final file = await ImageCacheData.getInstance().getImage(profile.uuid, profile.imageUuid);
      if (file == null) {
        log.warning("Skipping one profile because image loading failed");
        newList.add((dataRow.$1, null, null));
        continue;
      }
      newList.add((dataRow.$1, profile, file));
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
      appBar: AppBar(title: Text("Blocked profiles")),
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
          final image = item.$3;
          final String name;
          final Widget imageWidget;
          if (profileEntry != null && image != null) {
            name = profileEntry.name;
            imageWidget = xfileImgWidget(
              image,
              width: 100,
            );
          } else {
            name = "Private profile $index";
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
              // Expanded(
              //   child: Align(
              //     alignment: Alignment.centerRight,
              //     child: Padding(
              //       padding: const EdgeInsets.all(16.0),
              //       child: Icon(
              //         Icons.undo_rounded,
              //       ),
              //     ),
              //   )
              // )
            ],
          );

          return InkWell(
            onTap: () {
              showConfirmDialog(context, "Unblock profile?", details: "Unblock $name").then((value) async {
                if (value == true) {
                  if (await ChatRepository.getInstance().removeBlockFrom(item.$1)) {
                    showSnackBar("Unblock successfull");
                  }
                }
              });
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
