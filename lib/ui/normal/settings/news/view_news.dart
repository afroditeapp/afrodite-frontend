import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/model/freezed/logic/account/account.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/consts/animation.dart';
import 'package:pihka_frontend/ui_utils/list.dart';
import 'package:pihka_frontend/utils/app_error.dart';
import 'package:pihka_frontend/utils/result.dart';

final log = Logger("ViewNewsScreen");

Future<void> openViewNewsScreen(
  BuildContext context,
  String locale,
  NewsId id,
) {
  final pageKey = PageKey();
  return MyNavigator.pushWithKey(
    context,
    MaterialPage<void>(child: ViewNewsScreen(pageKey: pageKey, locale: locale, id: id)),
    pageKey,
  );
}

class ViewNewsScreen extends StatefulWidget {
  final PageKey pageKey;
  final String locale;
  final NewsId id;
  const ViewNewsScreen({
    required this.pageKey,
    required this.locale,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<ViewNewsScreen> createState() => ViewNewsScreenState();
}

class ViewNewsScreenState extends State<ViewNewsScreen> {
  final AccountDatabaseManager accountDb = LoginRepository.getInstance().repositories.accountDb;
  final ApiManager api = LoginRepository.getInstance().repositories.api;

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
              final showEditButton = state.permissions.adminNewsEditAll;
              if (showEditButton) {
                return IconButton(
                  onPressed: () {

                  },
                  icon: const Icon(Icons.edit),
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
      child: FutureBuilder<Result<GetNewsItemResult, ValueApiError>>(
        future: api.account((api) => api.getNewsItem(widget.id.nid, widget.locale)),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          switch (data) {
            case Ok():
              final item = data.value.item;
              if (item == null) {
                return buildListReplacementMessageSimple(
                  context, context.strings.generic_not_found
                );
              } else {
                return viewItem(context, item);
              }
            case Err():
              return buildListReplacementMessageSimple(
                context, context.strings.generic_error_occurred
              );
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

  @override
  void dispose() {
    super.dispose();
  }
}
