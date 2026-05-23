import 'dart:async';

import 'package:app/utils/app_error.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_protocol/server.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/account_repository.dart';
import 'package:app/utils/cancellation_token.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';

final _log = Logger("SendToSlotTask");

final _processingIdGenerator = _ProcessingIdGenerator();

class _ProcessingIdGenerator {
  int _nextProcessingId = 0;

  int nextProcessingId() {
    final id = _nextProcessingId;
    _nextProcessingId = (_nextProcessingId + 1) & 255;
    return id;
  }
}

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
  final bool faceDetected;
  ProcessingCompleted(this.contentId, this.faceDetected);
}

class SendToSlotError extends SendToSlotEvent {
  bool imageDataUploadTimeout;
  bool nsfwDetected;
  bool contentProcessingOngoing;
  SendToSlotError({
    this.imageDataUploadTimeout = false,
    this.nsfwDetected = false,
    this.contentProcessingOngoing = false,
  });
}

/// Asynchronous system for sending image to a slot
class SendImageToSlotTask {
  final ApiManager api;
  final token = CancellationToken();
  final latestStates = BehaviorSubject<Map<int, ContentProcessingState>>.seeded({});

  final AccountRepository account;
  SendImageToSlotTask(this.account, this.api);

  Future<void> dispose() async {
    token.cancel();
    await latestStates.close();
  }

  Stream<SendToSlotEvent> sendImageToSlot(
    Uint8List imgBytes,
    int slot, {
    bool secureCapture = false,
  }) {
    return Rx.merge([
      _trackWebSocketEvents(),
      _uploadImageToSlot(imgBytes, slot, secureCapture: secureCapture),
    ]);
  }

  Stream<SendToSlotEvent> _trackWebSocketEvents() async* {
    final stream = Rx.merge([
      account.contentProcessingStateChanges.map((event) => StateChangeEvent(event)),
      token.cancellationStatusStream.where((event) => event).map((_) => StateChangeQuit()),
    ]);
    await for (final event in stream) {
      switch (event) {
        case StateChangeEvent():
          final current = latestStates.value;
          current[event.value.id.id] = event.value.newState;
          latestStates.add(current);
        case StateChangeQuit():
          return;
      }
    }
  }

  Stream<SendToSlotEvent> _uploadImageToSlot(
    Uint8List imgBytes,
    int slot, {
    bool secureCapture = false,
  }) async* {
    yield Uploading();

    final processingId = _processingIdGenerator.nextProcessingId();
    final current = latestStates.value;
    current.remove(processingId);
    latestStates.add(current);

    final MultipartFile data = MultipartFile.fromBytes("", imgBytes);
    final Result<PutContentToContentSlotResult, ApiError> r;
    try {
      r = await api
          .media(
            (api) => api.putUploadContent(
              slot,
              processingId,
              secureCapture,
              MediaContentUploadType.image,
              data,
            ),
          )
          .timeout(Duration(minutes: 2));
    } on TimeoutException {
      yield SendToSlotError(imageDataUploadTimeout: true);
      token.cancel();
      return;
    }
    switch (r) {
      case Ok(:final v):
        if (v.error) {
          yield SendToSlotError(contentProcessingOngoing: v.errorContentProcessingOngoing);
          token.cancel();
          return;
        }
      case Err():
        yield SendToSlotError();
        token.cancel();
        return;
    }

    yield UploadCompleted();

    while (true) {
      if (token.isCancelled) {
        return;
      }

      try {
        await for (final states in latestStates.timeout(Duration(seconds: 10))) {
          if (token.isCancelled) {
            return;
          }

          final processingState = states[processingId];
          if (processingState == null) {
            continue;
          }

          final SendToSlotEvent converted = _convertState(processingState);
          yield converted;
          if (converted is ProcessingCompleted || converted is SendToSlotError) {
            token.cancel();
            return;
          }
        }
      } on TimeoutException {
        _log.warning("Timeout while waiting for content processing state");
        if (token.isCancelled) {
          return;
        }

        final currentState = await _getStateFromServerManually(processingId);
        yield currentState;
        if (currentState is ProcessingCompleted || currentState is SendToSlotError) {
          token.cancel();
          return;
        }
      }
    }
  }

  Future<SendToSlotEvent> _getStateFromServerManually(int processingId) async {
    try {
      final state = await api
          .media((api) => api.getContentProcessingState())
          .timeout(Duration(seconds: 10));
      switch (state) {
        case Ok(:final v):
          if (v.processingIdFromClient != processingId) {
            return SendToSlotError();
          }
          final current = latestStates.value;
          current[processingId] = v;
          latestStates.add(current);
          return _convertState(v);
        case Err():
          return SendToSlotError();
      }
    } on TimeoutException {
      return SendToSlotError();
    }
  }

  SendToSlotEvent _convertState(ContentProcessingState state) {
    switch (state.state) {
      case ContentProcessingStateType.processing:
        {
          return Processing();
        }
      case ContentProcessingStateType.inQueue:
        {
          final queueNumber = state.waitQueuePosition;
          if (queueNumber != null) {
            return InProcessingQueue(queueNumber);
          } else {
            return InProcessingQueue(0);
          }
        }
      case ContentProcessingStateType.nsfwDetected:
        return SendToSlotError(nsfwDetected: true);
      case ContentProcessingStateType.failed:
        return SendToSlotError();
      case ContentProcessingStateType.completed:
        {
          final contentId = state.cid;
          final faceDetected = state.faceDetected;
          if (contentId == null || faceDetected == null) {
            return SendToSlotError();
          } else {
            return ProcessingCompleted(contentId, faceDetected);
          }
        }
    }

    return SendToSlotError();
  }
}

sealed class StateChangeOrQuit {}

class StateChangeEvent extends StateChangeOrQuit {
  final ContentProcessingStateChanged value;
  StateChangeEvent(this.value);
}

class StateChangeQuit extends StateChangeOrQuit {}
