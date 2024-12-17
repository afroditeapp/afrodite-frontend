import 'dart:async';

import 'package:app/logic/profile/view_profiles.dart';
import 'package:app/model/freezed/logic/profile/view_profiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/data/chat/matches_iterator_manager.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/data/profile_repository.dart';
import 'package:database/database.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/profile/my_profile.dart';
import 'package:app/ui/normal/profiles/profile_grid.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:app/localizations.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/list.dart';
import 'package:app/utils/result.dart';

final log = Logger("SelectMatchScreen");

Future<ProfileEntry?> openSelectMatchView(
  BuildContext context,
) {
  final pageKey = PageKey();
  return MyNavigator.pushWithKey(
    context,
    MaterialPage<ProfileEntry>(child: SelectMatchScreen(pageKey: pageKey)),
    pageKey,
  );
}

class SelectMatchScreen extends StatefulWidget {
  final PageKey pageKey;
  const SelectMatchScreen({
    required this.pageKey,
    Key? key,
  }) : super(key: key);

  @override
  State<SelectMatchScreen> createState() => SelectMatchScreenState();
}

typedef MatchViewEntry = ({ProfileEntry profile, ProfileActionState? initialProfileAction});

class SelectMatchScreenState extends State<SelectMatchScreen> {
  final ScrollController _scrollController = ScrollController();
  PagingController<int, MatchViewEntry>? _pagingController =
    PagingController(firstPageKey: 0);
  StreamSubscription<ProfileChange>? _profileChangesSubscription;

  final ChatRepository chat = LoginRepository.getInstance().repositories.chat;
  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;

  final AccountDatabaseManager accountDb = LoginRepository.getInstance().repositories.accountDb;

  final MatchesIteratorManager _mainProfilesViewIterator = MatchesIteratorManager(
    LoginRepository.getInstance().repositories.chat,
    LoginRepository.getInstance().repositories.media,
    LoginRepository.getInstance().repositories.accountBackgroundDb,
    LoginRepository.getInstance().repositories.accountDb,
    LoginRepository.getInstance().repositories.connectionManager,
    LoginRepository.getInstance().repositories.chat.currentUser,
  );
  bool _reloadInProgress = false;

  @override
  void initState() {
    super.initState();
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
        ReceivedLikeRemoved() ||
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

    final newList = List<MatchViewEntry>.empty(growable: true);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.select_match_screen_title),
      ),
      body: content(),
    );
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
          child: BlocBuilder<MyProfileBloc, MyProfileData>(
            builder: (context, myProfileState) {
              return grid(context, myProfileState.profile?.unlimitedLikes ?? false);
            },
          ),
        ),
      ],),
    );
  }

  Widget grid(BuildContext context, bool iHaveUnlimitedLikesEnabled) {
    return PagedGridView(
      physics: const AlwaysScrollableScrollPhysics(),
      scrollController: _scrollController,
      pagingController: _pagingController!,
      padding: const EdgeInsets.symmetric(horizontal: COMMON_SCREEN_EDGE_PADDING),
      builderDelegate: PagedChildBuilderDelegate<MatchViewEntry>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          return GestureDetector(
              child: profileEntryWidgetStream(
                item.profile,
                iHaveUnlimitedLikesEnabled,
                item.initialProfileAction,
                accountDb,
                overrideOnTap: (context) {
                  MyNavigator.removePage(context, widget.pageKey, item.profile);
                },
            )
          );
        },
        noItemsFoundIndicatorBuilder: (context) {
          return buildListReplacementMessage(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.strings.chat_list_screen_no_matches_found,
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
              child: Text(context.strings.chat_list_screen_match_loading_failed),
            ),
          );
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
    );
  }

  Widget errorDetectedWidgetWithRetryButton(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Text(context.strings.chat_list_screen_match_loading_failed),
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
