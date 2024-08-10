

import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/account_repository.dart';
import 'package:pihka_frontend/utils/cancellation_token.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("SendToSlotTask");

sealed class SendToSlotEvent {}
class Uploading extends SendToSlotEvent {}
class UploadCompleted extends SendToSlotEvent {}
class InProcessingQueue extends SendToSlotEvent {
  final int queueNumber;
  InProcessingQueue(this.queueNumber);
}
class Processing extends SendToSlotEvent {}
class ProcessingCompleted extends SendToSlotEvent {
  final ContentId contentId;
  ProcessingCompleted(this.contentId);
}
class SendToSlotError extends SendToSlotEvent {}

/// Asynchronous system for sending image to a slot
class SendImageToSlotTask {

  final ApiManager api = ApiManager.getInstance();
  final token = CancellationToken();
  final uploadDone = BehaviorSubject<ContentProcessingId?>.seeded(null);

  final AccountRepository account;
  SendImageToSlotTask(this.account);

  Stream<SendToSlotEvent> sendImageToSlot(XFile file, int slot, {bool secureCapture = false}) {
    return Rx.merge([
      _uploadImageToSlot(file, slot, secureCapture: secureCapture),
      _trackEvents(slot),
    ]);
  }

  /// Only uploading part of the sendImageToSlot method
  Stream<SendToSlotEvent> _uploadImageToSlot(XFile file, int slot, {bool secureCapture = false}) async* {
    yield Uploading();
    final MultipartFile data;
    if (kIsWeb) {
      final bytes = await file.readAsBytes();
      data = MultipartFile.fromBytes("", bytes);
    } else {
      data = await MultipartFile.fromPath("", file.path);
    }
    final processingId = await api.media((api) => api.putContentToContentSlot(slot, secureCapture, MediaContentType.jpegImage, data));
    switch (processingId) {
      case Ok(:final v):
        uploadDone.add(v);
      case Err():
        yield SendToSlotError();
        token.cancel();
    }
  }

  /// Only processing part of the sendImageToSlot method
  Stream<SendToSlotEvent> _trackEvents(int slot) async* {
    // Keep track of events as there might be race conditions where the event
    // is received before processing ID is received.
    final eventHistory = <ContentProcessingStateChanged>[];
    ContentProcessingId? receivedId;
    while (true) {
      if (token.isCancelled) {
        return;
      }

      try {
        await for (final event in _eventsAndContentProcessingIdWithTimeout()) {
          if (token.isCancelled) {
            // (Checking Quit event is kinda redundant because of this...)
            return;
          }

          SendToSlotEvent? converted;

          if (receivedId != null) {
            if (event is Event && event.value.id.id == receivedId.id) {
              converted = _convertState(event.value.newState);
            } else if (event is Quit) {
              return;
            }
          } else {
            switch (event) {
              case Id(:final id): {
                final latestIndex = eventHistory.lastIndexWhere((element) => element.id.id == id.id);
                if (latestIndex != -1) {
                  converted = _convertState(eventHistory[latestIndex].newState);
                }
                receivedId = id;
              }
              case Event(:final value): {
                eventHistory.add(value);
              }
              case Quit(): {
                return;
              }
            }
          }

          if (converted != null) {
            yield converted;
            if (converted is ProcessingCompleted || converted is SendToSlotError) {
              token.cancel();
              return;
            }
          }
        }
      } on TimeoutException {
        log.warning("Timeout while waiting for content processing state");
        if (token.isCancelled) {
          return;
        }

        // Events might be lost because of network issues so
        // timeout is needed.
        final currentState = await _getStateFromServer(slot);
        yield currentState;
        if (currentState is ProcessingCompleted || currentState is SendToSlotError) {
          token.cancel();
          return;
        }
      }
    }
  }

  Stream<IdOrEvent> _eventsAndContentProcessingIdWithTimeout() {
    final e = account
        .contentProcessingStateChanges;
    return Rx.merge([
      e.map((event) => Event(event)),
      uploadDone.mapNotNull((v) => v).map((id) => Id(id)),
      token.cancellationStatusStream.where((event) => event).map((_) => Quit()),
    ]).timeout(const Duration(seconds: 10));
  }

  Future<SendToSlotEvent> _getStateFromServer(int slot) async {
    final state = await api.media((api) => api.getContentSlotState(slot));
    switch (state) {
      case Ok(:final v):
        return _convertState(v);
      case Err():
        return SendToSlotError();
    }
  }

  SendToSlotEvent _convertState(ContentProcessingState state) {
    switch (state.state) {
      case ContentProcessingStateType.processing: {
        return Processing();
      }
      case ContentProcessingStateType.inQueue: {
        final queueNumber = state.waitQueuePosition;
        if (queueNumber != null) {
          return InProcessingQueue(queueNumber);
        } else {
          return InProcessingQueue(0);
        }
      }
      case ContentProcessingStateType.failed:
        return SendToSlotError();
      case ContentProcessingStateType.empty:
        return SendToSlotError();
      case ContentProcessingStateType.completed: {
        final contentId = state.contentId;
        if (contentId == null) {
          return SendToSlotError();
        } else {
          return ProcessingCompleted(contentId);
        }
      }
    }

    return SendToSlotError();
  }
}

sealed class IdOrEvent {}

class Id extends IdOrEvent {
  final ContentProcessingId id;
  Id(this.id);
}
class Event extends IdOrEvent {
  final ContentProcessingStateChanged value;
  Event(this.value);
}
class Quit extends IdOrEvent {}
