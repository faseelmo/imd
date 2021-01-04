import 'package:flutter/widgets.dart';
import 'package:imd/screens/home/home.dart';
import 'package:imd/screens/analytics/analyticspage.dart';
import 'package:imd/screens/settings/account.dart';
import 'package:flutter/material.dart';

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: Home(),
          icon: Icon(Icons.home_outlined),
          title: Text("Home"),
        ),
        TabNavigationItem(
          page: Analytics(),
          icon: Icon(Icons.analytics_outlined),
          title: Text("Analytics"),
        ),
        TabNavigationItem(
          page: Account(),
          icon: Icon(Icons.account_circle_outlined),
          title: Text("Account"),
        ),
      ];
}
