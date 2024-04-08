
import 'package:openapi/api.dart' show AccountId, ProfileContent;
import 'package:openapi/api.dart' as api;
import 'package:pihka_frontend/database/account_database.dart';

import 'package:drift/drift.dart';
import 'package:pihka_frontend/database/profile_entry.dart';
import 'package:pihka_frontend/database/utils.dart';
import 'package:pihka_frontend/utils/date.dart';



part 'dao_pending_content.g.dart';


@DriftAccessor(tables: [Account])
class DaoPendingContent extends DatabaseAccessor<AccountDatabase> with _$DaoPendingContentMixin {
  DaoPendingContent(AccountDatabase db) : super(db);

}
