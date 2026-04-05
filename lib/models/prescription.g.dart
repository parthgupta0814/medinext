// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrescriptionAdapter extends TypeAdapter<Prescription> {
  @override
  final int typeId = 3;

  @override
  Prescription read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Prescription(
      id: fields[0] as String,
      familyMemberId: fields[1] as String,
      imagePath: fields[2] as String,
      title: fields[3] as String,
      uploadDate: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Prescription obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.familyMemberId)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.uploadDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrescriptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
