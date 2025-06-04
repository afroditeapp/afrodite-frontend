
import 'dart:async';

import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';

class Command {
  final String name;
  final FutureOr<void> Function() command;
  Command(this.name, this.command);
}

class SynchronousCommandRunner {
  final PublishSubject<Command> _subject = PublishSubject();
  final List<Command> _scheduledCommands = [];
  late StreamSubscription<void> subscription;

  void addIfNotAlreadyScheduled(Command command) {
    if (isScheduledOrRunning(command.name)) {
      return;
    }
    add(command);
  }

  void add(Command command) {
    _scheduledCommands.add(command);
    _subject.add(command);
  }

  bool isScheduledOrRunning(String name) {
    return _scheduledCommands.firstWhereOrNull((c) => c.name == name) != null;
  }

  void init() {
    subscription = _subject
      .asyncMap((v) async {
        await v.command();
        final found = _scheduledCommands.indexed.firstWhereOrNull((c) => c.$2.name == v.name);
        if (found != null) {
          _scheduledCommands.removeAt(found.$1);
        }
        return null;
      })
      .listen((_) {});
  }

  Future<void> dispose() async {
    await subscription.cancel();
  }
}
