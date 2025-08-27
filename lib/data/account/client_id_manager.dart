import 'package:async/async.dart' show StreamExtensions;
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';

enum ClientIdManagerState { idle, inProgress }

class ClientIdManager {
  final AccountDatabaseManager db;
  final ApiManager api;
  ClientIdManager(this.db, this.api);

  final BehaviorSubject<ClientIdManagerState> _state = BehaviorSubject.seeded(
    ClientIdManagerState.idle,
    sync: true,
  );

  Future<Result<ClientId, ()>> getClientId() async {
    if (_state.value == ClientIdManagerState.inProgress) {
      await _state.where((v) => v == ClientIdManagerState.idle).first;
      final currentClientId = await db
          .accountStream((db) => db.loginSession.watchClientId())
          .firstOrNull;
      if (currentClientId == null) {
        return const Err(());
      } else {
        return Ok(currentClientId);
      }
    }
    _state.add(ClientIdManagerState.inProgress);

    final currentClientId = await db.accountStream((db) => db.loginSession.watchClientId()).first;
    if (currentClientId == null) {
      final newClientId = await api.account((api) => api.postGetNextClientId()).ok();
      if (newClientId != null) {
        await db.accountAction((db) => db.loginSession.updateClientIdIfNull(newClientId));
        _state.add(ClientIdManagerState.idle);
        return Ok(newClientId);
      } else {
        _state.add(ClientIdManagerState.idle);
        return const Err(());
      }
    } else {
      _state.add(ClientIdManagerState.idle);
      return Ok(currentClientId);
    }
  }
}
