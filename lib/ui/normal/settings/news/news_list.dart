import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/account/news/news_count.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/model/freezed/logic/account/account.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/ui/normal/chat/message_row.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui/normal/settings/news/view_news.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';
import 'package:pihka_frontend/ui_utils/list.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:pihka_frontend/utils/api.dart';

final log = Logger("NewsListScreen");

Future<void> openNewsList(
  BuildContext context,
) {
  final pageKey = PageKey();
  final locale = Localizations.localeOf(context).languageCode;
  final bloc = context.read<NewsCountBloc>();
  return MyNavigator.pushWithKey(
    context,
    MaterialPage<void>(child: NewsListScreen(
      pageKey: pageKey,
      locale: locale,
      bloc: bloc,
    )),
    pageKey,
  );
}

class NewsListScreen extends StatefulWidget {
  final PageKey pageKey;
  final String locale;
  final NewsCountBloc bloc;
  const NewsListScreen({
    required this.pageKey,
    required this.locale,
    required this.bloc,
    super.key,
  });

  @override
  State<NewsListScreen> createState() => NewsListScreenState();
}

typedef NewsViewEntry = ({NewsItemSimple newsItem});

class NewsListScreenState extends State<NewsListScreen> {
  final ScrollController _scrollController = ScrollController();
  PagingController<int, NewsViewEntry>? _pagingController =
    PagingController(firstPageKey: 0);

  final AccountDatabaseManager accountDb = LoginRepository.getInstance().repositories.accountDb;
  final ApiManager api = LoginRepository.getInstance().repositories.api;

  NewsIteratorSessionId? _sessionId;

  @override
  void initState() {
    super.initState();
    _pagingController?.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  void showLoadingError() {
    // Show error UI
    _pagingController?.error = true;
  }

  Future<void> _fetchPage(int pageKey) async {
    if (pageKey == 0) {
      final r = await api.account((api) => api.postResetNewsPaging()).ok();
      if (r == null) {
        showLoadingError();
        return;
      }
      _sessionId = r.s;
      final dbResult = await accountDb.accountAction((db) => db.daoNews.setUnreadNewsCount(version: r.v, unreadNewsCount: r.c));
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

    if (news.news.isEmpty) {
      _pagingController?.appendLastPage([]);
    } else {
      _pagingController?.appendPage(newList, pageKey + 1);
    }
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
                    final r = await showConfirmDialog(context, context.strings.news_list_screen_create_new, yesNoActions: true);
                    if (r == true) {
                      final id = await api.accountAdmin((api) => api.postCreateNewsItem()).ok();
                      if (id == null) {
                        showSnackBar(R.strings.generic_error_occurred);
                      } else {
                        showSnackBar(R.strings.generic_action_completed);
                        if (context.mounted) {
                          await refresh();
                        }
                      }
                    }
                  },
                  icon: const Icon(Icons.add),
                );
              } else {
                return const SizedBox.shrink();
              }
            }
          )
        ],
      ),
      body: content(),
    );
  }

  Widget content() {
    return RefreshIndicator(
      onRefresh: () async {
        await refresh();
      },
      child: Column(children: [
        Expanded(
          child: grid(context),
        ),
      ],),
    );
  }

  Widget grid(BuildContext context) {
    return PagedListView(
      physics: const AlwaysScrollableScrollPhysics(),
      scrollController: _scrollController,
      pagingController: _pagingController!,
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
              openViewNewsScreen(
                context,
                widget.locale,
                item.newsItem.id,
                () {
                  if (context.mounted) {
                    refresh();
                  }
                }
              );
            }
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

  Future<void> refresh() async {
    _pagingController?.refresh();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pagingController?.dispose();
    _pagingController = null;
    super.dispose();
  }
}
