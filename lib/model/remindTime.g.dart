// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remindTime.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RemindTimeAdapter extends TypeAdapter<RemindTime> {
  @override
  final int typeId = 1;

  @override
  RemindTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RemindTime(
      fields[0] as int,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RemindTime obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.hour)
      ..writeByte(1)
      ..write(obj.minute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemindTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
