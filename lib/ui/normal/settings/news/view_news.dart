import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/account/news/view_news.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/model/freezed/logic/account/account.dart';
import 'package:pihka_frontend/model/freezed/logic/account/news/view_news.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/consts/animation.dart';
import 'package:pihka_frontend/ui_utils/list.dart';

final log = Logger("ViewNewsScreen");

Future<void> openViewNewsScreen(
  BuildContext context,
  String locale,
  NewsId id,
) {
  final pageKey = PageKey();
  return MyNavigator.pushWithKey(
    context,
    MaterialPage<void>(
      child: BlocProvider(
        create: (_) => ViewNewsBloc(id, locale),
        lazy: false,
        child: ViewNewsScreen(pageKey: pageKey)
      ),
    ),
    pageKey,
  );
}

class ViewNewsScreen extends StatefulWidget {
  final PageKey pageKey;
  const ViewNewsScreen({
    required this.pageKey,
    super.key,
  });

  @override
  State<ViewNewsScreen> createState() => ViewNewsScreenState();
}

class ViewNewsScreenState extends State<ViewNewsScreen> {
  final AccountId currentUser = LoginRepository.getInstance().repositories.accountId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<AccountBloc, AccountBlocData>(
            builder: (context, state) {
              if (state.permissions.adminNewsEditAll) {
                return editNewsActionButton();
              } else if (state.permissions.adminNewsCreate) {
                return BlocBuilder<ViewNewsBloc, ViewNewsData>(
                  builder: (context, newsState) {
                    if (newsState.item?.aidCreator == currentUser) {
                      return editNewsActionButton();
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
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
    return AnimatedSwitcher(
      duration: ANIMATED_SWITCHER_DEFAULT_DURATION,
      child: BlocBuilder<ViewNewsBloc, ViewNewsData>(
        builder: (context, state) {
          final item = state.item;
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.isError) {
            return buildListReplacementMessageSimple(
              context, context.strings.generic_error_occurred
            );
          } else if (item == null) {
            return buildListReplacementMessageSimple(
              context, context.strings.generic_not_found
            );
          } else {
            return viewItem(context, item);
          }
        }
      ),
    );
  }

  Widget viewItem(BuildContext context, NewsItem item) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.title),
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            Text(item.body),
          ],
        ),
      )
    );
  }

  Widget editNewsActionButton() {
    return IconButton(
      onPressed: () {

      },
      icon: const Icon(Icons.edit),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
