import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';
import 'package:my_first_flutter_app/constants/notifications-manager.dart';
import 'package:my_first_flutter_app/model/remindTime.dart';
import 'package:my_first_flutter_app/screens/welcome/welcome.dart';
import '../history.dart';

class CongratulationPage extends StatefulWidget {
  static const id = '/congratulation-page';

  @override
  _CongratulationPageState createState() => _CongratulationPageState();
}

class _CongratulationPageState extends State<CongratulationPage> {
  var hiveBox = Hive.box('savedData');
  var hiveBoxTime = Hive.box('timeReminded');

  bool notificationEnabled = false;
  int numberConsecutiveDate = 1;
  int lastExerciseMin = 0, lastExerciseSec = 0;

  @override
  void initState() {
    lastExerciseMin = hiveBox.getAt(hiveBox.length - 1).durationSeconds ~/ 60;
    lastExerciseSec = hiveBox.getAt(hiveBox.length - 1).durationSeconds % 60;
    for (int i = hiveBox.length - 1; i >= 1; i--) {
      if (i == hiveBox.length - 1) {
        if (hiveBox.getAt(i).date.day == DateTime.now().day) {
          numberConsecutiveDate = 1;
        } else
          break;
      }
      print(daysBetween(hiveBox.getAt(i).date, hiveBox.getAt(i - 1).date)
              .toString() +
          "?");
      if (daysBetween(hiveBox.getAt(i).date, hiveBox.getAt(i - 1).date).abs() <=
          1) {
        print(daysBetween(hiveBox.getAt(i - 1).date,
                    hiveBox.getAt(i).date.subtract(Duration(days: 1)))
                .toString() +
            "!!");
        if (daysBetween(hiveBox.getAt(i).date.subtract(Duration(days: 1)),
                hiveBox.getAt(i - 1).date) ==
            0) {
          setState(() {
            numberConsecutiveDate += 1;
          });
          print("!!" + numberConsecutiveDate.toString());
        }
      } else
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Themes.appBarTheme,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 8, bottom: 16),
                        child: Center(
                            child: Text(
                          'Congratulations!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                      Container(
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: null,
                          child: Icon(
                            Icons.done,
                            size: 40,
                            color: Themes.appBarTheme,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 32, bottom: 16),
                        child: Text('You have finished your exercise!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      componentInfo(
                          Themes.exerciseThemeMain,
                          Themes.exerciseIconMain,
                          'Number of Consecutive Days',
                          numberConsecutiveDate.toString(),
                          Icons.done),
                      componentInfo(
                          Themes.restThemeMain,
                          Themes.restIconMain,
                          'Exercises completed',
                          (hiveBox.getAt(hiveBox.length - 1).numberExercise *
                                  hiveBox
                                      .getAt(hiveBox.length - 1)
                                      .numberRepetitions)
                              .toString(),
                          Icons.directions_run),
                      componentInfo(
                          Themes.numberRepetitionsThemeMain,
                          Themes.numberRepetitionsIconMain,
                          'Time spent exercising',
                          lastExerciseMin.toString().padLeft(2, '0') +
                              ":" +
                              lastExerciseSec.toString().padLeft(2, '0'),
                          Icons.timer),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Notify me to exercise tomorrow, at the same time',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                      Container(
                        child: CupertinoSwitch(
                          value: notificationEnabled,
                          onChanged: (value) {
                            setState(() {
                              notificationEnabled = value;
                              if(value == true){
                                DateTime dateTime = hiveBox.getAt(hiveBox.length - 1).date;
                                showMessage('Notifications are set to happen daily, at ' +
                                    dateTime.hour.toString() +
                                    ":" +
                                    dateTime.minute.toString());
                              } else {
                                showMessage('Notification settings are not changed');
                              }
                            });
                          },
                          activeColor: Colors.pinkAccent,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromRGBO(253, 224, 229, 1),
                        ),
                        child: InkWell(
                          onTap: () {
                            changeSetting();
                            Navigator.popUntil(context, ModalRoute.withName(WelcomePage.id));
                            Navigator.pushNamed(context, History.id);
                          },
                          child: Center(
                              child: Text(
                            'View History',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Themes.appBarTheme,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Themes.appBarTheme,
                        ),
                        child: InkWell(
                          onTap: () {
                            changeSetting();
                            Navigator.popUntil(context, ModalRoute.withName(WelcomePage.id));
                          },
                          child: Center(
                              child: Text(
                            'Finished!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget componentInfo(Color colorBackground, Color colorText, String title,
      String details, IconData icon) {
    return Container(
      alignment: FractionalOffset.topCenter,
      width: 70,
      child: Column(
        children: [
          FloatingActionButton(
            heroTag: title,
            backgroundColor: colorBackground,
            onPressed: null,
            child: Icon(
              icon,
              color: colorText,
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(details,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: colorText,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
              )),
          Center(
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color.fromRGBO(88, 87, 87, 1.0)))),
        ],
      ),
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void changeSetting() {
    DateTime dateTime = hiveBox.getAt(hiveBox.length - 1).date;

    if (notificationEnabled == true) {
      if (hiveBoxTime.isEmpty) {
        addNotification(dateTime.hour, dateTime.minute);
      } else {
        replaceNotification(
            dateTime.hour, dateTime.minute);
      }
    }
  }

  void addNotification(int hour, int minute) {
    hiveBoxTime.add(RemindTime(hour, minute));
    NotificationsManager notificationManager = NotificationsManager.init();
    notificationManager.showNotificationOneTime(hour, minute);
  }

  void replaceNotification(int hour, int minute) {
    hiveBoxTime.deleteAt(0);
    hiveBoxTime.add(RemindTime(hour, minute));

    NotificationsManager notificationManager = NotificationsManager.init();
    cancelAllNotification();
    notificationManager.showNotificationOneTime(hour, minute);
  }
}
