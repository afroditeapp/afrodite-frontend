
import "package:openapi/api.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:app/utils/immutable_list.dart";

part 'new_moderation_request.freezed.dart';


@freezed
class NewModerationRequestData with _$NewModerationRequestData {
  factory NewModerationRequestData({
    @Default(AddedImages()) AddedImages selectedImgs,
  }) = _NewModerationRequestData;
}

class AddedImages {
  final UnmodifiableList<({int slot, ContentId content})> addedImgs;

  const AddedImages() :
    addedImgs = const UnmodifiableList<({int slot, ContentId content})>.empty();

  AddedImages._fromList(this.addedImgs);

  int? nextAvailableSlot() {
    final availableSlots = [0, 1, 2, 3];
    for (final img in addedImgs) {
      availableSlots.remove(img.slot);
    }

    return availableSlots.firstOrNull;
  }

  Iterable<ContentId> contentList() {
    return addedImgs.map((e) => e.content);
  }

  AddedImages removeAt(int index) {
    return AddedImages._fromList(addedImgs.removeAt(index));
  }

  AddedImages add(int slot, ContentId content) {
    return AddedImages._fromList(addedImgs.add((slot: slot, content: content)));
  }
}
