import 'dart:ui';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';
import 'package:my_first_flutter_app/constants/lifecycle-event-handler.dart';
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
List<LinearGradient> ThemeGradients = [];
List<Color> BorderColors = [];

class _ExerciseMainState extends State<ExerciseMain>
    with TickerProviderStateMixin {
  int index = 0;
  bool first = false;
  AnimationController? controller;
  int soundType = 0;
  DateTime timeStart = DateTime.now();

  final playerShort2Sec = AudioPlayer();
  final playerShort1Sec = AudioPlayer();
  final playerShort0Sec = AudioPlayer();
  final playerLong = AudioPlayer();
  FlutterTts flutterTts = FlutterTts();

  String get timerString {
    Duration duration = controller!.duration! * (controller!.value);

    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    WidgetsBinding.instance!
        .addObserver(LifecycleEventHandler(inactiveCallBack: () async {
      setState(() {
        if (controller != null && Hive.box('settings').get('isPaused') == true)
          controller!.stop();
      });
    }, detachedCallBack: () async {
      print('detached...');
    }, resumeCallBack: () async {
      print('resume...');
    }));

    soundType = Hive.box('settings').get('soundType');
    timeStart = DateTime.now();

    flutterTts.awaitSpeakCompletion(true);
    flutterTts.setLanguage("en-US");
    flutterTts.setSpeechRate(0.5);
    flutterTts.setVolume(1.0);
    flutterTts.setPitch(1.0);
    playSound(soundType, 'get ready', playerLong);

    playerShort2Sec.setAsset('assets/audio/beep-short.mp3');
    playerShort1Sec.setAsset('assets/audio/beep-short.mp3');
    playerShort0Sec.setAsset('assets/audio/beep-short.mp3');
    playerLong.setAsset('assets/audio/beep-long.mp3');
    playerShort2Sec.seek(Duration(seconds: 0));
    playerShort1Sec.seek(Duration(seconds: 0));
    playerShort0Sec.seek(Duration(seconds: 0));

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
    currentState = 'Ready';
    index = 0;
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
    for (int i = 1; i <= numberOfRepetitions; i++) {
      for (int j = 1; j <= numberOfExercises; j++) {
        States.add('Exercise');
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
        Time.add(minutesExercise * 60 + secondsExercise);
        if (j == numberOfExercises && numberOfRepetitions > 1) {
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
          Time.add(minutesToRepeat * 60 + secondsToRepeat);
        } else if (j == numberOfExercises && numberOfRepetitions == 1) {
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
    controller!.dispose();
    States.clear();
    Time.clear();
    playerShort2Sec.dispose();
    playerShort1Sec.dispose();
    playerShort0Sec.dispose();
    playerLong.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TimerColors[index],
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
                                print('timerString = ' + timerString);
                                if (timerString == '00:02') {
                                  if (soundType == 0 || soundType == 1)
                                    playSound(
                                        soundType, 'three', playerShort2Sec);
                                }
                                if (timerString == '00:01') {
                                  if (soundType == 0 || soundType == 1)
                                    playSound(
                                        soundType, 'two', playerShort1Sec);
                                }
                                if (timerString == '00:00') {
                                  if (soundType == 0 || soundType == 1)
                                    playSound(
                                        soundType, 'one', playerShort0Sec);
                                }
                                return new CustomPaint(
                                  painter: TimerPainter(
                                    animation: controller!,
                                    backgroundColor: BorderColors[index],
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
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      first != true ? 'Ready' : currentState,
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    ),
                                    Visibility(
                                      visible: index % 2 == 1,
                                      child: Container(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Text(
                                          ((index + 1) ~/ 2).toString() +
                                              "/" +
                                              (numberOfExercises *
                                                      numberOfRepetitions)
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                AnimatedBuilder(
                                    animation: controller!
                                      ..addStatusListener((status) {
                                        if (timerString == '00:08') {
                                          setState(() {
                                            print("HOW");
                                          });
                                        }
                                        if (controller!.value == 0) {
                                          print('WHY');
                                          String text =
                                              States[index] == 'Exercise'
                                                  ? 'Stop'
                                                  : 'Start';
                                          setState(() {
                                            playerLong.pause();
                                            if (soundType == 0 ||
                                                soundType == 1)
                                              playSound(
                                                  soundType, text, playerLong);
                                          });

                                          playerLong
                                              .seek(Duration(milliseconds: 0));
                                          playerShort2Sec
                                              .seek(Duration(milliseconds: 0));
                                          playerShort2Sec.pause();
                                          playerShort1Sec
                                              .seek(Duration(milliseconds: 0));
                                          playerShort1Sec.pause();
                                          playerShort0Sec
                                              .seek(Duration(milliseconds: 0));
                                          playerShort0Sec.pause();
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
                                                  timeStart,
                                                  false,
                                                  int.parse(MinutesExercise *
                                                          60) +
                                                      int.parse(
                                                          SecondsExercise),
                                                  int.parse(MinutesRest) * 60 +
                                                      int.parse(SecondsRest),
                                                  int.parse(NumberOfExercises),
                                                  int.parse(
                                                      NumberOfRepetitions),
                                                  int.parse(MinutesToRepeat) *
                                                          60 +
                                                      int.parse(
                                                          SecondsToRepeat)));
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
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.all(12),
                        child: Visibility(visible: false, child: FloatingActionButton(onPressed: () {},)),
                      ),
                      Container(
                        width: 150,
                        height: 150,
                        padding: EdgeInsets.all(32.0),
                        child: FloatingActionButton(
                            heroTag: 'Play and Pause',
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
                        visible: Hive.box('settings').get('soundType') == 0 ||
                            Hive.box('settings').get('soundType') == 1,
                        child: Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.all(12.0),
                            child: FloatingActionButton(
                              heroTag: 'Turn on or off the volume',
                              backgroundColor: TimerColors[index],
                              onPressed: () {
                                setState(() {
                                  if (soundType != 2) {
                                    soundType = 2;
                                  } else {
                                    soundType =
                                        Hive.box('settings').get('soundType');
                                  }
                                });
                              },
                              child: soundType != 2
                                  ? Icon(Icons.volume_up)
                                  : Icon(Icons.volume_off),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Visibility(
                  visible: currentState == 'Rest' || currentState == 'Ready',
                  child: currentState == 'Rest'
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              controller = AnimationController(
                                  vsync: this,
                                  duration: Duration(
                                      seconds: (controller!.value *
                                                  controller!
                                                      .duration!.inSeconds +
                                              15)
                                          .round()));
                              controller!.reverse(from: 1.0);
                            });
                          },
                          child: Text(
                            'Thêm 15 giây nghỉ',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              first = true;
                              action();
                              print(States[index]);
                              controller = AnimationController(
                                  vsync: this,
                                  duration: Duration(
                                      seconds: counterSeconds +
                                          counterMinutes * 60));
                              controller!.reverse(from: 1.0);
                              playerLong.seek(Duration(seconds: 0));
                              playSound(soundType, 'Start', playerLong);
                            });
                          },
                          child: Text(
                            'Bắt đầu luôn',
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

  void playSound(int type, String text, AudioPlayer player) async {
    if (type == 0) {
      flutterTts.speak(text);
    } else if (type == 1) {
      player.play();
    }
    //flutterTts.stop();
  }

  void action() {
    if (mounted) {
      setState(() {
        if (index < States.length - 1) index += 1;
        counterMinutes = Time[index] ~/ 60;
        counterSeconds = Time[index] % 60;
        CounterMinutes = counterMinutes.toString().padLeft(2, '0');
        CounterSeconds = counterSeconds.toString().padLeft(2, '0');
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
  final Animation<double> animation;
  final Color color, backgroundColor;

  TimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 9.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
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
