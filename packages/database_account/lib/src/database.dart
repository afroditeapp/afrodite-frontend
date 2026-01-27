import 'package:database_account/src/read/account/account.dart';
import 'package:database_account/src/read/app/app_notification_settings.dart';
import 'package:database_account/src/read/chat/backup.dart';
import 'package:database_account/src/read/chat/conversation_list.dart';
import 'package:database_account/src/read/chat/key.dart';
import 'package:database_account/src/read/chat/like.dart';
import 'package:database_account/src/read/chat/message.dart';
import 'package:database_account/src/read/chat/privacy.dart';
import 'package:database_account/src/read/chat/unread_messages_count.dart';
import 'package:database_account/src/read/common/config.dart';
import 'package:database_account/src/read/account/login_session.dart';
import 'package:database_account/src/read/app.dart';
import 'package:database_account/src/read/common/common.dart';
import 'package:database_account/src/read/media/media.dart';
import 'package:database_account/src/read/media/my_media.dart';
import 'package:database_account/src/read/profile/my_profile.dart';
import 'package:database_account/src/read/profile/privacy.dart';
import 'package:database_account/src/read/profile/profile.dart';
import 'package:database_account/src/read/profile/search.dart';
import 'package:database_account/src/write/account/account.dart';
import 'package:database_account/src/write/app/app_notification_settings.dart';
import 'package:database_account/src/write/chat/backup.dart';
import 'package:database_account/src/write/chat/conversation_list.dart';
import 'package:database_account/src/write/chat/key.dart';
import 'package:database_account/src/write/chat/like.dart';
import 'package:database_account/src/write/chat/message.dart';
import 'package:database_account/src/write/chat/privacy.dart';
import 'package:database_account/src/write/chat/unread_messages_count.dart';
import 'package:database_account/src/write/common/config.dart';
import 'package:database_account/src/write/account/login_session.dart';
import 'package:database_account/src/write/app.dart';
import 'package:database_account/src/write/common/common.dart';
import 'package:database_account/src/write/media/media.dart';
import 'package:database_account/src/write/media/my_media.dart';
import 'package:database_account/src/write/profile/my_profile.dart';
import 'package:database_account/src/write/profile/privacy.dart';
import 'package:database_account/src/write/profile/profile.dart';
import 'package:database_account/src/write/profile/search.dart';
import 'package:database_utils/database_utils.dart';
import 'package:database_model/database_model.dart';
import 'package:database_converter/database_converter.dart';
import 'package:drift/drift.dart';
import 'package:utils/utils.dart';
import 'package:openapi/api.dart';
import 'schema.dart' as schema;

part 'database.g.dart';

/// Common app data which can be accessed when app is in foreground
@DriftDatabase(
  tables: [
    // App
    schema.ProfileFilterFavorites,
    schema.ShowAdvancedProfileFilters,
    schema.InitialSync,
    schema.InitialSetupSkipped,
    schema.InitialSetupProgress,
    schema.GridSettings,
    schema.ChatBackupReminder,
    schema.AdminNotification,
    schema.AppNotificationSettings,
    schema.NotificationStatus,
    schema.News,
    schema.PushNotification,
    schema.EditProfileProgress,
    // Common
    schema.ServerMaintenance,
    schema.SyncVersion,
    schema.ReceivedLikesIteratorState,
    schema.ClientFeaturesConfig,
    schema.CustomReportsConfig,
    schema.ProfileAttributesConfig,
    schema.ProfileAttributesConfigAttributes,
    schema.ClientLanguageOnServer,
    schema.NewReceivedLikesCount,
    // Account
    schema.LocalAccountId,
    schema.AccountState,
    schema.Permissions,
    schema.ProfileVisibility,
    schema.EmailAddress,
    schema.EmailVerified,
    schema.AccountId,
    schema.LoginSessionTokens,
    // Media
    schema.MyMediaContent,
    schema.ProfileContent,
    // Profile
    schema.MyProfile,
    schema.Profile,
    schema.ProfileSearchAgeRange,
    schema.ProfileSearchGroups,
    schema.ProfileFilters,
    schema.InitialProfileAge,
    schema.ProfileStates,
    schema.ProfileLocation,
    schema.FavoriteProfiles,
    schema.AutomaticProfileSearchSettings,
    schema.AutomaticProfileSearchBadgeState,
    schema.ProfilePrivacySettings,
    // Chat
    schema.MyKeyPair,
    schema.PublicKey,
    schema.ConversationList,
    schema.DailyLikesLeft,
    schema.ChatPrivacySettings,
    schema.Message,
    schema.UnreadMessagesCount,
    schema.NewMessageNotification,
  ],
  daos: [
    // Read

    // App
    DaoReadApp,
    DaoReadAppNotificationSettings,
    // Common
    DaoReadCommon,
    DaoReadConfig,
    // Account
    DaoReadAccount,
    DaoReadLoginSession,
    // Media
    DaoReadMedia,
    DaoReadMyMedia,
    // Profile
    DaoReadProfile,
    DaoReadMyProfile,
    DaoReadProfilePrivacy,
    DaoReadSearch,
    // Chat
    DaoReadBackup,
    DaoReadConversationList,
    DaoReadKey,
    DaoReadLike,
    DaoReadMessage,
    DaoReadPrivacy,
    DaoReadChatUnreadMessagesCount,

    // Write

    // App
    DaoWriteApp,
    DaoWriteAppNotificationSettings,
    // Common
    DaoWriteCommon,
    DaoWriteConfig,
    // Account
    DaoWriteAccount,
    DaoWriteLoginSession,
    // Media
    DaoWriteMedia,
    DaoWriteMyMedia,
    // Profile
    DaoWriteProfile,
    DaoWriteMyProfile,
    DaoWriteProfilePrivacy,
    DaoWriteSearch,
    // Chat
    DaoWriteBackup,
    DaoWriteConversationList,
    DaoWriteKey,
    DaoWriteLike,
    DaoWriteMessage,
    DaoWritePrivacy,
    DaoWriteChatUnreadMessagesCount,
  ],
)
class AccountDatabase extends _$AccountDatabase {
  AccountDatabase(QueryExcecutorProvider dbProvider) : super(dbProvider.getQueryExcecutor());

