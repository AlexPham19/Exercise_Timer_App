import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:flutter_material_pickers/helpers/show_radio_picker.dart';
import 'package:my_first_flutter_app/model/exerciseData.dart';
import 'package:my_first_flutter_app/model/exerciseDetails.dart';

import '../../parse-json.dart';

class CustomExercise extends StatefulWidget {
  static const id = '/custom-exercise';

  @override
  _CustomExerciseState createState() => _CustomExerciseState();
}

String numberExercises = '', numberRepetitions = '';
int timeToChangeRep = 0;
List<ExerciseData> listCustomExercise = [];
List<ExerciseDetails> allPossibleExercise = [];

class _CustomExerciseState extends State<CustomExercise> {
  List<String> names = [];

  bool isDefaultButtonOn = false;

  int indexExercise = 1;
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerExerciseMinutes =
      new TextEditingController(text: '00');
  TextEditingController controllerExerciseSeconds =
      new TextEditingController(text: '05');
  TextEditingController controllerRestMinutes =
      new TextEditingController(text: '00');
  TextEditingController controllerRestSeconds =
      new TextEditingController(text: '05');
  String exerciseDuration = '00:05';
  String restDuration = '00:05';
  ExerciseDetails? chosenExercise;
  String chosenName = '';

  @override
  void initState() {
    isDefaultButtonOn = false;
    indexExercise = 1;
    controllerExerciseMinutes = TextEditingController(text: '00');
    controllerRestMinutes = TextEditingController(text: '00');
    controllerExerciseSeconds = TextEditingController(text: '05');
    controllerRestSeconds = TextEditingController(text: '05');
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
        backgroundColor: Colors.redAccent,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              FutureBuilder<List<ExerciseDetails>>(
                future: decodeExercises(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.length; i++) {
                      names.add(snapshot.data![i].name);
                      allPossibleExercise.add(snapshot.data![i]);
                    }
                  }
                  return Container();
                },
              ),
              Row(
                children: [
                  Text('Choose exercise for set $indexExercise: '),
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        showMaterialRadioPicker<String>(
                          context: context,
                          title: 'Pick Your Exercise',
                          items: names,
                          selectedItem: chosenName,
                          onChanged: (value) => setState(() {
                            chosenName = value;
                            controllerName.text = chosenName;
                          }),
                        );
                      },
                      child: TextField(
                        textAlign: TextAlign.center,
                        enabled: false,
                        controller: controllerName,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Choose exercise duration for set $indexExercise: '),
                  Flexible(
                    child: Container(
                      // width: 30,
                      // height: 30,
                      child: InkWell(
                        onTap: () {
                          showMaterialNumberPicker(
                              title: 'Minutes',
                              context: context,
                              minNumber: 0,
                              maxNumber: 59,
                              onChanged: (value) => setState(() {
                                    controllerExerciseMinutes.text =
                                        value.toString().padLeft(2, '0');
                                  }));
                        },
                        child: TextField(
                          enabled: false,
                          textAlign: TextAlign.center,
                          controller: controllerExerciseMinutes,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Text(':'),
                  Flexible(
                    child: Container(
                      // width: 30,
                      // height: 30,
                      child: InkWell(
                        onTap: () {
                          showMaterialNumberPicker(
                              title: 'Seconds',
                              context: context,
                              minNumber: 0,
                              maxNumber: 59,
                              onChanged: (value) => setState(() {
                                    controllerExerciseSeconds.text =
                                        value.toString().padLeft(2, '0');
                                  }));
                        },
                        child: TextField(
                          textAlign: TextAlign.center,
                          enabled: false,
                          controller: controllerExerciseSeconds,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text('Choose rest duration for set $indexExercise: '),
                  Flexible(
                    child: Container(
                      // width: 30,
                      // height: 30,
                      child: InkWell(
                        onTap: () {
                          showMaterialNumberPicker(
                              title: 'Minutes',
                              context: context,
                              minNumber: 0,
                              maxNumber: 59,
                              onChanged: (value) => setState(() {
                                    controllerRestMinutes.text =
                                        value.toString().padLeft(2, '0');
                                  }));
                        },
                        child: TextField(
                          enabled: false,
                          textAlign: TextAlign.center,
                          controller: controllerRestMinutes,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Text(':'),
                  Flexible(
                    child: Container(
                      // width: 30,
                      // height: 30,
                      child: InkWell(
                        onTap: () {
                          showMaterialNumberPicker(
                              title: 'Seconds',
                              context: context,
                              minNumber: 0,
                              maxNumber: 59,
                              onChanged: (value) => setState(() {
                                    controllerRestSeconds.text =
                                        value.toString().padLeft(2, '0');
                                  }));
                        },
                        child: TextField(
                          enabled: false,
                          textAlign: TextAlign.center,
                          controller: controllerRestSeconds,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (acceptableFormat()) {
                    if (indexExercise <= int.parse(numberExercises)) {
                      setState(() {
                        print(controllerName.text.toString());
                        print(controllerExerciseMinutes.text.toString());
                        print(controllerExerciseSeconds.text.toString());
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
                    controllerName.clear();
                  }
                },
                child: Text('Ok'),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (acceptableFormat()) {
                        setState(() {
                          for (int i = indexExercise;
                              i <= int.parse(numberExercises) - 1;
                              i++) {
                            addToList();
                          }
                          indexExercise = int.parse(numberExercises);
                          isDefaultButtonOn = true;
                        });
                      }
                    },
                    child: Text('Do it for all of the remaining exercises'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void addToList() {
    String imgUrl = '';
    for(int i = 0; i < allPossibleExercise.length; i++){
      if(allPossibleExercise[i].name == controllerName.text.toString()){
        setState(() {
          imgUrl = allPossibleExercise[i].imgUrl;
        });
        break;
      }
    }
    listCustomExercise.add(new ExerciseData(
      controllerName.text.toString(),
      int.parse(controllerExerciseMinutes.text.toString()) * 60 +
          int.parse(controllerExerciseSeconds.text.toString()),
      int.parse(controllerRestMinutes.text.toString()) * 60 +
          int.parse(controllerRestSeconds.text.toString()),
      imgUrl,
    ));
  }

  bool acceptableFormat() {
    String name = controllerName.text.toString();
    String activeMin = controllerExerciseMinutes.text.toString();
    String activeSec = controllerExerciseSeconds.text.toString();
    String passiveMin = controllerRestMinutes.text.toString();
    String passiveSec = controllerRestSeconds.text.toString();
    return name != '' &&
        int.parse(activeMin) * 60 + int.parse(activeSec) >= 5 &&
        int.parse(passiveSec) + int.parse(passiveMin) * 60 >= 5;
  }
}
