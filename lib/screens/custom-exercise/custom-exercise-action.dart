import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';
import 'package:my_first_flutter_app/constants/lifecycle-event-handler.dart';
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

  int exercises = 0, repetitions = 0;

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
    //flutterTts.speak('Get ready');
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
    controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: counterSeconds + counterMinutes * 60));
    repetitions = int.parse(numberRepetitions);
    exercises = int.parse(numberExercises);
    currentState = 'Ready';
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
    numberExercises = '';
    numberRepetitions = '';
    listCustomExercise.clear();
    index = 0;
    controller!.dispose();
    States.clear();
    Time.clear();
    TimerColors.clear();
    ThemeGradients.clear();
    BorderColors.clear();
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
                                print('timerString = ' + timerString);
                                // Nhớ dừng audio khi bấm nút dừng
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
                                return Container(
                                  child: Text('.'),
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
                                Visibility(
                                  visible: index % 2 == 1,
                                  child: Text(
                                    ((index + 1) ~/ 2).toString() +
                                        "/" +
                                        (exercises * repetitions).toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                Visibility(
                                  visible: index % 2 == 1,
                                  child: Image.asset(
                                    'assets/gif/' +
                                        listCustomExercise[index ~/ 2].imgUrl,
                                    height: 200,
                                    width: 300,
                                  ),
                                ),
                                AnimatedBuilder(
                                    animation: controller!
                                      ..addStatusListener((status) {
                                        if (controller!.value == 0) {
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
                                              print(
                                                  "******************** $timeStart ********************");
                                              hiveBox.add(SavedData(
                                                  totalDuration,
                                                  timeStart,
                                                  true,
                                                  -1,
                                                  -1,
                                                  int.parse(numberExercises),
                                                  int.parse(numberRepetitions),
                                                  timeToChangeRep));
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.all(12),
                        child: Visibility(
                          visible: States[index] != 'Ready' &&
                              States[index] != 'Time to change Rep' &&
                              States[index] != 'Rest',
                          child: FloatingActionButton(
                            heroTag: 'Exercise Guide',
                            backgroundColor: Themes.exerciseIconMain,
                            onPressed: () {
                              setState(() {
                                if (controller!.isAnimating) controller!.stop();
                              });
                              String name = '', description = '';
                              for (int i = 0;
                                  i < allPossibleExercise.length;
                                  i++) {
                                if (allPossibleExercise[i].name ==
                                    States[index]) {
                                  setState(() {
                                    name = States[index];
                                    description = allPossibleExercise[i].help;
                                  });
                                }
                              }
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('How to do $name:'),
                                      content: Text(description),
                                    );
                                  });
                            },
                            child: Text(
                              '?',
                              style: TextStyle(fontSize: 28),
                            ),
                          ),
                        ),
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
                      Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.all(12),
                        child: Visibility(
                          visible: Hive.box('settings').get('soundType') == 0 ||
                              Hive.box('settings').get('soundType') == 1,
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
                              //controller!.stop();
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
                            'Add 15 seconds to rest',
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
                              if (soundType == 0 || soundType == 1) {
                                playerLong.seek(Duration(seconds: 0));
                                playSound(soundType, 'Start', playerLong);
                              }
                            });
                          },
                          child: Text(
                            'Start Now',
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
        CounterMinutes = counterMinutes.toString().padLeft(2, '0');
        CounterSeconds = counterSeconds.toString().padLeft(2, '0');
        currentState = States[index];
      });
    }
  }

  void playSound(int type, String text, AudioPlayer player) async {
    if (type == 0) {
      flutterTts.speak(text);
    } else if (type == 1) {
      player.play();
    }
    //flutterTts.stop();
  }

  void showAskingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        controller!.stop();
        return AlertDialog(
          title: Column(
            children: [
              Text('Do you want to stop this exercise'),
              Text('If you do, this exercise will be discarded and not be saved'),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.popAndPushNamed(context, Exercises.id);
                },
                child: Text('Yes')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller!.reverse();
                },
                child: Text('No')),
          ],
        );
      },
    );
  }
}
