
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

  @override
  void initState() {
    _controller = PageController(initialPage: 0, keepPage: true);
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
      print(_selectedPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    for (int i = hiveBox.length - 1; i > 1; i--) {
      if (daysBetween(hiveBox.getAt(i).date, hiveBox.getAt(i - 1).date) <= 1) {
        if (daysBetween(hiveBox.getAt(i).date, hiveBox.getAt(i - 1).date) == 1)
          numberConsecutiveDate += 1;
      } else
        break;
    }
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
                        child: statisticsRow(numberConsecutiveDate, 1, 0), // Chưa rõ cách tính
                      ),
                    ),
                    Container(
                      child: Center(
                        child: statisticsRow(1, 0, 0), // dummy data. Mình chưa rõ cách tính
                      ),
                    ),
                    Container(
                      child: Center(
                        child: statisticsRow(1, 0, 0), // Chưa rõ cách tính
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

  Widget statisticsRow(
      int consecutiveDays, int numberOfExercises, int durationSeconds) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          infoColumn(Themes.exerciseIconMain, Themes.exerciseThemeMain,
              Icons.done, 'Số ngày liên tục', consecutiveDays.toString()),
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
