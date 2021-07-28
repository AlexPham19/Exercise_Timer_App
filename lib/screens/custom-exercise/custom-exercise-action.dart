import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';
import 'package:my_first_flutter_app/model/exerciseData.dart';
import 'package:my_first_flutter_app/model/savedData.dart';
import 'package:my_first_flutter_app/screens/custom-exercise/custom-exercise.dart';
import 'package:my_first_flutter_app/screens/exercises.dart';

class CustomExerciseAction extends StatefulWidget {
  static const id = '/custom-exercise-action';

  @override
  _CustomExerciseActionState createState() => _CustomExerciseActionState();
}

List<String> States = [];
List<int> Time = [];
int counterMinutes = 0, counterSeconds = 10; // low = number, up = string
String CounterMinutes = '00', CounterSeconds = '10';
String currentState = 'Ready';
List<Color> TimerColors = [];
List<ExerciseData> listData = [];
List<LinearGradient> ThemeGradients = [];
List<Color> BorderColors = [];

class _CustomExerciseActionState extends State<CustomExerciseAction>
    with TickerProviderStateMixin {
  AnimationController? controller;
  int index = 0;
  bool first = false;

  String get timerString {
    Duration duration = controller!.duration! * (controller!.value);
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    counterSeconds = 10;
    counterMinutes = 0;
    controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: counterSeconds + counterMinutes * 60));
    int repetitions = int.parse(numberRepetitions);
    int exercises = int.parse(numberExercises);
    States.add('Ready');
    Time.add(10);
    TimerColors.add(Color.fromRGBO(252, 182, 8, 1.0));
    BorderColors.add(Themes.readyTimerBorder);
    ThemeGradients.add(
      LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Themes.readyThemeStart, Themes.readyThemeEnd],
        tileMode: TileMode.repeated, // repeats the gradient over the canvas
      ),
    );
    for (int i = 1; i <= repetitions; i++) {
      for (int j = 1; j <= exercises; j++) {
        States.add(listCustomExercise[j - 1].name);
        TimerColors.add(Colors.green);
        BorderColors.add(Themes.exerciseTimerBorder);
        ThemeGradients.add(
          LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Themes.exerciseThemeStart, Themes.exerciseThemeEnd],
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        );
        Time.add(listCustomExercise[j - 1].secondExercise);
        if (j == exercises && repetitions > 1) {
          print(repetitions);
          States.add('Time to change Rep');
          TimerColors.add(Colors.yellow);
          BorderColors.add(Themes.readyTimerBorder);
          ThemeGradients.add(
            LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Themes.readyThemeStart, Themes.readyThemeEnd],
              tileMode:
                  TileMode.repeated, // repeats the gradient over the canvas
            ),
          );
          Time.add(timeToChangeRep);
        } else if (j == exercises && repetitions == 1) {
        } else {
          TimerColors.add(Colors.redAccent);
          BorderColors.add(Themes.restTimerBorder);
          ThemeGradients.add(
            LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Themes.restThemeStart, Themes.restThemeEnd],
              tileMode:
                  TileMode.repeated, // repeats the gradient over the canvas
            ),
          );
          States.add('Rest');
          Time.add(listCustomExercise[j - 1].secondRest);
        }
      }
    }
    if (repetitions > 1) States.removeAt(States.length - 1);
    controller!.forward(from: 1.0);
    for (int i = 0; i < States.length; i++) print(States[i]);
    super.initState();
    setState(() {
      listData = listCustomExercise;
    });
    print("State length is " + States.length.toString());
    for (int i = 0; i < listCustomExercise.length; i++) {
      print(i.toString() +
          ": " +
          listCustomExercise[i].name +
          ' --> ' +
          listCustomExercise[i].secondExercise.toString() +
          ' and ' +
          listCustomExercise[i].secondRest.toString());
    }
  }

  @override
  void dispose() {
    controller!.dispose();
    States.clear();
    Time.clear();
    TimerColors.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TimerColors[index],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            showAskingDialog();
          },
        ),
        title: Text(
          'Exercise Now',
          style: TextStyle(fontSize: 23),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          showAskingDialog();
          return false;
        },
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: ThemeGradients[index],
            ),
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.0, horizontal: 26.0),
                  child: Align(
                    alignment: FractionalOffset.center,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: AnimatedBuilder(
                              animation: controller!,
                              builder: (BuildContext context, Widget? child) {
                                return Container();
                              },
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  first != true ? 'Ready' : currentState,
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
                                ),
                                AnimatedBuilder(
                                    animation: controller!
                                      ..addStatusListener((status) {
                                        if (controller!.value == 0) {
                                          print(index);
                                          if (index >= States.length - 1) {
                                            setState(() {
                                              int totalDuration = 0;
                                              for (int i = 0;
                                                  i < listData.length;
                                                  i++) {
                                                totalDuration +=
                                                    listCustomExercise[i]
                                                        .secondExercise;
                                              }
                                              var hiveBox =
                                                  Hive.box('savedData');
                                              hiveBox.add(SavedData(
                                                  totalDuration,
                                                  DateTime.now(),
                                                  true,
                                                  -1,
                                                  -1,
                                                  int.parse(numberExercises),
                                                  int.parse(
                                                      numberRepetitions)));
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  '/congratulation-page');
                                            });
                                          } else {
                                            setState(() {
                                              action();
                                              controller = AnimationController(
                                                  vsync: this,
                                                  duration: Duration(
                                                      seconds: counterSeconds +
                                                          counterMinutes * 60));
                                              controller!.reverse(
                                                  from: controller!.value == 0.0
                                                      ? 1.0
                                                      : controller!.value);
                                            });
                                          }
                                        }
                                      }),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return new Text(
                                        first == true ? timerString : '10:00',
                                        style: TextStyle(
                                            fontSize: 60, color: Colors.white),
                                      );
                                    })
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 150,
                  padding: EdgeInsets.all(32.0),
                  child: FloatingActionButton(
                      elevation: 4.0,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AnimatedBuilder(
                          animation: controller!,
                          builder: (BuildContext context, Widget? child) {
                            return new Icon(
                              controller!.isAnimating
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 40.0,
                              color: TimerColors[index],
                            );
                          },
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          first = true;
                          if (index == States.length) dispose();
                          if (controller!.isAnimating)
                            controller!.stop();
                          else {
                            controller!.reverse(
                                from: controller!.value == 0.0
                                    ? 1.0
                                    : controller!.value);
                          }
                        });
                      }),
                ),
                Visibility(
                  visible: currentState == 'Rest',
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        controller!.stop();
                        controller = AnimationController(
                            vsync: this,
                            duration: Duration(
                                seconds: (controller!.value *
                                            controller!.duration!.inSeconds +
                                        15)
                                    .round()));
                        controller!.reverse(from: 1.0);
                      });
                    },
                    child: Text(
                      'Thêm 15 giây nghỉ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void action() {
    if (mounted) {
      setState(() {
        index += 1;
        counterMinutes = Time[index] ~/ 60;
        counterSeconds = Time[index] % 60;
        CounterMinutes = counterMinutes.toString();
        CounterSeconds = counterSeconds.toString();
        if (counterMinutes < 10) CounterMinutes = '0' + CounterMinutes;
        if (counterSeconds < 10) CounterSeconds = '0' + CounterSeconds;
        currentState = States[index];
      });
    }
  }

  void showAskingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        controller!.stop();
        return AlertDialog(
          title: Column(
            children: [
              Text('Bạn có chắc là thoát bài tập này?'),
              Text('Nếu bạn thoát, hệ thống sẽ không lưu bài tập này!'),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.popAndPushNamed(context, Exercises.id);
                },
                child: Text('Có')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller!.reverse();
                },
                child: Text('Đéo')),
          ],
        );
      },
    );
  }
}
