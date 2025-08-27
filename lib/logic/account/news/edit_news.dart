import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/api/server_connection_manager.dart";
import "package:app/data/login_repository.dart";
import "package:app/model/freezed/logic/account/news/edit_news.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";

abstract class EditNewsEvent {}

class Reload extends EditNewsEvent {}

class SaveTranslation extends EditNewsEvent {
  final String locale;
  final NewsContent content;
  SaveTranslation(this.locale, this.content);
}

class SetVisibilityToServer extends EditNewsEvent {
  final bool isVisible;
  SetVisibilityToServer(this.isVisible);
}

class SaveToServer extends EditNewsEvent {
  SaveToServer();
}

class EditNewsBloc extends Bloc<EditNewsEvent, EditNewsData> with ActionRunner {
  final ApiManager api = LoginRepository.getInstance().repositories.api;
  final NewsId id;
  final List<String> supportedLocales;
  EditNewsBloc(this.id, {required this.supportedLocales})
    : super(EditNewsData(supportedLocales: supportedLocales)) {
    on<Reload>((data, emit) async {
      emit(EditNewsData(supportedLocales: supportedLocales).copyWith(isLoading: true));

      var errorDetected = false;
      for (final l in supportedLocales) {
        final r = await loadTranslation(emit, l);
        if (r.isErr()) {
          errorDetected = true;
          break;
        }
      }
      if (errorDetected) {
        emit(state.copyWith(isLoading: false, isError: true));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    });
    on<SaveTranslation>((data, emit) async {
      emit(
        state.copyWith(
          editableTranslations: state.editableTranslationsWith(data.locale, data.content),
        ),
      );
    }, transformer: sequential());
    on<SetVisibilityToServer>((data, emit) async {
      await runOnce(() async {
        final r = await api.accountAdminAction(
          (api) => api.postSetNewsPublicity(id.nid, BooleanSetting(value: data.isVisible)),
        );
        switch (r) {
          case Ok():
            showSnackBar("Visibility change successful");
            add(Reload());
          case Err():
            showSnackBar("Error: visibility change failed");
        }
      });
    });
    on<SaveToServer>((data, emit) async {
      await runOnce(() async {
        var errorDetected = false;
        for (final l in supportedLocales) {
          if (!state.translationContainsUnsavedChanges(l)) {
            continue;
          }
          final r = await _saveTranslation(emit, l);
          errorDetected = r.isErr();
          switch (r) {
            case Ok():
              ();
            case Err(e: _SaveError.saveFailedAlreadyChanged):
              showSnackBar(
                "Error: saving translation $l failed because someone already changed it",
              );
              break;
            case Err(e: _SaveError.saveFailed):
              showSnackBar("Error: saving translation $l failed");
              break;
            case Err(e: _SaveError.reloadFailed):
              showSnackBar("Error: save successful but reload failed for translation $l");
              break;
          }
        }
        if (!errorDetected) {
          showSnackBar("Save successful");
        }
      });
    });

    add(Reload());
  }

  Future<Result<(), ()>> loadTranslation(Emitter<EditNewsData> emit, String locale) async {
    final translation = await api.account(
      (api) => api.getNewsItem(id.nid, locale, requireLocale: true),
    );
    switch (translation) {
      case Ok():
        final NewsContent c = (
          title: translation.value.item?.title ?? "",
          body: translation.value.item?.body ?? "",
          version: translation.value.item?.version ?? NewsTranslationVersion(version: 0),
        );
        emit(
          state.copyWith(
            currentTranslations: state.currentTranslationsWith(locale, c),
            editableTranslations: state.editableTranslationsWith(locale, c),
            isVisibleToUsers: !translation.value.private,
          ),
        );
        return const Ok(());
      case Err():
        return const Err(());
    }
  }

  Future<Result<(), _SaveError>> _saveTranslation(Emitter<EditNewsData> emit, String locale) async {
    final currentVersion =
        state.currentlNewsContent(locale).version ?? NewsTranslationVersion(version: 0);
    final edited = state.editedOrCurrentlNewsContent(locale);
    final r = await api.accountAdmin(
      (api) => api.postUpdateNewsTranslation(
        id.nid,
        locale,
        UpdateNewsTranslation(
          body: edited.body,
          title: edited.title,
          currentVersion: currentVersion,
        ),
      ),
    );
    switch (r) {
      case Ok():
        if (r.value.errorAlreadyChanged) {
          return const Err(_SaveError.saveFailedAlreadyChanged);
        }

        final loadResult = await loadTranslation(emit, locale);
        if (loadResult.isErr()) {
          return const Err(_SaveError.reloadFailed);
        }

        return const Ok(());
      case Err():
        return const Err(_SaveError.saveFailed);
    }
  }
}

enum _SaveError { saveFailedAlreadyChanged, saveFailed, reloadFailed }
