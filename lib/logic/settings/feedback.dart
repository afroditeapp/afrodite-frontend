import "package:app/api/server_connection_manager.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/settings/feedback.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";
import "package:app/utils/time.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";

sealed class FeedbackEvent {}

/// Resets the form state while keeping the already loaded config.
///
/// Sent when the feedback screen opens so that a previous visit does not leave
/// stale body text or a stale category selection behind.
class ResetFeedback extends FeedbackEvent {}

/// Loads the feedback form config from the server.
///
/// Sent when the feedback screen opens. The config defines the available
/// categories and the maximum body length.
class LoadFeedbackConfig extends FeedbackEvent {}

class SelectFeedbackCategory extends FeedbackEvent {
  final String key;
  SelectFeedbackCategory(this.key);
}

class UpdateFeedbackBody extends FeedbackEvent {
  final String body;
  UpdateFeedbackBody(this.body);
}

class SubmitFeedback extends FeedbackEvent {}

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackData> with ActionRunner {
  final ApiManager api;

  FeedbackBloc(RepositoryInstances r) : api = r.api, super(FeedbackData()) {
    on<ResetFeedback>((event, emit) {
      emit(FeedbackData(config: state.config));
    });
    on<LoadFeedbackConfig>((event, emit) async {
      emit(state.copyWith(config: state.config.copyWith(isLoading: true, isError: false)));

      final result = await api.account((api) => api.getFeedbackConfig());
      switch (result) {
        case Ok(:final v):
          emit(state.copyWith(config: FeedbackConfigData(isLoading: false, config: v)));
        case Err():
          emit(state.copyWith(config: state.config.copyWith(isLoading: false, isError: true)));
      }
    });
    on<SelectFeedbackCategory>((event, emit) {
      emit(state.copyWith(categoryKey: event.key));
    });
    on<UpdateFeedbackBody>((event, emit) {
      emit(state.copyWith(body: event.body));
    });
    on<SubmitFeedback>((event, emit) async {
      await runOnce(() async {
        final categoryKey = _categoryKey();
        final body = state.body.trim();
        if (categoryKey == null) {
          showSnackBar(R.strings.feedback_screen_category_required);
          return;
        }
        if (body.isEmpty) {
          showSnackBar(R.strings.feedback_screen_body_required);
          return;
        }

        emit(state.copyWith(updateState: const UpdateStarted()));

        final waitTime = WantedWaitingTimeManager();

        emit(state.copyWith(updateState: const UpdateInProgress()));

        final result = await api.account(
          (api) => api.postSendFeedback(SendFeedback(body: body, categoryKey: categoryKey)),
        );

        var failureDetected = false;
        switch (result) {
          case Ok(:final v):
            if (v.error) {
              failureDetected = true;
              if (v.errorBodyTooLong) {
                showSnackBar(R.strings.feedback_screen_error_body_too_long);
              } else if (v.errorUnknownCategory) {
                showSnackBar(R.strings.feedback_screen_error_unknown_category);
                add(LoadFeedbackConfig());
              } else if (v.errorEmailSendingFailed) {
                showSnackBar(R.strings.feedback_screen_error_email_sending_failed);
              } else {
                showSnackBar(R.strings.generic_error_occurred);
              }
            } else {
              showSnackBar(R.strings.feedback_screen_sent);
            }
          case Err():
            failureDetected = true;
            showSnackBar(R.strings.generic_error_occurred);
        }

        await waitTime.waitIfNeeded();

        emit(state.copyWith(updateState: UpdateIdle(updateFailed: failureDetected)));
      });
    });
  }

  /// Selected category or null when the user has not selected a category yet
  /// or the selected category was removed from the server config.
  String? _categoryKey() {
    final categories = state.categories();
    final selected = state.categoryKey;
    if (selected != null && categories.any((c) => c.key == selected)) {
      return selected;
    }
    return null;
  }
}
