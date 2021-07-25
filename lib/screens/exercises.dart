import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/model/exerciseDetails.dart';
import 'package:my_first_flutter_app/parse-json.dart';
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
        child: MainAppBar(title: 'Create Custom Exercise', scaffoldKey: _scaffoldKey,),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Text('Choose number of exercises per repetition:'),
                  Flexible(
                      child: InkWell(
                    child: TextField(
                      controller: textExercises,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(),
                    ),
                  ))
                ],
              ),
              Row(
                children: [
                  Text('Choose number of repetitions:'),
                  Flexible(
                      child: InkWell(
                    child: TextField(
                      controller: textRepetitions,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(),
                    ),
                  ))
                ],
              ),
              Row(
                children: [
                  Text('Choose time to change repetitions: '),
                  Flexible(
                      child: InkWell(
                    child: TextField(
                      controller: textToChangeMin,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(),
                    ),
                  )),
                  Flexible(
                      child: InkWell(
                        child: TextField(
                          controller: textToChangeSec,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(),
                        ),
                      ))
                ],
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      numberRepetitions = textRepetitions.text.toString();
                      numberExercises = textExercises.text.toString();
                      timeToChangeRep = int.parse(textToChangeMin.text.toString()) * 60 + int.parse(textToChangeSec.text.toString());
                    });
                    Navigator.pushReplacementNamed(context, CustomExercise.id);
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
}
