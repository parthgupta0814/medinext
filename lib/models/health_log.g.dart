// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HealthLogAdapter extends TypeAdapter<HealthLog> {
  @override
  final int typeId = 2;

  @override
  HealthLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthLog(
      id: fields[0] as String,
      familyMemberId: fields[1] as String,
      type: fields[2] as String,
      value: fields[3] as double,
      secondaryValue: fields[4] as String?,
      dateTime: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HealthLog obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.familyMemberId)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.value)
      ..writeByte(4)
      ..write(obj.secondaryValue)
      ..writeByte(5)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
