import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:async/async.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/account_repository.dart';
import 'package:pihka_frontend/data/profile/account_id_database_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_iterator_manager.dart';
import 'package:pihka_frontend/data/profile/profile_list/online_iterator.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/account_id_database.dart';
import 'package:pihka_frontend/database/chat/matches_database.dart';
import 'package:pihka_frontend/database/chat/message_database.dart';
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
  final profileEntryDownloader = ProfileEntryDownloader();
  final AccountIdDatabaseIterator sentBlocksIterator =
    AccountIdDatabaseIterator(SentBlocksDatabase.getInstance());
  final AccountIdDatabaseIterator receivedLikesIterator =
    AccountIdDatabaseIterator(ReceivedLikesDatabase.getInstance());
  final AccountIdDatabaseIterator matchesIterator =
    AccountIdDatabaseIterator(MatchesDatabase.getInstance());

  @override
  Future<void> init() async {
    // empty
  }

  @override
  Future<void> onLogin() async {
    sentBlocksIterator.reset();
    receivedLikesIterator.reset();

    _api.state
      .firstWhere((element) => element == ApiManagerState.connected)
      .then((value) async {
        // TODO: Perhps client should track these operations and retry
        // these if needed.

        // Download received blocks.
        await receivedBlocksRefresh();

        // Download sent blocks.
        final sentBlocks = await _api.chat((api) => api.getSentBlocks());
        await SentBlocksDatabase.getInstance().insertAccountIdList(sentBlocks?.profiles);

        // Download received likes.
        await receivedLikesRefresh();

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

  Future<bool> isInSentBlocks(AccountId accountId) async {
    return await SentBlocksDatabase.getInstance().exists(accountId);
  }

  Future<bool> isInReceivedBlocks(AccountId accountId) async {
    return await ReceivedBlocksDatabase.getInstance().exists(accountId);
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
      await ReceivedLikesDatabase.getInstance().removeAccountId(accountId);
      ProfileRepository.getInstance().sendProfileChange(ProfileBlocked(accountId));
    }
    return result.isSuccess();
  }

  Future<bool> removeBlockFrom(AccountId accountId) async {
    final (result, _) = await _api.chatWrapper().requestWithHttpStatus((api) => api.postUnblockProfile(accountId));
    if (result.isSuccess()) {
      await SentBlocksDatabase.getInstance().removeAccountId(accountId);
      ProfileRepository.getInstance().sendProfileChange(ProfileUnblocked(accountId));
    }
    return result.isSuccess();
  }

  /// Returns AccountId for all blocked profiles. ProfileEntry is returned only
  /// if the blocked profile is public.
  Future<List<(AccountId, ProfileEntry?)>> sentBlocksIteratorNext() async {
    final accounts = await sentBlocksIterator.nextList();
    final newList = List<(AccountId, ProfileEntry?)>.empty(growable: true);
    for (final accountId in accounts) {
      final profileData = await profileEntryDownloader.download(accountId);
      newList.add((accountId, profileData));
    }
    return newList;
  }

  void sentBlocksIteratorReset() {
    sentBlocksIterator.reset();
  }

  Future<void> receivedBlocksRefresh() async {
    final receivedBlocks = await _api.chat((api) => api.getReceivedBlocks());
    if (receivedBlocks != null) {
      final db = ReceivedBlocksDatabase.getInstance();

      final currentReceivedBlocks = await db.getAccountIdList(0, null) ?? [];
      await db.clearAccountIds();
      await db.insertAccountIdList(receivedBlocks.profiles);

      for (final account in receivedBlocks.profiles) {
        if (!currentReceivedBlocks.contains(account)) {
          await ReceivedLikesDatabase.getInstance().removeAccountId(account);
          await MatchesDatabase.getInstance().removeAccountId(account);
          await SentLikesDatabase.getInstance().removeAccountId(account);
          // Perhaps if both users blocks same time, the same account could be
          // in both sent and received blocks. This handles that case.
          await SentBlocksDatabase.getInstance().removeAccountId(account);
          ProfileRepository.getInstance().sendProfileChange(ProfileBlocked(account));
        }
      }
    }
  }

  /// ProfileEntry is returned if a profile of the like sender
  /// is cached or the profile is public.
  ///
  /// Private profiles are not returned (except the cached ones).
  Future<List<ProfileEntry>> receivedLikesIteratorNext() async {
    final accounts = await receivedLikesIterator.nextList();
    final newList = <ProfileEntry>[];
    for (final accountId in accounts) {
      final profileData =
        await ProfileDatabase.getInstance().getProfileEntry(accountId) ??
        await profileEntryDownloader.download(accountId);
      if (profileData != null) {
        newList.add(profileData);
      }
    }
    return newList;
  }

  void receivedLikesIteratorReset() {
    receivedLikesIterator.reset();
  }

  Future<void> receivedLikesRefresh() async {
    final receivedLikes = await _api.chat((api) => api.getReceivedLikes());
    if (receivedLikes != null) {
      final db = ReceivedLikesDatabase.getInstance();
      await db.clearAccountIds();
      await db.insertAccountIdList(receivedLikes.profiles);
      ProfileRepository.getInstance().sendProfileChange(LikesChanged());
    }
  }

  /// Iterate ProfileEntries of current matches.
  ///
  /// Matches can see the profiles of each other even if one/both are
  /// set as private.
  Future<List<ProfileEntry>> matchesIteratorNext() async {
    final accounts = await matchesIterator.nextList();
    final newList = <ProfileEntry>[];
    for (final accountId in accounts) {
      final profileData =
        await ProfileDatabase.getInstance().getProfileEntry(accountId) ??
        await profileEntryDownloader.download(accountId, isMatch: true);
      if (profileData != null) {
        newList.add(profileData);
      }
    }
    return newList;
  }

  void matchesIteratorReset() {
    matchesIterator.reset();
  }

  // Messages

  Future<void> receiveNewMessages() async {
    final currentUser = await AccountRepository.getInstance().accountId.firstOrNull;
    if (currentUser == null) {
      return;
    }
    final newMessages = await _api.chat((api) => api.getPendingMessages());
    if (newMessages != null) {
      final toBeDeleted = <PendingMessageId>[];
      final db = MessageDatabase.getInstance();
      for (final message in newMessages.messages) {
        if (await db.insertPendingMessage(currentUser, message)) {
          toBeDeleted.add(message.id);
        }
      }
      final toBeDeletedList = PendingMessageDeleteList(messagesIds: toBeDeleted);
      final (result, _) = await _api.chatWrapper().requestWithHttpStatus((api) => api.deletePendingMessages(toBeDeletedList));
      if (result.isSuccess()) {
        for (final message in newMessages.messages) {
          await db.updateReceivedMessageState(
            currentUser,
            message.id.accountIdSender,
            message.id.messageNumber,
            ReceivedMessageState.deletedFromServer,
          );
        }
      }
      // TODO: If request fails try again at some point.

      for (final message in newMessages.messages) {
        ProfileRepository.getInstance().sendProfileChange(ConversationChanged(message.id.accountIdSender));
      }
    }
  }
}
