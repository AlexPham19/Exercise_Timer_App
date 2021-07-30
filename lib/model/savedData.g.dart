// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savedData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedDataAdapter extends TypeAdapter<SavedData> {
  @override
  final int typeId = 0;

  @override
  SavedData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedData(
      fields[0] as int,
      fields[1] as DateTime,
      fields[2] as bool,
      fields[3] as int,
      fields[4] as int,
      fields[5] as int,
      fields[6] as int,
      fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SavedData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.durationSeconds)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.isCustom)
      ..writeByte(3)
      ..write(obj.exerciseTime)
      ..writeByte(4)
      ..write(obj.restTime)
      ..writeByte(5)
      ..write(obj.numberExercise)
      ..writeByte(6)
      ..write(obj.numberRepetitions)
      ..writeByte(7)
      ..write(obj.changeRepTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
