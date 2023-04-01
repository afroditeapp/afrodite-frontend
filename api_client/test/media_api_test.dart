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


/// tests for MediaApi
void main() {
  // final instance = MediaApi();

  group('tests for MediaApi', () {
    // Get profile image
    //
    // Get profile image
    //
    //Future getImage(String accountId, String imageFile) async
    test('test getImage', () async {
      // TODO
    });

    // Get current moderation request.
    //
    // Get current moderation request. 
    //
    //Future<ModerationRequest> getModerationRequest() async
    test('test getModerationRequest', () async {
      // TODO
    });

    // Get list of next moderation requests in moderation queue.
    //
    // Get list of next moderation requests in moderation queue.  ## Access  Account with `admin_moderate_images` capability is required to access this route. 
    //
    //Future<ModerationRequestList> getModerationRequestList() async
    test('test getModerationRequestList', () async {
      // TODO
    });

    // Handle moderation request.
    //
    // Handle moderation request.  ## Access  Account with `admin_moderate_images` capability is required to access this route. 
    //
    //Future postHandleModerationRequest(String requestId, HandleModerationRequest handleModerationRequest) async
    test('test postHandleModerationRequest', () async {
      // TODO
    });

    // Set image to moderation request slot.
    //
    // Set image to moderation request slot.  Slots \"camera\" and \"image1\" are available. 
    //
    //Future putImageToModerationSlot(String slotId, String body) async
    test('test putImageToModerationSlot', () async {
      // TODO
    });

    // Create new or override old moderation request.
    //
    // Create new or override old moderation request.  Set images to moderation request slots first. 
    //
    //Future putModerationRequest(NewModerationRequest newModerationRequest) async
    test('test putModerationRequest', () async {
      // TODO
    });

  });
}
