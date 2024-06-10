// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arrival_event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArrivalEventAdapter extends TypeAdapter<ArrivalEvent> {
  @override
  final int typeId = 0;

  @override
  ArrivalEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArrivalEvent(
      name: fields[0] as String,
      surname: fields[1] as String,
      occupation: fields[2] as String,
      dateOfBirth: fields[3] as DateTime,
      arrivalTime: fields[4] as DateTime,
      departureTime: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ArrivalEvent obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.surname)
      ..writeByte(2)
      ..write(obj.occupation)
      ..writeByte(3)
      ..write(obj.dateOfBirth)
      ..writeByte(4)
      ..write(obj.arrivalTime)
      ..writeByte(5)
      ..write(obj.departureTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArrivalEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
