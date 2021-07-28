import 'package:hive/hive.dart';

part 'savedData.g.dart';
@HiveType(typeId: 0)
class SavedData {
  @HiveField(0)
  final int durationSeconds;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final bool isCustom;
  @HiveField(3)
  final int exerciseTime;
  @HiveField(4)
  final int restTime;
  @HiveField(5)
  final int numberExercise;
  @HiveField(6)
  final int numberRepetitions;

  SavedData(this.durationSeconds, this.date, this.isCustom, this.exerciseTime, this.restTime, this.numberExercise, this.numberRepetitions);
}