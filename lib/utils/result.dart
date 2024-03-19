

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
    return switch (await this) {
      Ok(:final v) => v,
      Err() => null
    };
  }
}
