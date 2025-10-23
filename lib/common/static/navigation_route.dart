enum NavigationRoute {
  mainRoute("/"),
  detailRoute("/detail"),
  settingsRoute("/settings"),
  aboutRoute("/about");

  const NavigationRoute(this.name);
  final String name;
}
