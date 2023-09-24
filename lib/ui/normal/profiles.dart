import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:pihka_frontend/ui/utils.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pihka_frontend/ui/utils/image_page.dart';

class ProfileView extends BottomNavigationView {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();

  @override
  String title(BuildContext context) {
    return AppLocalizations.of(context).pageProfileGridTitle;
  }
}

class _ProfileViewState extends State<ProfileView> {
  PagingController<int, ProfileListEntry>? _pagingController =
    PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController?.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    if (pageKey == 0) {
      await ProfileRepository.getInstance().resetProfileIterator(false);
    }

    final profileList = await ProfileRepository.getInstance().nextList();
    if (profileList.isEmpty) {
      _pagingController?.appendLastPage([]);
    } else {
      _pagingController?.appendPage(profileList, pageKey + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await ProfileRepository.getInstance().resetProfileIterator(true);
        // This might be disposed after resetProfileIterator completes.
        _pagingController?.refresh();
      },
      child: PagedGridView(
        pagingController: _pagingController!,
        builderDelegate: PagedChildBuilderDelegate<ProfileListEntry>(
          animateTransitions: true,
          itemBuilder: (context, item, index) {
            final accountId = AccountId(accountId: item.uuid);
            final contentId = ContentId(contentId: item.imageUuid);
            return FutureBuilder(
              future: ImageCacheData.getInstance()
                .getImage(accountId, contentId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute<void>(builder: (_) => ViewProfilePage(accountId, data, index)));
                    },
                    child: Hero(
                      tag: (accountId, index),
                      child: Image.file(data)
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          },
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController?.dispose();
    _pagingController = null;
    super.dispose();
  }
}
