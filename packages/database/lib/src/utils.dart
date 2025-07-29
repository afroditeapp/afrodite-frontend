import 'package:drift/drift.dart';

extension ListExtensions<T> on List<T> {
  T? getAtOrNull(int index) {
    if (index < length) {
      return this[index];
    }
    return null;
  }
}

abstract class QueryExcecutorProvider {
  QueryExecutor getQueryExcecutor();
}

sealed class DbFile {}
class CommonDbFile extends DbFile {}
class CommonBackgroundDbFile extends DbFile {}
class AccountDbFile extends DbFile {
  final String accountId;
  AccountDbFile(this.accountId);
}
class AccountBackgroundDbFile extends DbFile {
  final String accountId;
  AccountBackgroundDbFile(this.accountId);
}
