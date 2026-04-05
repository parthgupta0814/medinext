import 'package:hive/hive.dart';

part 'medicine.g.dart';

@HiveType(typeId: 1)
class Medicine extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String familyMemberId;

  @HiveField(2)
  String medicineName;

  @HiveField(3)
  String dosage;

  @HiveField(4)
  String? note;

  @HiveField(5)
  String frequency; // e.g. "Daily", "Custom"

  @HiveField(6)
  List<String> reminderTimes; // e.g. ["08:00", "20:00"]

  @HiveField(7)
  DateTime startDate;

  @HiveField(8)
  DateTime? endDate;

  @HiveField(9)
  String beforeAfterMeal;

  @HiveField(10)
  bool activeStatus;

  Medicine({
    required this.id,
    required this.familyMemberId,
    required this.medicineName,
    required this.dosage,
    this.note,
    required this.frequency,
    required this.reminderTimes,
    required this.startDate,
    this.endDate,
    required this.beforeAfterMeal,
    this.activeStatus = true,
  });
}
