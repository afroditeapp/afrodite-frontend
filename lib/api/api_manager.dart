
import 'dart:async';

import 'package:english_words/english_words.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/api_provider.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

// TODO: Remove this file?

enum ApiRequestState {
  idle, inFlight,
}

abstract class ApiCallResult {}

class ApiRegisterResult extends ApiCallResult {
  final String accountId;
  ApiRegisterResult(this.accountId);
}


class ApiManager {
  final ApiProvider api = ApiProvider();
  final BehaviorSubject<ApiCallResult> apiResponses = BehaviorSubject();

  final BehaviorSubject<ApiRequestState> doRegister = BehaviorSubject();
  final BehaviorSubject<ApiRequestState> doLogin = BehaviorSubject();

  ApiManager();

  Stream<String?> currentAccountId() async* {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    throw UnimplementedError(null);
  }

  Future<String> getAccountId() async {
    return currentAccountId()
      .where((event) => event != null)
      .map((event) => event ?? "")
      .first;
  }

  Future<AccountIdLight> register() async {
      //apiResponses.stream.li
      doRegister.add(ApiRequestState.inFlight);

      var test = await api.account.postRegister();
      return test!;
  }
}

// class ApiCall<I, O> {
//   final BehaviorSubject<ApiRequestState> state = BehaviorSubject();
//   final StreamController<ApiRegisterResult> allRequests;
//   I? input;

//   ApiCall(Future<ApiCallResult> Function(I) apiCall, this.allRequests) {
//     state.distinct().listen((value) {
//       if (value == ApiRequestState.inFlight) {
//         if (input != null) {
//           await apiCall(input);
//         }
//       }
//     });
//   }

//   Future<O> requestCall(I input) {
//     var first = false;
//     allRequests.stream.listen((event) {
//       if !first {
//         allRequests
//       }
//     })
//     state.add(ApiRequestState.inFlight);
//   }
// }
