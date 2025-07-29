import "dart:async";

import "package:app/database/background_database_manager.dart";
import "package:app/ui_utils/attribute/attribute.dart";
import "package:database/database.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/profile_repository.dart";
import "package:app/model/freezed/logic/profile/attributes.dart";
import "package:app/utils.dart";


sealed class AttributesEvent {}
class NewAttributes extends AttributesEvent {
  final ProfileAttributes? attributes;
  NewAttributes(this.attributes);
}
class NewLocale extends AttributesEvent {
  final String? value;
  NewLocale(this.value);
}
class ProfileAttributesBloc extends Bloc<AttributesEvent, AttributesData> with ActionRunner {
  final BackgroundDatabaseManager backgroundDb = BackgroundDatabaseManager.getInstance();
  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;

  StreamSubscription<String?>? _localeSubscription;
  StreamSubscription<ProfileAttributes?>? _attributesSubscription;

  ProfileAttributesBloc() : super(AttributesData()) {
    on<NewLocale>((data, emit) async {
      final locale = data.value ?? state.localeOrDefaultLocale();
      final attributes = state.attributes;
      AttributeManager? manager;
      if (attributes != null) {
        manager = AttributeManager.createFrom(attributes, locale);
      } else {
        manager = null;
      }
      emit(state.copyWith(
        locale: locale,
        attributes: attributes,
        manager: manager,
      ));
    });
    on<NewAttributes>((data, emit) async {
      final attributes = data.attributes;
      AttributeManager? manager;
      if (attributes != null) {
        manager = AttributeManager.createFrom(attributes, state.localeOrDefaultLocale());
      } else {
        manager = null;
      }
      emit(state.copyWith(
        attributes: data.attributes,
        manager: manager,
      ));
    });

    _localeSubscription = backgroundDb
      .commonStream((db) => db.app.watchCurrentLocale())
      .listen((value) => add(NewLocale(value)));
    _attributesSubscription = profile.profileAttributes.listen((value) => add(NewAttributes(value)));
  }

  @override
  Future<void> close() async {
    await _localeSubscription?.cancel();
    await _attributesSubscription?.cancel();
    await super.close();
  }
}
