import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';
import 'package:my_first_flutter_app/widgets/drawer.dart';
import 'package:my_first_flutter_app/widgets/main-app-bar-with-drawer.dart';

String MinutesTotal = '00',
    SecondsTotal = '35',
    MinutesExercise = '00',
    SecondsExercise = '05',
    MinutesRest = '00',
    SecondsRest = '05',
    NumberOfExercises = '2',
    NumberOfRepetitions = '2',
    MinutesToRepeat = '00',
    SecondsToRepeat = '05';

class WelcomePage extends StatefulWidget {
  static const id = '/welcome';
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MaterialDrawer(currentRoute: '/welcome'),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: MainAppBar(
          title: 'Timer',
          scaffoldKey: _scaffoldKey,
        ),
      ),
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          showAskingDialog();
          return false;
        },
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Themes.appBarTheme,
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    MinutesTotal + ':' + SecondsTotal,
                    style: TextStyle(
                        fontSize: 70,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: RawMaterialButton(
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  onPressed: () {
                    Navigator.pushNamed(context, '/exercise-main');
                  },
                  child: Icon(
                    Icons.play_arrow,
                    size: 50.0,
                    color: Themes.appBarTheme,
                  ),
                  padding: EdgeInsets.all(15.0),
                  elevation: 8.0,
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: itemSetTime(
                          Icons.play_circle_outline,
                          Themes.exerciseThemeMain,
                          Themes.exerciseIconMain,
                          Themes.exerciseDialogTheme,
                          'Exercise',
                          MinutesExercise + ':' + SecondsExercise,
                          MinutesExercise,
                          SecondsExercise),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: itemSetTime(
                          Icons.pause_circle_outline,
                          Themes.restThemeMain,
                          Themes.restIconMain,
                          Themes.restDialogTheme,
                          'Rest',
                          MinutesRest + ':' + SecondsRest,
                          MinutesRest,
                          SecondsRest),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: itemSetReps(
                        Icons.play_circle_outline,
                        Themes.numberExerciseThemeMain,
                        Themes.numberExerciseIconMain,
                        Themes.numberExerciseDialogTheme,
                        'Exercises',
                        NumberOfExercises,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: itemSetReps(
                        Icons.play_circle_outline,
                        Themes.numberRepetitionsThemeMain,
                        Themes.numberRepetitionsIconMain,
                        Themes.numberRepetitionsDialogTheme,
                        'Repetitions',
                        NumberOfRepetitions,
                      ),
                    ),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: itemSetTime(
                            Icons.play_circle_outline,
                            Themes.timeToChangeRepThemeMain,
                            Themes.timeToChangeRepIconMain,
                            Themes.timeToChangeRepDialogTheme,
                            'Time to repeat',
                            MinutesToRepeat + ':' + SecondsToRepeat,
                            MinutesToRepeat,
                            SecondsToRepeat),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemSetTime(
      IconData icon,
      Color color,
      Color iconColor,
      Color dialogThemeColor,
      String title,
      String time,
      String minutes,
      String seconds) {
    return InkWell(
      onTap: () {
        showMaterialNumberPicker(
          backgroundColor: color,
          headerColor: dialogThemeColor,
          title: 'Seconds $title',
          context: context,
          minNumber: 0,
          maxNumber: 10 * 60,
          onChanged: (value) => setState(() {
            String min = (value ~/ 60).toString();
            String sec = (value % 60).toString();
            if (int.parse(min) * 60 + int.parse(sec) >= 5 &&
                min != '' &&
                sec != '' &&
                int.parse(sec) < 60) {
              switch (title) {
                case 'Exercise':
                  MinutesExercise = min.padLeft(2, '0');
                  SecondsExercise = sec.padLeft(2, '0');
                  break;
                case 'Rest':
                  MinutesRest = min.padLeft(2, '0');
                  SecondsRest = sec.padLeft(2, '0');
                  break;
                case 'Time to repeat':
                  MinutesToRepeat = min.padLeft(2, '0');
                  SecondsToRepeat = sec.padLeft(2, '0');
                  break;
                default:
                  {}
              }
              int minEx = int.parse(MinutesExercise);
              int secEx = int.parse(SecondsExercise);
              int minRest = int.parse(MinutesRest);
              int secRest = int.parse(SecondsRest);
              int numEx = int.parse(NumberOfExercises);
              int numRep = int.parse(NumberOfRepetitions);
              int minRep = int.parse(MinutesToRepeat);
              int secRep = int.parse(SecondsToRepeat);
              int secTotal = ((minEx * 60 + secEx) * numEx +
                      (minRest * 60 + secRest) * (numEx - 1)) *
                  (numRep);
              if (numRep > 1) secTotal += (minRep * 60 + secRep);
              int minTotal = secTotal ~/ 60;
              secTotal = secTotal % 60;
              MinutesTotal = minTotal.toString().padLeft(2, '0');
              SecondsTotal = secTotal.toString().padLeft(2, '0');
              print(MinutesToRepeat);
              print(SecondsToRepeat);
            } else {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content:
                        Text('Too few seconds! (Should be at least 5 secs)')));
            }
          }),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: iconColor),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                time,
                style: TextStyle(
                  color: iconColor,
                  fontSize: 23,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemSetReps(IconData icon, Color color, Color iconColor,
      Color dialogThemeColor, String title, String repetitions) {
    return InkWell(
      onTap: () {
        showMaterialNumberPicker(
          backgroundColor: color,
          headerColor: dialogThemeColor,
          buttonTextColor: iconColor,
          title: '$title',
          context: context,
          minNumber: 0,
          maxNumber: 20,
          onChanged: (value) => setState(() {
            String rep = value.toString();
            if (int.parse(rep) > 0) {
              switch (title) {
                case 'Repetitions':
                  NumberOfRepetitions = rep;
                  break;
                case 'Exercises':
                  NumberOfExercises = rep;
                  break;
                default:
                  {}
              }
              int minEx = int.parse(MinutesExercise);
              int secEx = int.parse(SecondsExercise);
              int minRest = int.parse(MinutesRest);
              int secRest = int.parse(SecondsRest);
              int numEx = int.parse(NumberOfExercises);
              int numRep = int.parse(NumberOfRepetitions);
              int minRep = int.parse(MinutesToRepeat);
              int secRep = int.parse(SecondsToRepeat);
              int secTotal = ((minEx * 60 + secEx) * numEx +
                      (minRest * 60 + secRest) * (numEx - 1)) *
                  (numRep);
              if (numRep > 1) secTotal += (minRep * 60 + secRep);
              int minTotal = secTotal ~/ 60;
              secTotal = secTotal % 60;
              MinutesTotal = minTotal.toString().padLeft(2, '0');
              SecondsTotal = secTotal.toString().padLeft(2, '0');
              print(MinutesToRepeat);
              print(SecondsToRepeat);
            } else {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content: Text('Too few $title! (Should be at least 1)')));
            }
          }),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: iconColor),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                repetitions,
                style: TextStyle(
                  color: iconColor,
                  fontSize: 23,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void showAskingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Text('Bạn có chắc là thoát ứng dụng này?'),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  exit(0);
                },
                child: Text('Có')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Đéo')),
          ],
        );
      },
    );
  }
}

