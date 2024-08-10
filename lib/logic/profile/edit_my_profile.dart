import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import 'package:database/database.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import "package:pihka_frontend/model/freezed/logic/profile/edit_my_profile.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/immutable_list.dart";


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
class NewUnlimitedLikesValue extends EditMyProfileEvent {
  final bool value;
  NewUnlimitedLikesValue(this.value);
}
class NewAttributeValue extends EditMyProfileEvent {
  final ProfileAttributeValueUpdate value;
  NewAttributeValue(this.value);
}

class EditMyProfileBloc extends Bloc<EditMyProfileEvent, EditMyProfileData> with ActionRunner {
  final ProfileRepository profile = ProfileRepository.getInstance();
  final MediaRepository media = LoginRepository.getInstance().repositories.media;
  final db = DatabaseManager.getInstance();

  EditMyProfileBloc() : super(EditMyProfileData()) {
    on<SetInitialValues>((data, emit) async {
      final attributes = data.profile.attributes
        .map((e) => ProfileAttributeValueUpdate(id: e.id, values: [...e.values]))
        .toList();

      emit(EditMyProfileData(
        age: data.profile.age,
        name: data.profile.name,
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
