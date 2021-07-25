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

  SavedData(this.durationSeconds, this.date, this.isCustom);
}