import 'package:hive/hive.dart';

part 'appointment.g.dart';

@HiveType(typeId: 4)
class Appointment extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String familyMemberId;

  @HiveField(2)
  String doctorName;

  @HiveField(3)
  String hospitalName;

  @HiveField(4)
  String diagnosis;

  @HiveField(5)
  DateTime appointmentDate;

  Appointment({
    required this.id,
    required this.familyMemberId,
    required this.doctorName,
    required this.hospitalName,
    required this.diagnosis,
    required this.appointmentDate,
  });
}
