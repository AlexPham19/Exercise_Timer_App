import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:my_first_flutter_app/widgets/drawer.dart';
import 'package:my_first_flutter_app/widgets/main-app-bar-with-drawer.dart';

import 'custom-exercise/custom-exercise.dart';

class Exercises extends StatefulWidget {
  static const id = '/exercises';

  @override
  _ExercisesState createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController textRepetitions = new TextEditingController(text: '1'),
      textExercises = new TextEditingController(text: '5');
  TextEditingController textToChangeMin = new TextEditingController(text: '00'),
      textToChangeSec = new TextEditingController(text: '30');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MaterialDrawer(currentRoute: Exercises.id),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: MainAppBar(
          title: 'Create Custom Exercise',
          scaffoldKey: _scaffoldKey,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(right: 8),
                      child:
                          Text('Choose number of exercises per repetition:')),
                  Flexible(
                      //width: 30,
                      child: InkWell(
                    onTap: () {
                      showMaterialNumberPicker(
                        title: 'Numbers of exercises',
                        context: context,
                        minNumber: 1,
                        maxNumber: 50,
                        onChanged: (value) => setState(() {
                          textExercises.text = value.toString();
                        }),
                      );
                    },
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: textExercises,
                      enabled: false,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
              Row(
                children: [
                  Text('Choose number of repetitions:'),
                  Flexible(
                      //width: 30,
                      child: InkWell(
                        onTap: () {
                          showMaterialNumberPicker(
                              title: 'Numbers of repetitions',
                              context: context,
                              minNumber: 1,
                              maxNumber: 50,
                              onChanged: (value) => setState(() {
                                    textRepetitions.text = value.toString();
                                  }));
                        },
                        child: TextField(
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                          controller: textRepetitions,
                          enabled: false,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
              Row(
                children: [
                  Text('Choose time to change between each repetition: '),
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                            //width: 30,
                            child: InkWell(
                              onTap: () {
                                showMaterialNumberPicker(
                                    title: 'Minutes',
                                    context: context,
                                    minNumber: 0,
                                    maxNumber: 59,
                                    onChanged: (value) => setState(() {
                                          textToChangeMin.text =
                                              value.toString().padLeft(2, '0');
                                        }));
                              },
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                                controller: textToChangeMin,
                                enabled: false,
                                keyboardType: TextInputType.number,
                                maxLength: 2,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 2),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                  ),
                                ),
                              ),
                            )),
                        Container(
                            padding: EdgeInsets.only(left: 4, right: 4),
                            child: Text(':')),
                        Flexible(
                          //width: 30,
                          child: InkWell(
                            onTap: () {
                              showMaterialNumberPicker(
                                  title: 'Seconds',
                                  context: context,
                                  minNumber: 0,
                                  maxNumber: 59,
                                  onChanged: (value) => setState(() {
                                        textToChangeSec.text =
                                            value.toString().padLeft(2, '0');
                                      }));
                            },
                            child: TextField(
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                              controller: textToChangeSec,
                              enabled: false,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 2),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      numberRepetitions = textRepetitions.text.toString();
                      numberExercises = textExercises.text.toString();
                      timeToChangeRep =
                          int.parse(textToChangeMin.text.toString()) * 60 +
                              int.parse(textToChangeSec.text.toString());
                    });
                    if (acceptableFormat()) {
                      Navigator.pushReplacementNamed(
                          context, CustomExercise.id);
                    } else {
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            content: Text('One of the inputs is too low!')));
                    }
                  },
                  child: Text('OK'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool acceptableFormat() {
    String textMin = textToChangeMin.text.toString();
    String textSec = textToChangeSec.text.toString();
    String textRep = textRepetitions.text.toString();
    String textExercise = textExercises.text.toString();
    return int.parse(textRep) > 0 &&
        int.parse(textExercise) > 0 &&
        int.parse(textMin) * 60 + int.parse(textSec) >= 5;
  }
}
