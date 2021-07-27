import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final String currentRoute;

  DrawerTile(
      {required this.title,
      required this.icon,
      required this.route,
      required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    Color customColor = (route == currentRoute)
        ? Color.fromRGBO(253, 200, 200, 1)
        : Colors.white;
    Color customColorIcon =
        (route == currentRoute) ? Themes.appBarTheme : Colors.grey;
    Color customColorTitle =
        (route == currentRoute) ? Themes.appBarTheme : Colors.black;
    return InkWell(
        onTap: () {
          if (currentRoute != route) {
            if (Navigator.canPop(context))
              Navigator.of(context).pushReplacementNamed(route);
            else
              Navigator.pushNamed(context, route);
          }
        },
        child: Container(
          color: customColor,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20.0),
          child: Row(
            children: [
              Icon(icon, size: 30.0, color: customColorIcon),
              Container(
                padding: EdgeInsets.only(left: 16, top: 12, bottom: 12),
                child: Text(
                  title,
                  style: TextStyle(
                      color: customColorTitle,
                      fontWeight: FontWeight.w500,
                      fontSize: 26.0),
                ),
              ),
            ],
          ),
        ));
  }
}
