import 'package:flutter/material.dart';

void replaceInitialWebBrowserUrl(RouteInformation info) {}

/// Gets the current browser location (protocol + hostname + port) without path fragments.
/// Returns an empty string on non-web platforms.
String getServerAddressFromBrowserAddressBar() {
  return '';
}
