import 'package:logging/logging.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/app_error.dart';

final log = Logger("ErrorManager");

/// Show error message on UI
class ErrorManager extends AppSingleton {
  static final _instance = ErrorManager();

  ErrorManager();

  factory ErrorManager.getInstance() {
    return _instance;
  }

  /// Show error message on UI
  void show(AppError e) {
    showSnackBar(e.title());
  }

  @override
  Future<void> init() async {
    // nothing to do
  }
}
