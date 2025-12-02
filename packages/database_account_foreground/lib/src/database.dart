import 'package:database_account_foreground/src/read/account/account.dart';
import 'package:database_account_foreground/src/read/chat/conversation_list.dart';
import 'package:database_account_foreground/src/read/chat/key.dart';
import 'package:database_account_foreground/src/read/chat/like.dart';
import 'package:database_account_foreground/src/read/chat/message.dart';
import 'package:database_account_foreground/src/read/chat/privacy.dart';
import 'package:database_account_foreground/src/read/common/config.dart';
import 'package:database_account_foreground/src/read/account/login_session.dart';
import 'package:database_account_foreground/src/read/app.dart';
import 'package:database_account_foreground/src/read/common/common.dart';
import 'package:database_account_foreground/src/read/media/media.dart';
import 'package:database_account_foreground/src/read/media/my_media.dart';
import 'package:database_account_foreground/src/read/profile/my_profile.dart';
import 'package:database_account_foreground/src/read/profile/profile.dart';
import 'package:database_account_foreground/src/read/profile/search.dart';
import 'package:database_account_foreground/src/write/account/account.dart';
import 'package:database_account_foreground/src/write/chat/conversation_list.dart';
import 'package:database_account_foreground/src/write/chat/key.dart';
import 'package:database_account_foreground/src/write/chat/like.dart';
import 'package:database_account_foreground/src/write/chat/message.dart';
import 'package:database_account_foreground/src/write/chat/privacy.dart';
import 'package:database_account_foreground/src/write/common/config.dart';
import 'package:database_account_foreground/src/write/account/login_session.dart';
import 'package:database_account_foreground/src/write/app.dart';
import 'package:database_account_foreground/src/write/common/common.dart';
import 'package:database_account_foreground/src/write/media/media.dart';
import 'package:database_account_foreground/src/write/media/my_media.dart';
import 'package:database_account_foreground/src/write/profile/my_profile.dart';
import 'package:database_account_foreground/src/write/profile/profile.dart';
import 'package:database_account_foreground/src/write/profile/search.dart';
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
    schema.GridSettings,
    // Common
    schema.ServerMaintenance,
    schema.SyncVersion,
    schema.ReceivedLikesIteratorState,
    schema.ClientFeaturesConfig,
    schema.CustomReportsConfig,
    schema.ProfileAttributesConfig,
    schema.ProfileAttributesConfigAttributes,
    schema.ClientLanguageOnServer,
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
    // Chat
    schema.MyKeyPair,
    schema.PublicKey,
    schema.ConversationList,
    schema.DailyLikesLeft,
    schema.ChatPrivacySettings,
    schema.Message,
  ],
  daos: [
    // Read

    // App
    DaoReadApp,
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
    DaoReadSearch,
    // Chat
    DaoReadConversationList,
    DaoReadKey,
    DaoReadLike,
    DaoReadMessage,
    DaoReadPrivacy,

    // Write

    // App
    DaoWriteApp,
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
    DaoWriteSearch,
    // Chat
    DaoWriteConversationList,
    DaoWriteKey,
    DaoWriteLike,
    DaoWriteMessage,
    DaoWritePrivacy,
  ],
)
class AccountForegroundDatabase extends _$AccountForegroundDatabase {
  AccountForegroundDatabase(QueryExcecutorProvider dbProvider)
    : super(dbProvider.getQueryExcecutor());

  AccountForegroundDatabaseRead get read => AccountForegroundDatabaseRead(this);
  AccountForegroundDatabaseWrite get write => AccountForegroundDatabaseWrite(this);

  @override
  int get schemaVersion => 1;
}

class AccountForegroundDatabaseRead {
  final AccountForegroundDatabase db;
  AccountForegroundDatabaseRead(this.db);
  // App
  DaoReadApp get app => db.daoReadApp;
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
  DaoReadSearch get search => db.daoReadSearch;
  // Chat
  DaoReadConversationList get conversationList => db.daoReadConversationList;
  DaoReadKey get key => db.daoReadKey;
  DaoReadLike get like => db.daoReadLike;
  DaoReadMessage get message => db.daoReadMessage;
  DaoReadPrivacy get privacy => db.daoReadPrivacy;
}

class AccountForegroundDatabaseWrite {
  final AccountForegroundDatabase db;
  AccountForegroundDatabaseWrite(this.db);
  // App
  DaoWriteApp get app => db.daoWriteApp;
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
  DaoWriteSearch get search => db.daoWriteSearch;
  // Chat
  DaoWriteConversationList get conversationList => db.daoWriteConversationList;
  DaoWriteKey get key => db.daoWriteKey;
  DaoWriteLike get like => db.daoWriteLike;
  DaoWriteMessage get message => db.daoWriteMessage;
  DaoWritePrivacy get privacy => db.daoWritePrivacy;
}
