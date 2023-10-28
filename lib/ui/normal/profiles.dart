import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/profile/profile_iterator_manager.dart';
import 'package:pihka_frontend/data/profile/profile_list/online_iterator.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/database/profile_database.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
import 'package:pihka_frontend/logic/profile/profile_filtering_settings/profile_filtering_settings.dart';
import 'package:pihka_frontend/logic/profile/view_profiles/view_profiles.dart';
import 'package:pihka_frontend/ui/normal/profiles/filter_profiles.dart';
import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:pihka_frontend/ui/utils.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pihka_frontend/ui/utils/image_page.dart';
import 'package:pihka_frontend/ui/utils/view_profile.dart';

var log = Logger("ProfileView");

class ProfileView extends BottomNavigationView {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();

  @override
  String title(BuildContext context) {
    return AppLocalizations.of(context).pageProfileGridTitle;
  }

  @override
  List<Widget>? actions(BuildContext context) {
    return [
      IconButton(
        icon: BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
          builder: (context, state) {
            if (state == ProfileFilteringSettingsData()) {
              return const Icon(Icons.filter_alt_outlined);
            } else {
              return const Icon(Icons.filter_alt_rounded);
            }
          },
        ),
        onPressed: () {
          final stateBeforeChanges = context.read<ProfileFilteringSettingsBloc>().state;

          Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const ProfileFilteringSettingsPage()))
            .then((value) {
              final stateAfterChanges = context.read<ProfileFilteringSettingsBloc>().state;
              if (stateBeforeChanges != stateAfterChanges) {
                simpleRefresh();
              }
            });
        },
      ),
    ];
  }
}

// TODO: Change to bloc or something?
var simpleRefresh = () {};

typedef ProfileViewEntry = (ProfileEntry profile, File img);

class _ProfileViewState extends State<ProfileView> {
  PagingController<int, ProfileViewEntry>? _pagingController =
    PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController?.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    simpleRefresh = () {
      setState(() {
        _pagingController?.refresh();
      });
    };
  }

  Future<void> _fetchPage(int pageKey) async {
    if (pageKey == 0) {
      ProfileRepository.getInstance().resetIteratorToBeginning();
    }

    final profileList = await ProfileRepository.getInstance().nextList();

    // Get images here instead of FutureBuilder because there was some weird
    // Hero tag error even if the builder index is in the tag.
    // Not sure does this image loading change affect the issue.
    // The PagedChildBuilderDelegate seems to run the builder twice for some
    // reason for the initial page.
    final newList = List<ProfileViewEntry>.empty(growable: true);
    for (final profile in profileList) {
      final accountId = AccountId(accountId: profile.uuid);
      final contentId = ContentId(contentId: profile.imageUuid);
      final file = await ImageCacheData.getInstance().getImage(accountId, contentId);
      if (file == null) {
        log.warning("Skipping one profile because image loading failed");
        continue;
      }
      newList.add((profile, file));
    }

    if (profileList.isEmpty) {
      _pagingController?.appendLastPage([]);
    } else {
      _pagingController?.appendPage(newList, pageKey + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await ProfileRepository.getInstance().refreshProfileIterator();
        // This might be disposed after resetProfileIterator completes.
        _pagingController?.refresh();
      },
      child: PagedGridView(
        pagingController: _pagingController!,
        builderDelegate: PagedChildBuilderDelegate<ProfileViewEntry>(
          animateTransitions: true,
          itemBuilder: (context, item, index) {
            final accountId = AccountId(accountId: item.$1.uuid);
            final profile = Profile(
              name: item.$1.name,
              profileText: item.$1.profileText,
              version: ProfileVersion(versionUuid: ""),
            );
            return GestureDetector(
              onTap: () {
                context.read<ViewProfileBloc>().add(SetProfileView(accountId, profile, item.$2, (accountId, index)));
                Navigator.push(context, MaterialPageRoute<RemoveProfileFromList?>(builder: (_) => const ViewProfilePage()))
                  .then((value) {
                    if (value is RemoveProfileFromList) {
                      final controller = _pagingController;
                      if (controller != null) {
                        setState(() {
                          controller.itemList?.removeAt(index);
                        });
                      }
                    }
                  });
              },
              child: Hero(
                tag: (accountId, index),
                child: Image.file(item.$2)
              ),
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
    simpleRefresh = () {};
    super.dispose();
  }
}
