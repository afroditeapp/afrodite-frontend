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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fi'),
    Locale('sv'),
  ];

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

  /// Title for email text
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get account_settings_screen_email_title;

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

  /// Name for the app
  ///
  /// In en, this message translates to:
  /// **'Afrodite'**
  String get app_name;

  /// Slogan for the app
  ///
  /// In en, this message translates to:
  /// **'Dating app'**
  String get app_slogan;

  /// Info text displayed when no profiles are found
  ///
  /// In en, this message translates to:
  /// **'No profiles found'**
  String get automatic_profile_search_results_screen_no_profiles_found;

  /// Title for automatic profile search results screen
  ///
  /// In en, this message translates to:
  /// **'Automatic profile search results'**
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

  /// Text for info dialog which is displayed once
  ///
  /// In en, this message translates to:
  /// **'Chats are stored only on this device. Removing this app removes the chats.'**
  String get chat_list_screen_info_dialog_text;

  /// Info text displayed when there is no chats
  ///
  /// In en, this message translates to:
  /// **'No chats found'**
  String get chat_list_screen_no_chats_found;

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
  String content_management_screen_content_deletion_allowed_wait_time(
    String p0,
  );

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
  /// **'Image management'**
  String get content_management_screen_title;

  /// Message input text field placeholder text
  ///
  /// In en, this message translates to:
  /// **'Type a message…'**
  String get conversation_screen_chat_box_placeholder_text;

  /// Description text for install Jitsi Meet dialog when app is running on Android
  ///
  /// In en, this message translates to:
  /// **'Video calling requires Jitsi Meet video calling app which is not installed currently. Install the app from Google Play Store?'**
  String get conversation_screen_install_jitsi_meet_dialog_description_android;

  /// Description text for install Jitsi Meet dialog when app is running on iOS
  ///
  /// In en, this message translates to:
  /// **'Video calling requires Jitsi Meet video calling app which is not installed currently. Install the app from App Store?'**
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
  String
  get conversation_screen_message_error_receiver_blocked_sender_or_receiver_not_found;

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

  /// Message state text that message decrypting failed
  ///
  /// In en, this message translates to:
  /// **'Decrypting failed'**
  String get conversation_screen_message_state_decrypting_failed;

  /// Message state text that public key download failed
  ///
  /// In en, this message translates to:
  /// **'Public key download failed'**
  String get conversation_screen_message_state_public_key_download_failed;

  /// Message state text that message was received successfully
  ///
  /// In en, this message translates to:
  /// **'Received successfully'**
  String get conversation_screen_message_state_received_successfully;

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

  /// Title for data settings
  ///
  /// In en, this message translates to:
  /// **'Data management'**
  String get data_settings_screen_title;

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

  /// Dialog title text for action which creates a new account
  ///
  /// In en, this message translates to:
  /// **'New account'**
  String get demo_account_screen_new_account_dialog_title;

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
  String edit_profile_screen_automatic_min_age_incrementing_info_dialog_text(
    String p0,
    String p1,
  );

  /// Snackbar text for notifying about invalid age
  ///
  /// In en, this message translates to:
  /// **'Invalid age'**
  String get edit_profile_screen_invalid_age;

  /// Snackbar text for notifying about invalid first name
  ///
  /// In en, this message translates to:
  /// **'Invalid first name'**
  String get edit_profile_screen_invalid_first_name;

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
  /// **'Looking for a date for today'**
  String get edit_profile_screen_unlimited_likes;

  /// Description for unlimited likes setting when it is disabled
  ///
  /// In en, this message translates to:
  /// **'Sending a chat request to you will decrease daily chat requests'**
  String get edit_profile_screen_unlimited_likes_description_disabled;

  /// Description for unlimited likes setting when it is enabled
  ///
  /// In en, this message translates to:
  /// **'Sending a chat request to you will not decrease daily chat requests'**
  String get edit_profile_screen_unlimited_likes_description_enabled;

  /// Description for unlimited likes setting when it is enabled and automatic disabling is enabled
  ///
  /// In en, this message translates to:
  /// **'Sending a chat request to you will not decrease daily chat requests. Disabled automatically at {p0}.'**
  String
  edit_profile_screen_unlimited_likes_description_enabled_and_automatic_disabling(
    String p0,
  );

  /// Dialog text for notifying user when profile text is too long
  ///
  /// In en, this message translates to:
  /// **'Profile text byte count is more than 2000 bytes'**
  String get edit_profile_text_screen_text_lenght_too_long;

  /// Generic action completed text
  ///
  /// In en, this message translates to:
  /// **'Action completed'**
  String get generic_action_completed;

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

  /// Generic copy text
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get generic_copy;

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

  /// Generic edit text
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get generic_edit;

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

  /// Generic login text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get generic_login;

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

  /// Generic max text
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get generic_max;

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

  /// Generic not supported on web text
  ///
  /// In en, this message translates to:
  /// **'Not supported on Web'**
  String get generic_not_supported_on_web;

  /// Generic OK text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get generic_ok;

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

  /// Generic retry text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get generic_retry;

  /// Generic save confirmation title text
  ///
  /// In en, this message translates to:
  /// **'Save?'**
  String get generic_save_confirmation_title;

  /// No description provided for @generic_search_settings_looking_for_all_genders_text.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get generic_search_settings_looking_for_all_genders_text;

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

  /// Generic skip text
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get generic_skip;

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

  /// Input field hint text for age
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

  /// Generic try again text
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get generic_try_again;

  /// Generic unlimited text
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get generic_unlimited;

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
  String image_processing_ui_upload_in_processing_queue_dialog_description(
    String p0,
  );

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

  /// Title for image cache max size setting
  ///
  /// In en, this message translates to:
  /// **'Image cache max size'**
  String get image_quality_settings_screen_image_cache_max_size;

  /// Title for image quality setting custom value
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get image_quality_settings_screen_image_quality_custom;

  /// Title for image quality setting medium value
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get image_quality_settings_screen_image_quality_high;

  /// Title for image quality setting low value
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get image_quality_settings_screen_image_quality_low;

  /// Title for image quality setting max value
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get image_quality_settings_screen_image_quality_max;

  /// Title for image quality setting medium value
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get image_quality_settings_screen_image_quality_medium;

  /// Value text for current quality setting
  ///
  /// In en, this message translates to:
  /// **'{p0} pixels'**
  String image_quality_settings_screen_image_quality_pixel_value(String p0);

  /// Title for image quality setting
  ///
  /// In en, this message translates to:
  /// **'Image width and height max quality'**
  String get image_quality_settings_screen_image_quality_setting;

  /// Title for image quality setting tiny value
  ///
  /// In en, this message translates to:
  /// **'Tiny'**
  String get image_quality_settings_screen_image_quality_tiny;

  /// Title for max image quality setting
  ///
  /// In en, this message translates to:
  /// **'Max image quality'**
  String get image_quality_settings_screen_max_image_quality;

  /// Image quality settings screen title
  ///
  /// In en, this message translates to:
  /// **'Image quality'**
  String get image_quality_settings_screen_title;

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

  /// Title text for asking age
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get initial_setup_screen_profile_basic_info_age_title;

  /// Input field hint text for profile first name
  ///
  /// In en, this message translates to:
  /// **'Insert your first name'**
  String get initial_setup_screen_profile_basic_info_first_name_hint_text;

  /// Title text for asking first name
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get initial_setup_screen_profile_basic_info_first_name_title;

  /// Title text for asking profile information
  ///
  /// In en, this message translates to:
  /// **'My profile has this info…'**
  String get initial_setup_screen_profile_basic_info_title;

  /// Error text that face is not detected for primary profile image
  ///
  /// In en, this message translates to:
  /// **'Face is not detected. Please select another picture.'**
  String
  get initial_setup_screen_profile_pictures_primary_image_face_not_detected;

  /// Dialog description text about profile primary image
  ///
  /// In en, this message translates to:
  /// **'Adding at least of one profile image is required. The first profile image must be a face picture. The square shaped crop of the first profile image is displayed in profile grid and some other places in the app.'**
  String
  get initial_setup_screen_profile_pictures_primary_image_info_dialog_description;

  /// Dialog title for initial setup profile picture selection dialog
  ///
  /// In en, this message translates to:
  /// **'Select picture…'**
  String get initial_setup_screen_profile_pictures_select_picture_dialog_title;

  /// Action title for selecting profile picture from gallery
  ///
  /// In en, this message translates to:
  /// **'From gallery'**
  String
  get initial_setup_screen_profile_pictures_select_picture_from_gallery_title;

  /// Action title for using security selfie as a profile picture
  ///
  /// In en, this message translates to:
  /// **'Security selfie'**
  String
  get initial_setup_screen_profile_pictures_select_picture_security_selfie_title;

  /// Action title for taking new picture to be used as a profile picture
  ///
  /// In en, this message translates to:
  /// **'Take new photo'**
  String
  get initial_setup_screen_profile_pictures_select_picture_take_new_picture_title;

  /// Title for profile pictures selection screen
  ///
  /// In en, this message translates to:
  /// **'My profile pictures are…'**
  String get initial_setup_screen_profile_pictures_title;

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
  /// **'No received chat requests found'**
  String get likes_screen_no_received_likes_found;

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

  /// Text for demo account login action
  ///
  /// In en, this message translates to:
  /// **'Demo account login'**
  String get login_screen_action_demo_account_login;

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

  /// Snackbar text for demo account locked error
  ///
  /// In en, this message translates to:
  /// **'Account locked. Contact customer support.'**
  String get login_screen_demo_account_locked;

  /// Snackbar text for demo account login failed
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get login_screen_demo_account_login_failed;

  /// Dialog info text that demo account login is in progress
  ///
  /// In en, this message translates to:
  /// **'Login…'**
  String get login_screen_demo_account_login_progress_dialog;

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

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_screen_login_button;

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

  /// Register button text
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get login_screen_register_button;

  /// Snackbar text for sign in with error
  ///
  /// In en, this message translates to:
  /// **'Sign in with failed'**
  String get login_screen_sign_in_with_error;

  /// Dialog info text that sign in with login is in progress
  ///
  /// In en, this message translates to:
  /// **'Login…'**
  String get login_screen_sign_in_with_progress_dialog;

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

  /// Info text about server maintenance
  ///
  /// In en, this message translates to:
  /// **'Maintenance break: {p0}'**
  String menu_screen_server_maintenance_info(String p0);

  /// Title for menu screen
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu_screen_title;

  /// Title for moderate images page
  ///
  /// In en, this message translates to:
  /// **'Moderate images'**
  String get moderate_images_screen_title;

  /// Beginning of moderation rejected reason category text
  ///
  /// In en, this message translates to:
  /// **'Rejected reason category: {p0}'**
  String moderation_rejected_category(String p0);

  /// Beginning of moderation rejected reason details text
  ///
  /// In en, this message translates to:
  /// **'Rejected reason details: {p0}'**
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

  /// Snackbar text for notifying that notification action was ignored
  ///
  /// In en, this message translates to:
  /// **'Notification action ignored because it is for another account'**
  String get notification_action_ignored;

  /// Title for automatic profile search found profiles notification
  ///
  /// In en, this message translates to:
  /// **'New or updated profiles found'**
  String get notification_automatic_profile_search_found_profiles;

  /// Title for notification category automatic profile search
  ///
  /// In en, this message translates to:
  /// **'Automatic profile search'**
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
  /// **'Chat requests'**
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

  /// Title for notification category profile text moderation completed
  ///
  /// In en, this message translates to:
  /// **'Profile texts'**
  String get notification_category_profile_text_moderation_completed;

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

  /// Info text that notification category is disabled from system settings
  ///
  /// In en, this message translates to:
  /// **'Disabled from system notification settings'**
  String
  get notification_settings_screen_notification_category_disabled_from_system_settings_text;

  /// Info text that notifications are disabled from system settings
  ///
  /// In en, this message translates to:
  /// **'Notifications are disabled from system notification settings'**
  String
  get notification_settings_screen_notifications_disabled_from_system_settings_text;

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

  /// Title for disable filters action
  ///
  /// In en, this message translates to:
  /// **'Disable filters'**
  String get profile_filtering_settings_screen_disable_filters_action;

  /// Title for disable filters action confirm dialog
  ///
  /// In en, this message translates to:
  /// **'Disable filters?'**
  String
  get profile_filtering_settings_screen_disable_filters_action_dialog_title;

  /// Title text for distance filter
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get profile_filtering_settings_screen_distance_filter;

  /// Value text for distance filter max value
  ///
  /// In en, this message translates to:
  /// **'Max {p0} km'**
  String profile_filtering_settings_screen_distance_filter_max_value(String p0);

  /// Value text for distance filter min and max value
  ///
  /// In en, this message translates to:
  /// **'{p0}-{p1} km'**
  String profile_filtering_settings_screen_distance_filter_min_and_max_value(
    String p0,
    String p1,
  );

  /// Value text for distance filter min value
  ///
  /// In en, this message translates to:
  /// **'Min {p0} km'**
  String profile_filtering_settings_screen_distance_filter_min_value(String p0);

  /// Title for profile created time filter
  ///
  /// In en, this message translates to:
  /// **'Profile created'**
  String get profile_filtering_settings_screen_profile_created_filter;

  /// Title for profile edited time filter
  ///
  /// In en, this message translates to:
  /// **'Profile edited'**
  String get profile_filtering_settings_screen_profile_edited_filter;

  /// Title for profile last seen time filter
  ///
  /// In en, this message translates to:
  /// **'Last seen'**
  String get profile_filtering_settings_screen_profile_last_seen_time_filter;

  /// Value text for profile last seen time filter when all is selected
  ///
  /// In en, this message translates to:
  /// **'Anytime'**
  String
  get profile_filtering_settings_screen_profile_last_seen_time_filter_all;

  /// Value text for profile last seen time filter when day is selected
  ///
  /// In en, this message translates to:
  /// **'{p0} day'**
  String profile_filtering_settings_screen_profile_last_seen_time_filter_day(
    String p0,
  );

  /// Value text for profile last seen time filter when multiple days is selected
  ///
  /// In en, this message translates to:
  /// **'{p0} days'**
  String profile_filtering_settings_screen_profile_last_seen_time_filter_days(
    String p0,
  );

  /// Value text for profile last seen time filter when only online profiles should be shown
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String
  get profile_filtering_settings_screen_profile_last_seen_time_filter_online;

  /// Value text for profile text filter
  ///
  /// In en, this message translates to:
  /// **'Profile text length'**
  String get profile_filtering_settings_screen_profile_text_filter;

  /// Value text for profile text filter when only max value is selected
  ///
  /// In en, this message translates to:
  /// **'Max {p0} characters'**
  String profile_filtering_settings_screen_profile_text_filter_max_value(
    String p0,
  );

  /// Value text for profile text filter when both min and max values are selected
  ///
  /// In en, this message translates to:
  /// **'{p0}-{p1} characters'**
  String
  profile_filtering_settings_screen_profile_text_filter_min_and_max_value(
    String p0,
    String p1,
  );

  /// Value text for profile text filter when only min value is selected
  ///
  /// In en, this message translates to:
  /// **'Min {p0} characters'**
  String profile_filtering_settings_screen_profile_text_filter_min_value(
    String p0,
  );

  /// Title for profile filtering settings screen
  ///
  /// In en, this message translates to:
  /// **'Profile filters'**
  String get profile_filtering_settings_screen_title;

  /// Title for unlimited likes filter
  ///
  /// In en, this message translates to:
  /// **'Looking for a date for today'**
  String get profile_filtering_settings_screen_unlimited_likes_filter;

  /// Snackbar text for notifying about failed profile filters update
  ///
  /// In en, this message translates to:
  /// **'Updating profile filters failed'**
  String get profile_filtering_settings_screen_updating_filters_failed;

  /// Dialog text for daily likes info dialog
  ///
  /// In en, this message translates to:
  /// **'Daily chat requests left: {p0}\nReset time: {p1}'**
  String profile_grid_screen_daily_likes_dialog_text(String p0, String p1);

  /// Dialog text for unlimited likes specific text in daily likes info dialog
  ///
  /// In en, this message translates to:
  /// **'Sending chat requests to those who are looking for a date for today does not decrease daily chat requests.'**
  String get profile_grid_screen_daily_likes_dialog_unlimited_likes_text;

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

  /// Title for horizontal padding setting
  ///
  /// In en, this message translates to:
  /// **'Horizontal margin'**
  String get profile_grid_settings_screen_horizontal_padding;

  /// Title for internal padding setting
  ///
  /// In en, this message translates to:
  /// **'Internal margin'**
  String get profile_grid_settings_screen_internal_padding;

  /// Title for profile thumbnail border radius setting
  ///
  /// In en, this message translates to:
  /// **'Profile thumbnail border radius'**
  String get profile_grid_settings_screen_profile_thumbnail_border_radius;

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
  String
  get profile_grid_settings_screen_random_profile_order_description_disabled;

  /// Description for random profile order setting when setting is enabled
  ///
  /// In en, this message translates to:
  /// **'Start from random location'**
  String
  get profile_grid_settings_screen_random_profile_order_description_enabled;

  /// Title for row profile count setting
  ///
  /// In en, this message translates to:
  /// **'Row profile count'**
  String get profile_grid_settings_screen_row_profile_count;

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
  String
  get report_chat_message_screen_symmetric_message_encryption_key_not_found;

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

  /// Snackbar text about invalid age range
  ///
  /// In en, this message translates to:
  /// **'Age range is invalid'**
  String get search_settings_screen_age_range_is_invalid;

  /// Title for search age range max value text field
  ///
  /// In en, this message translates to:
  /// **'Max age'**
  String get search_settings_screen_age_range_max_value_title;

  /// Title for search age range min value text field
  ///
  /// In en, this message translates to:
  /// **'Min age'**
  String get search_settings_screen_age_range_min_value_title;

  /// Title for automatic profile search settings category
  ///
  /// In en, this message translates to:
  /// **'Automatic search'**
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

  /// Note about search behavior
  ///
  /// In en, this message translates to:
  /// **'Profile grid only shows profiles which match with the above values.'**
  String get search_settings_screen_help_text;

  /// Title text for new profiles setting
  ///
  /// In en, this message translates to:
  /// **'Show only new profiles'**
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
  String
  view_profile_screen_non_accepted_profile_content_info_dialog_text_picture_title(
    String p0,
  );

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

  /// Text for view profile screen profile not available dialog
  ///
  /// In en, this message translates to:
  /// **'Profile not available'**
  String get view_profile_screen_profile_not_available_dialog_description;

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

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fi', 'sv'].contains(locale.languageCode);

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
