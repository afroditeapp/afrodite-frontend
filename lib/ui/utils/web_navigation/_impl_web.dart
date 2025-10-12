import 'package:flutter/material.dart';
import 'package:web/web.dart';

bool _replaced = false;

void replaceInitialWebBrowserUrl(RouteInformation info) {
  if (_replaced) {
    return;
  }
  _replaced = true;
  window.history.replaceState(null, "", "/#${info.uri.path}");
}

/// Gets the current browser location (protocol + hostname + port) without path fragments.
/// Returns a string like "http://localhost:3000" or "https://example.com:8080"
String getServerAddressFromBrowserAddressBar() {
  final location = window.location;
  final protocol = location.protocol; // includes ':' e.g., "http:"
  final host = location.hostname;
  final port = location.port;

  if (port.isEmpty) {
    return '$protocol//$host';
  } else {
    return '$protocol//$host:$port';
  }
}
