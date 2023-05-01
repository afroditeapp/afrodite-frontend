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


/// tests for AccountApi
void main() {
  // final instance = AccountApi();

  group('tests for AccountApi', () {
    // Cancel account deletion.
    //
    // Cancel account deletion.  Account state will move to previous state.
    //
    //Future deleteCancelDeletion() async
    test('test deleteCancelDeletion', () async {
      // TODO
    });

    // Get current account state.
    //
    // Get current account state.
    //
    //Future<Account> getAccountState() async
    test('test getAccountState', () async {
      // TODO
    });

    // Get deletion status.
    //
    // Get deletion status.  Get information when account will be really deleted.
    //
    //Future<DeleteStatus> getDeletionStatus() async
    test('test getDeletionStatus', () async {
      // TODO
    });

    // Setup non-changeable user information during `initial setup` state.
    //
    // Setup non-changeable user information during `initial setup` state.
    //
    //Future postAccountSetup(AccountSetup accountSetup) async
    test('test postAccountSetup', () async {
      // TODO
    });

    // Complete initial setup.
    //
    // Complete initial setup.  Request to this handler will complete if client is in `initial setup`, setup information is set and image moderation request has been made. 
    //
    //Future postCompleteSetup() async
    test('test postCompleteSetup', () async {
      // TODO
    });

    // Delete account.
    //
    // Delete account.  Changes account state to `pending deletion` from all possible states. Previous state will be saved, so it will be possible to stop automatic deletion process.
    //
    //Future postDelete() async
    test('test postDelete', () async {
      // TODO
    });

    // Get new ApiKey.
    //
    // Get new ApiKey.
    //
    //Future<ApiKey> postLogin(AccountIdLight accountIdLight) async
    test('test postLogin', () async {
      // TODO
    });

    // Register new account. Returns new account ID which is UUID.
    //
    // Register new account. Returns new account ID which is UUID.
    //
    //Future<AccountIdLight> postRegister() async
    test('test postRegister', () async {
      // TODO
    });

    // Update profile visiblity value.
    //
    // Update profile visiblity value.  This will check that the first image moderation request has been moderated before this turns the profile public.  Sets capablity `view_public_profiles` on or off depending on the value.
    //
    //Future putSettingProfileVisiblity(BooleanSetting booleanSetting) async
    test('test putSettingProfileVisiblity', () async {
      // TODO
    });

  });
}
