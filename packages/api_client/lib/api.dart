//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/account_api.dart';
part 'api/account_admin_api.dart';
part 'api/account_bot_api.dart';
part 'api/chat_api.dart';
part 'api/common_api.dart';
part 'api/common_admin_api.dart';
part 'api/media_api.dart';
part 'api/media_admin_api.dart';
part 'api/profile_api.dart';
part 'api/profile_admin_api.dart';

part 'model/accepted_profile_ages.dart';
part 'model/access_token.dart';
part 'model/accessible_account.dart';
part 'model/account.dart';
part 'model/account_ban_reason_category.dart';
part 'model/account_ban_reason_details.dart';
part 'model/account_content.dart';
part 'model/account_data.dart';
part 'model/account_id.dart';
part 'model/account_id_db_value.dart';
part 'model/account_setup.dart';
part 'model/account_state_container.dart';
part 'model/account_sync_version.dart';
part 'model/admin_info.dart';
part 'model/all_matches_page.dart';
part 'model/api_usage_count.dart';
part 'model/api_usage_statistics.dart';
part 'model/attribute.dart';
part 'model/attribute_id_and_hash.dart';
part 'model/attribute_mode.dart';
part 'model/attribute_order_mode.dart';
part 'model/attribute_value.dart';
part 'model/attribute_value_order_mode.dart';
part 'model/auth_pair.dart';
part 'model/backend_config.dart';
part 'model/backend_version.dart';
part 'model/boolean_setting.dart';
part 'model/bot_config.dart';
part 'model/client_config.dart';
part 'model/client_config_sync_version.dart';
part 'model/client_features_config.dart';
part 'model/client_features_file_hash.dart';
part 'model/client_id.dart';
part 'model/client_info.dart';
part 'model/client_local_id.dart';
part 'model/client_type.dart';
part 'model/client_version.dart';
part 'model/client_version_count.dart';
part 'model/client_version_statistics.dart';
part 'model/command_output.dart';
part 'model/content_id.dart';
part 'model/content_info.dart';
part 'model/content_info_detailed.dart';
part 'model/content_info_with_fd.dart';
part 'model/content_moderation_state.dart';
part 'model/content_processing_id.dart';
part 'model/content_processing_state.dart';
part 'model/content_processing_state_changed.dart';
part 'model/content_processing_state_type.dart';
part 'model/content_slot.dart';
part 'model/current_account_interaction_state.dart';
part 'model/custom_report.dart';
part 'model/custom_report_content.dart';
part 'model/custom_report_language.dart';
part 'model/custom_report_translation.dart';
part 'model/custom_report_type.dart';
part 'model/custom_reports_config.dart';
part 'model/custom_reports_file_hash.dart';
part 'model/custom_reports_order_mode.dart';
part 'model/delete_like_result.dart';
part 'model/demo_mode_confirm_login.dart';
part 'model/demo_mode_confirm_login_result.dart';
part 'model/demo_mode_login_result.dart';
part 'model/demo_mode_login_to_account.dart';
part 'model/demo_mode_login_token.dart';
part 'model/demo_mode_password.dart';
part 'model/demo_mode_token.dart';
part 'model/event_to_client.dart';
part 'model/event_type.dart';
part 'model/favorite_profiles_page.dart';
part 'model/fcm_device_token.dart';
part 'model/features_config.dart';
part 'model/get_account_ban_time_result.dart';
part 'model/get_account_deletion_request_result.dart';
part 'model/get_account_id_from_email_result.dart';
part 'model/get_all_admins_result.dart';
part 'model/get_api_usage_statistics_result.dart';
part 'model/get_api_usage_statistics_settings.dart';
part 'model/get_client_features_config_result.dart';
part 'model/get_client_version_statistics_result.dart';
part 'model/get_client_version_statistics_settings.dart';
part 'model/get_custom_reports_config_result.dart';
part 'model/get_initial_profile_age_info_result.dart';
part 'model/get_ip_address_statistics_result.dart';
part 'model/get_ip_address_statistics_settings.dart';
part 'model/get_media_content_result.dart';
part 'model/get_my_profile_result.dart';
part 'model/get_news_item_result.dart';
part 'model/get_profile_age_and_name.dart';
part 'model/get_profile_content_pending_moderation_list.dart';
part 'model/get_profile_content_result.dart';
part 'model/get_profile_filtering_settings.dart';
part 'model/get_profile_name_pending_moderation_list.dart';
part 'model/get_profile_name_state.dart';
part 'model/get_profile_result.dart';
part 'model/get_profile_statistics_history_result.dart';
part 'model/get_profile_statistics_result.dart';
part 'model/get_profile_text_pending_moderation_list.dart';
part 'model/get_profile_text_state.dart';
part 'model/get_public_key.dart';
part 'model/get_report_list.dart';
part 'model/group_values.dart';
part 'model/initial_content_moderation_completed_result.dart';
part 'model/ip_address_info.dart';
part 'model/language.dart';
part 'model/last_seen_time_filter.dart';
part 'model/latest_birthdate.dart';
part 'model/latest_viewed_message_changed.dart';
part 'model/limited_action_status.dart';
part 'model/location.dart';
part 'model/login_result.dart';
part 'model/maintenance_task.dart';
part 'model/manager_instance_name_list.dart';
part 'model/map_bounds.dart';
part 'model/map_config.dart';
part 'model/map_coordinate.dart';
part 'model/map_zoom.dart';
part 'model/matches_iterator_session_id.dart';
part 'model/matches_page.dart';
part 'model/matches_sync_version.dart';
part 'model/max_distance_km.dart';
part 'model/media_content_sync_version.dart';
part 'model/media_content_type.dart';
part 'model/message_number.dart';
part 'model/moderation_queue_type.dart';
part 'model/my_profile_content.dart';
part 'model/new_received_likes_count.dart';
part 'model/new_received_likes_count_result.dart';
part 'model/news_id.dart';
part 'model/news_item.dart';
part 'model/news_item_simple.dart';
part 'model/news_iterator_session_id.dart';
part 'model/news_page.dart';
part 'model/news_sync_version.dart';
part 'model/news_translation_version.dart';
part 'model/page_item_count_for_new_likes.dart';
part 'model/page_item_count_for_new_public_news.dart';
part 'model/pending_message.dart';
part 'model/pending_message_acknowledgement_list.dart';
part 'model/pending_message_id.dart';
part 'model/pending_notification_token.dart';
part 'model/pending_notification_with_data.dart';
part 'model/perf_metric_query.dart';
part 'model/perf_metric_query_result.dart';
part 'model/perf_metric_value_area.dart';
part 'model/perf_metric_values.dart';
part 'model/permissions.dart';
part 'model/post_moderate_profile_content.dart';
part 'model/post_moderate_profile_name.dart';
part 'model/post_moderate_profile_text.dart';
part 'model/process_report.dart';
part 'model/profile.dart';
part 'model/profile_age_counts.dart';
part 'model/profile_attribute_filter_value.dart';
part 'model/profile_attribute_filter_value_update.dart';
part 'model/profile_attribute_hash.dart';
part 'model/profile_attribute_info.dart';
part 'model/profile_attribute_query.dart';
part 'model/profile_attribute_query_item.dart';
part 'model/profile_attribute_query_result.dart';
part 'model/profile_attribute_value.dart';
part 'model/profile_attribute_value_update.dart';
part 'model/profile_content.dart';
part 'model/profile_content_moderation_rejected_reason_category.dart';
part 'model/profile_content_moderation_rejected_reason_details.dart';
part 'model/profile_content_pending_moderation.dart';
part 'model/profile_content_version.dart';
part 'model/profile_created_time_filter.dart';
part 'model/profile_edited_time_filter.dart';
part 'model/profile_filtering_settings_update.dart';
part 'model/profile_iterator_page.dart';
part 'model/profile_iterator_page_value.dart';
part 'model/profile_iterator_session_id.dart';
part 'model/profile_link.dart';
part 'model/profile_name_moderation_state.dart';
part 'model/profile_name_pending_moderation.dart';
part 'model/profile_page.dart';
part 'model/profile_search_age_range.dart';
part 'model/profile_statistics_history_value.dart';
part 'model/profile_statistics_history_value_type.dart';
part 'model/profile_sync_version.dart';
part 'model/profile_text_moderation_info.dart';
part 'model/profile_text_moderation_rejected_reason_category.dart';
part 'model/profile_text_moderation_rejected_reason_details.dart';
part 'model/profile_text_moderation_state.dart';
part 'model/profile_text_pending_moderation.dart';
part 'model/profile_update.dart';
part 'model/profile_version.dart';
part 'model/profile_visibility.dart';
part 'model/public_key.dart';
part 'model/public_key_data.dart';
part 'model/public_key_id.dart';
part 'model/public_key_id_and_version.dart';
part 'model/public_key_version.dart';
part 'model/received_blocks_page.dart';
part 'model/received_blocks_sync_version.dart';
part 'model/received_likes_iterator_session_id.dart';
part 'model/received_likes_page.dart';
part 'model/received_likes_sync_version.dart';
part 'model/refresh_token.dart';
part 'model/remote_bot_login.dart';
part 'model/report_account_info.dart';
part 'model/report_chat_info.dart';
part 'model/report_chat_info_interaction_state.dart';
part 'model/report_content.dart';
part 'model/report_detailed.dart';
part 'model/report_detailed_info.dart';
part 'model/report_iterator_mode.dart';
part 'model/report_iterator_query.dart';
part 'model/report_processing_state.dart';
part 'model/report_type_number.dart';
part 'model/reset_matches_iterator_result.dart';
part 'model/reset_news_iterator_result.dart';
part 'model/reset_received_likes_iterator_result.dart';
part 'model/scheduled_maintenance_status.dart';
part 'model/scheduled_task_status.dart';
part 'model/scheduled_task_type.dart';
part 'model/scheduled_task_type_value.dart';
part 'model/search_groups.dart';
part 'model/security_content.dart';
part 'model/send_like_result.dart';
part 'model/send_message_result.dart';
part 'model/sent_blocks_page.dart';
part 'model/sent_blocks_sync_version.dart';
part 'model/sent_likes_page.dart';
part 'model/sent_likes_sync_version.dart';
part 'model/sent_message_id.dart';
part 'model/sent_message_id_list.dart';
part 'model/set_account_ban_state.dart';
part 'model/set_account_setup.dart';
part 'model/set_profile_content.dart';
part 'model/set_profile_name.dart';
part 'model/set_public_key.dart';
part 'model/sign_in_with_login_info.dart';
part 'model/software_info.dart';
part 'model/software_update_state.dart';
part 'model/software_update_status.dart';
part 'model/statistics_profile_visibility.dart';
part 'model/sync_version.dart';
part 'model/system_info.dart';
part 'model/time_granularity.dart';
part 'model/translation.dart';
part 'model/unix_time.dart';
part 'model/unread_news_count.dart';
part 'model/unread_news_count_result.dart';
part 'model/update_chat_message_report.dart';
part 'model/update_custom_report_boolean.dart';
part 'model/update_message_view_status.dart';
part 'model/update_news_translation.dart';
part 'model/update_news_translation_result.dart';
part 'model/update_profile_content_report.dart';
part 'model/update_profile_name_report.dart';
part 'model/update_profile_text_report.dart';
part 'model/update_report_result.dart';


/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient();

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) => pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';
