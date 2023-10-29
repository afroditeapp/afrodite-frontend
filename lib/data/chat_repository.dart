import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/profile/profile_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_iterator_manager.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/chat/matches_database.dart';
import 'package:pihka_frontend/database/chat/received_blocks_database.dart';
import 'package:pihka_frontend/database/chat/received_likes_database.dart';
import 'package:pihka_frontend/database/chat/sent_blocks_database.dart';
import 'package:pihka_frontend/database/chat/sent_likes_database.dart';
import 'package:pihka_frontend/database/favorite_profiles_database.dart';
import 'package:pihka_frontend/database/profile_database.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:pihka_frontend/ui/utils.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("ChatRepository");

class ChatRepository extends DataRepository {
  ChatRepository._private();
  static final _instance = ChatRepository._private();
  factory ChatRepository.getInstance() {
    return _instance;
  }

  final ApiManager _api = ApiManager.getInstance();

  @override
  Future<void> init() async {
    // empty
  }

  @override
  Future<void> onLogin() async {
    _api.state
      .firstWhere((element) => element == ApiManagerState.connected)
      .then((value) async {
        // TODO: Perhps client should track these operations and retry
        // these if needed.

        // Download received blocks.
        final receivedBlocks = await _api.chat((api) => api.getReceivedBlocks());
        await ReceivedBlocksDatabase.getInstance().insertAccountIdList(receivedBlocks?.profiles);

        // Download sent blocks.
        final sentBlocks = await _api.chat((api) => api.getSentBlocks());
        await SentBlocksDatabase.getInstance().insertAccountIdList(sentBlocks?.profiles);

        // Download received likes.
        final receivedLikes = await _api.chat((api) => api.getReceivedLikes());
        await ReceivedLikesDatabase.getInstance().insertAccountIdList(receivedLikes?.profiles);

        // Download sent likes.
        final sentLikes = await _api.chat((api) => api.getSentLikes());
        await SentLikesDatabase.getInstance().insertAccountIdList(sentLikes?.profiles);

        // Download current matches.
        final matchesList = await _api.chat((api) => api.getMatches());
        await SentLikesDatabase.getInstance().insertAccountIdList(matchesList?.profiles);
      })
      .ignore();
  }

  @override
  Future<void> onLogout() async {
    await SentBlocksDatabase.getInstance().clearAccountIds();
    await SentLikesDatabase.getInstance().clearAccountIds();
    await ReceivedBlocksDatabase.getInstance().clearAccountIds();
    await ReceivedLikesDatabase.getInstance().clearAccountIds();
    await MatchesDatabase.getInstance().clearAccountIds();
  }

  Future<bool> isInMatches(AccountId accountId) async {
    return await MatchesDatabase.getInstance().exists(accountId);
  }

  Future<bool> isInLikedProfiles(AccountId accountId) async {
    return await SentLikesDatabase.getInstance().exists(accountId);
  }

  Future<bool> isInReceivedLikes(AccountId accountId) async {
    return await ReceivedLikesDatabase.getInstance().exists(accountId);
  }

  Future<bool> sendLikeTo(AccountId accountId) async {
    final (result, _) = await _api.chatWrapper().requestWithHttpStatus((api) => api.postSendLike(accountId));
    if (result.isSuccess()) {
      final isReceivedLike = await ReceivedLikesDatabase.getInstance().exists(accountId);
      if (isReceivedLike) {
        await MatchesDatabase.getInstance().insertAccountId(accountId);
      } else {
        await SentLikesDatabase.getInstance().insertAccountId(accountId);
      }
    }
    return result.isSuccess();
  }

  Future<bool> removeLikeFrom(AccountId accountId) async {
    final (result, _) = await _api.chatWrapper().requestWithHttpStatus((api) => api.deleteLike(accountId));
    if (result.isSuccess()) {
      await SentLikesDatabase.getInstance().removeAccountId(accountId);
    }
    return result.isSuccess();
  }

  Future<bool> sendBlockTo(AccountId accountId) async {
    final (result, _) = await _api.chatWrapper().requestWithHttpStatus((api) => api.postBlockProfile(accountId));
    if (result.isSuccess()) {
      await SentBlocksDatabase.getInstance().insertAccountId(accountId);
    }
    return result.isSuccess();
  }

  Future<bool> removeBlockFrom(AccountId accountId) async {
    final (result, _) = await _api.chatWrapper().requestWithHttpStatus((api) => api.postUnblockProfile(accountId));
    if (result.isSuccess()) {
      await SentBlocksDatabase.getInstance().removeAccountId(accountId);
    }
    return result.isSuccess();
  }
}
