import 'dart:async';

import 'package:app/data/general/notification/state/news_item_available.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/ui_utils/extensions/other.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/account/news/news_count.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/localizations.dart';
import 'package:app/ui/normal/settings/news/view_news.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/list.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/time.dart';

final log = Logger("NewsListScreen");

Future<void> openNewsList(BuildContext context) {
  return MyNavigator.push(context, const MaterialPage<void>(child: NewsListScreenOpener()));
}

class NewsListScreenOpener extends StatefulWidget {
  const NewsListScreenOpener({super.key});

  @override
  State<NewsListScreenOpener> createState() => _NewsListScreenOpenerState();
}

class _NewsListScreenOpenerState extends State<NewsListScreenOpener> {
  String? initialLocale;

  @override
  Widget build(BuildContext context) {
    initialLocale ??= Localizations.localeOf(context).languageCode;
    final bloc = context.read<NewsCountBloc>();
    return NewsListScreen(locale: initialLocale!, bloc: bloc);
  }
}

class NewsListScreen extends StatefulWidget {
  final String locale;
  final NewsCountBloc bloc;
  const NewsListScreen({required this.locale, required this.bloc, super.key});

  @override
  State<NewsListScreen> createState() => NewsListScreenState();
}

typedef NewsViewEntry = ({NewsItemSimple newsItem});

class NewsListScreenState extends State<NewsListScreen> {
  final ScrollController _scrollController = ScrollController();
  PagingState<int, NewsViewEntry> _pagingState = PagingState();

  final AccountBackgroundDatabaseManager accountBackgroundDb =
      LoginRepository.getInstance().repositories.accountBackgroundDb;
  final ApiManager api = LoginRepository.getInstance().repositories.api;

  NewsIteratorSessionId? _sessionId;

  bool isDisposed = false;

  @override
  void initState() {
    super.initState();
    NotificationNewsItemAvailable.getInstance().hide(accountBackgroundDb);
  }

  void updatePagingState(
    PagingState<int, NewsViewEntry> Function(PagingState<int, NewsViewEntry>) action,
  ) {
    if (isDisposed || !context.mounted) {
      return;
    }
    setState(() {
      _pagingState = action(_pagingState);
    });
  }

  void showLoadingError() {
    updatePagingState((s) => s.copyAndShowError());
  }

  void _fetchPage() async {
    if (_pagingState.isLoading) {
      return;
    }

    await Future<void>.value();

    updatePagingState((s) => s.copyAndShowLoading());

    if (_pagingState.isInitialPage()) {
      final r = await api.account((api) => api.postResetNewsPaging()).ok();
      if (r == null) {
        showLoadingError();
        return;
      }
      _sessionId = r.s;
      final dbResult = await accountBackgroundDb.accountAction(
        (db) => db.news.setUnreadNewsCount(version: r.v, unreadNewsCount: r.c),
      );
      if (dbResult.isErr()) {
        showLoadingError();
        return;
      }
    }

    final sessionId = _sessionId;
    if (sessionId == null) {
      showLoadingError();
      return;
    }

    final news = await api.account((api) => api.postGetNextNewsPage(widget.locale, sessionId)).ok();
    if (news == null || news.errorInvalidIteratorSessionId) {
      showLoadingError();
      return;
    }

    final newList = List<NewsViewEntry>.empty(growable: true);
    for (final newsItem in news.news) {
      newList.add((newsItem: newsItem));
    }

    updatePagingState((s) => s.copyAndAdd(newList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.news_list_screen_title),
        actions: [
          BlocBuilder<AccountBloc, AccountBlocData>(
            builder: (context, state) {
              if (state.permissions.adminNewsCreate) {
                return IconButton(
                  onPressed: () async {
                    final r = await showConfirmDialog(
                      context,
                      context.strings.news_list_screen_create_new,
                      yesNoActions: true,
                    );
                    if (r == true) {
                      final id = await api.accountAdmin((api) => api.postCreateNewsItem()).ok();
                      if (id == null) {
                        showSnackBar(R.strings.generic_error_occurred);
                      } else {
                        showSnackBar(R.strings.generic_action_completed);
                        if (context.mounted) {
                          refresh();
                        }
                      }
                    }
                  },
                  icon: const Icon(Icons.add),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      body: content(),
    );
  }

  Widget content() {
    return RefreshIndicator(
      onRefresh: () async {
        refresh();
      },
      child: Column(children: [Expanded(child: grid(context))]),
    );
  }

  Widget grid(BuildContext context) {
    return PagedListView(
      state: _pagingState,
      fetchNextPage: _fetchPage,
      physics: const AlwaysScrollableScrollPhysics(),
      scrollController: _scrollController,
      builderDelegate: PagedChildBuilderDelegate<NewsViewEntry>(
        animateTransitions: true,
        itemBuilder: (context, item, index) {
          final title = item.newsItem.title ?? context.strings.generic_empty;
          final time = item.newsItem.time;
          final String timeDetails;
          if (time != null) {
            timeDetails = timeString(time.toUtcDateTime());
          } else {
            timeDetails = context.strings.generic_empty;
          }
          final String subtitle;
          if (item.newsItem.private) {
            subtitle = "$timeDetails, ${context.strings.news_list_screen_not_published}";
          } else {
            subtitle = timeDetails;
          }

          return ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            onTap: () {
              openViewNewsScreen(context, widget.locale, item.newsItem.id, () {
                if (context.mounted) {
                  refresh();
                }
              });
            },
          );
        },
        noItemsFoundIndicatorBuilder: (context) {
          return buildListReplacementMessage(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.strings.news_list_screen_no_news_found,
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
              child: Text(context.strings.news_list_screen_news_loading_failed),
            ),
          );
        },
      ),
    );
  }

  Widget errorDetectedWidgetWithRetryButton(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Text(context.strings.news_list_screen_news_loading_failed),
          const Padding(padding: EdgeInsets.all(8)),
          ElevatedButton(
            onPressed: () {
              refresh();
            },
            child: Text(context.strings.generic_try_again),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }

  void refresh() {
    if (_pagingState.isLoading) {
      return;
    }
    setState(() {
      _pagingState = PagingState();
    });
  }

  @override
  void dispose() {
    isDisposed = true;
    _scrollController.dispose();
    super.dispose();
  }
}
