import 'package:hive/hive.dart';

part 'family_member.g.dart';

@HiveType(typeId: 0)
class FamilyMember extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? photoPath;

  @HiveField(3)
  int age;

  @HiveField(4)
  String gender;

  @HiveField(5)
  String bloodGroup;

  @HiveField(6)
  String? allergies;

  @HiveField(7)
  String? diseases;

  @HiveField(8)
  String? emergencyContact;

  FamilyMember({
    required this.id,
    required this.name,
    this.photoPath,
    required this.age,
    required this.gender,
    required this.bloodGroup,
    this.allergies,
    this.diseases,
    this.emergencyContact,
  });
}
