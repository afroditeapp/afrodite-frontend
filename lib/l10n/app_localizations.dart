import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_sv.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('fi'), Locale('sv')];

  /// Text for app publisher info
  ///
  /// In en, this message translates to:
  /// **'Publisher: {p0}'**
  String about_dialog_app_publisher(String p0);

  /// Text for Git commit ID
  ///
  /// In en, this message translates to:
  /// **'Version ID: {p0}'**
  String about_dialog_git_commit_id(String p0);

  /// Text for account ban reason
  ///
  /// In en, this message translates to:
  /// **'Ban reason: {p0}'**
  String account_banned_screen_ban_reason(String p0);

  /// Time when account unban process will begin
  ///
  /// In en, this message translates to:
  /// **'Account automatic unban process begins at {p0}'**
  String account_banned_screen_time_text(String p0);

  /// Title for account banned screen
  ///
  /// In en, this message translates to:
  /// **'Account banned'**
  String get account_banned_screen_title;

  /// Time when account deletion process will begin
  ///
  /// In en, this message translates to:
  /// **'Account automatic deletion process begins at {p0}'**
  String account_deletion_pending_screen_time_text(String p0);

  /// Title for account deletion pending screen
  ///
  /// In en, this message translates to:
  /// **'Account deletion pending'**
  String get account_deletion_pending_screen_title;

  /// Button text for cancel email change action
  ///
  /// In en, this message translates to:
  /// **'Cancel email change'**
  String get account_settings_screen_cancel_email_change_button;

  /// Title for cancel email change confirm dialog
  ///
  /// In en, this message translates to:
  /// **'Cancel email change?'**
  String get account_settings_screen_cancel_email_change_confirm_dialog_title;

  /// Button text for change email action
  ///
  /// In en, this message translates to:
  /// **'Change email'**
  String get account_settings_screen_change_email_button;

  /// Hint text for new email input
  ///
  /// In en, this message translates to:
  /// **'Enter new email address'**
  String get account_settings_screen_change_email_dialog_hint;

  /// Title for change email dialog
  ///
  /// In en, this message translates to:
  /// **'Change email address'**
  String get account_settings_screen_change_email_dialog_title;

  /// Title for delete account action
  ///
  /// In en, this message translates to:
  /// **'Request account deletion'**
  String get account_settings_screen_delete_account_action;

  /// Snackbar text about delete account action failure
  ///
  /// In en, this message translates to:
  /// **'Requesting account deletion failed'**
  String get account_settings_screen_delete_account_action_error;

  /// Title for delete account confirm dialog title
  ///
  /// In en, this message translates to:
  /// **'Request account deletion?'**
  String get account_settings_screen_delete_account_confirm_dialog_title;

  /// Snackbar text for successful email change cancellation
  ///
  /// In en, this message translates to:
  /// **'Email change cancelled'**
  String get account_settings_screen_email_change_cancelled;

  /// Snackbar text for successful email change initiation
  ///
  /// In en, this message translates to:
  /// **'Email change initiated. Please check your email.'**
  String get account_settings_screen_email_change_initiated;

  /// Text for not verified email status
  ///
  /// In en, this message translates to:
  /// **'Email not verified'**
  String get account_settings_screen_email_not_verified;

  /// Title for email text
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get account_settings_screen_email_title;

  /// Text for verified email status
  ///
  /// In en, this message translates to:
  /// **'Email verified'**
  String get account_settings_screen_email_verified;

  /// Text for email change completion time
  ///
  /// In en, this message translates to:
  /// **'Email change completes at: {p0}'**
  String account_settings_screen_pending_email_completion_time(String p0);

  /// Text for not verified pending email status
  ///
  /// In en, this message translates to:
  /// **'Pending email not verified'**
  String get account_settings_screen_pending_email_not_verified;

  /// Title for pending new email text
  ///
  /// In en, this message translates to:
  /// **'Pending new email address'**
  String get account_settings_screen_pending_email_title;

  /// Text for verified pending email status
  ///
  /// In en, this message translates to:
  /// **'Pending email verified'**
  String get account_settings_screen_pending_email_verified;

  /// Snackbar text when email is already verified
  ///
  /// In en, this message translates to:
  /// **'Email is already verified'**
  String get account_settings_screen_send_verification_email_already_verified;

  /// Button text for send verification email action
  ///
  /// In en, this message translates to:
  /// **'Send verification email'**
  String get account_settings_screen_send_verification_email_button;

  /// Snackbar text for successful email verification sending
  ///
  /// In en, this message translates to:
  /// **'Verification email sent successfully'**
  String get account_settings_screen_send_verification_email_sent_successfully;

  /// Title for account settings
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account_settings_screen_title;

  /// Title for admin settings screen
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin_settings_title;

  /// Title for app bar action which opens about dialog
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get app_bar_action_about;

  /// About dialog legalese
  ///
  /// In en, this message translates to:
  /// **''**
  String get app_legalese;

  /// Name for the app
  ///
  /// In en, this message translates to:
  /// **'Afrodite'**
  String get app_name;

  /// Publisher for the app
  ///
  /// In en, this message translates to:
  /// **''**
  String get app_publisher;

  /// Slogan for the app
  ///
  /// In en, this message translates to:
  /// **'Dating app'**
  String get app_slogan;

  /// Description text displayed when no profiles are found
  ///
  /// In en, this message translates to:
  /// **'You will be notified when this changes'**
  String get automatic_profile_search_results_screen_no_profiles_found_description;

  /// Title text displayed when no profiles are found
  ///
  /// In en, this message translates to:
  /// **'No new or updated profiles found'**
  String get automatic_profile_search_results_screen_no_profiles_found_title;

  /// Title for automatic profile search results screen
  ///
  /// In en, this message translates to:
  /// **'New and updated profiles'**
  String get automatic_profile_search_results_screen_title;

  /// Info text displayed when there is no blocked profiles
  ///
  /// In en, this message translates to:
  /// **'No blocked profiles'**
  String get blocked_profiles_screen_no_blocked_profiles;

  /// Placeholder text for private profile
  ///
  /// In en, this message translates to:
  /// **'Private profile'**
  String get blocked_profiles_screen_placeholder_for_private_profile;

  /// Title for blocked profiles screen
  ///
  /// In en, this message translates to:
  /// **'Blocked profiles'**
  String get blocked_profiles_screen_title;

  /// Description for unblock profile dialog
  ///
  /// In en, this message translates to:
  /// **'Unblock {p0}'**
  String blocked_profiles_screen_unblock_profile_dialog_description(String p0);

  /// Title for unblock profile dialog
  ///
  /// In en, this message translates to:
  /// **'Unblock profile?'**
  String get blocked_profiles_screen_unblock_profile_dialog_title;

  /// Snackbar text displayed when profile unblocking failed
  ///
  /// In en, this message translates to:
  /// **'Unblock failed'**
  String get blocked_profiles_screen_unblock_profile_failed;

  /// Snackbar text displayed when profile unblocking failed
  ///
  /// In en, this message translates to:
  /// **'Previous unblock is in progress'**
  String get blocked_profiles_screen_unblock_profile_in_progress;

  /// Snackbar text displayed when profile unblocking was successful
  ///
  /// In en, this message translates to:
  /// **'Unblock successful'**
  String get blocked_profiles_screen_unblock_profile_successful;

  /// Error text displayed when camera access is restricted
  ///
  /// In en, this message translates to:
  /// **'Camera access is restricted. Opening camera is not possible.'**
  String get camera_screen_camera_access_restricted_error;

  /// Error text displayed when camera initialization fails
  ///
  /// In en, this message translates to:
  /// **'Camera initialization failed'**
  String get camera_screen_camera_initialization_error;

  /// Error text displayed when camera initialization fails and error code exists
  ///
  /// In en, this message translates to:
  /// **'Camera initialization failed. Error code: {p0}'**
  String camera_screen_camera_initialization_error_with_error_code(String p0);

  /// Snackbar error text displayed when user tries to open camera but camera initialization is already in progress
  ///
  /// In en, this message translates to:
  /// **'Camera opening in progress'**
  String get camera_screen_camera_opening_already_in_progress_error;

  /// Error text displayed when there is no camera permission and system settings must be used for granting the permission
  ///
  /// In en, this message translates to:
  /// **'No camera permission. Please grant the camera permission from system settings.'**
  String get camera_screen_camera_permission_error_check_settings;

  /// Error text displayed when there is no camera permission
  ///
  /// In en, this message translates to:
  /// **'No camera permission. Please try again. If that will not work then grant the camera permission from system settings.'**
  String get camera_screen_camera_permission_error_try_again_or_check_settings;

  /// Error text displayed when there is no front camera available
  ///
  /// In en, this message translates to:
  /// **'No front camera available'**
  String get camera_screen_no_front_camera_error;

  /// Snackbar error text displayed when taking photo fails
  ///
  /// In en, this message translates to:
  /// **'Taking photo failed'**
  String get camera_screen_take_photo_error;

  /// Status text when connecting to transfer API
  ///
  /// In en, this message translates to:
  /// **'Connecting…'**
  String get chat_backup_connecting;

  /// Error message when data stream version is not supported
  ///
  /// In en, this message translates to:
  /// **'Unsupported data stream'**
  String get chat_backup_data_stream_unsupported;

  /// Error message when database for requested account does not exist
  ///
  /// In en, this message translates to:
  /// **'Database for requested account does not exist'**
  String get chat_backup_database_not_found;

  /// Error message when pairing code format is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid pairing code'**
  String get chat_backup_pairing_code_invalid;

  /// Label for pairing code
  ///
  /// In en, this message translates to:
  /// **'Device pairing code'**
  String get chat_backup_pairing_code_label;

  /// Error message when pairing code version is not supported
  ///
  /// In en, this message translates to:
  /// **'Unsupported pairing code version'**
  String get chat_backup_pairing_code_unsupported;

  /// Message when no backup has been created
  ///
  /// In en, this message translates to:
  /// **'Chat backup is not yet created. Backup now?'**
  String get chat_backup_reminder_dialog_message_no_backup;

  /// Message when backup is old
  ///
  /// In en, this message translates to:
  /// **'Chat backup has not been created since {p0} days. Backup now?'**
  String chat_backup_reminder_dialog_message_old_backup(String p0);

  /// Title for backup reminder dialog
  ///
  /// In en, this message translates to:
  /// **'Chat backup'**
  String get chat_backup_reminder_dialog_title;

  /// Label for backup reminder interval in singular day
  ///
  /// In en, this message translates to:
  /// **'Every day'**
  String get chat_backup_screen_backup_reminder_interval_day;

  /// Label for backup reminder interval in plural days
  ///
  /// In en, this message translates to:
  /// **'Every {p0} days'**
  String chat_backup_screen_backup_reminder_interval_days(String p0);

  /// Confirmation dialog for creating chat backup
  ///
  /// In en, this message translates to:
  /// **'Create chat backup?'**
  String get chat_backup_screen_create_backup_question;

  /// Details for create backup confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Backup includes current messages and encryption key.'**
  String get chat_backup_screen_create_backup_question_details;

  /// Confirmation dialog for importing chat backup
  ///
  /// In en, this message translates to:
  /// **'Import chat backup?'**
  String get chat_backup_screen_import_backup_question;

  /// Details for import backup confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'File: {p0}\n\nCurrent and backup messages will be merged. Current encryption key will be replaced if the one included in the backup is newer.'**
  String chat_backup_screen_import_backup_question_details(String p0);

  /// Error message when backup file is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid backup file'**
  String get chat_backup_screen_import_error_invalid_backup_file;

  /// Error message when backup file version is unsupported
  ///
  /// In en, this message translates to:
  /// **'Unsupported backup version'**
  String get chat_backup_screen_import_error_unsupported_version;

  /// Error message when backup was created by different account
  ///
  /// In en, this message translates to:
  /// **'Backup created by different account'**
  String get chat_backup_screen_import_error_wrong_account;

  /// Title for chat backup screen
  ///
  /// In en, this message translates to:
  /// **'Chat backup'**
  String get chat_backup_screen_title;

  /// Error message when transfer budget is exceeded
  ///
  /// In en, this message translates to:
  /// **'Yearly chat backup transfer budget exceeded. Please create a backup and transfer it manually.'**
  String get chat_backup_transfer_budget_exceeded;

  /// Description for chat data outdated state
  ///
  /// In en, this message translates to:
  /// **'Device changed or app reinstalled. Receive chat backup from previous device?'**
  String get chat_data_outdated_description;

  /// Error when too many public keys
  ///
  /// In en, this message translates to:
  /// **'Maximum number of encryption keys reached. Receive backup from previous device or contact service admins.'**
  String get chat_data_outdated_error_too_many_keys;

  /// Warning dialog message when public key adding fails because pending messages exists
  ///
  /// In en, this message translates to:
  /// **'You have unread messages encrypted using your old encryption key. If you continue, you can\'t read the messages. Continue?'**
  String get chat_data_outdated_pending_messages_warning;

  /// Button text to receive chat backup
  ///
  /// In en, this message translates to:
  /// **'Receive backup'**
  String get chat_data_outdated_receive_backup;

  /// Title for chat data outdated state
  ///
  /// In en, this message translates to:
  /// **'Chat data outdated'**
  String get chat_data_outdated_title;

  /// Info text displayed when there is no chats
  ///
  /// In en, this message translates to:
  /// **'No chats found'**
  String get chat_list_screen_no_chats_found;

  /// Description text displayed when there is no chats
  ///
  /// In en, this message translates to:
  /// **'Spread the word about the app in social media'**
  String get chat_list_screen_no_chats_found_description;

  /// Info text displayed when no matches are found
  ///
  /// In en, this message translates to:
  /// **'No accepted chat requests found'**
  String get chat_list_screen_no_matches_found;

  /// Title for action which opens matches screen
  ///
  /// In en, this message translates to:
  /// **'Accepted chat requests'**
  String get chat_list_screen_open_matches_screen_action;

  /// Title for conversation item which does not have profile available
  ///
  /// In en, this message translates to:
  /// **'Profile not available'**
  String get chat_list_screen_profile_not_available;

  /// Text indicating that the message is a sent message.
  ///
  /// In en, this message translates to:
  /// **'You: {p0}'**
  String chat_list_screen_sent_message_indicator(String p0);

  /// Title for chat list screen
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get chat_list_screen_title;

  /// Conversation status text for unread message
  ///
  /// In en, this message translates to:
  /// **'New message'**
  String get chat_list_screen_unread_message;

  /// Text for content deletion allowed wait time
  ///
  /// In en, this message translates to:
  /// **'Deletion possible starting at {p0}'**
  String content_management_screen_content_deletion_allowed_wait_time(String p0);

  /// Text for profile content
  ///
  /// In en, this message translates to:
  /// **'Profile image {p0}'**
  String content_management_screen_content_profile_content(String p0);

  /// Text for security content
  ///
  /// In en, this message translates to:
  /// **'Security selfie'**
  String get content_management_screen_content_security_content;

  /// Title for content management screen
  ///
  /// In en, this message translates to:
  /// **'My images'**
  String get content_management_screen_title;

  /// Message input text field placeholder text
  ///
  /// In en, this message translates to:
  /// **'Type a message…'**
  String get conversation_screen_chat_box_placeholder_text;

  /// Description text for install Jitsi Meet dialog when app is running on Android
  ///
  /// In en, this message translates to:
  /// **'Video calling requires Jitsi Meet video calling app which is not installed currently. Install the app from Google Play Store? After that, try this again.'**
  String get conversation_screen_install_jitsi_meet_dialog_description_android;

  /// Description text for install Jitsi Meet dialog when app is running on iOS
  ///
  /// In en, this message translates to:
  /// **'Video calling requires Jitsi Meet video calling app which is not installed currently. Install the app from App Store? After that, try this again.'**
  String get conversation_screen_install_jitsi_meet_dialog_description_ios;

  /// Title for install Jitsi Meet dialog
  ///
  /// In en, this message translates to:
  /// **'Install Jitsi Meet?'**
  String get conversation_screen_install_jitsi_meet_dialog_title;

  /// Button text for joining a video call
  ///
  /// In en, this message translates to:
  /// **'Join video call'**
  String get conversation_screen_join_video_call_button;

  /// Title text for join video call confirm dialog
  ///
  /// In en, this message translates to:
  /// **'Join video call?'**
  String get conversation_screen_join_video_call_dialog_title;

  /// Instruction text how to make a match
  ///
  /// In en, this message translates to:
  /// **'Send a message to accept the chat request!'**
  String get conversation_screen_make_match_instruction;

  /// Title text for message ID value
  ///
  /// In en, this message translates to:
  /// **'Message ID'**
  String get conversation_screen_message_details_message_id;

  /// Message remove or resend error that message is actually sent successfully
  ///
  /// In en, this message translates to:
  /// **'The message is actually sent successfully'**
  String get conversation_screen_message_error_is_actually_sent_successfully;

  /// Message send or resend error that receiver blocked sender or receiver not found
  ///
  /// In en, this message translates to:
  /// **'Receiver action prevented message sending'**
  String get conversation_screen_message_error_receiver_blocked_sender_or_receiver_not_found;

  /// Info text that encryption key changed
  ///
  /// In en, this message translates to:
  /// **'Encryption key changed'**
  String get conversation_screen_message_info_encryption_key_changed;

  /// Info text that messages in this conversation are end-to-end encrypted
  ///
  /// In en, this message translates to:
  /// **'Messages are end-to-end encrypted'**
  String get conversation_screen_message_info_encryption_started;

  /// Info text that message list is empty
  ///
  /// In en, this message translates to:
  /// **'No messages'**
  String get conversation_screen_message_list_empty;

  /// Message text that referenced message was not found
  ///
  /// In en, this message translates to:
  /// **'Message not found'**
  String get conversation_screen_message_not_found;

  /// Message state text that message decrypting failed
  ///
  /// In en, this message translates to:
  /// **'Decrypting failed'**
  String get conversation_screen_message_state_decrypting_failed;

  /// Message state text that message was delivered to receiver
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get conversation_screen_message_state_delivered;

  /// Message state text that message delivery failed
  ///
  /// In en, this message translates to:
  /// **'Delivery failed'**
  String get conversation_screen_message_state_delivery_failed;

  /// Message state text that public key download failed
  ///
  /// In en, this message translates to:
  /// **'Public key download failed'**
  String get conversation_screen_message_state_public_key_download_failed;

  /// Message state text that message was received and marked as seen
  ///
  /// In en, this message translates to:
  /// **'Received and seen'**
  String get conversation_screen_message_state_received_and_seen;

  /// Message state text that message was received and marked as seen locally
  ///
  /// In en, this message translates to:
  /// **'Received and seen locally'**
  String get conversation_screen_message_state_received_and_seen_locally;

  /// Message state text that message was received successfully
  ///
  /// In en, this message translates to:
  /// **'Received successfully'**
  String get conversation_screen_message_state_received_successfully;

  /// Message state text that message was seen by receiver
  ///
  /// In en, this message translates to:
  /// **'Seen'**
  String get conversation_screen_message_state_seen;

  /// Message state text that message sending failed
  ///
  /// In en, this message translates to:
  /// **'Sending failed'**
  String get conversation_screen_message_state_sending_failed;

  /// Message state text that message sending is in progress
  ///
  /// In en, this message translates to:
  /// **'Sending in progress'**
  String get conversation_screen_message_state_sending_in_progress;

  /// Message state text that message was sent successfully
  ///
  /// In en, this message translates to:
  /// **'Sent successfully'**
  String get conversation_screen_message_state_sent_successfully;

  /// Snackbar text that message is too long
  ///
  /// In en, this message translates to:
  /// **'Message is too long'**
  String get conversation_screen_message_too_long;

  /// Snackbar text that server is full of pending messages
  ///
  /// In en, this message translates to:
  /// **'Server pending message storage is full'**
  String get conversation_screen_message_too_many_pending_messages;

  /// Message text that message is unsupported
  ///
  /// In en, this message translates to:
  /// **'Unsupported message'**
  String get conversation_screen_message_unsupported;

  /// Action subtitle for open details action
  ///
  /// In en, this message translates to:
  /// **'Contains selectable text'**
  String get conversation_screen_open_details_action_subtitle;

  /// Snackbar text displayed when profile blocking is successful
  ///
  /// In en, this message translates to:
  /// **'Profile was blocked'**
  String get conversation_screen_profile_blocked;

  /// Snackbar text showing remaining daily messages count
  ///
  /// In en, this message translates to:
  /// **'Remaining daily messages: {p0}'**
  String conversation_screen_remaining_daily_messages(String p0);

  /// Action text for send video call invitation action
  ///
  /// In en, this message translates to:
  /// **'Send video call invitation'**
  String get conversation_screen_send_video_call_invitation_action;

  /// Title text for send video call invitation dialog
  ///
  /// In en, this message translates to:
  /// **'Send video call invitation?'**
  String get conversation_screen_send_video_call_invitation_dialog_title;

  /// Title for crop image screen
  ///
  /// In en, this message translates to:
  /// **'Crop image'**
  String get crop_image_screen_title;

  /// Snackbar text displayed when security selfie is changed
  ///
  /// In en, this message translates to:
  /// **'Security selfie changed'**
  String get current_security_selfie_screen_security_selfie_changed;

  /// Current security selfie screen title
  ///
  /// In en, this message translates to:
  /// **'Security selfie'**
  String get current_security_selfie_screen_title;

  /// Snackbar text for API limit error
  ///
  /// In en, this message translates to:
  /// **'Try again after 24 hours'**
  String get data_export_screen_api_limit_error;

  /// Title for data export screen when export type is admin
  ///
  /// In en, this message translates to:
  /// **'Data export'**
  String get data_export_screen_title_export_type_admin;

  /// Title for data export screen when export type is user
  ///
  /// In en, this message translates to:
  /// **'Download my data'**
  String get data_export_screen_title_export_type_user;

  /// Dialog title text for confirming logout from demo account
  ///
  /// In en, this message translates to:
  /// **'Logout?'**
  String get demo_account_screen_confirm_logout_dialog_title;

  /// Dialog title text for confirming login to some account
  ///
  /// In en, this message translates to:
  /// **'Login to account?'**
  String get demo_account_screen_login_to_account_dialog_title;

  /// Snackbar text for max account count error
  ///
  /// In en, this message translates to:
  /// **'Error: max account count'**
  String get demo_account_screen_max_account_count_error;

  /// Text for action which creates a new account
  ///
  /// In en, this message translates to:
  /// **'New account'**
  String get demo_account_screen_new_account_action;

  ///
  ///
  /// In en, this message translates to:
  /// **'Create new account and login to it?'**
  String get demo_account_screen_new_account_dialog_description;

  /// Text displayed when available accounts list is empty
  ///
  /// In en, this message translates to:
  /// **'No accounts available'**
  String get demo_account_screen_no_accounts_available;

  /// Title for require all wanted values setting
  ///
  /// In en, this message translates to:
  /// **'Require all wanted values'**
  String get edit_attribute_filter_value_screen_require_all_wanted_values;

  /// Attribute value search box placeholder text
  ///
  /// In en, this message translates to:
  /// **'Search…'**
  String get edit_attribute_filter_value_screen_search_placeholder_text;

  /// Show advanced filters action
  ///
  /// In en, this message translates to:
  /// **'Advanced filters'**
  String get edit_attribute_filter_value_screen_show_advanced_filters_action;

  /// Show basic filters action
  ///
  /// In en, this message translates to:
  /// **'Basic filters'**
  String get edit_attribute_filter_value_screen_show_basic_filters_action;

  /// Title for edit attribute filter screen
  ///
  /// In en, this message translates to:
  /// **'Edit filter'**
  String get edit_attribute_filter_value_screen_title;

  /// Snackbar text for max selected values error
  ///
  /// In en, this message translates to:
  /// **'Too many selected values'**
  String get edit_attribute_value_screen_max_selected_values_error;

  /// Snackbar text for notifying that one at least one option must be selected
  ///
  /// In en, this message translates to:
  /// **'At least one selection is required'**
  String get edit_attribute_value_screen_one_value_must_be_selected;

  /// Attribute value search box placeholder text
  ///
  /// In en, this message translates to:
  /// **'Search…'**
  String get edit_attribute_value_screen_search_placeholder_text;

  /// Title for gender setting
  ///
  /// In en, this message translates to:
  /// **'My profile\'s gender'**
  String get edit_my_gender_screen_gender_setting_title;

  /// Dialog text for notifying user when profile age min value is incremented
  ///
  /// In en, this message translates to:
  /// **'Min age will be increased to {p0} in {p1}'**
  String edit_profile_screen_automatic_min_age_incrementing_info_dialog_text(String p0, String p1);

  /// Snackbar text for notifying about invalid age
  ///
  /// In en, this message translates to:
  /// **'Invalid age'**
  String get edit_profile_screen_invalid_age;

  /// Snackbar text for notifying about invalid profile name
  ///
  /// In en, this message translates to:
  /// **'Invalid first name'**
  String get edit_profile_screen_invalid_profile_name;

  /// Snackbar text for notifying about that one profile image is required
  ///
  /// In en, this message translates to:
  /// **'One profile image is required'**
  String get edit_profile_screen_one_profile_image_required;

  /// Info text that primary profile image is not accepted
  ///
  /// In en, this message translates to:
  /// **'Picture is not currently accepted by moderators. Your profile will not be shown in profile grid until the picture is accepted.'**
  String get edit_profile_screen_primary_profile_content_not_accepted;

  /// Title for profile name text field
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get edit_profile_screen_profile_name;

  /// Description for profile name text field
  ///
  /// In en, this message translates to:
  /// **'Changing first name is possible only before it is accepted by moderators.'**
  String get edit_profile_screen_profile_name_description;

  /// Title for profile text field
  ///
  /// In en, this message translates to:
  /// **'Profile text'**
  String get edit_profile_screen_profile_text;

  /// Title for edit profile screen
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get edit_profile_screen_title;

  /// Title for unlimited likes setting
  ///
  /// In en, this message translates to:
  /// **'Up for a date today'**
  String get edit_profile_screen_unlimited_likes;

  /// Description for unlimited likes setting when it is enabled and automatic disabling is enabled
  ///
  /// In en, this message translates to:
  /// **'Turns off at {p0}'**
  String edit_profile_screen_unlimited_likes_description_enabled_and_automatic_disabling(String p0);

  /// Dialog text for notifying user when profile text is too long
  ///
  /// In en, this message translates to:
  /// **'Profile text byte count is more than 2000 bytes'**
  String get edit_profile_text_screen_text_length_too_long;

  /// Hint text for login code input field
  ///
  /// In en, this message translates to:
  /// **'Login code'**
  String get email_login_screen_code_hint;

  /// Help text for not receiving code
  ///
  /// In en, this message translates to:
  /// **'If you didn\'t receive the code:\n• Check your spam folder\n• Verify the email address is correct\n• Wait {p0} before requesting a new code\n• Make sure you have an existing account with this email'**
  String email_login_screen_didnt_receive_code(String p0);

  /// Hint text for email input field
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get email_login_screen_email_hint;

  /// Description for inputting login code
  ///
  /// In en, this message translates to:
  /// **'Enter the login code sent to {p0}'**
  String email_login_screen_input_code_description(String p0);

  /// Description for inputting email
  ///
  /// In en, this message translates to:
  /// **'Enter your email address to receive a login code. This works only for already existing accounts.'**
  String get email_login_screen_input_email_description;

  /// Button text for sending login code
  ///
  /// In en, this message translates to:
  /// **'Send login code'**
  String get email_login_screen_send_code_button;

  /// Title for email login screen
  ///
  /// In en, this message translates to:
  /// **'Email login'**
  String get email_login_screen_title;

  /// Text showing token validity time
  ///
  /// In en, this message translates to:
  /// **'Code expires in: {p0}'**
  String email_login_screen_token_validity(String p0);

  /// Title for email notification settings screen
  ///
  /// In en, this message translates to:
  /// **'Email notifications'**
  String get email_notification_settings_screen_title;

  /// Account ID text with value
  ///
  /// In en, this message translates to:
  /// **'Account ID: {p0}'**
  String generic_account_id_text_with_value(String p0);

  /// Snackbar text for account locked error
  ///
  /// In en, this message translates to:
  /// **'Account locked'**
  String get generic_account_locked_error;

  /// Generic action completed text
  ///
  /// In en, this message translates to:
  /// **'Action completed'**
  String get generic_action_completed;

  /// Generic age text
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get generic_age;

  /// Generic average text
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get generic_average;

  /// Generic cancel text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get generic_cancel;

  /// Generic cancel question
  ///
  /// In en, this message translates to:
  /// **'Cancel?'**
  String get generic_cancel_question;

  /// Generic close text
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get generic_close;

  /// Generic continue text
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get generic_continue;

  /// Generic message when text is copied to clipboard
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get generic_copied_to_clipboard;

  /// Generic copy text
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get generic_copy;

  /// Generic create text
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get generic_create;

  /// Generic data sync failed
  ///
  /// In en, this message translates to:
  /// **'Data sync failed'**
  String get generic_data_sync_failed;

  /// Generic delete text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get generic_delete;

  /// Generic delete question
  ///
  /// In en, this message translates to:
  /// **'Delete?'**
  String get generic_delete_question;

  /// Generic details text
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get generic_details;

  /// Generic disabled text
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get generic_disabled;

  /// Generic download text
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get generic_download;

  /// Generic download question
  ///
  /// In en, this message translates to:
  /// **'Download?'**
  String get generic_download_question;

  /// Generic edit text
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get generic_edit;

  /// Generic email sending failed text
  ///
  /// In en, this message translates to:
  /// **'Email sending failed'**
  String get generic_email_sending_failed;

  /// Generic email sending timeout text
  ///
  /// In en, this message translates to:
  /// **'Email sending timeout'**
  String get generic_email_sending_timeout;

  /// Generic empty text
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get generic_empty;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get generic_error;

  /// No description provided for @generic_error_app_version_is_unsupported.
  ///
  /// In en, this message translates to:
  /// **'Current app version is unsupported'**
  String get generic_error_app_version_is_unsupported;

  /// Generic error occurred text
  ///
  /// In en, this message translates to:
  /// **'Error occurred'**
  String get generic_error_occurred;

  /// Generic man gender text
  ///
  /// In en, this message translates to:
  /// **'Man'**
  String get generic_gender_man;

  /// Generic man gender text in plural form
  ///
  /// In en, this message translates to:
  /// **'Men'**
  String get generic_gender_man_plural;

  /// Generic non-binary gender text
  ///
  /// In en, this message translates to:
  /// **'Non-binary'**
  String get generic_gender_nonbinary;

  /// Generic non-binary gender text in plural form
  ///
  /// In en, this message translates to:
  /// **'Non-binaries'**
  String get generic_gender_nonbinary_plural;

  /// Generic woman gender text
  ///
  /// In en, this message translates to:
  /// **'Woman'**
  String get generic_gender_woman;

  /// Generic woman gender text in plural form
  ///
  /// In en, this message translates to:
  /// **'Women'**
  String get generic_gender_woman_plural;

  /// Generic import text
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get generic_import;

  /// Generic large size text
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get generic_large;

  /// Generic login text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get generic_login;

  /// Generic login progress dialog text
  ///
  /// In en, this message translates to:
  /// **'Login…'**
  String get generic_login_progress_dialog_text;

  /// Generic logout text
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get generic_logout;

  /// Generic logout confirmation title text
  ///
  /// In en, this message translates to:
  /// **'Logout?'**
  String get generic_logout_confirmation_title;

  /// Generic logout failed text
  ///
  /// In en, this message translates to:
  /// **'Logout failed'**
  String get generic_logout_failed;

  /// Generic margin text
  ///
  /// In en, this message translates to:
  /// **'Margin'**
  String get generic_margin;

  /// Generic max text
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get generic_max;

  /// Generic medium size text
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get generic_medium;

  /// Generic message text
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get generic_message;

  /// Generic min text
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get generic_min;

  /// Generic no text
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get generic_no;

  /// Generic not found text
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get generic_not_found;

  /// Generic OK text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get generic_ok;

  /// Generic preview noun text
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get generic_preview_noun;

  /// Generic previous action in progress text
  ///
  /// In en, this message translates to:
  /// **'Previous action is still in progress'**
  String get generic_previous_action_in_progress;

  /// Error text displayed when profile loading fails
  ///
  /// In en, this message translates to:
  /// **'Profile loading failed'**
  String get generic_profile_loading_failed;

  /// Generic receive text
  ///
  /// In en, this message translates to:
  /// **'Receive'**
  String get generic_receive;

  /// Generic refresh text
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get generic_refresh;

  /// Generic reject question
  ///
  /// In en, this message translates to:
  /// **'Reject?'**
  String get generic_reject_question;

  /// Generic remind text
  ///
  /// In en, this message translates to:
  /// **'Remind'**
  String get generic_remind;

  /// Generic resend text
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get generic_resend;

  /// Title for reset values to defaults action
  ///
  /// In en, this message translates to:
  /// **'Reset to default values'**
  String get generic_reset_to_defaults;

  /// Dialog title for confirming reseting values to defaults
  ///
  /// In en, this message translates to:
  /// **'Reset to default values?'**
  String get generic_reset_to_defaults_dialog_title;

  /// Generic restore text
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get generic_restore;

  /// Generic retry text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get generic_retry;

  /// Generic save text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get generic_save;

  /// Generic save confirmation title text
  ///
  /// In en, this message translates to:
  /// **'Save?'**
  String get generic_save_confirmation_title;

  /// Generic setting saved text
  ///
  /// In en, this message translates to:
  /// **'Setting saved'**
  String get generic_setting_saved;

  /// Generic show only selected text
  ///
  /// In en, this message translates to:
  /// **'Show only selected'**
  String get generic_show_only_selected;

  /// Generic size text
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get generic_size;

  /// Generic skip text
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get generic_skip;

  /// Generic small size text
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get generic_small;

  /// Generic state text
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get generic_state;

  /// Generic take photo text
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get generic_take_photo;

  /// Text field hint text for age
  ///
  /// In en, this message translates to:
  /// **'Insert an age between 18–99'**
  String get generic_text_field_age_hint_text;

  /// Generic this feature is disabled text
  ///
  /// In en, this message translates to:
  /// **'This feature is disabled'**
  String get generic_this_feature_is_disabled;

  /// Generic time text
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get generic_time;

  /// Generic today text
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get generic_today;

  /// Generic try again text
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get generic_try_again;

  /// Generic try again later with seconds text
  ///
  /// In en, this message translates to:
  /// **'Try again after {p0} seconds'**
  String generic_try_again_later_seconds(String p0);

  /// Generic unlimited text
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get generic_unlimited;

  /// Generic warning message
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get generic_warning;

  /// Generic short text for Friday
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get generic_weekday_fri;

  /// Generic short text for Monday
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get generic_weekday_mon;

  /// Generic short text for Saturday
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get generic_weekday_sat;

  /// Generic short text for Sunday
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get generic_weekday_sun;

  /// Generic short text for Thursday
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get generic_weekday_thu;

  /// Generic short text for Tuesday
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get generic_weekday_tue;

  /// Generic short text for Wednesday
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get generic_weekday_wed;

  /// Generic yes text
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get generic_yes;

  /// Generic yesterday text
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get generic_yesterday;

  /// Generic you text
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get generic_you;

  /// Dialog title for confirming new image
  ///
  /// In en, this message translates to:
  /// **'Continue with this photo?'**
  String get image_processing_ui_confirm_photo_dialog_title;

  /// Progress dialog info text that NSFW content is detected
  ///
  /// In en, this message translates to:
  /// **'Unallowed content detected from the uploaded photo. This might be false positive detection.'**
  String get image_processing_ui_nsfw_detected_dialog_title;

  /// Progress dialog info text that image upload failed
  ///
  /// In en, this message translates to:
  /// **'Upload failed'**
  String get image_processing_ui_upload_failed_dialog_title;

  /// Progress dialog info text that image is currently in server's processing queue
  ///
  /// In en, this message translates to:
  /// **'Waiting for processing. Queue number: {p0}'**
  String image_processing_ui_upload_in_processing_queue_dialog_description(String p0);

  /// Progress dialog info text that image upload is in progress
  ///
  /// In en, this message translates to:
  /// **'Uploading photo'**
  String get image_processing_ui_upload_in_progress_dialog_description;

  /// Progress dialog info text that image processing is ongoing
  ///
  /// In en, this message translates to:
  /// **'Processing ongoing'**
  String get image_processing_ui_upload_processing_ongoing_description;

  /// Title for age confirmation checkbox
  ///
  /// In en, this message translates to:
  /// **'I\'m at least 18 years old'**
  String get initial_setup_screen_age_confirmation_checkbox;

  /// Title for age confirmation screen
  ///
  /// In en, this message translates to:
  /// **'Age confirmation'**
  String get initial_setup_screen_age_confirmation_title;

  /// Hint text for inserting email address to text field
  ///
  /// In en, this message translates to:
  /// **'Insert email address'**
  String get initial_setup_screen_email_hint_text;

  /// Title for initial setup email address info
  ///
  /// In en, this message translates to:
  /// **'My email address is…'**
  String get initial_setup_screen_email_title;

  /// Text for initial setup chat backup saved successfully
  ///
  /// In en, this message translates to:
  /// **'Backup saved successfully'**
  String get initial_setup_screen_first_chat_backup_backup_saved_successfully;

  /// Description for initial setup first chat backup
  ///
  /// In en, this message translates to:
  /// **'Chat\'s are stored on this device only, so regular backups are recommended. Let\'s save the first backup.\n\nIf you have cloud storage, it is recommended to save the backup there.'**
  String get initial_setup_screen_first_chat_backup_description;

  /// Title for initial setup save chat backup button
  ///
  /// In en, this message translates to:
  /// **'Save chat backup'**
  String get initial_setup_screen_first_chat_backup_save_backup_button;

  /// Title for initial setup first chat backup screen
  ///
  /// In en, this message translates to:
  /// **'First chat backup'**
  String get initial_setup_screen_first_chat_backup_title;

  /// Title for ask gender screen
  ///
  /// In en, this message translates to:
  /// **'I am…'**
  String get initial_setup_screen_gender_title;

  /// Text for initial setup location help dialog
  ///
  /// In en, this message translates to:
  /// **'Select a location for your profile by tapping or long pressing the map.'**
  String get initial_setup_screen_location_help_dialog_text;

  /// Title for initial setup location screen
  ///
  /// In en, this message translates to:
  /// **'My profile\'s location is…'**
  String get initial_setup_screen_location_title;

  /// Text field hint text for profile name
  ///
  /// In en, this message translates to:
  /// **'Insert your first name'**
  String get initial_setup_screen_profile_basic_info_profile_name_hint_text;

  /// Title text for profile name text field
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get initial_setup_screen_profile_basic_info_profile_name_title;

  /// Title text for asking profile information
  ///
  /// In en, this message translates to:
  /// **'My profile has this info…'**
  String get initial_setup_screen_profile_basic_info_title;

  /// Error text that face is not detected for primary profile image
  ///
  /// In en, this message translates to:
  /// **'Face is not detected. Please select another picture.'**
  String get initial_setup_screen_profile_pictures_primary_image_face_not_detected;

  /// Dialog description text about profile primary image
  ///
  /// In en, this message translates to:
  /// **'Adding at least of one profile image is required. The first profile image must be a face picture. The square shaped crop of the first profile image is displayed in profile grid and some other places in the app.'**
  String get initial_setup_screen_profile_pictures_primary_image_info_dialog_description;

  /// Dialog title for initial setup profile picture selection dialog
  ///
  /// In en, this message translates to:
  /// **'Select picture…'**
  String get initial_setup_screen_profile_pictures_select_picture_dialog_title;

  /// Action title for selecting profile picture from gallery
  ///
  /// In en, this message translates to:
  /// **'From gallery'**
  String get initial_setup_screen_profile_pictures_select_picture_from_gallery_title;

  /// Action title for using security selfie as a profile picture
  ///
  /// In en, this message translates to:
  /// **'Security selfie'**
  String get initial_setup_screen_profile_pictures_select_picture_security_selfie_title;

  /// Action title for taking new picture to be used as a profile picture
  ///
  /// In en, this message translates to:
  /// **'Take new photo'**
  String get initial_setup_screen_profile_pictures_select_picture_take_new_picture_title;

  /// Title for profile pictures selection screen
  ///
  /// In en, this message translates to:
  /// **'My profile pictures are…'**
  String get initial_setup_screen_profile_pictures_title;

  /// Snackbar error text that selected picture is unsupported
  ///
  /// In en, this message translates to:
  /// **'Selected image is not a JPEG or PNG image'**
  String get initial_setup_screen_profile_pictures_unsupported_image_error;

  /// Title for refresh face detected values
  ///
  /// In en, this message translates to:
  /// **'Refresh face detection statuses'**
  String get initial_setup_screen_refresh_face_detected_values_action;

  /// Subtitle for max age search setting
  ///
  /// In en, this message translates to:
  /// **'…with max age…'**
  String get initial_setup_screen_search_settings_max_age_subtitle;

  /// Subtitle for min age search setting
  ///
  /// In en, this message translates to:
  /// **'…with min age…'**
  String get initial_setup_screen_search_settings_min_age_subtitle;

  /// Title for ask search settings screen
  ///
  /// In en, this message translates to:
  /// **'I am searching for…'**
  String get initial_setup_screen_search_settings_title;

  /// Description for initial setup security selfie step
  ///
  /// In en, this message translates to:
  /// **'Take selfie with your phone\'s front camera. The selfie is used for moderating your profile images and by default it is only visible to content Moderators.'**
  String get initial_setup_screen_security_selfie_description;

  /// Error text that face is not detected for initial setup security selfie screen
  ///
  /// In en, this message translates to:
  /// **'Face is not detected. Please try again several times and if necessary ask customer support to do manual face detection.'**
  String get initial_setup_screen_security_selfie_face_not_detected;

  /// Title for initial setup security selfie screen
  ///
  /// In en, this message translates to:
  /// **'My security selfie is…'**
  String get initial_setup_screen_security_selfie_title;

  /// Description for skip initial setup confirm dialog
  ///
  /// In en, this message translates to:
  /// **'Use this only if you will have some admin rights to the service.'**
  String get initial_setup_screen_skip_dialog_description;

  /// Title for skip initial setup confirm dialog
  ///
  /// In en, this message translates to:
  /// **'Skip account initial setup?'**
  String get initial_setup_screen_skip_dialog_title;

  /// Text displayed when like loading fails
  ///
  /// In en, this message translates to:
  /// **'Chat request loading failed'**
  String get likes_screen_like_loading_failed;

  /// Info text displayed when there is no received likes
  ///
  /// In en, this message translates to:
  /// **'No received chat requests'**
  String get likes_screen_no_received_likes_found;

  /// Description text displayed when there is no received likes
  ///
  /// In en, this message translates to:
  /// **'Spread the word about the app in social media'**
  String get likes_screen_no_received_likes_found_description;

  /// Title for likes screen refresh action
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get likes_screen_refresh_action;

  /// Title for likes screen
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get likes_screen_title;

  /// Snackbar text for connecting WebSocket failed
  ///
  /// In en, this message translates to:
  /// **'Connecting WebSocket failed. Try again later.'**
  String get login_screen_connecting_websocket_failed;

  /// Description for demo account login dialog
  ///
  /// In en, this message translates to:
  /// **'Login to demo account on the demo account server.'**
  String get login_screen_demo_account_dialog_description;

  /// Title for demo account login dialog
  ///
  /// In en, this message translates to:
  /// **'Demo account login'**
  String get login_screen_demo_account_dialog_title;

  /// Snackbar text for demo account login failed
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get login_screen_demo_account_login_failed;

  /// Snackbar text for demo account login session expiration
  ///
  /// In en, this message translates to:
  /// **'Demo account session expired'**
  String get login_screen_demo_account_login_session_expired;

  /// Placeholder text for demo account password
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_screen_demo_account_password;

  /// Placeholder text for demo account username
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get login_screen_demo_account_username;

  /// Snackbar error message when email is already used by another account
  ///
  /// In en, this message translates to:
  /// **'Email address is already in use by another account'**
  String get login_screen_email_already_used;

  /// Snackbar text for invalid email login token error
  ///
  /// In en, this message translates to:
  /// **'Invalid email login code'**
  String get login_screen_invalid_email_login_token;

  /// Description text for iOS PWA installation guide
  ///
  /// In en, this message translates to:
  /// **'To use this app on iOS, please add it to your home screen:'**
  String get login_screen_ios_pwa_install_description;

  /// First step for iOS PWA installation
  ///
  /// In en, this message translates to:
  /// **'1. Tap the Share button'**
  String get login_screen_ios_pwa_install_step1;

  /// Second step for iOS PWA installation
  ///
  /// In en, this message translates to:
  /// **'2. Scroll down and tap \"Add to Home Screen\"'**
  String get login_screen_ios_pwa_install_step2;

  /// Third step for iOS PWA installation
  ///
  /// In en, this message translates to:
  /// **'3. Tap \"Add\" in the top right corner'**
  String get login_screen_ios_pwa_install_step3;

  /// Fourth step for iOS PWA installation
  ///
  /// In en, this message translates to:
  /// **'4. Open the app from your home screen'**
  String get login_screen_ios_pwa_install_step4;

  /// Snackbar text for login API request failed
  ///
  /// In en, this message translates to:
  /// **'Login API request failed. Try again later.'**
  String get login_screen_login_api_request_failed;

  /// Word 'and' between terms of service and privacy policy links
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get login_screen_login_note_text_and;

  /// Text about agreeing terms of service and privacy policy
  ///
  /// In en, this message translates to:
  /// **'By signing in, you agree to our'**
  String get login_screen_login_note_text_beginning;

  /// Text for privacy policy link
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get login_screen_login_note_text_privacy_policy;

  /// Text for terms of service link
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get login_screen_login_note_text_tos;

  /// Text that registering new accounts is disabled on web
  ///
  /// In en, this message translates to:
  /// **'Registering new accounts is not possible using a web browser.'**
  String get login_screen_registering_disabled_on_web;

  /// Snackbar error message when sign in with account email is not verified
  ///
  /// In en, this message translates to:
  /// **'Email address of the selected account is not verified'**
  String get login_screen_sign_in_with_email_unverified;

  /// Snackbar text for sign in with error
  ///
  /// In en, this message translates to:
  /// **'Sign in with failed'**
  String get login_screen_sign_in_with_error;

  /// Snackbar text about failed location update
  ///
  /// In en, this message translates to:
  /// **'Location update failed'**
  String get map_location_update_failed;

  /// Snackbar text about successful location update
  ///
  /// In en, this message translates to:
  /// **'Location update successful'**
  String get map_location_update_successful;

  /// OpenStreetMap data attribution link text
  ///
  /// In en, this message translates to:
  /// **'OpenStreetMap contributors'**
  String get map_openstreetmap_data_attribution_link_text;

  /// Help text for selecting map location
  ///
  /// In en, this message translates to:
  /// **'Tap or long press the map to select a location.'**
  String get map_select_location_help_text;

  /// Snackbar text about map tile error
  ///
  /// In en, this message translates to:
  /// **'Map tile error'**
  String get map_tile_error;

  /// Title text for server maintenance info
  ///
  /// In en, this message translates to:
  /// **'Maintenance break'**
  String get menu_screen_server_maintenance_title;

  /// Title for menu screen
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu_screen_title;

  /// Beginning of moderation rejected reason category text
  ///
  /// In en, this message translates to:
  /// **'Rejection category: {p0}'**
  String moderation_rejected_category(String p0);

  /// Beginning of moderation rejected reason details text
  ///
  /// In en, this message translates to:
  /// **'Rejection details: {p0}'**
  String moderation_rejected_details(String p0);

  /// Beginning of moderation state text
  ///
  /// In en, this message translates to:
  /// **'Moderation state: {p0}'**
  String moderation_state(String p0);

  /// Moderation state for accepted content
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get moderation_state_accepted;

  /// Moderation state rejected by bot
  ///
  /// In en, this message translates to:
  /// **'Rejected by bot'**
  String get moderation_state_rejected_by_bot;

  /// Moderation state rejected by human
  ///
  /// In en, this message translates to:
  /// **'Rejected by human'**
  String get moderation_state_rejected_by_human;

  /// Moderation state waiting bot or human moderation
  ///
  /// In en, this message translates to:
  /// **'Waiting bot or human moderation'**
  String get moderation_state_waiting_bot_or_human_moderation;

  /// Moderation state waiting human moderation
  ///
  /// In en, this message translates to:
  /// **'Waiting human moderation'**
  String get moderation_state_waiting_human_moderation;

  /// Dialog title for create new news item confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Create new?'**
  String get news_list_screen_create_new;

  /// Info text displayed when news loading fails
  ///
  /// In en, this message translates to:
  /// **'News loading failed'**
  String get news_list_screen_news_loading_failed;

  /// Info text displayed when no news are found
  ///
  /// In en, this message translates to:
  /// **'No news found'**
  String get news_list_screen_no_news_found;

  /// News item state text for not yet published news item
  ///
  /// In en, this message translates to:
  /// **'Not published'**
  String get news_list_screen_not_published;

  /// Title for news list screen title
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news_list_screen_title;

  /// Title for automatic profile search found multiple profiles notification
  ///
  /// In en, this message translates to:
  /// **'{p0} new or updated profiles found'**
  String notification_automatic_profile_search_found_profiles_multiple(String p0);

  /// Title for automatic profile search found single profile notification
  ///
  /// In en, this message translates to:
  /// **'New or updated profile found'**
  String get notification_automatic_profile_search_found_profiles_single;

  /// Title for notification category automatic profile search
  ///
  /// In en, this message translates to:
  /// **'New and updated profiles'**
  String get notification_category_automatic_profile_search;

  /// Title for notification category group chat
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get notification_category_group_chat;

  /// Title for notification category group content moderation
  ///
  /// In en, this message translates to:
  /// **'Content moderation'**
  String get notification_category_group_content_moderation;

  /// Title for notification category group general
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get notification_category_group_general;

  /// Title for notification category likes
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get notification_category_likes;

  /// Title for notification category media content moderation completed
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get notification_category_media_content_moderation_completed;

  /// Title for notification category messages
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get notification_category_messages;

  /// Title for notification category news item available
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get notification_category_news_item_available;

  /// Title for notification category profile string moderation completed
  ///
  /// In en, this message translates to:
  /// **'Profile name and text'**
  String get notification_category_profile_string_moderation_completed;

  /// Title for like received notification when multiple likes is received
  ///
  /// In en, this message translates to:
  /// **'Chat requests received'**
  String get notification_like_received_multiple;

  /// Title for like received notification when single like is received
  ///
  /// In en, this message translates to:
  /// **'Chat request received'**
  String get notification_like_received_single;

  /// Title for media content accepted notification
  ///
  /// In en, this message translates to:
  /// **'Image accepted'**
  String get notification_media_content_accepted;

  /// Title for media content deleted notification
  ///
  /// In en, this message translates to:
  /// **'Image deleted'**
  String get notification_media_content_deleted;

  /// Description for media content deleted notification
  ///
  /// In en, this message translates to:
  /// **'Unallowed content was detected from the image. This might be false positive detection.'**
  String get notification_media_content_deleted_description;

  /// Title for media content rejected notification
  ///
  /// In en, this message translates to:
  /// **'Image rejected'**
  String get notification_media_content_rejected;

  /// Title for message received when multiple messages are received
  ///
  /// In en, this message translates to:
  /// **'{p0} sent messages'**
  String notification_message_received_multiple(String p0);

  /// Title for message received when multiple messages are received but there is no info who sent it
  ///
  /// In en, this message translates to:
  /// **'New messages received'**
  String get notification_message_received_multiple_generic;

  /// Title for message received when single message is received
  ///
  /// In en, this message translates to:
  /// **'{p0} sent a message'**
  String notification_message_received_single(String p0);

  /// Title for message received when single message is received but there is no info who sent it
  ///
  /// In en, this message translates to:
  /// **'New message received'**
  String get notification_message_received_single_generic;

  /// Title for news item available notification
  ///
  /// In en, this message translates to:
  /// **'News available'**
  String get notification_news_item_available;

  /// Description text for notification permission dialog
  ///
  /// In en, this message translates to:
  /// **'Allow notifications to receive notifications for example from new chat requests and messages.'**
  String get notification_permission_dialog_description;

  /// Title for notification permission dialog
  ///
  /// In en, this message translates to:
  /// **'Allow notifications?'**
  String get notification_permission_dialog_title;

  /// Title for profile name accepted notification
  ///
  /// In en, this message translates to:
  /// **'Profile name accepted'**
  String get notification_profile_name_accepted;

  /// Title for profile name rejected notification
  ///
  /// In en, this message translates to:
  /// **'Profile name rejected'**
  String get notification_profile_name_rejected;

  /// Title for profile text accepted notification
  ///
  /// In en, this message translates to:
  /// **'Profile text accepted'**
  String get notification_profile_text_accepted;

  /// Title for profile text rejected notification
  ///
  /// In en, this message translates to:
  /// **'Profile text rejected'**
  String get notification_profile_text_rejected;

  /// Info text when iOS PWA notification permission is denied
  ///
  /// In en, this message translates to:
  /// **'Permission not granted. Try again or grant permission from iOS system settings.'**
  String get notification_settings_screen_ios_pwa_permission_denied;

  /// Info text that notification category is disabled from system settings
  ///
  /// In en, this message translates to:
  /// **'Disabled from system notification settings'**
  String get notification_settings_screen_notification_category_disabled_from_system_settings_text;

  /// Info text that notifications are disabled from system settings
  ///
  /// In en, this message translates to:
  /// **'Notifications are disabled from system notification settings'**
  String get notification_settings_screen_notifications_disabled_from_system_settings_text;

  /// Action title for opening system notification settings
  ///
  /// In en, this message translates to:
  /// **'System notification settings'**
  String get notification_settings_screen_open_system_notification_settings;

  /// Title for notification settings screen
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notification_settings_screen_title;

  /// Info text when web notification permission is denied
  ///
  /// In en, this message translates to:
  /// **'Permission not granted. Try again or grant permission from browser settings.'**
  String get notification_settings_screen_web_permission_denied;

  /// Info text for web that notification permission is not enabled
  ///
  /// In en, this message translates to:
  /// **'Notification permission is not enabled'**
  String get notification_settings_screen_web_permission_not_enabled;

  /// Action title for requesting web notification permission
  ///
  /// In en, this message translates to:
  /// **'Enable notifications'**
  String get notification_settings_screen_web_request_permission;

  /// Setting for last seen time visibility
  ///
  /// In en, this message translates to:
  /// **'Last seen time'**
  String get privacy_settings_last_seen_time;

  /// Setting for message seen state
  ///
  /// In en, this message translates to:
  /// **'Message read receipts'**
  String get privacy_settings_message_state_seen;

  /// Setting for online status visibility
  ///
  /// In en, this message translates to:
  /// **'Online status'**
  String get privacy_settings_online_status;

  /// Title for chat privacy settings category
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get privacy_settings_screen_chat_category;

  /// Title for profile privacy settings category
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get privacy_settings_screen_profile_category;

  /// Title for privacy settings screen
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy_settings_screen_title;

  /// Setting for typing indicator
  ///
  /// In en, this message translates to:
  /// **'Typing indicator'**
  String get privacy_settings_typing_indicator;

  /// Title for disable filters action
  ///
  /// In en, this message translates to:
  /// **'Disable filters'**
  String get profile_filters_screen_disable_filters_action;

  /// Title for disable filters action confirm dialog
  ///
  /// In en, this message translates to:
  /// **'Disable filters?'**
  String get profile_filters_screen_disable_filters_action_dialog_title;

  /// Title text for distance filter
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get profile_filters_screen_distance_filter;

  /// Value text for distance filter max value
  ///
  /// In en, this message translates to:
  /// **'Max {p0} km'**
  String profile_filters_screen_distance_filter_max_value(String p0);

  /// Value text for distance filter min and max value
  ///
  /// In en, this message translates to:
  /// **'{p0}-{p1} km'**
  String profile_filters_screen_distance_filter_min_and_max_value(String p0, String p1);

  /// Value text for distance filter min value
  ///
  /// In en, this message translates to:
  /// **'Min {p0} km'**
  String profile_filters_screen_distance_filter_min_value(String p0);

  /// Title for max profile age filter
  ///
  /// In en, this message translates to:
  /// **'Max age'**
  String get profile_filters_screen_max_age_filter;

  /// Title for min profile age filter
  ///
  /// In en, this message translates to:
  /// **'Min age'**
  String get profile_filters_screen_min_age_filter;

  /// Title for profile created time filter
  ///
  /// In en, this message translates to:
  /// **'Profile created'**
  String get profile_filters_screen_profile_created_filter;

  /// Title for profile edited time filter
  ///
  /// In en, this message translates to:
  /// **'Profile edited'**
  String get profile_filters_screen_profile_edited_filter;

  /// Title for profile last seen time filter
  ///
  /// In en, this message translates to:
  /// **'Last seen'**
  String get profile_filters_screen_profile_last_seen_time_filter;

  /// Value text for profile last seen time filter when all is selected
  ///
  /// In en, this message translates to:
  /// **'Anytime'**
  String get profile_filters_screen_profile_last_seen_time_filter_all;

  /// Value text for profile last seen time filter when day is selected
  ///
  /// In en, this message translates to:
  /// **'{p0} day'**
  String profile_filters_screen_profile_last_seen_time_filter_day(String p0);

  /// Value text for profile last seen time filter when multiple days is selected
  ///
  /// In en, this message translates to:
  /// **'{p0} days'**
  String profile_filters_screen_profile_last_seen_time_filter_days(String p0);

  /// Error text when privacy setting has disabled last seen time filter
  ///
  /// In en, this message translates to:
  /// **'Disabled from privacy settings'**
  String get profile_filters_screen_profile_last_seen_time_filter_disabled_from_privacy;

  /// Value text for profile last seen time filter when only online profiles should be shown
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get profile_filters_screen_profile_last_seen_time_filter_online;

  /// Value text for profile text filter
  ///
  /// In en, this message translates to:
  /// **'Profile text length'**
  String get profile_filters_screen_profile_text_filter;

  /// Value text for profile text filter when only max value is selected
  ///
  /// In en, this message translates to:
  /// **'Max {p0} characters'**
  String profile_filters_screen_profile_text_filter_max_value(String p0);

  /// Value text for profile text filter when both min and max values are selected
  ///
  /// In en, this message translates to:
  /// **'{p0}-{p1} characters'**
  String profile_filters_screen_profile_text_filter_min_and_max_value(String p0, String p1);

  /// Value text for profile text filter when only min value is selected
  ///
  /// In en, this message translates to:
  /// **'Min {p0} characters'**
  String profile_filters_screen_profile_text_filter_min_value(String p0);

  /// Title for profile filters screen
  ///
  /// In en, this message translates to:
  /// **'Profile filters'**
  String get profile_filters_screen_title;

  /// Title for unlimited likes filter
  ///
  /// In en, this message translates to:
  /// **'Up for a date today'**
  String get profile_filters_screen_unlimited_likes_filter;

  /// Snackbar text for notifying about failed profile filters update
  ///
  /// In en, this message translates to:
  /// **'Updating profile filters failed'**
  String get profile_filters_screen_updating_filters_failed;

  /// Dialog text for daily likes info dialog
  ///
  /// In en, this message translates to:
  /// **'Daily chat requests left: {p0}\nReset time: {p1}'**
  String profile_grid_screen_daily_likes_dialog_text(String p0, String p1);

  /// Dialog text for unlimited likes specific text in daily likes info dialog
  ///
  /// In en, this message translates to:
  /// **'Sending chat requests to those who are up for a date today does not decrease daily chat requests.'**
  String get profile_grid_screen_daily_likes_dialog_unlimited_likes_text;

  /// Info text which is shown when email is not verified
  ///
  /// In en, this message translates to:
  /// **'Please verify your email address. A verification link has been sent to your email. If you don\'t see it, check your spam folder.'**
  String get profile_grid_screen_email_not_verified;

  /// Button text for account settings action when email is not verified
  ///
  /// In en, this message translates to:
  /// **'Account settings'**
  String get profile_grid_screen_email_not_verified_button;

  /// Snackbar text that filtering favorite profiles is not supported
  ///
  /// In en, this message translates to:
  /// **'Filtering favorite profiles is not supported'**
  String get profile_grid_screen_filtering_favorite_profiles_is_not_supported;

  /// Info text that initial moderation is ongoing
  ///
  /// In en, this message translates to:
  /// **'You can view profiles and others can see your profile after your profile images are moderated.'**
  String get profile_grid_screen_initial_moderation_ongoing;

  /// Description that no favorite profiles were found
  ///
  /// In en, this message translates to:
  /// **'Mark a profile as a favorite to add it here.'**
  String get profile_grid_screen_no_favorite_profiles_found_description;

  /// Title that no favorite profiles were found
  ///
  /// In en, this message translates to:
  /// **'No favorite profiles found'**
  String get profile_grid_screen_no_favorite_profiles_found_title;

  /// Description displayed when there is no profiles and there is no filters enabled
  ///
  /// In en, this message translates to:
  /// **'Spread the word about the app in social media'**
  String get profile_grid_screen_no_profiles_found_description_filters_disabled;

  /// Description displayed when there is no profiles and some filter is enabled
  ///
  /// In en, this message translates to:
  /// **'Change or disable filter settings'**
  String get profile_grid_screen_no_profiles_found_description_filters_enabled;

  /// Title that no profiles were found
  ///
  /// In en, this message translates to:
  /// **'No profiles found'**
  String get profile_grid_screen_no_profiles_found_title;

  /// Text displayed when primary profile content does not exist
  ///
  /// In en, this message translates to:
  /// **'First profile picture does not exist'**
  String get profile_grid_screen_primary_profile_content_does_not_exist;

  /// Text displayed when face is not detected from primary profile content
  ///
  /// In en, this message translates to:
  /// **'Face is not detected from first profile picture'**
  String get profile_grid_screen_primary_profile_content_face_not_detected;

  /// Text displayed when primary profile content is not accepted
  ///
  /// In en, this message translates to:
  /// **'First profile picture is not accepted'**
  String get profile_grid_screen_primary_profile_content_is_not_accepted;

  /// Snackbar text that profile filter settings update is ongoing
  ///
  /// In en, this message translates to:
  /// **'Profile filter settings update is ongoing'**
  String get profile_grid_screen_profile_filter_settings_update_ongoing;

  /// Info text which is shown when profile visibility is set to private
  ///
  /// In en, this message translates to:
  /// **'To view profiles, set your profile visibility to public from app settings.'**
  String get profile_grid_screen_profile_is_private_info;

  /// Text displayed when security selfie does not exist
  ///
  /// In en, this message translates to:
  /// **'Security selfie does not exist'**
  String get profile_grid_screen_security_content_does_not_exist;

  /// Text displayed when security selfie is not accepted
  ///
  /// In en, this message translates to:
  /// **'Security selfie is not accepted'**
  String get profile_grid_screen_security_content_is_not_accepted;

  /// Title for show all profiles action
  ///
  /// In en, this message translates to:
  /// **'Show all profiles'**
  String get profile_grid_screen_show_all_profiles_action;

  /// Title for show favorite profiles action
  ///
  /// In en, this message translates to:
  /// **'Show favorite profiles'**
  String get profile_grid_screen_show_favorite_profiles_action;

  /// Button text for start initial setup button
  ///
  /// In en, this message translates to:
  /// **'Start account initial setup'**
  String get profile_grid_screen_start_initial_setup_button;

  /// Title for profile grid screen
  ///
  /// In en, this message translates to:
  /// **'Profiles'**
  String get profile_grid_screen_title;

  /// Title for common settings to all profile grids
  ///
  /// In en, this message translates to:
  /// **'All profile grids'**
  String get profile_grid_settings_screen_all_grids_title;

  /// Title for profiles screen settings category
  ///
  /// In en, this message translates to:
  /// **'Profiles screen'**
  String get profile_grid_settings_screen_profiles_screen;

  /// Title for random profile order setting
  ///
  /// In en, this message translates to:
  /// **'Random profile order'**
  String get profile_grid_settings_screen_random_profile_order;

  /// Description for random profile order setting when setting is disabled
  ///
  /// In en, this message translates to:
  /// **'Start from your location'**
  String get profile_grid_settings_screen_random_profile_order_description_disabled;

  /// Description for random profile order setting when setting is enabled
  ///
  /// In en, this message translates to:
  /// **'Start from random location'**
  String get profile_grid_settings_screen_random_profile_order_description_enabled;

  /// Profile grid settings screen title
  ///
  /// In en, this message translates to:
  /// **'Profile grid'**
  String get profile_grid_settings_screen_title;

  /// Snackbar text for profile image is not accepted error
  ///
  /// In en, this message translates to:
  /// **'Profile image is not accepted by moderators'**
  String get profile_image_error_image_not_accepted;

  /// Snackbar text for no profile image error
  ///
  /// In en, this message translates to:
  /// **'No profile image'**
  String get profile_image_error_no_image;

  /// Snackbar text for no primary profile image error
  ///
  /// In en, this message translates to:
  /// **'No primary profile image'**
  String get profile_image_error_no_primary_image;

  /// Title for profile location screen
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get profile_location_screen_title;

  /// Title for profile statistics history screen
  ///
  /// In en, this message translates to:
  /// **'Profile statistics history'**
  String get profile_statistics_history_screen_title;

  /// Success message after backup import
  ///
  /// In en, this message translates to:
  /// **'Backup imported successfully'**
  String get receive_chat_backup_import_success;

  /// Status text when importing backup
  ///
  /// In en, this message translates to:
  /// **'Importing backup…'**
  String get receive_chat_backup_importing;

  /// Instruction for using pairing code
  ///
  /// In en, this message translates to:
  /// **'On the source device:'**
  String get receive_chat_backup_pairing_code_instruction;

  /// First step for using pairing code
  ///
  /// In en, this message translates to:
  /// **'1. Open {p0}'**
  String receive_chat_backup_pairing_code_step1(String p0);

  /// Second step for using pairing code
  ///
  /// In en, this message translates to:
  /// **'2. Logout if login screen is not visible'**
  String get receive_chat_backup_pairing_code_step2;

  /// Third step for using pairing code
  ///
  /// In en, this message translates to:
  /// **'3. Tap the three dots in the top right corner'**
  String get receive_chat_backup_pairing_code_step3;

  /// Fourth step for using pairing code
  ///
  /// In en, this message translates to:
  /// **'4. Select \"Send chat backup\"'**
  String get receive_chat_backup_pairing_code_step4;

  /// Fifth step for using pairing code
  ///
  /// In en, this message translates to:
  /// **'5. Scan the QR code and start transfer'**
  String get receive_chat_backup_pairing_code_step5;

  /// Title for receive chat backup screen
  ///
  /// In en, this message translates to:
  /// **'Receive chat backup'**
  String get receive_chat_backup_screen_title;

  /// Button text to show QR code
  ///
  /// In en, this message translates to:
  /// **'Show QR code'**
  String get receive_chat_backup_show_qr_code;

  /// Button text to show textual pairing code
  ///
  /// In en, this message translates to:
  /// **'Show text code'**
  String get receive_chat_backup_show_text_code;

  /// Status text when transferring backup data
  ///
  /// In en, this message translates to:
  /// **'Receiving backup…'**
  String get receive_chat_backup_transferring;

  /// Status text when waiting for source device
  ///
  /// In en, this message translates to:
  /// **'Waiting for source device'**
  String get receive_chat_backup_waiting_for_source;

  /// Snackbar text for backend signed message not found error
  ///
  /// In en, this message translates to:
  /// **'Backend signed message not found'**
  String get report_chat_message_screen_backend_signed_message_not_found;

  /// Chat message reporting confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Report chat message?'**
  String get report_chat_message_screen_confirm_dialog_title;

  /// Snackbar text for symmetric message encryption key not found error
  ///
  /// In en, this message translates to:
  /// **'Symmetric message encryption key not found'**
  String get report_chat_message_screen_symmetric_message_encryption_key_not_found;

  /// Profile image reporting confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Report profile image?'**
  String get report_profile_image_screen_confirm_dialog_title;

  /// Profile image title for reporting screen
  ///
  /// In en, this message translates to:
  /// **'Profile image {p0}'**
  String report_profile_image_screen_image_title(String p0);

  /// Snackbar text displayed when reporting old profile image
  ///
  /// In en, this message translates to:
  /// **'Report failed. Profile image has changed.'**
  String get report_profile_image_screen_profile_image_changed_error;

  /// Title for report chat message action
  ///
  /// In en, this message translates to:
  /// **'Chat message'**
  String get report_screen_chat_message_action;

  /// Text for dialog for custom report boolean reporting
  ///
  /// In en, this message translates to:
  /// **'Report user as \'{p0}\'?'**
  String report_screen_custom_report_boolean_dialog_description(String p0);

  /// Title for dialog for custom report boolean reporting
  ///
  /// In en, this message translates to:
  /// **'Report?'**
  String get report_screen_custom_report_boolean_dialog_title;

  /// Title for report profile image action
  ///
  /// In en, this message translates to:
  /// **'Profile image'**
  String get report_screen_profile_image_action;

  /// Title for report profile name action
  ///
  /// In en, this message translates to:
  /// **'Profile name'**
  String get report_screen_profile_name_action;

  /// Snackbar text for when reporting old profile name
  ///
  /// In en, this message translates to:
  /// **'Report failed. Profile name has changed.'**
  String get report_screen_profile_name_changed_error;

  /// Profile name reporting confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Report profile name?'**
  String get report_screen_profile_name_dialog_title;

  /// Title for report profile text action
  ///
  /// In en, this message translates to:
  /// **'Profile text'**
  String get report_screen_profile_text_action;

  /// Snackbar text for when reporting old profile text
  ///
  /// In en, this message translates to:
  /// **'Report failed. Profile text has changed.'**
  String get report_screen_profile_text_changed_error;

  /// Profile text reporting confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Report profile text?'**
  String get report_screen_profile_text_dialog_title;

  /// Snackbar text for successful report
  ///
  /// In en, this message translates to:
  /// **'Reported'**
  String get report_screen_snackbar_report_successful;

  /// Snackbar text for too many reports error
  ///
  /// In en, this message translates to:
  /// **'Report failed. Too many reports.'**
  String get report_screen_snackbar_too_many_reports_error;

  /// Title for report screen
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report_screen_title;

  /// Instruction for scanning QR code
  ///
  /// In en, this message translates to:
  /// **'Point your camera at the QR code'**
  String get scan_pairing_code_instruction;

  /// Title for scan pairing code screen
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scan_pairing_code_screen_title;

  /// Title for automatic profile search settings category
  ///
  /// In en, this message translates to:
  /// **'New and updated profiles'**
  String get search_settings_screen_automatic_search;

  /// Title for change gender filter value action
  ///
  /// In en, this message translates to:
  /// **'Gender filter'**
  String get search_settings_screen_change_gender_filter_action_tile;

  /// Title for change my profile's gender action
  ///
  /// In en, this message translates to:
  /// **'Change my profile\'s gender'**
  String get search_settings_screen_change_my_gender_action_title;

  /// Title text for distance setting
  ///
  /// In en, this message translates to:
  /// **'Use max distance filter'**
  String get search_settings_screen_distance;

  /// Title text for filters setting
  ///
  /// In en, this message translates to:
  /// **'Use multiple-choice question filters'**
  String get search_settings_screen_filters;

  /// Snackbar text about missing gender filter value
  ///
  /// In en, this message translates to:
  /// **'Gender filter is not selected'**
  String get search_settings_screen_gender_filter_is_not_selected;

  /// Snackbar text about missing gender information
  ///
  /// In en, this message translates to:
  /// **'Your gender information is not set'**
  String get search_settings_screen_gender_is_not_selected;

  /// Title text for new profiles setting
  ///
  /// In en, this message translates to:
  /// **'Hide updated profiles'**
  String get search_settings_screen_new_profiles;

  /// Snackbar text about failed search settings update
  ///
  /// In en, this message translates to:
  /// **'Updating search settings failed'**
  String get search_settings_screen_search_settings_update_failed;

  /// Title for search settings
  ///
  /// In en, this message translates to:
  /// **'Profile search'**
  String get search_settings_screen_title;

  /// Title text for weekdays setting
  ///
  /// In en, this message translates to:
  /// **'Search weekdays'**
  String get search_settings_screen_weekdays;

  /// Content count text
  ///
  /// In en, this message translates to:
  /// **'Images {p0}/{p1}'**
  String select_content_screen_count(String p0, String p1);

  /// Face detected text
  ///
  /// In en, this message translates to:
  /// **'Face detected'**
  String get select_content_screen_face_detected;

  /// Title for select content screen
  ///
  /// In en, this message translates to:
  /// **'Select image'**
  String get select_content_screen_title;

  /// Title for select match screen
  ///
  /// In en, this message translates to:
  /// **'Accepted chat requests'**
  String get select_match_screen_title;

  /// Status text when creating backup
  ///
  /// In en, this message translates to:
  /// **'Creating backup…'**
  String get send_chat_backup_creating_backup;

  /// Status text when idle and ready to send
  ///
  /// In en, this message translates to:
  /// **'Ready to send backup'**
  String get send_chat_backup_idle;

  /// Hint text for pairing code input
  ///
  /// In en, this message translates to:
  /// **'Enter code from receiving device'**
  String get send_chat_backup_pairing_code_hint;

  /// Button text to scan QR code
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get send_chat_backup_scan_qr_button;

  /// Title for send chat backup screen
  ///
  /// In en, this message translates to:
  /// **'Send chat backup'**
  String get send_chat_backup_screen_title;

  /// Button text to send another backup
  ///
  /// In en, this message translates to:
  /// **'Send another backup'**
  String get send_chat_backup_send_another_button;

  /// Button text to start sending backup
  ///
  /// In en, this message translates to:
  /// **'Start transfer'**
  String get send_chat_backup_start_button;

  /// Status text when backup sent successfully
  ///
  /// In en, this message translates to:
  /// **'Backup sent successfully'**
  String get send_chat_backup_success;

  /// Status text when transferring backup
  ///
  /// In en, this message translates to:
  /// **'Sending backup…'**
  String get send_chat_backup_transferring;

  /// Server connection indicator text when connection failed after max retries
  ///
  /// In en, this message translates to:
  /// **'Connection failed'**
  String get server_connection_indicator_connection_failed;

  /// Info dialog message when connection failed after max retries
  ///
  /// In en, this message translates to:
  /// **'Unable to connect to the server. Please check your internet connection and try again later. If the problem persists, the server may be temporarily unavailable.'**
  String get server_connection_indicator_connection_failed_dialog_text;

  /// Server connection indicator text showing countdown
  ///
  /// In en, this message translates to:
  /// **'Reconnecting in {p0}s'**
  String server_connection_indicator_reconnecting_in_seconds(String p0);

  /// Title for data settings category
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get settings_screen_data_category;

  /// Title for general settings category
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settings_screen_general_category;

  /// Title for privacy and security settings category
  ///
  /// In en, this message translates to:
  /// **'Privacy and security'**
  String get settings_screen_privacy_and_security_category;

  /// Title for profile settings category
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get settings_screen_profile_category;

  /// Description for pending public profile visibility
  ///
  /// In en, this message translates to:
  /// **'Your profile will be visible in profile grid once your images are moderated as accepted'**
  String get settings_screen_profile_visiblity_pending_public_description;

  /// Description for private profile visibility
  ///
  /// In en, this message translates to:
  /// **'Your profile is not visible in profile grid'**
  String get settings_screen_profile_visiblity_private_description;

  /// Description for public profile visibility
  ///
  /// In en, this message translates to:
  /// **'Your profile is visible in profile grid'**
  String get settings_screen_profile_visiblity_public_description;

  /// Title for profile visibility setting
  ///
  /// In en, this message translates to:
  /// **'Profile visibility'**
  String get settings_screen_profile_visiblity_setting;

  /// Title for settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_screen_title;

  /// Snackbar info text that API usage limit is reached
  ///
  /// In en, this message translates to:
  /// **'API usage limit is reached. Try again tomorrow.'**
  String get snackbar_api_usage_limit_reached;

  /// Snackbar error text for API errors
  ///
  /// In en, this message translates to:
  /// **'API error'**
  String get snackbar_error_api;

  /// Snackbar error text for API timeouts
  ///
  /// In en, this message translates to:
  /// **'API timeout'**
  String get snackbar_error_api_timeout;

  /// Snackbar error text for database errors
  ///
  /// In en, this message translates to:
  /// **'Database error'**
  String get snackbar_error_database;

  /// Snackbar error text for file errors
  ///
  /// In en, this message translates to:
  /// **'File error'**
  String get snackbar_error_file;

  /// Snackbar error text for logic errors
  ///
  /// In en, this message translates to:
  /// **'Logic error'**
  String get snackbar_error_logic;

  /// Splash screen error text that app is already running
  ///
  /// In en, this message translates to:
  /// **'App is already running'**
  String get splash_screen_app_is_already_running;

  /// Text for age range
  ///
  /// In en, this message translates to:
  /// **'Ages: {p0}'**
  String statistics_screen_age_range(String p0);

  /// Text for all profiles count
  ///
  /// In en, this message translates to:
  /// **'All profiles: {p0}'**
  String statistics_screen_count_all_profiles(String p0);

  /// Text for man profiles count
  ///
  /// In en, this message translates to:
  /// **'Men: {p0}'**
  String statistics_screen_count_men(String p0);

  /// Text for non-binary profiles count
  ///
  /// In en, this message translates to:
  /// **'Non-binaries: {p0}'**
  String statistics_screen_count_nonbinaries(String p0);

  /// Text for online users count
  ///
  /// In en, this message translates to:
  /// **'Online users: {p0}'**
  String statistics_screen_count_online_users(String p0);

  /// Text for online users count in bar chart tooltip
  ///
  /// In en, this message translates to:
  /// **'Online: {p0}'**
  String statistics_screen_count_online_users_bar_chart_tooltip(String p0);

  /// Text for private profiles count
  ///
  /// In en, this message translates to:
  /// **'Private profiles: {p0}'**
  String statistics_screen_count_private_profiles(String p0);

  /// Text for public profiles count
  ///
  /// In en, this message translates to:
  /// **'Public profiles: {p0}'**
  String statistics_screen_count_public_profiles(String p0);

  /// Text for registered users count
  ///
  /// In en, this message translates to:
  /// **'Registered users: {p0}'**
  String statistics_screen_count_registered_users(String p0);

  /// Text for woman profiles count
  ///
  /// In en, this message translates to:
  /// **'Women: {p0}'**
  String statistics_screen_count_women(String p0);

  /// Text for hour value
  ///
  /// In en, this message translates to:
  /// **'Hour: {p0}'**
  String statistics_screen_hour_value(String p0);

  /// Title for online users per hour statistics
  ///
  /// In en, this message translates to:
  /// **'Online users per hour'**
  String get statistics_screen_online_users_per_hour_statistics_title;

  /// Text for data generation time
  ///
  /// In en, this message translates to:
  /// **'Time: {p0}'**
  String statistics_screen_time(String p0);

  /// Title for statistics screen
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics_screen_title;

  /// Info text that app update is required
  ///
  /// In en, this message translates to:
  /// **'Current app version is not supported. Please update the app.'**
  String get unsupported_client_screen_info;

  /// Title for unsupported client screen
  ///
  /// In en, this message translates to:
  /// **'App update required'**
  String get unsupported_client_screen_title;

  /// No description provided for @url_app_privacy_policy_link.
  ///
  /// In en, this message translates to:
  /// **'https://example.com'**
  String get url_app_privacy_policy_link;

  /// No description provided for @url_app_tos_link.
  ///
  /// In en, this message translates to:
  /// **'https://example.com'**
  String get url_app_tos_link;

  /// Description text for video call tip dialog
  ///
  /// In en, this message translates to:
  /// **'You can send video call invitation using video call button at top right corner of the screen.'**
  String get video_call_tip_dialog_description;

  /// Title for video call tip dialog
  ///
  /// In en, this message translates to:
  /// **'Like video calls?'**
  String get video_call_tip_dialog_title;

  /// Title for view image screen
  ///
  /// In en, this message translates to:
  /// **'View image'**
  String get view_image_screen_title;

  /// Text for news edited time
  ///
  /// In en, this message translates to:
  /// **'Edited: {p0}'**
  String view_news_screen_edited(String p0);

  /// Text for news published time
  ///
  /// In en, this message translates to:
  /// **'Published: {p0}'**
  String view_news_screen_published(String p0);

  /// Text for view profile screen add to favorites action
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get view_profile_screen_add_to_favorites_action;

  /// Snackbar text for view profile screen add to favorites action result successful
  ///
  /// In en, this message translates to:
  /// **'Added to favorites'**
  String get view_profile_screen_add_to_favorites_action_successful;

  /// Snackbar text for view profile screen displayed when action failed because of the profile is already a match
  ///
  /// In en, this message translates to:
  /// **'Chatting is already possible'**
  String get view_profile_screen_already_match;

  /// Text for view profile screen block action
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get view_profile_screen_block_action;

  /// Title for view profile screen block action dialog
  ///
  /// In en, this message translates to:
  /// **'Block profile?'**
  String get view_profile_screen_block_action_dialog_title;

  /// Snackbar text for view profile screen block action successful
  ///
  /// In en, this message translates to:
  /// **'Profile blocked'**
  String get view_profile_screen_block_action_successful;

  /// Text for view profile screen chat action
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get view_profile_screen_chat_action;

  /// Text for view profile screen like action
  ///
  /// In en, this message translates to:
  /// **'Send chat request'**
  String get view_profile_screen_like_action;

  /// Title for view profile screen like action dialog
  ///
  /// In en, this message translates to:
  /// **'Send chat request?'**
  String get view_profile_screen_like_action_dialog_title;

  /// Snackbar text for view profile screen like action failed because of like is already sent
  ///
  /// In en, this message translates to:
  /// **'Chat request already sent'**
  String get view_profile_screen_like_action_like_already_sent;

  /// Snackbar text for view profile screen like action successful
  ///
  /// In en, this message translates to:
  /// **'Chat request sent'**
  String get view_profile_screen_like_action_successful;

  /// Snackbar text for view profile screen like action failed because of like limit
  ///
  /// In en, this message translates to:
  /// **'No daily chat requests left. Try again tomorrow.'**
  String get view_profile_screen_like_action_try_again_tomorrow;

  /// Text for view profile screen edit my profile action
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get view_profile_screen_my_profile_edit_action;

  /// Snackbar text that it is not possible to open my profile screen when initial setup is not done
  ///
  /// In en, this message translates to:
  /// **'Dating profile is not created'**
  String get view_profile_screen_my_profile_initial_setup_not_done;

  /// Title for view profile screen when my profile is viewed
  ///
  /// In en, this message translates to:
  /// **'My profile'**
  String get view_profile_screen_my_profile_title;

  /// View profile screen info dialog text about non-accepted profile content
  ///
  /// In en, this message translates to:
  /// **'All profile pictures are not yet moderated or some picture is moderated as rejected. Only accepted pictures are visible to users.'**
  String get view_profile_screen_non_accepted_profile_content_info_dialog_text;

  /// Picture title text for dialog about non-accepted profile content
  ///
  /// In en, this message translates to:
  /// **'Picture {p0}'**
  String view_profile_screen_non_accepted_profile_content_info_dialog_text_picture_title(String p0);

  /// View profile screen info dialog text about non-accepted profile name
  ///
  /// In en, this message translates to:
  /// **'Profile name is not yet moderated or it is moderated as rejected. Only the first letter is visible to users.'**
  String get view_profile_screen_non_accepted_profile_name_info_dialog_text;

  /// View profile screen info dialog text about non-accepted profile text
  ///
  /// In en, this message translates to:
  /// **'Profile text is not yet moderated or it is moderated as rejected. Only the first letter is visible to users.'**
  String get view_profile_screen_non_accepted_profile_text_info_dialog_text;

  /// View profile screen text that profile is currently online
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get view_profile_screen_profile_currently_online;

  /// Snackbar text for notifying about failed profile edit
  ///
  /// In en, this message translates to:
  /// **'Profile editing failed'**
  String get view_profile_screen_profile_edit_failed;

  /// View profile screen text that profile is last seen day ago
  ///
  /// In en, this message translates to:
  /// **'Last seen {p0} day ago'**
  String view_profile_screen_profile_last_seen_day(String p0);

  /// View profile screen text that profile is last seen multiple days ago
  ///
  /// In en, this message translates to:
  /// **'Last seen {p0} days ago'**
  String view_profile_screen_profile_last_seen_days(String p0);

  /// View profile screen text that profile is last seen hour ago
  ///
  /// In en, this message translates to:
  /// **'Last seen {p0} hour ago'**
  String view_profile_screen_profile_last_seen_hour(String p0);

  /// View profile screen text that profile is last seen multiple hours ago
  ///
  /// In en, this message translates to:
  /// **'Last seen {p0} hours ago'**
  String view_profile_screen_profile_last_seen_hours(String p0);

  /// View profile screen text that profile is last seen minute ago
  ///
  /// In en, this message translates to:
  /// **'Last seen {p0} minute ago'**
  String view_profile_screen_profile_last_seen_minute(String p0);

  /// View profile screen text that profile is last seen multiple minutes ago
  ///
  /// In en, this message translates to:
  /// **'Last seen {p0} minutes ago'**
  String view_profile_screen_profile_last_seen_minutes(String p0);

  /// View profile screen text that profile is last seen second ago
  ///
  /// In en, this message translates to:
  /// **'Last seen {p0} second ago'**
  String view_profile_screen_profile_last_seen_second(String p0);

  /// View profile screen text that profile is last seen multiple seconds ago
  ///
  /// In en, this message translates to:
  /// **'Last seen {p0} seconds ago'**
  String view_profile_screen_profile_last_seen_seconds(String p0);

  /// Text for view profile screen remove from favorites action
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get view_profile_screen_remove_from_favorites_action;

  /// Snackbar text for view profile screen remove from favorites action result successful
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites'**
  String get view_profile_screen_remove_from_favorites_action_successful;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fi', 'sv'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fi':
      return AppLocalizationsFi();
    case 'sv':
      return AppLocalizationsSv();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
