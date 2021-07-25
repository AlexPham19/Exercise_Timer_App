import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';

import 'drawer-tile.dart';

class MaterialDrawer extends StatelessWidget {
  final String currentRoute;

  MaterialDrawer({required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Themes.appBarTheme),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.timer,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Stopwatch',
                      style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView(
                  children: <Widget>[
                    DrawerTile(
                      title: 'Timer',
                      icon: Icons.timer,
                      route: '/welcome',
                      currentRoute: currentRoute,
                    ),
                    DrawerTile(
                      title: 'Exercises',
                      icon: Icons.run_circle_outlined,
                      route: '/exercises',
                      currentRoute: currentRoute,
                    ),
                    DrawerTile(
                        title: 'History',
                        icon: Icons.calendar_today,
                        route: '/history',
                        currentRoute: currentRoute),
                    DrawerTile(
                        title: 'Settings',
                        icon: Icons.settings,
                        route: '/settings',
                        currentRoute: currentRoute),
                    DrawerTile(
                        title: 'Statistics',
                        icon: Icons.bar_chart,
                        route: '/statistics',
                        currentRoute: currentRoute),
                    DrawerTile(
                        title: 'Promotions',
                        icon: Icons.attach_money,
                        route: '/promotions',
                        currentRoute: currentRoute),
                    Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 32, left: 32, right: 32),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/try-premium');
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(253, 200, 200, 1),
                              elevation: 8.0,
                              padding: EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.monetization_on_outlined,
                                  size: 40.0,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text('Try Premium',
                                      style: TextStyle(fontSize: 25.0)),
                                ),
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
