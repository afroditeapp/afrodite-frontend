import 'dart:async';

import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/account/client_features_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:openapi/api.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/account/news/view_news.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/news/view_news.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/localizations.dart';
import 'package:app/ui/normal/settings/news/edit_news.dart';
import 'package:app/ui_utils/consts/animation.dart';
import 'package:app/ui_utils/list.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/time.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> openViewNewsScreen(BuildContext context, NewsId id, void Function() refreshNewsList) {
  return MyNavigator.push(context, ViewNewsPage(id));
}

void _emptyCallback() {}

class ViewNewsPage extends MyScreenPage<()> {
  ViewNewsPage(NewsId id, {void Function() refreshNewsList = _emptyCallback})
    : super(
        builder: (_) {
          return BlocProvider(
            create: (context) => ViewNewsBloc(
              context.read<RepositoryInstances>(),
              id,
              Localizations.localeOf(context).languageCode,
            ),
            lazy: false,
            child: ViewNewsScreen(id: id, refreshNewsList: refreshNewsList),
          );
        },
      );
}

class ViewNewsScreen extends StatefulWidget {
  final NewsId id;
  final void Function() refreshNewsList;
  const ViewNewsScreen({required this.id, required this.refreshNewsList, super.key});

  @override
  State<ViewNewsScreen> createState() => ViewNewsScreenState();
}

class ViewNewsScreenState extends State<ViewNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<AccountBloc, AccountBlocData>(
            builder: (context, state) {
              if (state.permissions.adminNewsEditAll) {
                return editNewsActionButton(context);
              } else if (state.permissions.adminNewsCreate) {
                return BlocBuilder<ViewNewsBloc, ViewNewsData>(
                  builder: (context, newsState) {
                    final currentUser = context.read<RepositoryInstances>().accountId;
                    if (newsState.item?.aidCreator == currentUser) {
                      return editNewsActionButton(context);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
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
    return AnimatedSwitcher(
      duration: ANIMATED_SWITCHER_DEFAULT_DURATION,
      child: BlocBuilder<ViewNewsBloc, ViewNewsData>(
        builder: (context, state) {
          final item = state.item;
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.isError) {
            return buildListReplacementMessageSimple(
              context,
              context.strings.generic_error_occurred,
            );
          } else if (item == null) {
            return buildListReplacementMessageSimple(context, context.strings.generic_not_found);
          } else {
            return viewItem(context, item);
          }
        },
      ),
    );
  }

  Widget viewItem(BuildContext context, NewsItem item) {
    String details = "";
    final latestPublicationTime = item.time;
    if (latestPublicationTime != null) {
      final latestPublicationTimeString = timeString(latestPublicationTime.toUtcDateTime());
      details = context.strings.view_news_screen_published(latestPublicationTimeString);
    }
    final editTime = item.editUnixTime;
    if (editTime != null) {
      final editTimeText = timeString(UnixTime(ut: editTime).toUtcDateTime());
      details += "\n${context.strings.view_news_screen_edited(editTimeText)}";
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViewNewsItem(title: item.title, body: item.body),
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            Text(details),
          ],
        ),
      ),
    );
  }

  Widget editNewsActionButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final bloc = context.read<ViewNewsBloc>();
        final config = context.read<ClientFeaturesConfigBloc>().state;
        await openEditNewsScreen(context, widget.id, config.newsLocales());
        if (!bloc.isClosed) {
          bloc.add(Reload());
          widget.refreshNewsList();
        }
      },
      icon: const Icon(Icons.edit),
    );
  }
}

class ViewNewsItem extends StatelessWidget {
  final String title;
  final String body;
  const ViewNewsItem({required this.title, required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
        MarkdownBody(
          data: body,
          onTapLink: (text, href, title) {
            if (href != null) {
              launchUrlString(href);
            }
          },
        ),
      ],
    );
  }
}
