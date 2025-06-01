import 'dart:async';

import 'package:app/data/general/iterator/base_iterator_manager.dart';
import 'package:app/logic/profile/view_profiles.dart';
import 'package:app/logic/settings/ui_settings.dart';
import 'package:app/model/freezed/logic/profile/view_profiles.dart';
import 'package:app/model/freezed/logic/settings/ui_settings.dart';
import 'package:app/ui_utils/extensions/other.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/data/profile_repository.dart';
import 'package:database/database.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/profile/my_profile.dart';
import 'package:app/ui/normal/profiles/profile_grid.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/list.dart';
import 'package:app/utils/result.dart';

typedef ProfileGridProfileEntry = ({ProfileEntry profile, ProfileActionState? initialProfileAction});

class GenericProfileGrid extends StatefulWidget {
  final BaseIteratorManager Function() buildIteratorManager;
  final String noProfilesText;
  const GenericProfileGrid({
    required this.buildIteratorManager,
    required this.noProfilesText,
    super.key,
  });

  @override
  State<GenericProfileGrid> createState() => _GenericProfileGridState();
}

class _GenericProfileGridState extends State<GenericProfileGrid> {
  final ScrollController _scrollController = ScrollController();
  PagingController<int, ProfileGridProfileEntry>? _pagingController =
    PagingController(firstPageKey: 0);
  StreamSubscription<ProfileChange>? _profileChangesSubscription;

  final ChatRepository chat = LoginRepository.getInstance().repositories.chat;
  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;

  final AccountDatabaseManager accountDb = LoginRepository.getInstance().repositories.accountDb;

  late final BaseIteratorManager _mainProfilesViewIterator;
  bool _reloadInProgress = false;

  @override
  void initState() {
    super.initState();

    _mainProfilesViewIterator = widget.buildIteratorManager();
    _mainProfilesViewIterator.reset(true);

    _pagingController?.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = profile.profileChanges.listen((event) {
      _handleProfileChange(event);
    });
  }

  void _handleProfileChange(ProfileChange event) {
    switch (event) {
      case ProfileBlocked():
        _removeAccountIdFromList(event.profile);
      case ProfileNowPrivate() ||
        ProfileUnblocked() ||
        ConversationChanged() ||
        ReloadMainProfileView() ||
        ProfileFavoriteStatusChange(): {}
    }
  }

  void _removeAccountIdFromList(AccountId accountId) {
    final controller = _pagingController;
    if (controller != null) {
      setState(() {
        controller.itemList?.removeWhere((item) => item.profile.uuid == accountId);
      });
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    if (pageKey == 0) {
      _mainProfilesViewIterator.resetToBeginning();
    }

    final profileList = await _mainProfilesViewIterator.nextList().ok();
    if (profileList == null) {
      // Show error UI
      _pagingController?.error = true;
      return;
    }

    final newList = List<ProfileGridProfileEntry>.empty(growable: true);
    for (final profile in profileList) {
      final initialProfileAction = await resolveProfileAction(chat, profile.uuid);
      newList.add((profile: profile, initialProfileAction: initialProfileAction));
    }

    if (profileList.isEmpty) {
      _pagingController?.appendLastPage([]);
    } else {
      _pagingController?.appendPage(newList, pageKey + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return content();
  }

  Widget content() {
    return RefreshIndicator(
      onRefresh: () async {
        if (!_reloadInProgress) {
          await refreshProfileGrid();
        }
      },
      child: Column(children: [
        Expanded(
          child: BlocBuilder<UiSettingsBloc, UiSettingsData>(
            buildWhen: (previous, current) => previous.gridSettings != current.gridSettings,
            builder: (context, uiSettings) {
              return BlocBuilder<MyProfileBloc, MyProfileData>(
                builder: (context, myProfileState) {
                  return grid(context, myProfileState.profile?.unlimitedLikes ?? false, uiSettings.gridSettings);
                },
              );
            }
          ),
        ),
      ],),
    );
  }

  Widget grid(BuildContext context, bool iHaveUnlimitedLikesEnabled, GridSettings settings) {
    return PagedGridView(
      physics: const AlwaysScrollableScrollPhysics(),
      scrollController: _scrollController,
      pagingController: _pagingController!,
      padding: const EdgeInsets.symmetric(horizontal: COMMON_SCREEN_EDGE_PADDING),
      builderDelegate: PagedChildBuilderDelegate<ProfileGridProfileEntry>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          return GestureDetector(
              child: profileEntryWidgetStream(
                item.profile,
                iHaveUnlimitedLikesEnabled,
                item.initialProfileAction,
                accountDb,
                settings,
            )
          );
        },
        noItemsFoundIndicatorBuilder: (context) {
          return buildListReplacementMessage(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.noProfilesText,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        },
        firstPageErrorIndicatorBuilder: (context) {
          return errorDetectedWidgetWithRetryButton(context);
        },
        newPageErrorIndicatorBuilder: (context) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(context.strings.generic_profile_loading_failed),
            ),
          );
        },
      ),
      gridDelegate: settings.toSliverGridDelegate(),
    );
  }

  Widget errorDetectedWidgetWithRetryButton(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Text(context.strings.generic_profile_loading_failed),
          const Padding(padding: EdgeInsets.all(8)),
          ElevatedButton(
            onPressed: () {
              if (!_reloadInProgress) {
                refreshProfileGrid();
              }
            },
            child: Text(context.strings.generic_try_again),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }

  Future<void> refreshProfileGrid() async {
    _reloadInProgress = true;
    await _mainProfilesViewIterator.loadingInProgress.firstWhere((e) => e == false);
    _mainProfilesViewIterator.refresh();
    // This might be disposed after resetProfileIterator completes.
    _pagingController?.refresh();
    _reloadInProgress = false;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pagingController?.dispose();
    _pagingController = null;
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = null;
    super.dispose();
  }
}
