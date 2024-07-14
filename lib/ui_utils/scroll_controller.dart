
import 'package:flutter/material.dart';

extension ScrollControllerExtensions on ScrollController {
  void bottomNavigationRelatedJumpToBeginningIfClientsConnected() {
    if (hasClients) {
      animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
