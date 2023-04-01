//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:openapi/api.dart';
import 'package:test/test.dart';


/// tests for ProfileApi
void main() {
  // final instance = ProfileApi();

  group('tests for ProfileApi', () {
    // TODO: Remove this at some point
    //
    // TODO: Remove this at some point
    //
    //Future<Profile> getDefaultProfile(String accountId) async
    test('test getDefaultProfile', () async {
      // TODO
    });

    // Get next page of profile list.
    //
    // Get next page of profile list.
    //
    //Future<ProfilePage> getNextProfilePage() async
    test('test getNextProfilePage', () async {
      // TODO
    });

    // Get account's current profile.
    //
    // Get account's current profile.  Profile can include version UUID which can be used for caching.  # Access Public profile access requires `view_public_profiles` capability. Public and private profile access requires `admin_view_all_profiles` capablility.  # Microservice notes If account feature is set as external service then cached capability information from account service is used for access checks.
    //
    //Future<Profile> getProfile(String accountId) async
    test('test getProfile', () async {
      // TODO
    });

    // Update profile information.
    //
    // Update profile information.  Writes the profile to the database only if it is changed.  TODO: string lenght validation, limit saving new profiles
    //
    //Future postProfile(Profile profile) async
    test('test postProfile', () async {
      // TODO
    });

    // Reset profile paging.
    //
    // Reset profile paging.  After this request getting next profiles will continue from the nearest profiles.
    //
    //Future postResetProfilePaging() async
    test('test postResetProfilePaging', () async {
      // TODO
    });

    // Update location
    //
    // Update location
    //
    //Future putLocation(Location location) async
    test('test putLocation', () async {
      // TODO
    });

  });
}
