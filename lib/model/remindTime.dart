import 'package:hive/hive.dart';

part 'remindTime.g.dart';

@HiveType(typeId: 1)
class RemindTime{
  @HiveField(0)
  final int hour;
  @HiveField(1)
  final int minute;

  RemindTime(this.hour, this.minute);
}