import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../models/medicine.dart';
import '../models/family_member.dart';
import '../providers/family_provider.dart';
import '../providers/medicine_provider.dart';
import '../services/notification_service.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({Key? key}) : super(key: key);

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedFamilyMemberId;
  String _beforeAfterMeal = 'After meal';
  String _frequency = 'Daily';
  
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 7));
  
  List<TimeOfDay> _reminderTimes = [const TimeOfDay(hour: 8, minute: 0)];

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveMedicine() async {
    if (_formKey.currentState!.validate() && _selectedFamilyMemberId != null) {
      final newMedicine = Medicine(
        id: const Uuid().v4(),
        familyMemberId: _selectedFamilyMemberId!,
        medicineName: _nameController.text,
        dosage: _dosageController.text,
        note: _notesController.text.isNotEmpty ? _notesController.text : null,
        frequency: _frequency,
        reminderTimes: _reminderTimes.map((t) => '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}').toList(),
        startDate: _startDate,
        endDate: _endDate,
        beforeAfterMeal: _beforeAfterMeal,
      );

      await Provider.of<MedicineProvider>(context, listen: false).addMedicine(newMedicine);

      // Schedule Notifications
      int idOffset = newMedicine.id.hashCode; 
      for (int i = 0; i < _reminderTimes.length; i++) {
        final time = _reminderTimes[i];
        final now = DateTime.now();
        var scheduledDate = DateTime(now.year, now.month, now.day, time.hour, time.minute);
        if (scheduledDate.isBefore(now)) {
          scheduledDate = scheduledDate.add(const Duration(days: 1));
        }

        await NotificationService.scheduleMedicineReminder(
          id: idOffset + i,
          title: "Time for ${_nameController.text}",
          body: "Dosage: ${_dosageController.text} $_beforeAfterMeal",
          scheduledDate: scheduledDate,
        );
      }

      Navigator.pop(context);
    } else if (_selectedFamilyMemberId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a family member')));
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _addTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _reminderTimes.add(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final familyProvider = Provider.of<FamilyProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Add Medicine', style: TextStyle(color: Color(0xFF005EA4))),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF005EA4)),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(color: const Color(0xFF0077CE), borderRadius: BorderRadius.circular(16)),
                    child: const Icon(Icons.medication, size: 32, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('New Medication', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF191C1D))),
                        Text('Add a schedule for your family', style: TextStyle(color: Color(0xFF404752))),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 32),

              // Basic Details
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 24, offset: const Offset(0, 8))]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('MEDICINE NAME', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF005EA4))),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(filled: true, fillColor: Color(0xFFE1E3E4), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none), hintText: 'e.g. Amoxicillin'),
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    const Text('DOSAGE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF005EA4))),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _dosageController,
                      decoration: const InputDecoration(filled: true, fillColor: Color(0xFFE1E3E4), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none), hintText: 'e.g. 500mg'),
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    const Text('FOR FAMILY MEMBER', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF005EA4))),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(filled: true, fillColor: Color(0xFFE1E3E4), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none)),
                      value: _selectedFamilyMemberId,
                      items: familyProvider.members.map((m) => DropdownMenuItem(value: m.id, child: Text(m.name))).toList(),
                      onChanged: (val) => setState(() => _selectedFamilyMemberId = val),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Schedule
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: const Color(0xFFF3F4F5), borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.event, size: 18),
                        SizedBox(width: 8),
                        Text('SCHEDULE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF404752))),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context, true),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('START DATE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF404752))),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(DateFormat('MMM dd, yyyy').format(_startDate)),
                                      const Icon(Icons.calendar_today, size: 16, color: Color(0xFF005EA4)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context, false),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('END DATE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF404752))),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(DateFormat('MMM dd, yyyy').format(_endDate)),
                                      const Icon(Icons.calendar_today, size: 16, color: Color(0xFF005EA4)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Reminders
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 24, offset: const Offset(0, 8))]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.alarm, size: 18),
                        SizedBox(width: 8),
                        Text('REMINDERS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF404752))),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ..._reminderTimes.map((time) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(time.format(context), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => setState(() => _reminderTimes.remove(time)),
                          )
                        ],
                      ),
                    )).toList(),
                    OutlinedButton.icon(
                      onPressed: () => _addTime(context),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Time'),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    const Text('FOOD INTAKE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF404752))),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _foodButton('Before meal'),
                        const SizedBox(width: 8),
                        _foodButton('After meal'),
                        const SizedBox(width: 8),
                        _foodButton('Empty stomach'),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: _saveMedicine,
            icon: const Icon(Icons.check_circle),
            label: const Text('Save Medication', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF005EA4),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _foodButton(String text) {
    bool isSelected = _beforeAfterMeal == text;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _beforeAfterMeal = text),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF005EA4) : const Color(0xFFF3F4F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : const Color(0xFF404752),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
