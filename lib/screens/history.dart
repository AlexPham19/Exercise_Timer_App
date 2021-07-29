import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';
import 'package:my_first_flutter_app/model/savedData.dart';
import 'package:my_first_flutter_app/widgets/drawer.dart';
import 'package:my_first_flutter_app/widgets/main-app-bar-with-drawer.dart';

class History extends StatefulWidget {
  static const id = '/history';

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var hiveBox = Hive.box('savedData');

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MaterialDrawer(
        currentRoute: '/history',
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: MainAppBar(
          title: 'History',
          scaffoldKey: _scaffoldKey,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView.builder(
          itemCount: hiveBox.length,
          itemBuilder: (BuildContext context, int index) {
            SavedData data = hiveBox.getAt(index);
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {
                  if (Platform.isIOS)
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => CupertinoActionSheet(
                        actions: <CupertinoActionSheetAction>[
                          CupertinoActionSheetAction(
                            child: const Text('Use this setting'),
                            onPressed: () {
                              if (hiveBox.getAt(index).isCustom == true) {
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(SnackBar(
                                      content: Text(
                                          'This setting could not be used, as this workout is a custom one')));
                              } else {
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(SnackBar(
                                      content: Text(
                                          'This feature is currently under development')));
                              }
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text('Delete Workout'),
                            onPressed: () {
                              setState(() {
                                hiveBox.deleteAt(index);
                              });
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    );
                  else
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                //leading: new Icon(Icons.photo),
                                title: new Text('Use this setting'),
                                onTap: () {
                                  if (hiveBox.getAt(index).isCustom == true) {
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(SnackBar(
                                          content: Text(
                                              'This setting could not be used, as this workout is a custom one')));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(SnackBar(
                                          content: Text(
                                              'This feature is currently under development')));
                                  }
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                //leading: new Icon(Icons.music_note),
                                title: new Text('Delete Workout'),
                                onTap: () {
                                  setState(() {
                                    hiveBox.deleteAt(index);
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                },
                child: Column(
                  children: [
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.grey,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    data.date.day.toString() +
                                        " thg " +
                                        data.date.month.toString() +
                                        ' ' +
                                        data.date.year.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Themes.appBarTheme,
                                  ),
                                  text: (data.durationSeconds ~/ 60).toString(),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' min ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextSpan(
                                      text: (data.durationSeconds % 60)
                                          .toString(),
                                    ),
                                    TextSpan(
                                      text: ' s',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Color.fromRGBO(251, 251, 251, 1.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            data.exerciseTime != -1
                                ? textComponent('Tập luyện',
                                    data.exerciseTime.toString(), true)
                                : Text('(Custom Exercise)'),
                            data.restTime != -1
                                ? textComponent(
                                    'Nghỉ ngơi', data.restTime.toString(), true)
                                : Container(),
                            textComponent('Bài tập',
                                data.numberExercise.toString(), false),
                            textComponent('Vòng tập',
                                data.numberRepetitions.toString(), false),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget textComponent(String title, String number, bool isTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(number,
                style: TextStyle(
                    color: Themes.appBarTheme,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
            isTime == true
                ? Container(
                    padding: EdgeInsets.only(top: 6), child: Text(' s '))
                : Container(),
          ],
        )
      ],
    );
  }
}
