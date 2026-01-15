import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/general/iterator/base_iterator_manager.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/data/general/iterator/online_iterator.dart';
import 'package:app/database/account_database_manager.dart';

class ReceivedLikesIteratorManager extends BaseIteratorManager {
  final AccountDatabaseManager db;
  final MediaRepository media;
  final ServerConnectionManager connectionManager;

  ReceivedLikesIteratorManager(
    ChatRepository chat,
    this.media,
    this.db,
    this.connectionManager,
    AccountId currentUser,
  ) : super(chat, currentUser, clearDatabase: false);

  @override
  OnlineIterator createNewIterator(bool clearDatabase) {
    return OnlineIterator(
      resetServerIterator: clearDatabase,
      media: media,
      io: ReceivedLikesOnlineIteratorIo(db, connectionManager),
      db: db,
      connectionManager: connectionManager,
    );
  }
}
