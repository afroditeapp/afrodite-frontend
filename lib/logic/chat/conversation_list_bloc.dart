import "dart:async";
import "dart:collection";

import 'package:bloc_concurrency/bloc_concurrency.dart' show sequential;

import "package:async/async.dart" show StreamExtensions;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/model/freezed/logic/chat/conversation_list_bloc.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/immutable_list.dart";
import "package:pihka_frontend/utils/iterator.dart";

var log = Logger("ConversationListBloc");

sealed class ConversationListEvent {}
class HandleNewConversationList extends ConversationListEvent {
  final List<AccountId> data;
  HandleNewConversationList(this.data);
}

class ConversationListBloc extends Bloc<ConversationListEvent, ConversationListData> with ActionRunner {
  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;

  final ConversationListChangeCalculator calculator = ConversationListChangeCalculator();

  StreamSubscription<List<AccountId>>? _conversationListSubscription;

  ConversationListBloc() : super(ConversationListData()) {
    on<HandleNewConversationList>((data, emit) async {
      final calculatorResult = calculator.calculate(data.data);
      emit(state.copyWith(
        conversations: UnmodifiableList(calculatorResult.current),
        changesBetweenCurrentAndPrevious: UnmodifiableList(calculatorResult.changes),
        initialLoadDone: true,
      ));
    },
      transformer: sequential(),
    );

    _conversationListSubscription = profile.getConversationListUpdates().listen((data) {
      log.finest(data);
      add(HandleNewConversationList(data));
    });
  }

  @override
  Future<void> close() async {
    await _conversationListSubscription?.cancel();
    return super.close();
  }
}

// TODO(test): Unit tests for the calculator would be nice
class ConversationListChangeCalculator {
  Map<AccountId, int> currentIndexes = {};
  LinkedHashSet<AccountId> currentAccounts = LinkedHashSet();

  /// It is assumed that every item in newData is unique
  ChangeCalculationResult calculate(List<AccountId> newData) {
    log.info("Conversation list change calculations start");

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

    log.info("Conversation list change calculations done");

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

      if (currentList.length > progressIndex + 1) {
        // Remove removed items from end of the current list
        final lastI = currentList.length - 1;
        final id = currentList.removeLast();
        log.finest("calculator: remove item from end of the current list, remove: $lastI");
        return [RemoveItem(lastI, id)];
      } else {
        // currentQueue has now equal content
        log.finest("calculator: content is now equal");
        return null;
      }
    }

    final itemAtProgress = currentList.elementAtOrNull(progressIndex);
    if (itemAtProgress != newNextFinal) {
      log.finest("calculator: items not equal at index $progressIndex");
      currentList.insert(progressIndex, newNextFinal);
      final List<ListItemChange> changes = [AddItem(progressIndex, newNextFinal)];
      progressIndex++;

      for (final (i, value) in currentList.indexed.skip(progressIndex)) {
        if (value == newNextFinal) {
          log.finest("calculator: remove existing value from index $i");
          currentList.removeAt(i);
          changes.add(RemoveItem(i, newNextFinal));
          // The items are unique, so only one removing is needed
          break;
        }
      }

      return changes;
    } else {
      // The items were equal
      log.finest("calculator: items equal at index $progressIndex");
      progressIndex++;
      return [];
    }
  }
}

class ChangeCalculationResult {
  final List<AccountId> current;
  final List<ListItemChange> changes;
  ChangeCalculationResult(this.current, this.changes);
}
