import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';
import 'package:my_first_flutter_app/widgets/drawer.dart';
import 'package:my_first_flutter_app/widgets/main-app-bar-with-drawer.dart';

class Statistics extends StatefulWidget {
  static const id = '/statistics';

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _selectedPage = 0;
  PageController _controller = new PageController(initialPage: 0);

  var hiveBox = Hive.box('savedData');

  int numberConsecutiveDate = 0;

  int totalExercises = 0;
  int totalDurations = 0;

  int totalDays7Days = 0;
  int totalExercises7Days = 0;
  int totalDurations7Days = 0;

  int totalDays30Days = 0;
  int totalExercises30Days = 0;
  int totalDurations30Days = 0;

  @override
  void initState() {
    setState(() {
      _controller = PageController(initialPage: 0, keepPage: true);
    });
    totalDays7Days = 0;
    totalExercises7Days = 0;
    totalDurations7Days = 0;
    numberConsecutiveDate = 0;
    totalExercises = 0;
    totalDurations = 0;
    totalDays30Days = 0;
    totalExercises30Days = 0;
    totalDurations30Days = 0;
    if (hiveBox.length == 1) {
      setState(() {
        numberConsecutiveDate = 1;
      });
    } else {
      for (int i = hiveBox.length - 1; i > 0; i--) {
        if (i == hiveBox.length - 1) {
          if (hiveBox.getAt(i).date.day == DateTime.now().day) {
            setState(() {
              numberConsecutiveDate = 1;
            });
          } else
            break;
        }
        if (daysBetween(hiveBox.getAt(i).date, hiveBox.getAt(i - 1).date)
                .abs() <=
            1) {
          if (daysBetween(hiveBox.getAt(i).date.subtract(Duration(days: 1)),
                  hiveBox.getAt(i - 1).date) ==
              0) {
            setState(() {
              numberConsecutiveDate += 1;
            });
          }
        } else
          break;
      }
    }

    for (int i = 0; i < hiveBox.length; i++) {
      if (daysBetween(hiveBox.getAt(i).date, DateTime.now()) == 0 &&
          hiveBox.getAt(i).date.day == DateTime.now().day) {
        setState(() {
          totalDurations +=
              int.parse(hiveBox.getAt(i).durationSeconds.toString());
          totalExercises = totalExercises +
              int.parse(hiveBox.getAt(i).numberExercise.toString()) *
                  int.parse(hiveBox.getAt(i).numberRepetitions.toString());
        });
      }
    }
    for (int i = 0; i < hiveBox.length; i++) {
      if (daysBetween(hiveBox.getAt(i).date, DateTime.now()) <= 29 &&
          hiveBox.getAt(i).date.day !=
              DateTime.now().subtract(Duration(days: 30))) {
        setState(() {
          totalDays30Days += 1;
          totalDurations30Days +=
              int.parse(hiveBox.getAt(i).durationSeconds.toString());
          totalExercises30Days = totalExercises30Days +
              int.parse(hiveBox.getAt(i).numberExercise.toString()) *
                  int.parse(hiveBox.getAt(i).numberRepetitions.toString());
        });
      }
    }
    for (int i = 0; i < hiveBox.length; i++) {
      if (daysBetween(hiveBox.getAt(i).date, DateTime.now()) <= 6 &&
          hiveBox.getAt(i).date.day !=
              DateTime.now().subtract(Duration(days: 7))) {
        setState(() {
          totalDays7Days += 1;
          totalDurations7Days +=
              int.parse(hiveBox.getAt(i).durationSeconds.toString());
          totalExercises7Days = totalExercises7Days +
              int.parse(hiveBox.getAt(i).numberExercise.toString()) *
                  int.parse(hiveBox.getAt(i).numberRepetitions.toString());
        });
      }
    }


    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changePage(int page) {
    setState(() {
      _selectedPage = page;
      _controller.animateToPage(page,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn);
      //print(_selectedPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MaterialDrawer(
        currentRoute: Statistics.id,
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: MainAppBar(
          title: 'Statistics',
          scaffoldKey: _scaffoldKey,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Chọn Thời gian',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8, bottom: 24),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleButtons(
                      fillColor: Themes.appBarTheme,
                      color: Colors.grey,
                      selectedColor: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                      onPressed: (int index) {
                        setState(() {
                          _changePage(index);
                        });
                      },
                      isSelected: [
                        _selectedPage == 0,
                        _selectedPage == 1,
                        _selectedPage == 2,
                      ],
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Text("Đến Ngày"),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _changePage(1);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Text("Tuần trước"),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _changePage(2);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Text("Tháng trước"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (int page) {
                    setState(() {
                      _selectedPage = page;
                    });
                  },
                  children: [
                    Container(
                      child: Center(
                        child: statisticsRow(
                            numberConsecutiveDate,
                            totalExercises,
                            totalDurations,
                            true), // Chưa rõ cách tính
                      ),
                    ),
                    Container(
                      child: Center(
                        child: statisticsRow(
                            1,
                            totalExercises7Days,
                            totalDurations7Days,
                            false), // dummy data. Mình chưa rõ cách tính
                      ),
                    ),
                    Container(
                      child: Center(
                        child: statisticsRow(1, totalExercises30Days,
                            totalDurations30Days, false), // Chưa rõ cách tính
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget statisticsRow(int consecutiveDays, int numberOfExercises,
      int durationSeconds, bool isOptionDaySelected) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          infoColumn(
              Themes.exerciseIconMain,
              Themes.exerciseThemeMain,
              Icons.done,
              isOptionDaySelected ? 'Số ngày tập liên tiếp' : 'Số ngày đã tập',
              consecutiveDays.toString()),
          infoColumn(
              Themes.restIconMain,
              Themes.restThemeMain,
              Icons.directions_run,
              'Các bài tập đã hoàn tất',
              numberOfExercises.toString()),
          infoColumn(
              Themes.numberRepetitionsIconMain,
              Themes.numberRepetitionsThemeMain,
              Icons.timer,
              'Thời gian bài tập',
              (durationSeconds ~/ 60).toString().padLeft(2, '0') +
                  ":" +
                  (durationSeconds % 60).toString().padLeft(2, '0')),
        ],
      ),
    );
  }

  Widget infoColumn(Color colorIcon, Color colorBackground, IconData icon,
      String title, String details) {
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
              color: colorIcon,
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(details,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: colorIcon,
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
}
