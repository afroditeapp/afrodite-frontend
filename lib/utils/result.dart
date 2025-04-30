

import 'dart:async';

import 'package:app/utils/app_error.dart';

sealed class Result<Success, Error> {
  const Result();

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
  const Ok(this.value);
  Success get v => value;
}

final class Err<Ok, E> extends Result<Ok, E> {
  final E error;
  const Err(this.error);
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

  Future<Result<Success, NextErr>> mapErr<NextErr>(FutureOr<NextErr> Function(Error) errMap) async {
    return switch (await this) {
      Ok(:final v) => Ok(v),
      Err(:final e) => Err(await errMap(e)),
    };
  }

  Future<Result<NextSuccess, Error>> mapOk<NextSuccess>(FutureOr<NextSuccess> Function(Success) okMap) async {
    return switch (await this) {
      Ok(:final v) => Ok(await okMap(v)),
      Err(:final e) => Err(e),
    };
  }

  Future<Result<Success, Error>> onErr(FutureOr<void> Function() onErrAction) async {
    final result = await this;
    if (result.isErr()) {
      await onErrAction();
    }
    return result;
  }

  Future<Result<Success, Error>> onOk(FutureOr<void> Function() onOkAction) async {
    final result = await this;
    if (result.isOk()) {
      await onOkAction();
    }
    return result;
  }

  Future<Result<Success, Error>> inspectErr(FutureOr<void> Function(Error) inspectErrAction) async {
    final result = await this;
    switch (result) {
      case Ok():
        return result;
      case Err(:final e):
        await inspectErrAction(e);
        return result;
    }
  }

  Future<Result<Success, Error>> inspectOk(FutureOr<void> Function(Success) inspectOkAction) async {
    final result = await this;
    switch (result) {
      case Ok(:final v):
        await inspectOkAction(v);
        return result;
      case Err():
        return result;
    }
  }

  Future<Result<void, void>> empty() async {
    final result = await this;
    switch (result) {
      case Ok():
        return const Ok(null);
      case Err():
        return const Err(null);
    }
  }

  Future<Result<Success, void>> emptyErr() async {
    final result = await this;
    switch (result) {
      case Ok(:final v):
        return Ok(v);
      case Err():
        return const Err(null);
    }
  }

  Future<Result<NextSuccess, Error>> andThen<NextSuccess>(FutureOr<Result<NextSuccess, Error>> Function(Success) andThenAction) async {
    final result = await this;
    switch (result) {
      case Ok(:final v):
        return await andThenAction(v);
      case Err(:final e):
        return Err(e);
    }
  }
}

extension ResultExtAppError<Success, Error extends AppError> on Future<Result<Success, Error>> {
  Future<Result<NextSuccess, AppError>> andThen<NextSuccess, NextErr extends AppError>(FutureOr<Result<NextSuccess, NextErr>> Function(Success) andThenAction) async {
    final result = await this;
    switch (result) {
      case Ok(:final v):
        return await andThenAction(v);
      case Err(:final e):
        return Err(e);
    }
  }
}

extension ResultExtAppErrorFlatten<Success, ErrorInner extends AppError, ErrorOuter extends AppError> on Future<Result<Result<Success, ErrorInner>, ErrorOuter>> {
  Future<Result<Success, AppError>> flatten() async {
    final result = await this;
    switch (result) {
      case Ok(:final v):
        return v;
      case Err(:final e):
        return Err(e);
    }
  }
}

extension ResultExtAppErrorErrorIfNull<Success extends Object, ErrorInner extends AppError> on Future<Result<Success?, ErrorInner>> {
  Future<Result<Success, AppError>> errorIfNull() async {
    final result = await this;
    switch (result) {
      case Ok(:final v):
        if (v == null) {
          return const Err(MissingValue());
        } else {
          return Ok(v);
        }
      case Err(:final e):
        return Err(e);
    }
  }
}
