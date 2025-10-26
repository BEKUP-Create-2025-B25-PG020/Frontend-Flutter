enum NavigationRoute {
  mainRoute("/"),
  homeroute("/home"),
  detailRoute("/detail"),
  settingsRoute("/settings"),
  aboutRoute("/about");

  const NavigationRoute(this.name);
  final String name;
}
