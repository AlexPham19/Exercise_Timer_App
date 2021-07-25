import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_first_flutter_app/screens/custom-exercise/custom-exercise-action.dart';
import 'package:my_first_flutter_app/screens/custom-exercise/custom-exercise.dart';
import 'package:my_first_flutter_app/screens/exercise/congratulation-page.dart';
import 'package:my_first_flutter_app/screens/exercise/exercise-main.dart';
import 'package:my_first_flutter_app/screens/exercises.dart';
import 'package:my_first_flutter_app/screens/history.dart';
import 'package:my_first_flutter_app/screens/promotions.dart';
import 'package:my_first_flutter_app/screens/settings.dart';
import 'package:my_first_flutter_app/screens/statistics.dart';
import 'package:my_first_flutter_app/screens/welcome/welcome.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/savedData.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(SavedDataAdapter());
  Hive.openBox('savedData');
  runApp(myApp());

}

class myApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
      title: "Timer App",
      initialRoute: "/welcome",
      routes: <String, WidgetBuilder>{
        "/welcome": (BuildContext context) => new WelcomePage(),
        "/exercises": (BuildContext context) => new Exercises(),
        "/custom-exercise": (BuildContext context) => new CustomExercise(),
        "/custom-exercise-action": (BuildContext context) => new CustomExerciseAction(),
        "/history": (BuildContext context) => new History(),
        "/settings": (BuildContext context) => new Settings(),
        "/statistics": (BuildContext context) => new Statistics(),
        "/promotions": (BuildContext context) => new Promotions(),
        "/exercise-main": (BuildContext context) => new ExerciseMain(),
        "/congratulation-page": (BuildContext context) => new CongratulationPage(),
      },
    );
  }
}

