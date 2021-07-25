import 'dart:async';
import 'dart:ui';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_first_flutter_app/model/savedData.dart';
import 'package:my_first_flutter_app/screens/welcome/welcome.dart';

class ExerciseMain extends StatefulWidget {
  @override
  _ExerciseMainState createState() => _ExerciseMainState();
}

int minutesExercise = int.parse(MinutesExercise);
int secondsExercise = int.parse(SecondsExercise);
int minutesRest = int.parse(MinutesRest);
int secondsRest = int.parse(SecondsRest);
int minutesToRepeat = int.parse(MinutesToRepeat);
int secondsToRepeat = int.parse(SecondsToRepeat);
int numberOfExercises = int.parse(NumberOfExercises);
int numberOfRepetitions = int.parse(NumberOfRepetitions);

List<String> States = [];
List<int> Time = [];
int counterMinutes = 0, counterSeconds = 10; // low = number, up = string
String CounterMinutes = '00', CounterSeconds = '10';
String currentState = 'Ready';
List<Color> TimerColors = [];

class _ExerciseMainState extends State<ExerciseMain>
    with TickerProviderStateMixin {
  int index = 0;
  bool first = false;
  AnimationController? controller;

  String get timerString {
    Duration duration = controller!.duration! * (controller!.value);
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    counterSeconds = 10;
    counterMinutes = 0;
    int minutesExercise = int.parse(MinutesExercise);
    int secondsExercise = int.parse(SecondsExercise);
    int minutesRest = int.parse(MinutesRest);
    int secondsRest = int.parse(SecondsRest);
    int minutesToRepeat = int.parse(MinutesToRepeat);
    int secondsToRepeat = int.parse(SecondsToRepeat);
    int numberOfExercises = int.parse(NumberOfExercises);
    int numberOfRepetitions = int.parse(NumberOfRepetitions);
    controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: counterSeconds + counterMinutes * 60));

    States.add('Ready');
    Time.add(10);
    TimerColors.add(Color.fromRGBO(252, 182, 8, 1.0));
    for (int i = 1; i <= numberOfRepetitions; i++) {
      for (int j = 1; j <= numberOfExercises; j++) {
        States.add('Exercise');
        TimerColors.add(Colors.green);
        Time.add(minutesExercise * 60 + secondsExercise);
        if (j == numberOfExercises && numberOfRepetitions > 1) {
          States.add('Time to change Rep');
          TimerColors.add(Colors.blue);
          Time.add(minutesToRepeat * 60 + secondsToRepeat);
        } else if (j == numberOfExercises && numberOfRepetitions == 1) {
        } else {
          TimerColors.add(Colors.redAccent);
          States.add('Rest');
          Time.add(minutesRest * 60 + secondsRest);
        }
      }
    }
    if (numberOfRepetitions > 1) States.removeAt(States.length - 1);
    controller!.forward(from: 1.0);
    for (int i = 0; i < States.length; i++) print(States[i]);
    super.initState();
  }

  @override
  void dispose() {
    States.clear();
    Time.clear();
    //TimerColors.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Now'),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          showAskingDialog();
          return false;
        },
        child: SafeArea(
          child: Container(
            color: TimerColors[index],
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
                                return new CustomPaint(
                                  painter: TimerPainter(
                                    animation: controller!,
                                    backgroundColor:
                                        Color.fromRGBO(194, 192, 192, 1),
                                    color: Colors.white,
                                  ),
                                );
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
                                          if (index >= States.length - 1) {
                                            setState(() {
                                              var hiveBox =
                                                  Hive.box('savedData');
                                              hiveBox.add(SavedData(
                                                  (int.parse(MinutesExercise) *
                                                              60 +
                                                          int.parse(
                                                              SecondsExercise)) *
                                                      int.parse(
                                                          NumberOfExercises) *
                                                      int.parse(
                                                          NumberOfRepetitions),
                                                  DateTime.now(),
                                                  false));
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
                    child: Text('Thêm 15 giây nghỉ'),
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
        if(index < States.length - 1)
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
                    Navigator.pop(context);
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
        });
  }
}

class TimerPainter extends CustomPainter {
  final Animation animation;
  final Color color, backgroundColor;

  TimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 20.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
    paint.color = color;
    double progress = (1 - animation.value) * 2 * pi;
    canvas.drawArc(Offset.zero & size, pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
