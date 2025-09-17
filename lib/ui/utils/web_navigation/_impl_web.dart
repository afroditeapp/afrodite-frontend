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
