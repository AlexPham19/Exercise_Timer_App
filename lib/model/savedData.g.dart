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
    );
  }

  @override
  void write(BinaryWriter writer, SavedData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.durationSeconds)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.isCustom);
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
