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

enum Type { TextRepetitions, TextExercises, TextToChangeMin, TextToChangeSec }

class _ExercisesState extends State<Exercises> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String textRepetitions = '1',
      textExercises = '5',
      textToChangeMin = '00',
      textToChangeSec = '30';

  @override
  void initState() {
    super.initState();
  }

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
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child:
                            Text('Choose number of exercises per repetition:')),
                    inputField(Type.TextExercises, textExercises,
                        'Number of exercises', 1, 30),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Choose number of repetitions:'),
                    inputField(Type.TextRepetitions, textRepetitions,
                        'Number of repetitions', 1, 30),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                            'Choose time to change between each repetition: ')),
                    Container(
                      child: Row(
                        children: [
                          inputField(Type.TextToChangeMin, textToChangeMin,
                              'Minutes', 0, 10),
                          Container(
                              padding: EdgeInsets.only(left: 4, right: 4),
                              child: Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              )),
                          inputField(Type.TextToChangeSec, textToChangeSec,
                              'Seconds', 0, 59),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      numberRepetitions = textRepetitions.toString();
                      numberExercises = textExercises.toString();
                      timeToChangeRep =
                          int.parse(textToChangeMin.toString()) * 60 +
                              int.parse(textToChangeSec.toString());
                    });
                    if (acceptableFormat()) {
                      Navigator.pushNamed(
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
    String textMin = textToChangeMin.toString();
    String textSec = textToChangeSec.toString();
    String textRep = textRepetitions.toString();
    String textExercise = textExercises.toString();
    return int.parse(textRep) > 0 &&
        int.parse(textExercise) > 0 &&
        int.parse(textMin) * 60 + int.parse(textSec) >= 5;
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
            if (type == Type.TextToChangeMin)
              textToChangeMin = value.toString();
            if (type == Type.TextToChangeSec)
              textToChangeSec = value.toString();
            if (type == Type.TextRepetitions)
              textRepetitions = value.toString();
            if (type == Type.TextExercises) textExercises = value.toString();
          }),
        );
      },
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        alignment: Alignment.center,
        child: Text(
          type == Type.TextRepetitions || type == Type.TextExercises
              ? input
              : input.padLeft(2, '0'),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
