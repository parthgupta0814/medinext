import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/health_log.dart';
import '../services/hive_service.dart';

class HealthLogsProvider with ChangeNotifier {
  List<HealthLog> _logs = [];

  List<HealthLog> get logs => _logs;

  HealthLogsProvider() {
    loadLogs();
  }

  void loadLogs() {
    var box = Hive.box<HealthLog>(HiveService.healthLogsBox);
    _logs = box.values.toList();
    notifyListeners();
  }

  List<HealthLog> getLogsForMember(String memberId, String type) {
    return _logs.where((log) => log.familyMemberId == memberId && log.type == type).toList();
  }

  Future<void> addLog(HealthLog log) async {
    var box = Hive.box<HealthLog>(HiveService.healthLogsBox);
    await box.put(log.id, log);
    loadLogs();
  }

  Future<void> deleteLog(String id) async {
    var box = Hive.box<HealthLog>(HiveService.healthLogsBox);
    await box.delete(id);
    loadLogs();
  }
}
