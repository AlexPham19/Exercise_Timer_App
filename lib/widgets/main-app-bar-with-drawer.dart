import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';

class MainAppBar extends StatelessWidget {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Color color = Themes.appBarTheme;

  const MainAppBar({required this.title, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 23),
      ),
      centerTitle: true,
      backgroundColor: color,
    );
  }
}
