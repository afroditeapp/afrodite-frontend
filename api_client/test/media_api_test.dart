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
    //Future<MultipartFile> getImage(String accountId, String contentId) async
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

    // Get current list of moderation requests in my moderation queue.
    //
    // Get current list of moderation requests in my moderation queue. Additional requests will be added to my queue if necessary.  ## Access  Account with `admin_moderate_images` capability is required to access this route. 
    //
    //Future<ModerationList> patchModerationRequestList() async
    test('test patchModerationRequestList', () async {
      // TODO
    });

    // Handle moderation request of some account.
    //
    // Handle moderation request of some account.  ## Access  Account with `admin_moderate_images` capability is required to access this route. 
    //
    //Future postHandleModerationRequest(String accountId, HandleModerationRequest handleModerationRequest) async
    test('test postHandleModerationRequest', () async {
      // TODO
    });

    // Set image to moderation request slot.
    //
    // Set image to moderation request slot.  Slots from 0 to 2 are available.  TODO: resize and check images at some point 
    //
    //Future<ContentId> putImageToModerationSlot(int slotId, MultipartFile body) async
    test('test putImageToModerationSlot', () async {
      // TODO
    });

    // Create new or override old moderation request.
    //
    // Create new or override old moderation request.  Make sure that moderation request has content IDs which points to your own image slots. 
    //
    //Future putModerationRequest(ModerationRequestContent moderationRequestContent) async
    test('test putModerationRequest', () async {
      // TODO
    });

  });
}
