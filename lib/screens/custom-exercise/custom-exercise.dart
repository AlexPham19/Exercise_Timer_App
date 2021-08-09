import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:flutter_material_pickers/helpers/show_radio_picker.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';
import 'package:my_first_flutter_app/model/exerciseData.dart';
import 'package:my_first_flutter_app/model/exerciseDetails.dart';

import '../../parse-json.dart';

class CustomExercise extends StatefulWidget {
  static const id = '/custom-exercise';

  @override
  _CustomExerciseState createState() => _CustomExerciseState();
}

enum Type {
  TextName,
  TextExerciseMinutes,
  TextExerciseSeconds,
  TextRestMinutes,
  TextRestSeconds
}

String numberExercises = '', numberRepetitions = '';
int timeToChangeRep = 0;
List<ExerciseData> listCustomExercise = [];
List<ExerciseDetails> allPossibleExercise = [];

class _CustomExerciseState extends State<CustomExercise> {
  List<String> names = [];

  bool isDefaultButtonOn = false;

  int indexExercise = 1;
  String controllerName = 'choose...';
  String controllerExerciseMinutes = '00';
  String controllerExerciseSeconds = '05';
  String controllerRestMinutes = '00';
  String controllerRestSeconds = '05';
  String exerciseDuration = '00:05';
  String restDuration = '00:05';
  ExerciseDetails? chosenExercise;
  String chosenName = '';

  @override
  void initState() {
    isDefaultButtonOn = false;
    indexExercise = 1;
    controllerExerciseMinutes = '00';
    controllerRestMinutes = '00';
    controllerExerciseSeconds = '05';
    controllerRestSeconds = '05';
    controllerName = 'Donkey Kick';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Exercises',
          style: TextStyle(fontSize: 23),
        ),
        centerTitle: true,
        backgroundColor: Themes.appBarTheme,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  FutureBuilder<List<ExerciseDetails>>(
                    future: decodeExercises(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      if (snapshot.hasData && names.length < 1) {
                        for (int i = 0; i < snapshot.data!.length; i++) {
                          names.add(snapshot.data![i].name);
                          allPossibleExercise.add(snapshot.data![i]);
                        }
                          controllerName = allPossibleExercise[0].name;
                      }
                      return Container();
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Choose exercise for set $indexExercise: '),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Themes.customExerciseBorder),
                          ),
                          child: InkWell(
                            onTap: () {
                              showMaterialRadioPicker<String>(
                                context: context,
                                title: 'Pick Your Exercise',
                                items: names,
                                selectedItem: chosenName,
                                onChanged: (value) => setState(() {
                                  chosenName = value;
                                  controllerName = chosenName;
                                }),
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    controllerName,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Themes.appBarTheme),
                                  ),
                                ),
                                Container(
                                  alignment: FractionalOffset.centerRight,
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                    color: Themes.appBarTheme,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'Choose exercise duration for set $indexExercise: '),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Themes.customExerciseBorder),
                          ),
                          child: Row(
                            children: [
                              inputField(
                                  Type.TextExerciseMinutes,
                                  controllerExerciseMinutes,
                                  'Minutes to Exercise',
                                  0,
                                  10),
                              Text(
                                ':',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              inputField(
                                  Type.TextExerciseSeconds,
                                  controllerExerciseSeconds,
                                  'Seconds to Exercise',
                                  0,
                                  59),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Choose rest duration for set $indexExercise: '),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Themes.customExerciseBorder),
                          ),
                          child: Row(
                            children: [
                              inputField(
                                  Type.TextRestMinutes,
                                  controllerRestMinutes,
                                  'Minutes to Rest',
                                  0,
                                  10),
                              Text(
                                ':',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              inputField(
                                  Type.TextRestSeconds,
                                  controllerRestSeconds,
                                  'Seconds to Rest',
                                  0,
                                  59),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'Do it for all of the remaining exercises',
                            style: TextStyle(),
                          ),
                        CupertinoSwitch(
                          activeColor: Themes.appBarTheme,
                          value: isDefaultButtonOn,
                          onChanged: (value) {
                            if (acceptableFormat()) {
                              if (value == true) {
                                setState(() {
                                  isDefaultButtonOn = value;
                                  setState(() {
                                    for (int i = indexExercise;
                                        i <= int.parse(numberExercises) - 1;
                                        i++) {
                                      addToList();
                                    }
                                    indexExercise = int.parse(numberExercises);
                                    isDefaultButtonOn = true;
                                  });
                                });
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                    content: Text(
                                        'You have not choose your exercise, or your rest/exercise time is below 5 seconds!')));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                alignment: FractionalOffset.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                      primary: acceptableFormat()
                          ? Themes.appBarTheme
                          : Themes.customExerciseInactiveButton),
                  onPressed: () {
                    if (acceptableFormat()) {
                      if (indexExercise <= int.parse(numberExercises)) {
                        setState(() {
                          print(controllerName.toString());
                          print(controllerExerciseMinutes.toString());
                          print(controllerExerciseSeconds.toString());
                          addToList();
                        });
                      }
                      if (indexExercise >= int.parse(numberExercises) ||
                          isDefaultButtonOn == true) {
                        Navigator.pushReplacementNamed(
                            context, '/custom-exercise-action');
                      }
                      if (indexExercise < int.parse(numberExercises))
                        indexExercise += 1;
                      setState(() {
                        controllerName = '';
                      });
                    } else {
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            content: Text(
                                'You have not choose your exercise, or your rest/exercise time is below 5 seconds!')));
                    }
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addToList() {
    String imgUrl = '';
    for (int i = 0; i < allPossibleExercise.length; i++) {
      if (allPossibleExercise[i].name == controllerName.toString()) {
        setState(() {
          imgUrl = allPossibleExercise[i].imgUrl;
        });
        break;
      }
    }
    listCustomExercise.add(new ExerciseData(
      controllerName.toString(),
      int.parse(controllerExerciseMinutes.toString()) * 60 +
          int.parse(controllerExerciseSeconds.toString()),
      int.parse(controllerRestMinutes.toString()) * 60 +
          int.parse(controllerRestSeconds.toString()),
      imgUrl,
    ));
  }

  bool acceptableFormat() {
    String name = controllerName.toString();
    String activeMin = controllerExerciseMinutes.toString();
    String activeSec = controllerExerciseSeconds.toString();
    String passiveMin = controllerRestMinutes.toString();
    String passiveSec = controllerRestSeconds.toString();
    return name != '' &&
        name != 'Choose...' &&
        int.parse(activeMin) * 60 + int.parse(activeSec) >= 5 &&
        int.parse(passiveSec) + int.parse(passiveMin) * 60 >= 5;
  }

  Widget inputField(Type type, String input, String titlePicker, int minNumber,
      int maxNumber) {
    return InkWell(
      onTap: () {
        showMaterialNumberPicker(
          title: titlePicker,
          context: context,
          minNumber: minNumber,
          maxNumber: maxNumber,
          onChanged: (value) => setState(() {
            if (type == Type.TextExerciseMinutes)
              controllerExerciseMinutes = value.toString();
            if (type == Type.TextExerciseSeconds)
              controllerExerciseSeconds = value.toString();
            if (type == Type.TextRestMinutes)
              controllerRestMinutes = value.toString();
            if (type == Type.TextRestSeconds)
              controllerRestSeconds = value.toString();
          }),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        alignment: Alignment.center,
        child: Text(
          input.padLeft(2, '0'),
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Themes.appBarTheme),
        ),
      ),
    );
  }
}
