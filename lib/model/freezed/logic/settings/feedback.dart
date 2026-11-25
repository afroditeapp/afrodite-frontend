import "package:freezed_annotation/freezed_annotation.dart";
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:openapi/api.dart';

part 'feedback.freezed.dart';

/// Feedback form config loaded from the server.
class FeedbackConfigData {
  final bool isLoading;
  final bool isError;
  final FeedbackConfig? config;

  const FeedbackConfigData({this.isLoading = true, this.isError = false, this.config});

  FeedbackConfigData copyWith({bool? isLoading, bool? isError, FeedbackConfig? config}) {
    return FeedbackConfigData(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      config: config ?? this.config,
    );
  }

  /// Feedback feature is enabled in the server config when there is at least
  /// one category.
  bool available() => categories().isNotEmpty;

  List<FeedbackCategory> categories() => config?.categories ?? const [];

  int bodyMaxLength() => config?.bodyMaxGraphemeClusterCount ?? 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedbackConfigData &&
          other.isLoading == isLoading &&
          other.isError == isError &&
          other.config == config;

  @override
  int get hashCode => Object.hash(isLoading, isError, config);
}

@freezed
class FeedbackData with _$FeedbackData, UpdateStateProvider {
  FeedbackData._();
  factory FeedbackData({
    @Default(UpdateIdle()) UpdateState updateState,
    @Default(FeedbackConfigData()) FeedbackConfigData config,
    String? categoryKey,
    @Default("") String body,
  }) = _FeedbackData;

  bool unsavedChanges() => body.trim().isNotEmpty;

  List<FeedbackCategory> categories() => config.categories();

  int bodyMaxLength() => config.bodyMaxLength();
}
