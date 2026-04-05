import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/family_member.dart';
import '../services/hive_service.dart';

class FamilyProvider with ChangeNotifier {
  List<FamilyMember> _members = [];
  
  List<FamilyMember> get members => _members;

  FamilyProvider() {
    loadMembers();
  }

  void loadMembers() {
    var box = Hive.box<FamilyMember>(HiveService.familyMembersBox);
    _members = box.values.toList();
    notifyListeners();
  }

  Future<void> addMember(FamilyMember member) async {
    var box = Hive.box<FamilyMember>(HiveService.familyMembersBox);
    await box.put(member.id, member);
    loadMembers();
  }

  Future<void> updateMember(FamilyMember member) async {
    await member.save();
    loadMembers();
  }

  Future<void> deleteMember(String id) async {
    var box = Hive.box<FamilyMember>(HiveService.familyMembersBox);
    await box.delete(id);
    loadMembers();
  }
}