  AccountDatabaseRead get read => AccountDatabaseRead(this);
  AccountDatabaseWrite get write => AccountDatabaseWrite(this);

  @override
  int get schemaVersion => 1;
}

class AccountDatabaseRead {
  final AccountDatabase db;
  AccountDatabaseRead(this.db);
  // App
  DaoReadApp get app => db.daoReadApp;
  DaoReadAppNotificationSettings get appNotificationSettings => db.daoReadAppNotificationSettings;
  // Common
  DaoReadCommon get common => db.daoReadCommon;
  DaoReadConfig get config => db.daoReadConfig;
  // Account
  DaoReadAccount get account => db.daoReadAccount;
  DaoReadLoginSession get loginSession => db.daoReadLoginSession;
  // Media
  DaoReadMedia get media => db.daoReadMedia;
  DaoReadMyMedia get myMedia => db.daoReadMyMedia;
  // Profile
  DaoReadProfile get profile => db.daoReadProfile;
  DaoReadMyProfile get myProfile => db.daoReadMyProfile;
  DaoReadProfilePrivacy get profilePrivacy => db.daoReadProfilePrivacy;
  DaoReadSearch get search => db.daoReadSearch;
  // Chat
  DaoReadBackup get backup => db.daoReadBackup;
  DaoReadConversationList get conversationList => db.daoReadConversationList;
  DaoReadKey get key => db.daoReadKey;
  DaoReadLike get like => db.daoReadLike;
  DaoReadMessage get message => db.daoReadMessage;
  DaoReadPrivacy get privacy => db.daoReadPrivacy;
  DaoReadChatUnreadMessagesCount get chatUnreadMessagesCount => db.daoReadChatUnreadMessagesCount;
}

class AccountDatabaseWrite {
  final AccountDatabase db;
  AccountDatabaseWrite(this.db);
  // App
  DaoWriteApp get app => db.daoWriteApp;
  DaoWriteAppNotificationSettings get appNotificationSettings => db.daoWriteAppNotificationSettings;
  // Common
  DaoWriteCommon get common => db.daoWriteCommon;
  DaoWriteConfig get config => db.daoWriteConfig;
  // Account
  DaoWriteAccount get account => db.daoWriteAccount;
  DaoWriteLoginSession get loginSession => db.daoWriteLoginSession;
  // Media
  DaoWriteMedia get media => db.daoWriteMedia;
  DaoWriteMyMedia get myMedia => db.daoWriteMyMedia;
  // Profile
  DaoWriteProfile get profile => db.daoWriteProfile;
  DaoWriteMyProfile get myProfile => db.daoWriteMyProfile;
  DaoWriteProfilePrivacy get profilePrivacy => db.daoWriteProfilePrivacy;
  DaoWriteSearch get search => db.daoWriteSearch;
  // Chat
  DaoWriteBackup get backup => db.daoWriteBackup;
  DaoWriteConversationList get conversationList => db.daoWriteConversationList;
  DaoWriteKey get key => db.daoWriteKey;
  DaoWriteLike get like => db.daoWriteLike;
  DaoWriteMessage get message => db.daoWriteMessage;
  DaoWritePrivacy get privacy => db.daoWritePrivacy;
  DaoWriteChatUnreadMessagesCount get chatUnreadMessagesCount => db.daoWriteChatUnreadMessagesCount;
}
