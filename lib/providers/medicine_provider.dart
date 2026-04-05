import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/medicine.dart';
import '../services/hive_service.dart';

class MedicineProvider with ChangeNotifier {
  List<Medicine> _medicines = [];
  
  List<Medicine> get medicines => _medicines;

  MedicineProvider() {
    loadMedicines();
  }

  void loadMedicines() {
    var box = Hive.box<Medicine>(HiveService.medicinesBox);
    _medicines = box.values.toList();
    notifyListeners();
  }

  List<Medicine> getMedicinesForMember(String memberId) {
    return _medicines.where((med) => med.familyMemberId == memberId).toList();
  }

  Future<void> addMedicine(Medicine med) async {
    var box = Hive.box<Medicine>(HiveService.medicinesBox);
    await box.put(med.id, med);
    loadMedicines();
  }

  Future<void> updateMedicine(Medicine med) async {
    await med.save();
    loadMedicines();
  }

  Future<void> deleteMedicine(String id) async {
    var box = Hive.box<Medicine>(HiveService.medicinesBox);
    await box.delete(id);
    loadMedicines();
  }
}
