// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_member.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FamilyMemberAdapter extends TypeAdapter<FamilyMember> {
  @override
  final int typeId = 0;

  @override
  FamilyMember read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FamilyMember(
      id: fields[0] as String,
      name: fields[1] as String,
      photoPath: fields[2] as String?,
      age: fields[3] as int,
      gender: fields[4] as String,
      bloodGroup: fields[5] as String,
      allergies: fields[6] as String?,
      diseases: fields[7] as String?,
      emergencyContact: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FamilyMember obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.photoPath)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.bloodGroup)
      ..writeByte(6)
      ..write(obj.allergies)
      ..writeByte(7)
      ..write(obj.diseases)
      ..writeByte(8)
      ..write(obj.emergencyContact);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FamilyMemberAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
