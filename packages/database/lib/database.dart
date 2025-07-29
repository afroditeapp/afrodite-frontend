/// Drift code generation related parts of app database code.
library;

export 'src/background/profile_table.dart' show DaoProfilesBackground;
export 'src/background/common_database.dart' show CommonBackgroundDatabase;
export 'src/background/account_database.dart' show AccountBackgroundDatabase;

export 'src/foreground/account/dao_current_content.dart' show PrimaryProfileContent;
export 'src/foreground/profile_table.dart' show DaoProfiles;
export 'src/foreground/message_table.dart' show DaoMessageTable;
export 'src/foreground/common_database.dart' show CommonDatabase, NOTIFICATION_PERMISSION_ASKED_DEFAULT;
export 'src/foreground/account_database.dart' show AccountDatabase, PROFILE_FILTER_FAVORITES_DEFAULT;

export 'src/model/app.dart' show GridSettings;
export 'src/model/chat.dart' show MessageEntry, MessageState, SentMessageState, ReceivedMessageState, InfoMessageState, LocalMessageId, UnreadMessagesCount;
export 'src/model/profile.dart' show MyProfileEntry, ProfileEntry, ProfileLocalDbId, ProfileTitle, InitialAgeInfo, AvailableAges, AutomaticAgeChangeInfo, ProfileAttributeAndHash, ProfileAttributes, ProfileThumbnail;
export 'src/model/account.dart' show AccountState, AccountStateContainerToAccountState;
export 'src/model/media.dart' show MyContent, ContentIdAndAccepted;
export 'src/model/common.dart' show ServerMaintenanceInfo;
export 'src/model/chat.dart' show PrivateKeyData, PublicKeyData, AllKeyData, ForeignPublicKey;
export 'src/model/chat/message.dart' show Message, u16ToLittleEndianBytes, TextMessage, VideoCallInvitation, UnsupportedMessage;

export 'src/utils.dart' show QueryExcecutorProvider, DbFile, CommonDbFile, CommonBackgroundDbFile, AccountDbFile, AccountBackgroundDbFile;
