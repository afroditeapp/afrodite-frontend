import 'package:app/data/profile/automatic_profile_search/automatic_profile_search_database_iterator.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/general/iterator/base_iterator_manager.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/data/general/iterator/online_iterator.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';

class AutomaticProfileSearchIteratorManager extends BaseIteratorManager {
  final AccountDatabaseManager db;
  final MediaRepository media;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final ServerConnectionManager connectionManager;

  AutomaticProfileSearchIteratorManager(ChatRepository chat, this.media, this.accountBackgroundDb, this.db, this.connectionManager, AccountId currentUser) :
    super(chat, db, currentUser, initialIterator: AutomaticProfileSearchDatabaseIterator(db: db));

  @override
  OnlineIterator createOnlineIterator() {
    return OnlineIterator(
      resetServerIterator: true,
      media: media,
      io: AutomaticProfileSearchOnlineIteratorIo(db, connectionManager.api),
      accountBackgroundDb: accountBackgroundDb,
      db: db,
      connectionManager: connectionManager,
    );
  }
}
