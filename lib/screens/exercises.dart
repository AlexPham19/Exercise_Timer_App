import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:my_first_flutter_app/constants/Theme.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Text(
                                'Choose number of exercises per repetition:')),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Themes.customExerciseBorder),
                          ),
                          child: inputField(Type.TextExercises, textExercises,
                              'Number of exercises', 1, 30),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Choose number of repetitions:'),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Themes.customExerciseBorder),
                          ),
                          child: inputField(Type.TextRepetitions,
                              textRepetitions, 'Number of repetitions', 1, 30),
                        ),
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Themes.customExerciseBorder),
                          ),
                          child: Row(
                            children: [
                              inputField(Type.TextToChangeMin, textToChangeMin,
                                  'Minutes', 0, 10),
                              Text(
                                ':',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              inputField(Type.TextToChangeSec, textToChangeSec,
                                  'Seconds', 0, 59),
                            ],
                          ),
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
                    setState(() {
                      numberRepetitions = textRepetitions.toString();
                      numberExercises = textExercises.toString();
                      timeToChangeRep =
                          int.parse(textToChangeMin.toString()) * 60 +
                              int.parse(textToChangeSec.toString());
                    });
                    if (acceptableFormat()) {
                      Navigator.pushNamed(context, CustomExercise.id);
                    } else {
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            content: Text('Number of exercise/repetitions should not be 0, or time to change between each repetition should be greater than 5 seconds!')));
                    }
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(fontSize: 20),
                  ),
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
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        alignment: Alignment.center,
        child: Text(
          type == Type.TextRepetitions || type == Type.TextExercises
              ? input
              : input.padLeft(2, '0'),
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Themes.appBarTheme),
        ),
      ),
    );
  }
}
