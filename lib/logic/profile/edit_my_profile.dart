import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/media_repository.dart";
import "package:app/data/profile_repository.dart";
import 'package:database/database.dart';
import 'package:app/database/database_manager.dart';
import "package:app/model/freezed/logic/profile/edit_my_profile.dart";
import "package:app/utils.dart";
import "package:app/utils/immutable_list.dart";


sealed class EditMyProfileEvent {}
class SetInitialValues extends EditMyProfileEvent {
  final ProfileEntry profile;
  SetInitialValues(this.profile);
}
class NewAge extends EditMyProfileEvent {
  final int? value;
  NewAge(this.value);
}
class NewName extends EditMyProfileEvent {
  final String? value;
  NewName(this.value);
}
class NewProfileText extends EditMyProfileEvent {
  final String? value;
  NewProfileText(this.value);
}
class NewUnlimitedLikesValue extends EditMyProfileEvent {
  final bool value;
  NewUnlimitedLikesValue(this.value);
}
class NewAttributeValue extends EditMyProfileEvent {
  final ProfileAttributeValueUpdate value;
  NewAttributeValue(this.value);
}

class EditMyProfileBloc extends Bloc<EditMyProfileEvent, EditMyProfileData> with ActionRunner {
  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;
  final MediaRepository media = LoginRepository.getInstance().repositories.media;
  final db = DatabaseManager.getInstance();

  EditMyProfileBloc() : super(EditMyProfileData()) {
    on<SetInitialValues>((data, emit) async {
      final attributes = data.profile.attributes
        .map((e) => ProfileAttributeValueUpdate(id: e.id, v: [...e.v]))
        .toList();

      emit(EditMyProfileData(
        age: data.profile.age,
        name: data.profile.name,
        profileText: data.profile.profileText,
        attributes: UnmodifiableList(attributes),
        unlimitedLikes: data.profile.unlimitedLikes,
      ));
    });
    on<NewAge>((data, emit) async {
      emit(state.copyWith(age: data.value));
    });
    on<NewName>((data, emit) async {
      emit(state.copyWith(name: data.value));
    });
    on<NewProfileText>((data, emit) async {
      emit(state.copyWith(profileText: data.value));
    });
    on<NewUnlimitedLikesValue>((data, emit) async {
      emit(state.copyWith(unlimitedLikes: data.value));
    });
    on<NewAttributeValue>((data, emit) async {
      final newAttributes = <ProfileAttributeValueUpdate>[];
      var found = false;
      for (final a in state.attributes) {
        if (a.id == data.value.id) {
          newAttributes.add(data.value);
          found = true;
        } else {
          newAttributes.add(a);
        }
      }
      if (!found) {
        newAttributes.add(data.value);
      }
      emit(state.copyWith(attributes: UnmodifiableList(newAttributes)));
    });
  }
}
