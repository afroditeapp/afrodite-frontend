


import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/error_manager.dart';

class ApiWrapper<T> {
  final T api;

  ApiWrapper(this.api);

  Future<R?> request<R extends Object>(Future<R?> Function(T) action) async {
    try {
      return await action(api);
    } on ApiException catch (e) {
      print(e);
      ErrorManager.getInstance().send(Error.api);
    }

    return null;
  }

  Future<R?> requestWithException<R extends Object>(Future<R?> Function(T) action) async {
    try {
      return await action(api);
    } on ApiException catch (e) {
      print(e);
      ErrorManager.getInstance().send(Error.api);
      rethrow;
    }
  }
}
