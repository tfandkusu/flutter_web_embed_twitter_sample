import 'dart:html' as html;

class platformViewRegistry {
  static registerViewFactory(
      String viewTypeId, html.Element Function(int viewId) viewFactory) {}
}
