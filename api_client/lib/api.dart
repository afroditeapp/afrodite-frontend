//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
part 'api/chat_api.dart';
part 'api/common_api.dart';
part 'api/common_admin_api.dart';
part 'api/media_api.dart';
part 'api/media_admin_api.dart';
part 'api/media_internal_api.dart';
part 'api/profile_api.dart';

part 'model/access_token.dart';
part 'model/accessible_account.dart';
part 'model/account.dart';
part 'model/account_content.dart';
part 'model/account_data.dart';
part 'model/account_id.dart';
part 'model/account_setup.dart';
part 'model/account_state.dart';
part 'model/account_sync_version.dart';
part 'model/attribute.dart';
part 'model/attribute_mode.dart';
part 'model/attribute_order_mode.dart';
part 'model/attribute_value.dart';
part 'model/attribute_value_order_mode.dart';
part 'model/auth_pair.dart';
part 'model/available_profile_attributes.dart';
part 'model/backend_config.dart';
part 'model/backend_version.dart';
part 'model/boolean_setting.dart';
part 'model/bot_config.dart';
part 'model/build_info.dart';
part 'model/capabilities.dart';
part 'model/command_output.dart';
part 'model/content_access_check.dart';
part 'model/content_id.dart';
part 'model/content_info.dart';
part 'model/content_info_detailed.dart';
part 'model/content_processing_id.dart';
part 'model/content_processing_state.dart';
part 'model/content_processing_state_changed.dart';
part 'model/content_processing_state_type.dart';
part 'model/content_slot.dart';
part 'model/content_state.dart';
part 'model/delete_status.dart';
part 'model/demo_mode_confirm_login.dart';
part 'model/demo_mode_confirm_login_result.dart';
part 'model/demo_mode_login_result.dart';
part 'model/demo_mode_login_to_account.dart';
part 'model/demo_mode_login_token.dart';
part 'model/demo_mode_password.dart';
part 'model/demo_mode_token.dart';
part 'model/download_type.dart';
part 'model/download_type_query_param.dart';
part 'model/event_to_client.dart';
part 'model/event_type.dart';
part 'model/favorite_profiles_page.dart';
part 'model/group_values.dart';
part 'model/handle_moderation_request.dart';
part 'model/icon_location.dart';
part 'model/icon_resource.dart';
part 'model/language.dart';
part 'model/latest_viewed_message_changed.dart';
part 'model/location.dart';
part 'model/login_result.dart';
part 'model/map_tile_x.dart';
part 'model/map_tile_y.dart';
part 'model/map_tile_z.dart';
part 'model/matches_page.dart';
part 'model/matches_sync_version.dart';
part 'model/media_content_type.dart';
part 'model/message_number.dart';
part 'model/moderation.dart';
part 'model/moderation_list.dart';
part 'model/moderation_queue_type.dart';
part 'model/moderation_queue_type_param.dart';
part 'model/moderation_request.dart';
part 'model/moderation_request_content.dart';
part 'model/moderation_request_id.dart';
part 'model/moderation_request_state.dart';
part 'model/new_content_params.dart';
part 'model/pending_message.dart';
part 'model/pending_message_delete_list.dart';
part 'model/pending_message_id.dart';
part 'model/pending_messages_page.dart';
part 'model/pending_profile_content.dart';
part 'model/pending_security_content.dart';
part 'model/perf_history_query.dart';
part 'model/perf_history_query_result.dart';
part 'model/perf_history_value.dart';
part 'model/perf_value_area.dart';
part 'model/profile.dart';
part 'model/profile_age.dart';
part 'model/profile_all_of.dart';
part 'model/profile_attribute_filter_list.dart';
part 'model/profile_attribute_filter_list_update.dart';
part 'model/profile_attribute_filter_value.dart';
part 'model/profile_attribute_filter_value_update.dart';
part 'model/profile_attribute_value.dart';
part 'model/profile_attribute_value_update.dart';
part 'model/profile_attributes.dart';
part 'model/profile_attributes_sync_version.dart';
part 'model/profile_content.dart';
part 'model/profile_link.dart';
part 'model/profile_page.dart';
part 'model/profile_search_age_range.dart';
part 'model/profile_update.dart';
part 'model/profile_version.dart';
part 'model/profile_visibility.dart';
part 'model/reboot_query_param.dart';
part 'model/received_blocks_page.dart';
part 'model/received_blocks_sync_version.dart';
part 'model/received_likes_page.dart';
part 'model/received_likes_sync_version.dart';
part 'model/refresh_token.dart';
part 'model/reset_data_query_param.dart';
part 'model/search_groups.dart';
part 'model/security_content.dart';
part 'model/send_message_to_account.dart';
part 'model/sent_blocks_page.dart';
part 'model/sent_blocks_sync_version.dart';
part 'model/sent_likes_page.dart';
part 'model/sent_likes_sync_version.dart';
part 'model/set_profile_content.dart';
part 'model/sign_in_with_login_info.dart';
part 'model/slot_id.dart';
part 'model/software_info.dart';
part 'model/software_options.dart';
part 'model/sync_version.dart';
part 'model/system_info.dart';
part 'model/system_info_list.dart';
part 'model/time_granularity.dart';
part 'model/translation.dart';
part 'model/unix_time.dart';
part 'model/update_message_view_status.dart';


const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

ApiClient defaultApiClient = ApiClient();
