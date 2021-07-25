import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:my_first_flutter_app/model/exerciseData.dart';
import 'package:my_first_flutter_app/model/savedData.dart';

class CongratulationPage extends StatefulWidget {
  @override
  _CongratulationPageState createState() => _CongratulationPageState();
}

class _CongratulationPageState extends State<CongratulationPage> {
  var hiveBox = Hive.box('savedData');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finished'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[

            ],
          ),
        ),
      ),
    );
  }
}
