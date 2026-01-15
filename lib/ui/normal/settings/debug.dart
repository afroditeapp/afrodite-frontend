import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:async/async.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:native_utils/native_utils.dart';
import 'package:openapi/api.dart';
import 'package:app/data/general/notification/state/like_received.dart';
import 'package:app/data/general/notification/state/message_received.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/result.dart';

class DebugSettingsPage extends MyScreenPage<()> with SimpleUrlParser<DebugSettingsPage> {
  final RepositoryInstances r;
  DebugSettingsPage(this.r) : super(builder: (_) => DebugSettingsScreen(r));

  @override
  DebugSettingsPage create() => DebugSettingsPage(r);
}

class DebugSettingsScreen extends StatefulWidget {
  final ApiManager api;
  final ProfileRepository profile;
  final AccountDatabaseManager accountDb;
  final AccountId accountId;

  DebugSettingsScreen(RepositoryInstances r, {super.key})
    : api = r.api,
      profile = r.profile,
      accountDb = r.accountDb,
      accountId = r.accountId;

  @override
  State<DebugSettingsScreen> createState() => _DebugSettingsScreenState();
}

class _DebugSettingsScreenState extends State<DebugSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Debug")),
      body: settingsList(context),
    );
  }

  Widget settingsList(BuildContext context) {
    List<Setting> settings = [];

    settings.add(
      Setting.createSetting(
        Icons.notification_add,
        "Notification: Likes",
        () => NotificationLikeReceived.getInstance().incrementReceivedLikesCount(widget.accountDb),
      ),
    );

    settings.add(
      Setting.createSetting(
        Icons.notification_add,
        "Notification: New message (first chat)",
        () => showConversationNotifications(take: 1),
      ),
    );

    settings.add(
      Setting.createSetting(
        Icons.notification_add,
        "Notification: New message (second chat)",
        () => showConversationNotifications(skip: 1, take: 1),
      ),
    );

    settings.add(
      Setting.createSetting(
        Icons.notification_add,
        "Notification: New message (chats 1-5)",
        () => showConversationNotifications(take: 5),
      ),
    );

    settings.add(
      Setting.createSetting(
        Icons.key,
        "Generate and upload new keys",
        () => generateAndUploadNewKeys(context),
      ),
    );

    final checkboxes = [
      CheckboxListTile(
        value: _debugLogic.conversationLastUpdateTimeChanger,
        onChanged: (value) {
          setState(() {
            if (value == true) {
              _debugLogic.startConversationLastUpdateTimeChanger(widget.accountDb);
            } else {
              _debugLogic.stopConversationLastUpdateTimeChanger();
            }
          });
        },
        title: const Text("Update conversation last updated time automatically"),
      ),
      CheckboxListTile(
        value: _debugLogic.openVideoCallsToBrowser,
        onChanged: (value) {
          setState(() {
            _debugLogic.openVideoCallsToBrowser = value ?? false;
          });
        },
        title: const Text("Open video calls to browser"),
      ),
    ];

    return SingleChildScrollView(
      child: Column(children: [...settings.map((setting) => setting.toListTile()), ...checkboxes]),
    );
  }

  Future<void> showConversationNotifications({int skip = 0, required int take}) async {
    final List<AccountId> matchList =
        await widget.profile.getConversationListUpdates().firstOrNull ?? [];
    final match = matchList.firstOrNull;
    if (match == null) {
      return;
    }

    for (final a in matchList.skip(skip).take(take)) {
      ConversationId? conversationId = await widget.accountDb
          .accountData((db) => db.chatUnreadMessagesCount.getConversationId(a))
          .ok();
      if (conversationId == null) {
        final r = await widget.api.chat((api) => api.getConversationId(a.aid)).ok();
        conversationId = r?.value;
      }
      await NotificationMessageReceived.getInstance().updateMessageReceivedCount(
        a,
        1,
        conversationId,
        widget.accountDb,
      );
    }
  }

  Future<void> generateAndUploadNewKeys(BuildContext context) async {
    try {
      // Generate keys
      final currentUserString = widget.accountId.aid;
      final (GeneratedMessageKeys?, int) generateKeysResult;
      if (kIsWeb) {
        generateKeysResult = await generateMessageKeys(currentUserString);
      } else {
        generateKeysResult = await Isolate.run(() => generateMessageKeys(currentUserString));
      }

      final (newKeys, result) = generateKeysResult;
      if (newKeys == null) {
        showSnackBar('Failed: Key generation error code $result');
        return;
      }

      // Upload public key to server
      final r = await widget.api
          .chat((api) => api.postAddPublicKey(MultipartFile.fromBytes("", newKeys.public.toList())))
          .ok();

      final keyId = r?.keyId;
      if (r == null || keyId == null || r.error || r.errorTooManyPublicKeys) {
        showSnackBar(
          r?.errorTooManyPublicKeys == true
              ? 'Failed: Too many public keys'
              : 'Failed: Server error',
        );
        return;
      }

      // Save keys to database
      final private = PrivateKeyBytes(data: newKeys.private);
      final public = PublicKeyBytes(data: newKeys.public);

      final dbResult = await widget.accountDb.accountAction(
        (db) => db.key.setMessageKeys(
          private: private,
          public: public,
          publicKeyId: keyId,
          publicKeyIdOnServer: keyId,
        ),
      );

      if (dbResult.isErr()) {
        showSnackBar('Failed: Could not save keys to database');
        return;
      }

      // Success
      showSnackBar('Success! New keys generated and uploaded. Key ID: ${keyId.id}');
    } catch (e) {
      showSnackBar('Failed: $e');
    }
  }
}

final _debugRandom = Random();
final _debugLogic = DebugLogic();

DebugLogic getDebugLogic() => _debugLogic;

class DebugLogic {
  bool conversationLastUpdateTimeChanger = false;
  bool openVideoCallsToBrowser = false;
  StreamSubscription<void>? _conversationLastUpdateTimeChangerSubscription;

  void startConversationLastUpdateTimeChanger(AccountDatabaseManager accountDb) {
    conversationLastUpdateTimeChanger = true;
    _startConversationLastUpdateTimeChanger(accountDb);
  }

  void _startConversationLastUpdateTimeChanger(AccountDatabaseManager accountDb) async {
    await _conversationLastUpdateTimeChangerSubscription?.cancel();
    _conversationLastUpdateTimeChangerSubscription = Stream.periodic(const Duration(seconds: 1), (
      _,
    ) async {
      final matches = await accountDb
          .accountData((db) => db.conversationList.getConversationListNoBlocked(0, 1000))
          .ok();
      if (matches == null || matches.isEmpty) {
        return;
      }
      final randomMatch = matches[_debugRandom.nextInt(matches.length)];
      await accountDb.accountAction(
        (db) => db.conversationList.setCurrentTimeToConversationLastChanged(randomMatch),
      );
    }).listen((_) {});
  }

  void stopConversationLastUpdateTimeChanger() {
    conversationLastUpdateTimeChanger = false;
    _stopConversationLastUpdateTimeChanger();
  }

  void _stopConversationLastUpdateTimeChanger() async {
    await _conversationLastUpdateTimeChangerSubscription?.cancel();
  }
}
