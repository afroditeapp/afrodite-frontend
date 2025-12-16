import 'dart:async';
import 'dart:math';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/chat/message_key_generator.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/model/freezed/logic/chat/chat_enabled.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';

sealed class ChatEnabledEvent {}

class EnableChatWithNewKeypair extends ChatEnabledEvent {}

class QueryKeyInfo extends ChatEnabledEvent {}

class ClearRemainingKeyGenerations extends ChatEnabledEvent {}

class ChatEnabledBloc extends Bloc<ChatEnabledEvent, ChatEnabledData> {
  final ChatRepository chat;
  final ApiManager api;
  final AccountDatabaseManager db;
  final MessageKeyManager messageKeyManager;
  final AccountId currentUser;

  StreamSubscription<bool?>? _chatEnabledSubscription;

  ChatEnabledBloc(RepositoryInstances r)
    : chat = r.chat,
      api = r.api,
      db = r.accountDb,
      messageKeyManager = r.chat.messageKeyManager,
      currentUser = r.accountId,
      super(const ChatEnabledData()) {
    on<EnableChatWithNewKeypair>((event, emit) async {
      emit(state.copyWith(isEnabling: true));

      // Generate new keys (this will also upload and save to DB)
      final result = await messageKeyManager.generateNewKeypairAndUploadPublicKey();

      if (result.isOk()) {
        // The database will automatically update chatEnabled status
        // via the stream subscription
        emit(state.copyWith(isEnabling: false));
      } else {
        emit(state.copyWith(isEnabling: false, enableError: true));
      }
    });

    // Listen to database stream for chat enabled status
    _chatEnabledSubscription = db.accountStream((db) => db.key.watchChatEnabled()).listen((
      isEnabled,
    ) {
      add(_ChatEnabledChanged(isEnabled ?? false));
    });

    on<_ChatEnabledChanged>((event, emit) {
      emit(state.copyWith(chatEnabled: event.chatEnabled, enableError: false));
    });

    on<QueryKeyInfo>((event, emit) async {
      final result = await api.chat((api) => api.getPrivatePublicKeyInfo(currentUser.aid));
      final keyInfo = result.ok();
      if (keyInfo != null) {
        final currentKeyId = keyInfo.latestPublicKeyId?.id ?? 0;
        final maxKeys = max(
          keyInfo.maxPublicKeyCountFromBackendConfig,
          keyInfo.maxPublicKeyCountFromAccountConfig,
        );
        final remainingGenerations = maxKeys - currentKeyId;
        emit(state.copyWith(remainingKeyGenerations: remainingGenerations));
      }
    });

    on<ClearRemainingKeyGenerations>((event, emit) {
      emit(state.copyWith(remainingKeyGenerations: null));
    });
  }

  @override
  Future<void> close() async {
    await _chatEnabledSubscription?.cancel();
    return super.close();
  }
}

class _ChatEnabledChanged extends ChatEnabledEvent {
  final bool chatEnabled;
  _ChatEnabledChanged(this.chatEnabled);
}
