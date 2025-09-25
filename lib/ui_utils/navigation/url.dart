import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/list.dart';
import 'package:app/utils/result.dart';
import 'package:database/database.dart';
import 'package:flutter/widgets.dart';
import 'package:openapi/api.dart';

class UrlSegments {
  List<String> urlSegments;
  UrlSegments._(this.urlSegments);

  UrlSegments.fromRouteInformation(RouteInformation routeInformation)
    : urlSegments = [...routeInformation.uri.pathSegments];

  bool get isNotEmpty => urlSegments.isNotEmpty;
  String get first => urlSegments.first;

  Result<(int, UrlSegments), ()> intValue() {
    final stringValue = urlSegments.getAtOrNull(1);
    if (stringValue == null) {
      return Err(());
    }
    final intValue = int.tryParse(stringValue);
    if (intValue == null) {
      return Err(());
    }

    return Ok((intValue, UrlSegments._(urlSegments.skip(2).toList())));
  }

  Future<Result<(UrlAccountId, UrlSegments), ()>> accountId(AccountDatabaseManager db) async {
    final output = intValue().ok();
    if (output == null) {
      return Err(());
    }
    final (value, nextSegments) = output;

    final localAccountId = LocalAccountId(value);

    final accountId = await db
        .accountData((db) => db.account.localAccountIdToAccountId(localAccountId))
        .ok();
    if (accountId == null) {
      return Err(());
    }

    return Ok((UrlAccountId(accountId, localAccountId), nextSegments));
  }

  UrlSegments noArguments() {
    return UrlSegments._(urlSegments.skip(1).toList());
  }
}

class UrlAccountId {
  final AccountId accountId;
  final LocalAccountId localAccountId;
  UrlAccountId(this.accountId, this.localAccountId);
}
