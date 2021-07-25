import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/widgets/drawer.dart';
import 'package:my_first_flutter_app/widgets/main-app-bar-with-drawer.dart';

class Statistics extends StatefulWidget {

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MaterialDrawer(
        currentRoute: '/statistics',
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: MainAppBar(title: 'Statistics', scaffoldKey: _scaffoldKey,),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Text('Statistics'),
        ),
      ),
    );
  }
}
