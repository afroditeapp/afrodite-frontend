import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/chat/matches_database_iterator.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/general/iterator/base_iterator_manager.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/data/general/iterator/online_iterator.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';

class MatchesIteratorManager extends BaseIteratorManager {
  final AccountDatabaseManager db;
  final MediaRepository media;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final ServerConnectionManager connectionManager;

  MatchesIteratorManager(
    ChatRepository chat,
    this.media,
    this.accountBackgroundDb,
    this.db,
    this.connectionManager,
    AccountId currentUser,
  ) : super(chat, currentUser, initialIterator: MatchesDatabaseIterator(db: db));

  @override
  OnlineIterator createClearDatabaseIterator() {
    return OnlineIterator(
      resetServerIterator: true,
      media: media,
      io: MatchesOnlineIteratorIo(db, connectionManager),
      accountBackgroundDb: accountBackgroundDb,
      db: db,
      connectionManager: connectionManager,
    );
  }

  @override
  MatchesDatabaseIterator createDatabaseIterator() => MatchesDatabaseIterator(db: db);
}
