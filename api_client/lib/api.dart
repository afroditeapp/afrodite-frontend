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
part 'api/accountinternal_api.dart';
part 'api/media_api.dart';
part 'api/mediainternal_api.dart';
part 'api/profile_api.dart';

part 'model/account.dart';
part 'model/account_id.dart';
part 'model/account_id_light.dart';
part 'model/account_setup.dart';
part 'model/account_state.dart';
part 'model/api_key.dart';
part 'model/boolean_setting.dart';
part 'model/capabilities.dart';
part 'model/delete_status.dart';
part 'model/handle_moderation_request.dart';
part 'model/image_file.dart';
part 'model/image_file_name.dart';
part 'model/location.dart';
part 'model/moderation_request.dart';
part 'model/moderation_request_list.dart';
part 'model/new_moderation_request.dart';
part 'model/profile.dart';
part 'model/profile_link.dart';
part 'model/profile_page.dart';
part 'model/slot_id.dart';


const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

ApiClient defaultApiClient = ApiClient();
