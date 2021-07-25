import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:my_first_flutter_app/model/exerciseDetails.dart';

Future<String> getJsonLessons() {
  return rootBundle.loadString('assets/data/exercises.json');
}

Future<List<ExerciseDetails>> decodeExercises() async {
  return json
      .decode(await getJsonLessons())
      .map<ExerciseDetails>((json) => ExerciseDetails.fromMap(json))
      .toList();
}
