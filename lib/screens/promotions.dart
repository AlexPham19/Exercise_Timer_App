import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/widgets/drawer.dart';
import 'package:my_first_flutter_app/widgets/main-app-bar-with-drawer.dart';

class Promotions extends StatefulWidget {

  @override
  _PromotionsState createState() => _PromotionsState();
}

class _PromotionsState extends State<Promotions> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MaterialDrawer(
        currentRoute: '/promotions',
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: MainAppBar(title: 'Promotions', scaffoldKey: _scaffoldKey,),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Text('Promotion'),
        ),
      ),
    );
  }
}
