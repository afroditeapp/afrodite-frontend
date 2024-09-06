

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
