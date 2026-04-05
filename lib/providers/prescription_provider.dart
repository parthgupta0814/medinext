import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/prescription.dart';
import '../services/hive_service.dart';

class PrescriptionProvider with ChangeNotifier {
  List<Prescription> _prescriptions = [];

  List<Prescription> get prescriptions => _prescriptions;

  PrescriptionProvider() {
    loadPrescriptions();
  }

  void loadPrescriptions() {
    var box = Hive.box<Prescription>(HiveService.prescriptionsBox);
    _prescriptions = box.values.toList();
    notifyListeners();
  }

  List<Prescription> getPrescriptionsForMember(String memberId) {
    return _prescriptions.where((p) => p.familyMemberId == memberId).toList();
  }

  Future<void> addPrescription(Prescription prescription) async {
    var box = Hive.box<Prescription>(HiveService.prescriptionsBox);
    await box.put(prescription.id, prescription);
    loadPrescriptions();
  }

  Future<void> deletePrescription(String id) async {
    var box = Hive.box<Prescription>(HiveService.prescriptionsBox);
    await box.delete(id);
    loadPrescriptions();
  }
}
