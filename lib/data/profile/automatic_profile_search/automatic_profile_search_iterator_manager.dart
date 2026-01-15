import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/general/iterator/base_iterator_manager.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/data/general/iterator/online_iterator.dart';
import 'package:app/database/account_database_manager.dart';

class AutomaticProfileSearchIteratorManager extends BaseIteratorManager {
  final AccountDatabaseManager db;
  final MediaRepository media;
  final ServerConnectionManager connectionManager;

  AutomaticProfileSearchIteratorManager(
    ChatRepository chat,
    this.media,
    this.db,
    this.connectionManager,
    AccountId currentUser,
  ) : super(chat, currentUser, clearDatabase: true);

  @override
  OnlineIterator createNewIterator(bool clearDatabase) {
    return OnlineIterator(
      resetServerIterator: clearDatabase,
      media: media,
      io: AutomaticProfileSearchOnlineIteratorIo(db, connectionManager),
      db: db,
      connectionManager: connectionManager,
    );
  }
}
