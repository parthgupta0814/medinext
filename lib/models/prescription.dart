import 'package:hive/hive.dart';

part 'prescription.g.dart';

@HiveType(typeId: 3)
class Prescription extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String familyMemberId;

  @HiveField(2)
  String imagePath;

  @HiveField(3)
  String title;

  @HiveField(4)
  DateTime uploadDate;

  Prescription({
    required this.id,
    required this.familyMemberId,
    required this.imagePath,
    required this.title,
    required this.uploadDate,
  });
}
