import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/chat/matches_database_iterator.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/general/iterator/base_iterator_manager.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/data/general/iterator/online_iterator.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';

class MatchesIteratorManager extends BaseIteratorManager {
  final AccountDatabaseManager db;
  final MediaRepository media;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final ServerConnectionManager connectionManager;

  MatchesIteratorManager(ChatRepository chat, this.media, this.accountBackgroundDb, this.db, this.connectionManager, AccountId currentUser) :
    super(chat, db, currentUser, initialIterator: MatchesDatabaseIterator(db: db));

  @override
  OnlineIterator createOnlineIterator() {
    return OnlineIterator(
      resetServerIterator: true,
      media: media,
      io: MatchesOnlineIteratorIo(db, connectionManager.api),
      accountBackgroundDb: accountBackgroundDb,
      db: db,
      connectionManager: connectionManager,
    );
  }
}
