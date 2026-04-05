import 'package:hive_flutter/hive_flutter.dart';
import '../models/family_member.dart';
import '../models/medicine.dart';
import '../models/health_log.dart';
import '../models/prescription.dart';
import '../models/appointment.dart';

class HiveService {
  static const String familyMembersBox = 'family_members';
  static const String medicinesBox = 'medicines';
  static const String healthLogsBox = 'health_logs';
  static const String prescriptionsBox = 'prescriptions';
  static const String appointmentsBox = 'appointments';

  static Future<void> init() async {
    await Hive.initFlutter();

    // Register Adapters
    Hive.registerAdapter(FamilyMemberAdapter());
    Hive.registerAdapter(MedicineAdapter());
    Hive.registerAdapter(HealthLogAdapter());
    Hive.registerAdapter(PrescriptionAdapter());
    Hive.registerAdapter(AppointmentAdapter());

    // Open Boxes
    await Hive.openBox<FamilyMember>(familyMembersBox);
    await Hive.openBox<Medicine>(medicinesBox);
    await Hive.openBox<HealthLog>(healthLogsBox);
    await Hive.openBox<Prescription>(prescriptionsBox);
    await Hive.openBox<Appointment>(appointmentsBox);
  }
}
