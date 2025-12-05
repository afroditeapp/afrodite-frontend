import 'dart:convert';
import 'dart:typed_data';

import 'package:openapi/api.dart';
import 'package:utils/utils.dart';

class BackupMetadata {
  /// Timestamp when the backup was created
  final UtcDateTime createdAt;

  /// Account ID that created the backup
  final AccountId accountId;

  /// Current private key at backup time (if available)
  final Uint8List? privateKeyData;

  /// Current public key at backup time (if available)
  final Uint8List? publicKeyData;

  /// Public key ID at backup time (if available)
  final int? publicKeyId;

  BackupMetadata({
    required this.createdAt,
    required this.accountId,
    this.privateKeyData,
    this.publicKeyData,
    this.publicKeyId,
  });

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toUnixEpochMilliseconds(),
      'accountId': accountId.aid,
      if (privateKeyData != null) 'privateKeyData': base64Encode(privateKeyData!),
      if (publicKeyData != null) 'publicKeyData': base64Encode(publicKeyData!),
      if (publicKeyId != null) 'publicKeyId': publicKeyId,
    };
  }

  factory BackupMetadata.fromJson(Map<String, dynamic> json) {
    return BackupMetadata(
      createdAt: UtcDateTime.fromUnixEpochMilliseconds(json['createdAt'] as int),
      accountId: AccountId(aid: json['accountId'] as String),
      privateKeyData: json['privateKeyData'] != null
          ? base64Decode(json['privateKeyData'] as String)
          : null,
      publicKeyData: json['publicKeyData'] != null
          ? base64Decode(json['publicKeyData'] as String)
          : null,
      publicKeyId: json['publicKeyId'] as int?,
    );
  }

  Uint8List toBytes() {
    final jsonString = jsonEncode(toJson());
    return Uint8List.fromList(utf8.encode(jsonString));
  }

  static BackupMetadata fromBytes(Uint8List bytes) {
    final jsonString = utf8.decode(bytes);
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return BackupMetadata.fromJson(json);
  }
}

/// JSON representation of a message record
/// References binary blobs by index
class BackupMessageJson {
  /// Local database ID of the message
  final int localId;

  /// Client-side timestamp when message was created/received
  final UtcDateTime localUnixTime;

  /// Client-side message state
  final int messageState;

  /// Index to symmetric encryption key blob (null if not present)
  final int? symmetricKeyBlobIndex;

  /// Index to backend signed PGP message blob (null if not present)
  final int? backendSignedPgpMessageBlobIndex;

  /// Index to message data blob (null if not present)
  final int? messageBlobIndex;

  /// Time when the message was sent (from server)
  final UtcDateTime? sentUnixTime;

  /// Time when the message was delivered (for sent messages)
  final UtcDateTime? deliveredUnixTime;

  /// Time when the message was seen (for sent messages)
  final UtcDateTime? seenUnixTime;

  /// Message ID (client which sends the message generates the ID)
  final MessageId? messageId;

  /// Message number from the server
  final MessageNumber? messageNumber;

  BackupMessageJson({
    required this.localId,
    required this.localUnixTime,
    required this.messageState,
    this.symmetricKeyBlobIndex,
    this.backendSignedPgpMessageBlobIndex,
    this.messageBlobIndex,
    this.sentUnixTime,
    this.deliveredUnixTime,
    this.seenUnixTime,
    this.messageId,
    this.messageNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'localId': localId,
      'localUnixTime': localUnixTime.toUnixEpochMilliseconds(),
      'messageState': messageState,
      if (symmetricKeyBlobIndex != null) 'symmetricKeyBlobIndex': symmetricKeyBlobIndex,
      if (backendSignedPgpMessageBlobIndex != null)
        'backendSignedPgpMessageBlobIndex': backendSignedPgpMessageBlobIndex,
      if (messageBlobIndex != null) 'messageBlobIndex': messageBlobIndex,
      if (sentUnixTime != null) 'sentUnixTime': sentUnixTime!.toUnixEpochMilliseconds(),
      if (deliveredUnixTime != null)
        'deliveredUnixTime': deliveredUnixTime!.toUnixEpochMilliseconds(),
      if (seenUnixTime != null) 'seenUnixTime': seenUnixTime!.toUnixEpochMilliseconds(),
      if (messageId != null) 'messageId': messageId!.id,
      if (messageNumber != null) 'messageNumber': messageNumber!.mn,
    };
  }

  factory BackupMessageJson.fromJson(Map<String, dynamic> json) {
    return BackupMessageJson(
      localId: json['localId'] as int,
      localUnixTime: UtcDateTime.fromUnixEpochMilliseconds(json['localUnixTime'] as int),
      messageState: json['messageState'] as int,
      symmetricKeyBlobIndex: json['symmetricKeyBlobIndex'] as int?,
      backendSignedPgpMessageBlobIndex: json['backendSignedPgpMessageBlobIndex'] as int?,
      messageBlobIndex: json['messageBlobIndex'] as int?,
      sentUnixTime: json['sentUnixTime'] != null
          ? UtcDateTime.fromUnixEpochMilliseconds(json['sentUnixTime'] as int)
          : null,
      deliveredUnixTime: json['deliveredUnixTime'] != null
          ? UtcDateTime.fromUnixEpochMilliseconds(json['deliveredUnixTime'] as int)
          : null,
      seenUnixTime: json['seenUnixTime'] != null
          ? UtcDateTime.fromUnixEpochMilliseconds(json['seenUnixTime'] as int)
          : null,
      messageId: json['messageId'] != null ? MessageId(id: json['messageId'] as String) : null,
      messageNumber: json['messageNumber'] != null
          ? MessageNumber(mn: json['messageNumber'] as int)
          : null,
    );
  }
}

/// Account with its associated messages
class BackupAccountJson {
  /// Account ID (the other party in conversations)
  final AccountId accountId;

  /// List of messages with this account
  final List<BackupMessageJson> messages;

  BackupAccountJson({required this.accountId, required this.messages});

  Map<String, dynamic> toJson() {
    return {'accountId': accountId.aid, 'messages': messages.map((m) => m.toJson()).toList()};
  }

  factory BackupAccountJson.fromJson(Map<String, dynamic> json) {
    return BackupAccountJson(
      accountId: AccountId(aid: json['accountId'] as String),
      messages: (json['messages'] as List)
          .map((m) => BackupMessageJson.fromJson(m as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Complete backup JSON structure
class BackupJson {
  final BackupMetadata metadata;
  final List<BackupAccountJson> accounts;

  BackupJson({required this.metadata, required this.accounts});

  Map<String, dynamic> toJson() {
    return {'metadata': metadata.toJson(), 'accounts': accounts.map((a) => a.toJson()).toList()};
  }

  factory BackupJson.fromJson(Map<String, dynamic> json) {
    return BackupJson(
      metadata: BackupMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      accounts: (json['accounts'] as List)
          .map((a) => BackupAccountJson.fromJson(a as Map<String, dynamic>))
          .toList(),
    );
  }

  Uint8List toBytes() {
    final jsonString = jsonEncode(toJson());
    return Uint8List.fromList(utf8.encode(jsonString));
  }

  static BackupJson fromBytes(Uint8List bytes) {
    final jsonString = utf8.decode(bytes);
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return BackupJson.fromJson(json);
  }
}
