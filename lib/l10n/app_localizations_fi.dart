// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String about_dialog_app_publisher(String p0) {
    return 'Publisher: $p0';
  }

  @override
  String about_dialog_git_commit_id(String p0) {
    return 'Version ID: $p0';
  }

  @override
  String account_banned_screen_ban_reason(String p0) {
    return 'Ban reason: $p0';
  }

  @override
  String account_banned_screen_time_text(String p0) {
    return 'Account automatic unban process begins at $p0';
  }

  @override
  String get account_banned_screen_title => 'Account banned';

  @override
  String account_deletion_pending_screen_time_text(String p0) {
    return 'Account automatic deletion process begins at $p0';
  }

  @override
  String get account_deletion_pending_screen_title =>
      'Account deletion pending';

  @override
  String get account_settings_screen_cancel_email_change_button =>
      'Cancel email change';

  @override
  String get account_settings_screen_cancel_email_change_confirm_dialog_title =>
      'Cancel email change?';

  @override
  String get account_settings_screen_change_email_button => 'Change email';

  @override
  String get account_settings_screen_change_email_dialog_hint =>
      'Enter new email address';

  @override
  String get account_settings_screen_change_email_dialog_title =>
      'Change email address';

  @override
  String get account_settings_screen_delete_account_action =>
      'Request account deletion';

  @override
  String get account_settings_screen_delete_account_action_error =>
      'Requesting account deletion failed';

  @override
  String get account_settings_screen_delete_account_confirm_dialog_title =>
      'Request account deletion?';

  @override
  String get account_settings_screen_email_change_cancelled =>
      'Email change cancelled';

  @override
  String get account_settings_screen_email_change_initiated =>
      'Email change initiated. Please check your email.';

  @override
  String get account_settings_screen_email_not_verified => 'Email not verified';

  @override
  String get account_settings_screen_email_title => 'Email address';

  @override
  String get account_settings_screen_email_verified => 'Email verified';

  @override
  String account_settings_screen_pending_email_completion_time(String p0) {
    return 'Email change completes at: $p0';
  }

  @override
  String get account_settings_screen_pending_email_not_verified =>
      'Pending email not verified';

  @override
  String get account_settings_screen_pending_email_title =>
      'Pending new email address';

  @override
  String get account_settings_screen_pending_email_verified =>
      'Pending email verified';

  @override
  String get account_settings_screen_send_verification_email_already_verified =>
      'Email is already verified';

  @override
  String get account_settings_screen_send_verification_email_button =>
      'Send verification email';

  @override
  String
  get account_settings_screen_send_verification_email_sent_successfully =>
      'Verification email sent successfully';

  @override
  String get account_settings_screen_title => 'Account';

  @override
  String get admin_settings_title => 'Admin';

  @override
  String get app_bar_action_about => 'About';

  @override
  String get app_legalese => '';

  @override
  String get app_name => 'Afrodite';

  @override
  String get app_publisher => '';

  @override
  String get app_slogan => 'Deittisovellus';

  @override
  String get automatic_profile_search_results_screen_no_profiles_found =>
      'No profiles found';

  @override
  String get automatic_profile_search_results_screen_title =>
      'Automatic profile search results';

  @override
  String get blocked_profiles_screen_no_blocked_profiles =>
      'No blocked profiles';

  @override
  String get blocked_profiles_screen_placeholder_for_private_profile =>
      'Private profile';

  @override
  String get blocked_profiles_screen_title => 'Blocked profiles';

  @override
  String blocked_profiles_screen_unblock_profile_dialog_description(String p0) {
    return 'Unblock $p0';
  }

  @override
  String get blocked_profiles_screen_unblock_profile_dialog_title =>
      'Unblock profile?';

  @override
  String get blocked_profiles_screen_unblock_profile_failed => 'Unblock failed';

  @override
  String get blocked_profiles_screen_unblock_profile_in_progress =>
      'Previous unblock is in progress';

  @override
  String get blocked_profiles_screen_unblock_profile_successful =>
      'Unblock successful';

  @override
  String get camera_screen_camera_access_restricted_error =>
      'Camera access is restricted. Opening camera is not possible.';

  @override
  String get camera_screen_camera_initialization_error =>
      'Camera initialization failed';

  @override
  String camera_screen_camera_initialization_error_with_error_code(String p0) {
    return 'Camera initialization failed. Error code: $p0';
  }

  @override
  String get camera_screen_camera_opening_already_in_progress_error =>
      'Camera opening in progress';

  @override
  String get camera_screen_camera_permission_error_check_settings =>
      'No camera permission. Please grant the camera permission from system settings.';

  @override
  String
  get camera_screen_camera_permission_error_try_again_or_check_settings =>
      'No camera permission. Please try again. If that will not work then grant the camera permission from system settings.';

  @override
  String get camera_screen_no_front_camera_error => 'No front camera available';

  @override
  String get camera_screen_take_photo_error => 'Taking photo failed';

  @override
  String get chat_data_screen_create_backup => 'Create backup';

  @override
  String get chat_data_screen_create_backup_question => 'Create chat backup?';

  @override
  String get chat_data_screen_create_backup_question_details =>
      'Backup includes current messages and encryption key.';

  @override
  String get chat_data_screen_import_backup => 'Import backup';

  @override
  String get chat_data_screen_import_backup_question => 'Import chat backup?';

  @override
  String chat_data_screen_import_backup_question_details(String p0) {
    return 'File: $p0\n\nCurrent and backup messages will be merged. Current encryption key will be replaced if the one included in the backup is newer.';
  }

  @override
  String get chat_data_screen_title => 'Chat data';

  @override
  String get chat_list_screen_info_dialog_text =>
      'Chats are stored only on this device. Removing this app removes the chats.';

  @override
  String get chat_list_screen_no_chats_found => 'No chats found';

  @override
  String get chat_list_screen_no_chats_found_description =>
      'Spread the word about the app in social media';

  @override
  String get chat_list_screen_no_matches_found =>
      'No accepted chat requests found';

  @override
  String get chat_list_screen_open_matches_screen_action =>
      'Accepted chat requests';

  @override
  String get chat_list_screen_profile_not_available => 'Profile not available';

  @override
  String chat_list_screen_sent_message_indicator(String p0) {
    return 'You: $p0';
  }

  @override
  String get chat_list_screen_title => 'Chatit';

  @override
  String get chat_list_screen_unread_message => 'New message';

  @override
  String content_management_screen_content_deletion_allowed_wait_time(
    String p0,
  ) {
    return 'Deletion possible starting at $p0';
  }

  @override
  String content_management_screen_content_profile_content(String p0) {
    return 'Profile image $p0';
  }

  @override
  String get content_management_screen_content_security_content =>
      'Security selfie';

  @override
  String get content_management_screen_title => 'My images';

  @override
  String get conversation_screen_chat_box_placeholder_text => 'Type a message…';

  @override
  String
  get conversation_screen_install_jitsi_meet_dialog_description_android =>
      'Video calling requires Jitsi Meet video calling app which is not installed currently. Install the app from Google Play Store? After that, try this again.';

  @override
  String get conversation_screen_install_jitsi_meet_dialog_description_ios =>
      'Video calling requires Jitsi Meet video calling app which is not installed currently. Install the app from App Store? After that, try this again.';

  @override
  String get conversation_screen_install_jitsi_meet_dialog_title =>
      'Install Jitsi Meet?';

  @override
  String get conversation_screen_join_video_call_button => 'Join video call';

  @override
  String get conversation_screen_join_video_call_dialog_title =>
      'Join video call?';

  @override
  String get conversation_screen_make_match_instruction =>
      'Send a message to accept the chat request!';

  @override
  String get conversation_screen_message_details_message_id => 'Message ID';

  @override
  String get conversation_screen_message_error_is_actually_sent_successfully =>
      'The message is actually sent successfully';

  @override
  String
  get conversation_screen_message_error_receiver_blocked_sender_or_receiver_not_found =>
      'Receiver action prevented message sending';

  @override
  String get conversation_screen_message_info_encryption_key_changed =>
      'Encryption key changed';

  @override
  String get conversation_screen_message_info_encryption_started =>
      'Messages are end-to-end encrypted';

  @override
  String get conversation_screen_message_list_empty => 'No messages';

  @override
  String get conversation_screen_message_state_decrypting_failed =>
      'Decrypting failed';

  @override
  String get conversation_screen_message_state_delivered => 'Delivered';

  @override
  String get conversation_screen_message_state_public_key_download_failed =>
      'Public key download failed';

  @override
  String get conversation_screen_message_state_received_and_seen =>
      'Received and seen';

  @override
  String get conversation_screen_message_state_received_and_seen_locally =>
      'Received and seen locally';

  @override
  String get conversation_screen_message_state_received_successfully =>
      'Received successfully';

  @override
  String get conversation_screen_message_state_seen => 'Seen';

  @override
  String get conversation_screen_message_state_sending_failed =>
      'Sending failed';

  @override
  String get conversation_screen_message_state_sending_in_progress =>
      'Sending in progress';

  @override
  String get conversation_screen_message_state_sent_successfully =>
      'Sent successfully';

  @override
  String get conversation_screen_message_too_long => 'Message is too long';

  @override
  String get conversation_screen_message_too_many_pending_messages =>
      'Server pending message storage is full';

  @override
  String get conversation_screen_message_unsupported => 'Unsupported message';

  @override
  String get conversation_screen_open_details_action_subtitle =>
      'Contains selectable text';

  @override
  String get conversation_screen_profile_blocked => 'Profile was blocked';

  @override
  String get conversation_screen_send_video_call_invitation_action =>
      'Send video call invitation';

  @override
  String get conversation_screen_send_video_call_invitation_dialog_title =>
      'Send video call invitation?';

  @override
  String get crop_image_screen_title => 'Crop image';

  @override
  String get current_security_selfie_screen_security_selfie_changed =>
      'Security selfie changed';

  @override
  String get current_security_selfie_screen_title => 'Security selfie';

  @override
  String get data_export_screen_api_limit_error => 'Try again after 24 hours';

  @override
  String get data_export_screen_title_export_type_admin => 'Data export';

  @override
  String get data_export_screen_title_export_type_user => 'Download my data';

  @override
  String get demo_account_screen_confirm_logout_dialog_title => 'Logout?';

  @override
  String get demo_account_screen_login_to_account_dialog_title =>
      'Login to account?';

  @override
  String get demo_account_screen_max_account_count_error =>
      'Error: max account count';

  @override
  String get demo_account_screen_new_account_action => 'New account';

  @override
  String get demo_account_screen_new_account_dialog_description =>
      'Create new account and login to it?';

  @override
  String get demo_account_screen_no_accounts_available =>
      'No accounts available';

  @override
  String get edit_attribute_filter_value_screen_require_all_wanted_values =>
      'Require all wanted values';

  @override
  String get edit_attribute_filter_value_screen_search_placeholder_text =>
      'Search…';

  @override
  String get edit_attribute_filter_value_screen_show_advanced_filters_action =>
      'Advanced filters';

  @override
  String get edit_attribute_filter_value_screen_show_basic_filters_action =>
      'Basic filters';

  @override
  String get edit_attribute_filter_value_screen_title => 'Edit filter';

  @override
  String get edit_attribute_value_screen_max_selected_values_error =>
      'Too many selected values';

  @override
  String get edit_attribute_value_screen_one_value_must_be_selected =>
      'At least one selection is required';

  @override
  String get edit_attribute_value_screen_search_placeholder_text => 'Search…';

  @override
  String get edit_my_gender_screen_gender_setting_title =>
      'My profile\'s gender';

  @override
  String edit_profile_screen_automatic_min_age_incrementing_info_dialog_text(
    String p0,
    String p1,
  ) {
    return 'Min age will be increased to $p0 in $p1';
  }

  @override
  String get edit_profile_screen_invalid_age => 'Invalid age';

  @override
  String get edit_profile_screen_invalid_profile_name => 'Invalid first name';

  @override
  String get edit_profile_screen_one_profile_image_required =>
      'One profile image is required';

  @override
  String get edit_profile_screen_primary_profile_content_not_accepted =>
      'Picture is not currently accepted by moderators. Your profile will not be shown in profile grid until the picture is accepted.';

  @override
  String get edit_profile_screen_profile_name => 'First name';

  @override
  String get edit_profile_screen_profile_name_description =>
      'Changing first name is possible only before it is accepted by moderators.';

  @override
  String get edit_profile_screen_profile_text => 'Profile text';

  @override
  String get edit_profile_screen_title => 'Edit profile';

  @override
  String get edit_profile_screen_unlimited_likes => 'Up for a date today';

  @override
  String
  edit_profile_screen_unlimited_likes_description_enabled_and_automatic_disabling(
    String p0,
  ) {
    return 'Turns off at $p0';
  }

  @override
  String get edit_profile_text_screen_text_lenght_too_long =>
      'Profile text byte count is more than 2000 bytes';

  @override
  String get email_login_screen_code_hint => 'Login code';

  @override
  String email_login_screen_didnt_receive_code(String p0) {
    return 'If you didn\'t receive the code:\n• Check your spam folder\n• Verify the email address is correct\n• Wait $p0 before requesting a new code\n• Make sure you have an existing account with this email';
  }

  @override
  String get email_login_screen_email_hint => 'Email address';

  @override
  String email_login_screen_input_code_description(String p0) {
    return 'Enter the login code sent to $p0';
  }

  @override
  String get email_login_screen_input_email_description =>
      'Enter your email address to receive a login code. This works only for already existing accounts.';

  @override
  String get email_login_screen_send_code_button => 'Send login code';

  @override
  String get email_login_screen_title => 'Email login';

  @override
  String email_login_screen_token_validity(String p0) {
    return 'Code expires in: $p0';
  }

  @override
  String get email_notification_settings_screen_title => 'Email notifications';

  @override
  String generic_account_id_text_with_value(String p0) {
    return 'Account ID: $p0';
  }

  @override
  String get generic_account_locked_error => 'Account locked';

  @override
  String get generic_action_completed => 'Action completed';

  @override
  String get generic_age => 'Age';

  @override
  String get generic_average => 'Average';

  @override
  String get generic_cancel => 'Peruuta';

  @override
  String get generic_cancel_question => 'Cancel?';

  @override
  String get generic_close => 'Sulje';

  @override
  String get generic_continue => 'Continue';

  @override
  String get generic_copy => 'Copy';

  @override
  String get generic_data_sync_failed => 'Data sync failed';

  @override
  String get generic_delete => 'Delete';

  @override
  String get generic_delete_question => 'Delete?';

  @override
  String get generic_details => 'Details';

  @override
  String get generic_disabled => 'Disabled';

  @override
  String get generic_download => 'Download';

  @override
  String get generic_download_question => 'Download?';

  @override
  String get generic_edit => 'Edit';

  @override
  String get generic_email_sending_failed => 'Email sending failed';

  @override
  String get generic_email_sending_timeout => 'Email sending timeout';

  @override
  String get generic_empty => 'Tyhjä';

  @override
  String get generic_error => 'Virhe';

  @override
  String get generic_error_app_version_is_unsupported =>
      'Current app version is unsupported';

  @override
  String get generic_error_occurred => 'Error occurred';

  @override
  String get generic_gender_man => 'Man';

  @override
  String get generic_gender_man_plural => 'Men';

  @override
  String get generic_gender_nonbinary => 'Non-binary';

  @override
  String get generic_gender_nonbinary_plural => 'Non-binaries';

  @override
  String get generic_gender_woman => 'Woman';

  @override
  String get generic_gender_woman_plural => 'Women';

  @override
  String get generic_large => 'Large';

  @override
  String get generic_login => 'Login';

  @override
  String get generic_login_progress_dialog_text => 'Login…';

  @override
  String get generic_logout => 'Logout';

  @override
  String get generic_logout_confirmation_title => 'Logout?';

  @override
  String get generic_logout_failed => 'Logout failed';

  @override
  String get generic_margin => 'Margin';

  @override
  String get generic_max => 'Max';

  @override
  String get generic_medium => 'Medium';

  @override
  String get generic_message => 'Message';

  @override
  String get generic_min => 'Min';

  @override
  String get generic_no => 'No';

  @override
  String get generic_not_found => 'Not found';

  @override
  String get generic_ok => 'OK';

  @override
  String get generic_preview_noun => 'Preview';

  @override
  String get generic_previous_action_in_progress =>
      'Previous action is still in progress';

  @override
  String get generic_profile_loading_failed => 'Profile loading failed';

  @override
  String get generic_refresh => 'Refresh';

  @override
  String get generic_reject_question => 'Reject?';

  @override
  String get generic_resend => 'Resend';

  @override
  String get generic_reset_to_defaults => 'Reset to default values';

  @override
  String get generic_reset_to_defaults_dialog_title =>
      'Reset to default values?';

  @override
  String get generic_retry => 'Retry';

  @override
  String get generic_save => 'Save';

  @override
  String get generic_save_confirmation_title => 'Save?';

  @override
  String get generic_setting_saved => 'Setting saved';

  @override
  String get generic_show_only_selected => 'Show only selected';

  @override
  String get generic_size => 'Size';

  @override
  String get generic_skip => 'Skip';

  @override
  String get generic_small => 'Small';

  @override
  String get generic_state => 'State';

  @override
  String get generic_take_photo => 'Take photo';

  @override
  String get generic_text_field_age_hint_text => 'Insert an age between 18–99';

  @override
  String get generic_this_feature_is_disabled => 'This feature is disabled';

  @override
  String get generic_time => 'Time';

  @override
  String get generic_today => 'Today';

  @override
  String get generic_try_again => 'Try again';

  @override
  String generic_try_again_later_seconds(String p0) {
    return 'Try again after $p0 seconds';
  }

  @override
  String get generic_unlimited => 'Unlimited';

  @override
  String get generic_weekday_fri => 'Fri';

  @override
  String get generic_weekday_mon => 'Mon';

  @override
  String get generic_weekday_sat => 'Sat';

  @override
  String get generic_weekday_sun => 'Sun';

  @override
  String get generic_weekday_thu => 'Thu';

  @override
  String get generic_weekday_tue => 'Tue';

  @override
  String get generic_weekday_wed => 'Wed';

  @override
  String get generic_yes => 'Yes';

  @override
  String get generic_yesterday => 'Yesterday';

  @override
  String get image_processing_ui_confirm_photo_dialog_title =>
      'Continue with this photo?';

  @override
  String get image_processing_ui_nsfw_detected_dialog_title =>
      'Unallowed content detected from the uploaded photo. This might be false positive detection.';

  @override
  String get image_processing_ui_upload_failed_dialog_title => 'Upload failed';

  @override
  String image_processing_ui_upload_in_processing_queue_dialog_description(
    String p0,
  ) {
    return 'Waiting for processing. Queue number: $p0';
  }

  @override
  String get image_processing_ui_upload_in_progress_dialog_description =>
      'Uploading photo';

  @override
  String get image_processing_ui_upload_processing_ongoing_description =>
      'Processing ongoing';

  @override
  String get initial_setup_screen_age_confirmation_checkbox =>
      'I\'m at least 18 years old';

  @override
  String get initial_setup_screen_age_confirmation_title => 'Age confirmation';

  @override
  String get initial_setup_screen_email_hint_text => 'Insert email address';

  @override
  String get initial_setup_screen_email_title => 'My email address is…';

  @override
  String get initial_setup_screen_gender_title => 'I am…';

  @override
  String get initial_setup_screen_location_help_dialog_text =>
      'Select a location for your profile by tapping or long pressing the map.';

  @override
  String get initial_setup_screen_location_title =>
      'My profile\'s location is…';

  @override
  String get initial_setup_screen_profile_basic_info_profile_name_hint_text =>
      'Insert your first name';

  @override
  String get initial_setup_screen_profile_basic_info_profile_name_title =>
      'First name';

  @override
  String get initial_setup_screen_profile_basic_info_title =>
      'My profile has this info…';

  @override
  String
  get initial_setup_screen_profile_pictures_primary_image_face_not_detected =>
      'Face is not detected. Please select another picture.';

  @override
  String
  get initial_setup_screen_profile_pictures_primary_image_info_dialog_description =>
      'Adding at least of one profile image is required. The first profile image must be a face picture. The square shaped crop of the first profile image is displayed in profile grid and some other places in the app.';

  @override
  String
  get initial_setup_screen_profile_pictures_select_picture_dialog_title =>
      'Select picture…';

  @override
  String
  get initial_setup_screen_profile_pictures_select_picture_from_gallery_title =>
      'From gallery';

  @override
  String
  get initial_setup_screen_profile_pictures_select_picture_security_selfie_title =>
      'Security selfie';

  @override
  String
  get initial_setup_screen_profile_pictures_select_picture_take_new_picture_title =>
      'Take new photo';

  @override
  String get initial_setup_screen_profile_pictures_title =>
      'My profile pictures are…';

  @override
  String get initial_setup_screen_profile_pictures_unsupported_image_error =>
      'Selected image is not an JPEG image';

  @override
  String get initial_setup_screen_refresh_face_detected_values_action =>
      'Refresh face detection statuses';

  @override
  String get initial_setup_screen_search_settings_max_age_subtitle =>
      '…with max age…';

  @override
  String get initial_setup_screen_search_settings_min_age_subtitle =>
      '…with min age…';

  @override
  String get initial_setup_screen_search_settings_title =>
      'I am searching for…';

  @override
  String get initial_setup_screen_security_selfie_description =>
      'Take selfie with your phone\'s front camera. The selfie is used for moderating your profile images and by default it is only visible to content Moderators.';

  @override
  String get initial_setup_screen_security_selfie_face_not_detected =>
      'Face is not detected. Please try again several times and if necessary ask customer support to do manual face detection.';

  @override
  String get initial_setup_screen_security_selfie_title =>
      'My security selfie is…';

  @override
  String get initial_setup_screen_skip_dialog_description =>
      'Use this only if you will have some admin rights to the service.';

  @override
  String get initial_setup_screen_skip_dialog_title =>
      'Skip account initial setup?';

  @override
  String get likes_screen_like_loading_failed => 'Chat request loading failed';

  @override
  String get likes_screen_no_received_likes_found =>
      'No received chat requests';

  @override
  String get likes_screen_no_received_likes_found_description =>
      'Spread the word about the app in social media';

  @override
  String get likes_screen_refresh_action => 'Refresh';

  @override
  String get likes_screen_title => 'Pyynnöt';

  @override
  String get login_screen_connecting_websocket_failed =>
      'Connecting WebSocket failed. Try again later.';

  @override
  String get login_screen_demo_account_dialog_description =>
      'Login to demo account on the demo account server.';

  @override
  String get login_screen_demo_account_dialog_title => 'Demo account login';

  @override
  String get login_screen_demo_account_login_failed => 'Login failed';

  @override
  String get login_screen_demo_account_login_session_expired =>
      'Demo account session expired';

  @override
  String get login_screen_demo_account_password => 'Password';

  @override
  String get login_screen_demo_account_username => 'Username';

  @override
  String get login_screen_email_already_used =>
      'Email address is already in use by another account';

  @override
  String get login_screen_invalid_email_login_token =>
      'Invalid email login code';

  @override
  String get login_screen_ios_pwa_install_description =>
      'To use this app on iOS, please add it to your home screen:';

  @override
  String get login_screen_ios_pwa_install_step1 => '1. Tap the Share button';

  @override
  String get login_screen_ios_pwa_install_step2 =>
      '2. Scroll down and tap \"Add to Home Screen\"';

  @override
  String get login_screen_ios_pwa_install_step3 =>
      '3. Tap \"Add\" in the top right corner';

  @override
  String get login_screen_ios_pwa_install_step4 =>
      '4. Open the app from your home screen';

  @override
  String get login_screen_login_api_request_failed =>
      'Login API request failed. Try again later.';

  @override
  String get login_screen_login_note_text_and => 'and';

  @override
  String get login_screen_login_note_text_beginning =>
      'By signing in, you agree to our';

  @override
  String get login_screen_login_note_text_privacy_policy => 'Privacy Policy';

  @override
  String get login_screen_login_note_text_tos => 'Terms of Service';

  @override
  String get login_screen_registering_disabled_on_web =>
      'Registering new accounts is not possible using a web browser.';

  @override
  String get login_screen_sign_in_with_email_unverified =>
      'Email address of the selected account is not verified';

  @override
  String get login_screen_sign_in_with_error => 'Sign in with failed';

  @override
  String get map_location_update_failed => 'Location update failed';

  @override
  String get map_location_update_successful => 'Location update successful';

  @override
  String get map_openstreetmap_data_attribution_link_text =>
      'OpenStreetMap contributors';

  @override
  String get map_select_location_help_text =>
      'Tap or long press the map to select a location.';

  @override
  String get map_tile_error => 'Map tile error';

  @override
  String get menu_screen_server_maintenance_title => 'Maintenance break';

  @override
  String get menu_screen_title => 'Menu';

  @override
  String moderation_rejected_category(String p0) {
    return 'Rejected reason category: $p0';
  }

  @override
  String moderation_rejected_details(String p0) {
    return 'Rejected reason details: $p0';
  }

  @override
  String moderation_state(String p0) {
    return 'Moderation state: $p0';
  }

  @override
  String get moderation_state_accepted => 'Accepted';

  @override
  String get moderation_state_rejected_by_bot => 'Rejected by bot';

  @override
  String get moderation_state_rejected_by_human => 'Rejected by human';

  @override
  String get moderation_state_waiting_bot_or_human_moderation =>
      'Waiting bot or human moderation';

  @override
  String get moderation_state_waiting_human_moderation =>
      'Waiting human moderation';

  @override
  String get news_list_screen_create_new => 'Create new?';

  @override
  String get news_list_screen_news_loading_failed => 'News loading failed';

  @override
  String get news_list_screen_no_news_found => 'No news found';

  @override
  String get news_list_screen_not_published => 'Not published';

  @override
  String get news_list_screen_title => 'News';

  @override
  String notification_automatic_profile_search_found_profiles_multiple(
    String p0,
  ) {
    return '$p0 new or updated profiles found';
  }

  @override
  String get notification_automatic_profile_search_found_profiles_single =>
      'New or updated profile found';

  @override
  String get notification_category_automatic_profile_search =>
      'Automatic profile search';

  @override
  String get notification_category_group_chat => 'Chat';

  @override
  String get notification_category_group_content_moderation =>
      'Content moderation';

  @override
  String get notification_category_group_general => 'General';

  @override
  String get notification_category_likes => 'Requests';

  @override
  String get notification_category_media_content_moderation_completed =>
      'Images';

  @override
  String get notification_category_messages => 'Messages';

  @override
  String get notification_category_news_item_available => 'News';

  @override
  String get notification_category_profile_string_moderation_completed =>
      'Profile name and text';

  @override
  String get notification_like_received_multiple => 'Chat requests received';

  @override
  String get notification_like_received_single => 'Chat request received';

  @override
  String get notification_media_content_accepted => 'Image accepted';

  @override
  String get notification_media_content_deleted => 'Image deleted';

  @override
  String get notification_media_content_deleted_description =>
      'Unallowed content was detected from the image. This might be false positive detection.';

  @override
  String get notification_media_content_rejected => 'Image rejected';

  @override
  String notification_message_received_multiple(String p0) {
    return '$p0 sent messages';
  }

  @override
  String get notification_message_received_multiple_generic =>
      'New messages received';

  @override
  String notification_message_received_single(String p0) {
    return '$p0 sent a message';
  }

  @override
  String get notification_message_received_single_generic =>
      'New message received';

  @override
  String get notification_news_item_available => 'News available';

  @override
  String get notification_permission_dialog_description =>
      'Allow notifications to receive notifications for example from new chat requests and messages.';

  @override
  String get notification_permission_dialog_title => 'Allow notifications?';

  @override
  String get notification_profile_name_accepted => 'Profile name accepted';

  @override
  String get notification_profile_name_rejected => 'Profile name rejected';

  @override
  String get notification_profile_text_accepted => 'Profile text accepted';

  @override
  String get notification_profile_text_rejected => 'Profile text rejected';

  @override
  String get notification_settings_screen_ios_pwa_permission_denied =>
      'Permission not granted. Try again or grant permission from iOS system settings.';

  @override
  String
  get notification_settings_screen_notification_category_disabled_from_system_settings_text =>
      'Disabled from system notification settings';

  @override
  String
  get notification_settings_screen_notifications_disabled_from_system_settings_text =>
      'Notifications are disabled from system notification settings';

  @override
  String get notification_settings_screen_open_system_notification_settings =>
      'System notification settings';

  @override
  String get notification_settings_screen_title => 'Notifications';

  @override
  String get notification_settings_screen_web_permission_denied =>
      'Permission not granted. Try again or grant permission from browser settings.';

  @override
  String get notification_settings_screen_web_permission_not_enabled =>
      'Notification permission is not enabled';

  @override
  String get notification_settings_screen_web_request_permission =>
      'Enable notifications';

  @override
  String get privacy_settings_last_seen_time => 'Last seen time';

  @override
  String get privacy_settings_message_state_delivered =>
      'Message delivery receipts';

  @override
  String get privacy_settings_message_state_sent => 'Message read receipts';

  @override
  String get privacy_settings_online_status => 'Online status';

  @override
  String get privacy_settings_screen_chat_category => 'Chat';

  @override
  String get privacy_settings_screen_profile_category => 'Profile';

  @override
  String get privacy_settings_screen_title => 'Privacy';

  @override
  String get privacy_settings_typing_indicator => 'Typing indicator';

  @override
  String get profile_filters_screen_disable_filters_action => 'Disable filters';

  @override
  String get profile_filters_screen_disable_filters_action_dialog_title =>
      'Disable filters?';

  @override
  String get profile_filters_screen_distance_filter => 'Distance';

  @override
  String profile_filters_screen_distance_filter_max_value(String p0) {
    return 'Max $p0 km';
  }

  @override
  String profile_filters_screen_distance_filter_min_and_max_value(
    String p0,
    String p1,
  ) {
    return '$p0-$p1 km';
  }

  @override
  String profile_filters_screen_distance_filter_min_value(String p0) {
    return 'Min $p0 km';
  }

  @override
  String get profile_filters_screen_max_age_filter => 'Max age';

  @override
  String get profile_filters_screen_min_age_filter => 'Min age';

  @override
  String get profile_filters_screen_profile_created_filter => 'Profile created';

  @override
  String get profile_filters_screen_profile_edited_filter => 'Profile edited';

  @override
  String get profile_filters_screen_profile_last_seen_time_filter =>
      'Last seen';

  @override
  String get profile_filters_screen_profile_last_seen_time_filter_all =>
      'Anytime';

  @override
  String profile_filters_screen_profile_last_seen_time_filter_day(String p0) {
    return '$p0 day';
  }

  @override
  String profile_filters_screen_profile_last_seen_time_filter_days(String p0) {
    return '$p0 days';
  }

  @override
  String get profile_filters_screen_profile_last_seen_time_filter_online =>
      'Online';

  @override
  String get profile_filters_screen_profile_text_filter =>
      'Profile text length';

  @override
  String profile_filters_screen_profile_text_filter_max_value(String p0) {
    return 'Max $p0 characters';
  }

  @override
  String profile_filters_screen_profile_text_filter_min_and_max_value(
    String p0,
    String p1,
  ) {
    return '$p0-$p1 characters';
  }

  @override
  String profile_filters_screen_profile_text_filter_min_value(String p0) {
    return 'Min $p0 characters';
  }

  @override
  String get profile_filters_screen_title => 'Profile filters';

  @override
  String get profile_filters_screen_unlimited_likes_filter =>
      'Up for a date today';

  @override
  String get profile_filters_screen_updating_filters_failed =>
      'Updating profile filters failed';

  @override
  String profile_grid_screen_daily_likes_dialog_text(String p0, String p1) {
    return 'Daily chat requests left: $p0\nReset time: $p1';
  }

  @override
  String get profile_grid_screen_daily_likes_dialog_unlimited_likes_text =>
      'Sending chat requests to those who are up for a date today does not decrease daily chat requests.';

  @override
  String get profile_grid_screen_email_not_verified =>
      'Please verify your email address. A verification link has been sent to your email. If you don\'t see it, check your spam folder.';

  @override
  String get profile_grid_screen_email_not_verified_button =>
      'Account settings';

  @override
  String get profile_grid_screen_filtering_favorite_profiles_is_not_supported =>
      'Filtering favorite profiles is not supported';

  @override
  String get profile_grid_screen_initial_moderation_ongoing =>
      'You can view profiles and others can see your profile after your profile images are moderated.';

  @override
  String get profile_grid_screen_no_favorite_profiles_found_description =>
      'Mark a profile as a favorite to add it here.';

  @override
  String get profile_grid_screen_no_favorite_profiles_found_title =>
      'No favorite profiles found';

  @override
  String
  get profile_grid_screen_no_profiles_found_description_filters_disabled =>
      'Spread the word about the app in social media';

  @override
  String
  get profile_grid_screen_no_profiles_found_description_filters_enabled =>
      'Change or disable filter settings';

  @override
  String get profile_grid_screen_no_profiles_found_title => 'No profiles found';

  @override
  String get profile_grid_screen_primary_profile_content_does_not_exist =>
      'First profile picture does not exist';

  @override
  String get profile_grid_screen_primary_profile_content_face_not_detected =>
      'Face is not detected from first profile picture';

  @override
  String get profile_grid_screen_primary_profile_content_is_not_accepted =>
      'First profile picture is not accepted';

  @override
  String get profile_grid_screen_profile_filter_settings_update_ongoing =>
      'Profile filter settings update is ongoing';

  @override
  String get profile_grid_screen_profile_is_private_info =>
      'To view profiles, set your profile visibility to public from app settings.';

  @override
  String get profile_grid_screen_security_content_does_not_exist =>
      'Security selfie does not exist';

  @override
  String get profile_grid_screen_security_content_is_not_accepted =>
      'Security selfie is not accepted';

  @override
  String get profile_grid_screen_show_all_profiles_action =>
      'Show all profiles';

  @override
  String get profile_grid_screen_show_favorite_profiles_action =>
      'Show favorite profiles';

  @override
  String get profile_grid_screen_start_initial_setup_button =>
      'Start account initial setup';

  @override
  String get profile_grid_screen_title => 'Profiles';

  @override
  String get profile_grid_settings_screen_all_grids_title =>
      'All profile grids';

  @override
  String get profile_grid_settings_screen_profiles_screen => 'Profiles screen';

  @override
  String get profile_grid_settings_screen_random_profile_order =>
      'Random profile order';

  @override
  String
  get profile_grid_settings_screen_random_profile_order_description_disabled =>
      'Start from your location';

  @override
  String
  get profile_grid_settings_screen_random_profile_order_description_enabled =>
      'Start from random location';

  @override
  String get profile_grid_settings_screen_title => 'Profile grid';

  @override
  String get profile_image_error_image_not_accepted =>
      'Profile image is not accepted by moderators';

  @override
  String get profile_image_error_no_image => 'No profile image';

  @override
  String get profile_image_error_no_primary_image => 'No primary profile image';

  @override
  String get profile_location_screen_title => 'Location';

  @override
  String get profile_statistics_history_screen_title =>
      'Profile statistics history';

  @override
  String get report_chat_message_screen_backend_signed_message_not_found =>
      'Backend signed message not found';

  @override
  String get report_chat_message_screen_confirm_dialog_title =>
      'Report chat message?';

  @override
  String
  get report_chat_message_screen_symmetric_message_encryption_key_not_found =>
      'Symmetric message encryption key not found';

  @override
  String get report_profile_image_screen_confirm_dialog_title =>
      'Report profile image?';

  @override
  String report_profile_image_screen_image_title(String p0) {
    return 'Profile image $p0';
  }

  @override
  String get report_profile_image_screen_profile_image_changed_error =>
      'Report failed. Profile image has changed.';

  @override
  String get report_screen_chat_message_action => 'Chat message';

  @override
  String report_screen_custom_report_boolean_dialog_description(String p0) {
    return 'Report user as \'$p0\'?';
  }

  @override
  String get report_screen_custom_report_boolean_dialog_title => 'Report?';

  @override
  String get report_screen_profile_image_action => 'Profile image';

  @override
  String get report_screen_profile_name_action => 'Profile name';

  @override
  String get report_screen_profile_name_changed_error =>
      'Report failed. Profile name has changed.';

  @override
  String get report_screen_profile_name_dialog_title => 'Report profile name?';

  @override
  String get report_screen_profile_text_action => 'Profile text';

  @override
  String get report_screen_profile_text_changed_error =>
      'Report failed. Profile text has changed.';

  @override
  String get report_screen_profile_text_dialog_title => 'Report profile text?';

  @override
  String get report_screen_snackbar_report_successful => 'Reported';

  @override
  String get report_screen_snackbar_too_many_reports_error =>
      'Report failed. Too many reports.';

  @override
  String get report_screen_title => 'Report';

  @override
  String get search_settings_screen_automatic_search => 'Automatic search';

  @override
  String get search_settings_screen_change_gender_filter_action_tile =>
      'Gender filter';

  @override
  String get search_settings_screen_change_my_gender_action_title =>
      'Change my profile\'s gender';

  @override
  String get search_settings_screen_distance => 'Use max distance filter';

  @override
  String get search_settings_screen_filters =>
      'Use multiple-choice question filters';

  @override
  String get search_settings_screen_gender_filter_is_not_selected =>
      'Gender filter is not selected';

  @override
  String get search_settings_screen_gender_is_not_selected =>
      'Your gender information is not set';

  @override
  String get search_settings_screen_new_profiles => 'Show only new profiles';

  @override
  String get search_settings_screen_search_settings_update_failed =>
      'Updating search settings failed';

  @override
  String get search_settings_screen_title => 'Profile search';

  @override
  String get search_settings_screen_weekdays => 'Search weekdays';

  @override
  String select_content_screen_count(String p0, String p1) {
    return 'Images $p0/$p1';
  }

  @override
  String get select_content_screen_face_detected => 'Face detected';

  @override
  String get select_content_screen_title => 'Select image';

  @override
  String get select_match_screen_title => 'Accepted chat requests';

  @override
  String get server_connection_indicator_connection_failed =>
      'Connection failed';

  @override
  String get server_connection_indicator_connection_failed_dialog_text =>
      'Unable to connect to the server. Please check your internet connection and try again later. If the problem persists, the server may be temporarily unavailable.';

  @override
  String server_connection_indicator_reconnecting_in_seconds(String p0) {
    return 'Reconnecting in ${p0}s';
  }

  @override
  String get settings_screen_data_category => 'Data';

  @override
  String get settings_screen_general_category => 'General';

  @override
  String get settings_screen_privacy_and_security_category =>
      'Privacy and security';

  @override
  String get settings_screen_profile_category => 'Profile';

  @override
  String get settings_screen_profile_visiblity_pending_public_description =>
      'Your profile will be visible in profile grid once your images are moderated as accepted';

  @override
  String get settings_screen_profile_visiblity_private_description =>
      'Your profile is not visible in profile grid';

  @override
  String get settings_screen_profile_visiblity_public_description =>
      'Your profile is visible in profile grid';

  @override
  String get settings_screen_profile_visiblity_setting => 'Profile visibility';

  @override
  String get settings_screen_title => 'Asetukset';

  @override
  String get snackbar_api_usage_limit_reached =>
      'API usage limit is reached. Try again tomorrow.';

  @override
  String get snackbar_error_api => 'API error';

  @override
  String get snackbar_error_database => 'Database error';

  @override
  String get snackbar_error_file => 'File error';

  @override
  String get snackbar_error_logic => 'Logic error';

  @override
  String get splash_screen_app_is_already_running => 'App is already running';

  @override
  String statistics_screen_age_range(String p0) {
    return 'Ages: $p0';
  }

  @override
  String statistics_screen_count_all_profiles(String p0) {
    return 'All profiles: $p0';
  }

  @override
  String statistics_screen_count_men(String p0) {
    return 'Men: $p0';
  }

  @override
  String statistics_screen_count_nonbinaries(String p0) {
    return 'Non-binaries: $p0';
  }

  @override
  String statistics_screen_count_online_users(String p0) {
    return 'Online users: $p0';
  }

  @override
  String statistics_screen_count_online_users_bar_chart_tooltip(String p0) {
    return 'Online: $p0';
  }

  @override
  String statistics_screen_count_private_profiles(String p0) {
    return 'Private profiles: $p0';
  }

  @override
  String statistics_screen_count_public_profiles(String p0) {
    return 'Public profiles: $p0';
  }

  @override
  String statistics_screen_count_registered_users(String p0) {
    return 'Registered users: $p0';
  }

  @override
  String statistics_screen_count_women(String p0) {
    return 'Women: $p0';
  }

  @override
  String statistics_screen_hour_value(String p0) {
    return 'Hour: $p0';
  }

  @override
  String get statistics_screen_online_users_per_hour_statistics_title =>
      'Online users per hour';

  @override
  String statistics_screen_time(String p0) {
    return 'Time: $p0';
  }

  @override
  String get statistics_screen_title => 'Statistics';

  @override
  String get unsupported_client_screen_info =>
      'Current app version is not supported. Please update the app.';

  @override
  String get unsupported_client_screen_title => 'App update required';

  @override
  String get url_app_privacy_policy_link => 'https://example.com';

  @override
  String get url_app_tos_link => 'https://example.com';

  @override
  String get view_image_screen_title => 'Kuva';

  @override
  String view_news_screen_edited(String p0) {
    return 'Edited: $p0';
  }

  @override
  String view_news_screen_published(String p0) {
    return 'Published: $p0';
  }

  @override
  String get view_profile_screen_add_to_favorites_action => 'Add to favorites';

  @override
  String get view_profile_screen_add_to_favorites_action_successful =>
      'Added to favorites';

  @override
  String get view_profile_screen_already_match =>
      'Chatting is already possible';

  @override
  String get view_profile_screen_block_action => 'Block';

  @override
  String get view_profile_screen_block_action_dialog_title => 'Block profile?';

  @override
  String get view_profile_screen_block_action_successful => 'Profile blocked';

  @override
  String get view_profile_screen_chat_action => 'Chat';

  @override
  String get view_profile_screen_like_action => 'Send chat request';

  @override
  String get view_profile_screen_like_action_dialog_title =>
      'Send chat request?';

  @override
  String get view_profile_screen_like_action_like_already_sent =>
      'Chat request already sent';

  @override
  String get view_profile_screen_like_action_successful => 'Chat request sent';

  @override
  String get view_profile_screen_like_action_try_again_tomorrow =>
      'No daily chat requests left. Try again tomorrow.';

  @override
  String get view_profile_screen_my_profile_edit_action => 'Edit profile';

  @override
  String get view_profile_screen_my_profile_initial_setup_not_done =>
      'Dating profile is not created';

  @override
  String get view_profile_screen_my_profile_title => 'My profile';

  @override
  String
  get view_profile_screen_non_accepted_profile_content_info_dialog_text =>
      'All profile pictures are not yet moderated or some picture is moderated as rejected. Only accepted pictures are visible to users.';

  @override
  String
  view_profile_screen_non_accepted_profile_content_info_dialog_text_picture_title(
    String p0,
  ) {
    return 'Picture $p0';
  }

  @override
  String get view_profile_screen_non_accepted_profile_name_info_dialog_text =>
      'Profile name is not yet moderated or it is moderated as rejected. Only the first letter is visible to users.';

  @override
  String get view_profile_screen_non_accepted_profile_text_info_dialog_text =>
      'Profile text is not yet moderated or it is moderated as rejected. Only the first letter is visible to users.';

  @override
  String get view_profile_screen_profile_currently_online => 'Online';

  @override
  String get view_profile_screen_profile_edit_failed =>
      'Profile editing failed';

  @override
  String view_profile_screen_profile_last_seen_day(String p0) {
    return 'Last seen $p0 day ago';
  }

  @override
  String view_profile_screen_profile_last_seen_days(String p0) {
    return 'Last seen $p0 days ago';
  }

  @override
  String view_profile_screen_profile_last_seen_hour(String p0) {
    return 'Last seen $p0 hour ago';
  }

  @override
  String view_profile_screen_profile_last_seen_hours(String p0) {
    return 'Last seen $p0 hours ago';
  }

  @override
  String view_profile_screen_profile_last_seen_minute(String p0) {
    return 'Last seen $p0 minute ago';
  }

  @override
  String view_profile_screen_profile_last_seen_minutes(String p0) {
    return 'Last seen $p0 minutes ago';
  }

  @override
  String view_profile_screen_profile_last_seen_second(String p0) {
    return 'Last seen $p0 second ago';
  }

  @override
  String view_profile_screen_profile_last_seen_seconds(String p0) {
    return 'Last seen $p0 seconds ago';
  }

  @override
  String get view_profile_screen_remove_from_favorites_action =>
      'Remove from favorites';

  @override
  String get view_profile_screen_remove_from_favorites_action_successful =>
      'Removed from favorites';
}
