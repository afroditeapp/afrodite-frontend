import 'dart:async';

import 'package:app/utils/result.dart';

extension NullableExt<T extends Object> on T? {
  Result<T, Error> okOrDirect<Error>(Error error) {
    final value = this;
    if (value == null) {
      return Err(error);
    } else {
      return Ok(value);
    }
  }

  Next? map<Next>(Next? Function(T) mapAction) {
    final value = this;
    if (value == null) {
      return null;
    } else {
      return mapAction(value);
    }
  }
}

extension NullableFutureExt<T extends Object> on Future<T?> {
  Future<Result<T, Error>> okOr<Error>(Error error) async {
    final value = await this;
    return value.okOrDirect(error);
  }

  Future<Next?> map<Next>(FutureOr<Next?> Function(T) mapAction) async {
    final value = await this;
    if (value == null) {
      return null;
    } else {
      return await mapAction(value);
    }
  }
}
