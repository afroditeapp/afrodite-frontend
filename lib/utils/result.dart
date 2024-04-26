

sealed class Result<Success, Error> {
  bool isErr() {
    return this is Err;
  }

  bool isOk() {
    return this is Ok;
  }

  Success? ok() {
    return switch (this) {
      Ok(:final v) => v,
      Err() => null
    };
  }

  Result<Success, NextErr> mapErr<NextErr>(NextErr Function(Error) errMap) {
    return switch (this) {
      Ok(:final v) => Ok(v),
      Err(:final e) => Err(errMap(e)),
    };
  }

  Result<NextSuccess, Error> mapOk<NextSuccess>(NextSuccess Function(Success) okMap) {
    return switch (this) {
      Ok(:final v) => Ok(okMap(v)),
      Err(:final e) => Err(e),
    };
  }
}

final class Ok<Success, Err> extends Result<Success, Err> {
  final Success value;
  Ok(this.value);
  Success get v => value;
}

final class Err<Ok, E> extends Result<Ok, E> {
  final E error;
  Err(this.error);
  E get e => error;
}


extension FutureResultExt<Success, Error> on Future<Result<Success, Error>> {
  Future<bool> isErr() async {
    final result = await this;
    final isErr = result.isErr();
    return isErr;
  }

  Future<bool> isOk() async {
    final result = await this;
    return result.isOk();
  }

  Future<Success?> ok() async {
    final result = await this;
    return result.ok();
  }

  Future<Result<Success, NextErr>> mapErr<NextErr>(NextErr Function(Error) errMap) async {
    final result = await this;
    return result.mapErr(errMap);
  }

  Future<Result<NextSuccess, Error>> mapOk<NextSuccess>(NextSuccess Function(Success) okMap) async {
    final result = await this;
    return result.mapOk(okMap);
  }
}
