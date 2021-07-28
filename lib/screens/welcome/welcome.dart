import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';
import 'package:my_first_flutter_app/widgets/drawer.dart';
import 'package:my_first_flutter_app/widgets/main-app-bar-with-drawer.dart';

String MinutesTotal = '',
    SecondsTotal = '',
    MinutesExercise = '',
    SecondsExercise = '',
    MinutesRest = '',
    SecondsRest = '',
    NumberOfExercises = '',
    NumberOfRepetitions = '',
    MinutesToRepeat = '',
    SecondsToRepeat = '';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    MinutesTotal = '00';
    SecondsTotal = '35';
    MinutesExercise = '00';
    SecondsExercise = '05';
    MinutesRest = '00';
    SecondsRest = '05';
    NumberOfExercises = '2';
    NumberOfRepetitions = '2';
    MinutesToRepeat = '00';
    SecondsToRepeat = '05';
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
          title: 'Stopwatch',
          scaffoldKey: _scaffoldKey,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xffFA5853), Color(0xffF42E52)],
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
             // color: Themes.appBarTheme,
              padding: EdgeInsets.symmetric(vertical: 20),
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
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
    );
  }

  Widget itemSetTime(IconData icon, Color color, Color iconColor, Color dialogThemeColor, String title,
      String time, String minutes, String seconds) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController _editingControllerMinutes =
                new TextEditingController(text: minutes);
            TextEditingController _editingControllerSeconds =
                new TextEditingController(text: seconds);
            return AlertDialog(
              backgroundColor: dialogThemeColor,
              actions: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      String min = _editingControllerMinutes.text.toString();
                      String sec = _editingControllerSeconds.text.toString();
                      if (int.parse(min) * 60 + int.parse(sec) >= 5 &&
                          min != '' &&
                          sec != '' &&
                          int.parse(sec) < 60) {
                        setState(() {
                          switch (title) {
                            case 'Exercise':
                              MinutesExercise = min;
                              SecondsExercise = sec;
                              break;
                            case 'Rest':
                              MinutesRest = min;
                              SecondsRest = sec;
                              break;
                            case 'Time to repeat':
                              MinutesToRepeat = min;
                              SecondsToRepeat = sec;
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
                          MinutesTotal = minTotal.toString();
                          SecondsTotal = secTotal.toString();
                          if (minTotal < 10) MinutesTotal = '0' + MinutesTotal;
                          if (secTotal < 10) SecondsTotal = '0' + SecondsTotal;
                          print(MinutesToRepeat);
                          print(SecondsToRepeat);
                        });
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'OK',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
              content: Container(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_circle_outline,
                                color: Colors.white, size: 30.0),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 60.0,
                          width: 50.0,
                          child: TextField(
                            maxLength: 2,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                            ),
                            style: TextStyle(
                              fontSize: 40.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            cursorColor: Colors.white,
                            cursorHeight: 60.0,
                            autofocus: true,
                            controller: _editingControllerMinutes,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            ':',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          height: 60.0,
                          width: 50.0,
                          child: TextField(
                            maxLength: 2,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: 40.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                            ),
                            cursorColor: Colors.white,
                            autofocus: true,
                            controller: _editingControllerSeconds,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
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

  Widget itemSetReps(IconData icon, Color color, Color iconColor, Color dialogThemeColor, String title,
      String repetitions) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController _editingControllerReps =
                new TextEditingController(text: repetitions);
            return AlertDialog(
              backgroundColor: dialogThemeColor,
              actions: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      String rep = _editingControllerReps.text.toString();
                      if (int.parse(rep) > 0) {
                        setState(() {
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
                          MinutesTotal = minTotal.toString();
                          SecondsTotal = secTotal.toString();
                          if (minTotal < 10) MinutesTotal = '0' + MinutesTotal;
                          if (secTotal < 10) SecondsTotal = '0' + SecondsTotal;
                        });
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'OK',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
              content: Container(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(icon, color: Colors.white, size: 30.0),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 60.0,
                          width: 50.0,
                          child: TextField(
                            maxLength: 3,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                            ),
                            style: TextStyle(
                              fontSize: 40.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            cursorColor: Colors.white,
                            cursorHeight: 60.0,
                            autofocus: true,
                            controller: _editingControllerReps,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
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
}