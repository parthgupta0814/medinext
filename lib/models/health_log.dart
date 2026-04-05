import 'package:hive/hive.dart';

part 'health_log.g.dart';

@HiveType(typeId: 2)
class HealthLog extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String familyMemberId;

  @HiveField(2)
  String type; // e.g. "BP", "Sugar", "Weight", "Temp"

  @HiveField(3)
  double value; // Alternatively String if BP like "120/80"
  
  @HiveField(4)
  String? secondaryValue; // Useful for BP as "80" when value is "120"
  
  @HiveField(5)
  DateTime dateTime;

  HealthLog({
    required this.id,
    required this.familyMemberId,
    required this.type,
    required this.value,
    this.secondaryValue,
    required this.dateTime,
  });
}
