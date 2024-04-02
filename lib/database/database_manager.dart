
import 'package:pihka_frontend/database/common_database.dart';
import 'package:pihka_frontend/utils.dart';

class DatabaseManager extends AppSingleton {
  DatabaseManager._private();
  static final _instance = DatabaseManager._private();
  factory DatabaseManager.getInstance() {
    return _instance;
  }

  bool initDone = false;
  late final CommonDatabase commonDatabase;

  @override
  Future<void> init() async {
    if (initDone) {
      return;
    }
    initDone = true;

    commonDatabase = CommonDatabase(doInit: true);
    // Make sure that the database libraries are initialized
    await commonDataStream((db) => db.watchDemoAccountUserId()).first;
  }

  Stream<T> commonDataStream<T>(Stream<T> Function(CommonDatabase) mapper) async* {
    final stream = mapper(commonDatabase);
    yield* stream;
  }

  Stream<T> commonDataStreamOrDefault<T extends Object>(Stream<T?> Function(CommonDatabase) mapper, T defaultValue) async* {
    final stream = mapper(commonDatabase);
    yield* stream.map((event) {
      if (event == null) {
        return defaultValue;
      } else {
        return event;
      }
    });
  }

  Future<T> commonData<T>(Stream<T> Function(CommonDatabase) mapper) async {
    final stream = mapper(commonDatabase);
    return await stream.first;
  }

  Future<T> commonDataOrDefault<T extends Object>(Stream<T?> Function(CommonDatabase) mapper, T defaultValue) async {
    final stream = mapper(commonDatabase);
    return await stream.first ?? defaultValue;
  }

  Future<void> commonAction(Future<void> Function(CommonDatabase) action) async {
    return await action(commonDatabase);
  }
}
