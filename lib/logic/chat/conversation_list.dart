import "dart:collection";

import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:app/utils/iterator.dart";

final _log = Logger("ConversationListBloc");

class ChangeCalculationResult {
  final List<AccountId> current;
  final List<ListItemChange> changes;
  ChangeCalculationResult(this.current, this.changes);
}

sealed class ListItemChange {}

class AddItem extends ListItemChange {
  final int i;
  final AccountId id;
  AddItem(this.i, this.id);
}

class RemoveItem extends ListItemChange {
  final int i;
  final AccountId id;
  RemoveItem(this.i, this.id);
}

// TODO(test): Unit tests for the calculator would be nice
class ConversationListChangeCalculator {
  Map<AccountId, int> currentIndexes = {};
  LinkedHashSet<AccountId> currentAccounts = LinkedHashSet();

  /// It is assumed that every item in newData is unique
  ChangeCalculationResult calculate(List<AccountId> newData) {
    _log.finest("Conversation list change calculations start");

    final LinkedHashSet<AccountId> newAccounts = LinkedHashSet.from(newData);
    final newIndexes = <AccountId, int>{};
    for (final (i, value) in newData.indexed) {
      newIndexes[value] = i;
    }

    final newIterator = newAccounts.iterator;
    final currentItemsCopy = [...currentAccounts];

    final logic = CalculatorLogic(newIterator, currentItemsCopy);
    final List<ListItemChange> changes = [];
    while (true) {
      final newChanges = logic.nextChanges();
      if (newChanges == null) {
        break;
      } else {
        changes.addAll(newChanges);
      }
    }

    currentIndexes = newIndexes;
    currentAccounts = newAccounts;

    _log.finest("Conversation list change calculations done");

    return ChangeCalculationResult(newData, changes);
  }
}

class CalculatorLogic {
  final Iterator<AccountId> newIterator;
  final List<AccountId> currentList;
  CalculatorLogic(this.newIterator, this.currentList);

  int progressIndex = 0;

  /// If null is returned then all changes are calculated
  List<ListItemChange>? nextChanges() {
    final newNextFinal = newIterator.next();
    if (newNextFinal == null) {
      // The new list is already processed

      if (currentList.length >= progressIndex + 1) {
        // Remove removed items from end of the current list
        final lastI = currentList.length - 1;
        final id = currentList.removeLast();
        _log.finest("calculator: remove item from end of the current list, remove: $lastI");
        return [RemoveItem(lastI, id)];
      } else {
        // currentQueue has now equal content
        _log.finest("calculator: content is now equal");
        return null;
      }
    }

    final itemAtProgress = currentList.elementAtOrNull(progressIndex);
    final itemAtNextProgress = currentList.elementAtOrNull(progressIndex + 1);
    if (itemAtProgress != newNextFinal && itemAtNextProgress == newNextFinal) {
      _log.finest("calculator: single value removal detected, remove: $progressIndex");
      currentList.removeAt(progressIndex);
      final List<ListItemChange> changes = [RemoveItem(progressIndex, newNextFinal)];
      progressIndex++;
      return changes;
    } else if (itemAtProgress != newNextFinal) {
      _log.finest("calculator: items not equal at index $progressIndex");
      currentList.insert(progressIndex, newNextFinal);
      final List<ListItemChange> changes = [AddItem(progressIndex, newNextFinal)];
      progressIndex++;

      for (final (i, value) in currentList.indexed.skip(progressIndex)) {
        if (value == newNextFinal) {
          _log.finest("calculator: remove existing value from index $i");
          currentList.removeAt(i);
          changes.add(RemoveItem(i, newNextFinal));
          // The items are unique, so only one removing is needed
          break;
        }
      }

      return changes;
    } else {
      // The items were equal
      _log.finest("calculator: items equal at index $progressIndex");
      progressIndex++;
      return [];
    }
  }
}
