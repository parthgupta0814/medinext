import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/appointment.dart';
import '../services/hive_service.dart';

class AppointmentProvider with ChangeNotifier {
  List<Appointment> _appointments = [];

  List<Appointment> get appointments => _appointments;

  AppointmentProvider() {
    loadAppointments();
  }

  void loadAppointments() {
    var box = Hive.box<Appointment>(HiveService.appointmentsBox);
    _appointments = box.values.toList();
    notifyListeners();
  }

  List<Appointment> getAppointmentsForMember(String memberId) {
    return _appointments.where((a) => a.familyMemberId == memberId).toList();
  }

  Future<void> addAppointment(Appointment appointment) async {
    var box = Hive.box<Appointment>(HiveService.appointmentsBox);
    await box.put(appointment.id, appointment);
    loadAppointments();
  }

  Future<void> deleteAppointment(String id) async {
    var box = Hive.box<Appointment>(HiveService.appointmentsBox);
    await box.delete(id);
    loadAppointments();
  }
}
