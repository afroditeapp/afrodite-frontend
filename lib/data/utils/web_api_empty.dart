WebApiWindow window = WebApiWindow(WebApiLocation(""));

class WebApiWindow {
  final WebApiLocation location;
  WebApiWindow(this.location);
}

class WebApiLocation {
  final String host;
  WebApiLocation(this.host);
}
