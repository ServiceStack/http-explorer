import 'package:flutter/cupertino.dart';

import 'constants.dart';

class AppData {
  static Map<String,String> defaultHeaders = {
    "User-Agent": "HTTPExplorer/1.0",
    "Accept": "application/json",
    "Accept-Encoding": "gzip, deflate, br",
  };
}

class Site extends ChangeNotifier {
  String baseUrl;
  bool expanded = false;
  Site(this.baseUrl) {
    var route = Route("/", [HttpMethods.Get]);
    addRoute(route);
  }

  get friendlyLabel => baseUrl.split('://')[1];

  Map<String, Route> routeMap = {};
  List<Route> routes = [];

  void addRoute(Route route) {
    if (routeMap.containsKey(route.path))
      return;

    routes.add(route);
    routeMap[route.path] = route;
  }

  void toggleExpanded() {
    this.expanded = !this.expanded;
    this.notifyListeners();
  }
}

class Route {
  String path;
  List<String> segments;
  List<RouteItem> routeItems = [];

  Route(this.path, List<String> methods) :
    segments = path.split('/') {
    routeItems = methods.map((x) => RouteItem(this, x)).toList();
  }
}

class RouteItem {
  Route route;
  String method;
  String? description;
  RouteItem(this.route, this.method);
}

class HttpRequest {
  Map<String,String> headers = {};
  Map<String,String> queryParams = {};
  Map<String,String> formParams = {};
  String? requestBody;
  String get contentType => headers["Content-Type"] ?? "application/json";
  void set(String contentType) => headers["Content-Type"] = contentType;
  HttpRequest() {
    AppData.defaultHeaders.forEach((key, value) {
      headers[key] = value;
    });
  }
}

class HttpResponse {
  String? responseBody;
}
