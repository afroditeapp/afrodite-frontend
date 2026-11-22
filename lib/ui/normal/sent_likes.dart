import 'dart:async';

import 'package:app/data/profile_repository.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/chat/sent_likes.dart';
import 'package:app/logic/profile/view_profiles.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/profiles/view_profile.dart';
import 'package:app/ui_utils/extensions/other.dart';
import 'package:app/ui_utils/profile_thumbnail_image_or_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/data/image_cache.dart';
import 'package:database/database.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/list.dart';
import 'package:app/utils/result.dart';

class SentLikesListPage extends MyScreenPage<()> with SimpleUrlParser<SentLikesListPage> {
  final RepositoryInstances r;
  SentLikesListPage(this.r) : super(builder: (_) => SentLikesScreen(r));

  @override
  SentLikesListPage create() => SentLikesListPage(r);
}

class SentLikesScreen extends StatefulWidget {
  final RepositoryInstances r;
  const SentLikesScreen(this.r, {super.key});

  @override
  State<SentLikesScreen> createState() => _SentLikesScreenState();
}

const _IMG_SIZE = 100.0;

typedef SentLikeEntry = (AccountId accountId, ProfileEntry? profile);

class _SentLikesScreenState extends State<SentLikesScreen> {
  PagingState<int, SentLikeEntry> _pagingState = PagingState();

  SentLikesIteratorState? _iteratorState;

  StreamSubscription<ProfileChange>? _profileChangesSubscription;

  bool isDisposed = false;

  @override
  void initState() {
    super.initState();

    _profileChangesSubscription = widget.r.profile.profileChanges.listen((event) {
      switch (event) {
        case ProfileBlocked():
          removeAccountIdFromList(event.profile);
        case ReloadMainProfileView() || ProfileFavoriteStatusChange():
          {}
      }
    });
  }

  void updatePagingState(
    PagingState<int, SentLikeEntry> Function(PagingState<int, SentLikeEntry>) action,
  ) {
    if (isDisposed || !context.mounted) {
      return;
    }
    setState(() {
      _pagingState = action(_pagingState);
    });
  }

  void removeAccountIdFromList(AccountId accountId) {
    updatePagingState((s) => s.filterItems((item) => item.$1.aid != accountId.aid));
  }

  Future<void> _fetchPage() async {
    if (_pagingState.isLoading) {
      return;
    }

    await Future<void>.value();

    updatePagingState((s) => s.copyAndShowLoading());

    if (_pagingState.isInitialPage()) {
      _iteratorState = null;
    }

    final page = await _fetchProcessedPage();
    if (page == null) {
      updatePagingState((s) => s.copyAndShowError());
    } else {
      updatePagingState((s) => s.copyAndAdd(page));
    }
  }

  /// Fetches the next page of sent likes, filters away blocked profiles and
  /// downloads the profiles. Returns null on error.
  Future<List<SentLikeEntry>?> _fetchProcessedPage() async {
    while (true) {
      final page = await _fetchNextServerPage();
      if (page == null) {
        return null;
      }

      if (page.isEmpty) {
        return [];
      }

      final processed = <SentLikeEntry>[];
      for (final link in page) {
        final accountId = link.a;
        if (await widget.r.chat.isInSentBlocks(accountId)) {
          continue;
        }

        final profile = await widget.r.chat.profileEntryDownloader.download(accountId).ok();
        processed.add((accountId, profile));
      }

      if (processed.isEmpty) {
        // All entries were filtered away, so get the next page.
        continue;
      }

      return processed;
    }
  }

  /// Returns the next page of sent likes from the server, or null on error.
  Future<List<ProfileLink>?> _fetchNextServerPage() async {
    final SentLikesIteratorState state;
    final existingState = _iteratorState;
    if (existingState == null) {
      final newState = await widget.r.api
          .chat((api) => api.getInitialSentLikesIteratorState())
          .ok();
      if (newState == null) {
        return null;
      }
      _iteratorState = newState;
      state = newState;
    } else {
      state = existingState;
    }

    final page = await widget.r.api.chat((api) => api.postGetSentLikesPage(state)).ok();
    if (page == null) {
      return null;
    }

    if (page.p.isEmpty) {
      return [];
    }

    state.page += 1;
    return page.p;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.sent_likes_screen_title)),
      body: grid(context),
    );
  }

  Widget grid(BuildContext context) {
    return PagedListView(
      state: _pagingState,
      fetchNextPage: _fetchPage,
      builderDelegate: PagedChildBuilderDelegate<SentLikeEntry>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          final accountId = item.$1;
          final profileEntry = item.$2;
          final String name;
          final Widget imageWidget;
          if (profileEntry != null) {
            name = profileEntry.profileNameOrFirstCharacterProfileName();
            imageWidget = ProfileThumbnailImageOrError.fromProfileEntry(
              entry: profileEntry,
              width: _IMG_SIZE,
              height: _IMG_SIZE,
              cacheSize: ImageCacheSize.squareImageForListWithTextContent(context, _IMG_SIZE),
            );
          } else {
            name = context.strings.sent_likes_screen_profile_not_available;
            imageWidget = SizedBox(
              width: _IMG_SIZE,
              height: _IMG_SIZE,
              child: Container(color: Colors.grey),
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
            children: [
              imageWidget,
              Expanded(child: textWidget),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING),
                  child: Icon(profileEntry != null ? Icons.chevron_right_rounded : Icons.block),
                ),
              ),
            ],
          );

          return InkWell(
            onTap: () => _handleTap(context, accountId, profileEntry),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(height: _IMG_SIZE, child: rowWidget),
            ),
          );
        },
        noItemsFoundIndicatorBuilder: (context) {
          return buildListReplacementMessage(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.strings.sent_likes_screen_no_sent_likes,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        },
        firstPageErrorIndicatorBuilder: (context) {
          return buildListReplacementMessage(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.strings.sent_likes_screen_loading_failed,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Padding(padding: EdgeInsets.all(8)),
                ElevatedButton(
                  onPressed: () => updatePagingState((_) => PagingState()),
                  child: Text(context.strings.generic_try_again),
                ),
              ],
            ),
          );
        },
        newPageErrorIndicatorBuilder: (context) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(context.strings.sent_likes_screen_loading_failed),
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleTap(
    BuildContext context,
    AccountId accountId,
    ProfileEntry? profileEntry,
  ) async {
    if (profileEntry != null) {
      final initialProfileAction = await resolveProfileAction(widget.r.chat, accountId);
      if (!context.mounted) {
        return;
      }
      await openProfileView(context, profileEntry, initialProfileAction);
      return;
    }

    final accepted = await showConfirmDialog(
      context,
      context.strings.sent_likes_screen_block_profile_dialog_title,
      details: context.strings.sent_likes_screen_block_profile_dialog_description,
      yesNoActions: true,
      scrollable: true,
    );
    if (accepted == true && context.mounted) {
      context.read<SentLikesBloc>().add(BlockSentLikeProfile(accountId));
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    _profileChangesSubscription?.cancel();
    _profileChangesSubscription = null;
    super.dispose();
  }
}
