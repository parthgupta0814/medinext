import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../models/health_log.dart';
import '../models/family_member.dart';
import '../providers/health_logs_provider.dart';
import '../providers/family_provider.dart';
import '../widgets/bottom_nav.dart';

class HealthLogsScreen extends StatefulWidget {
  const HealthLogsScreen({Key? key}) : super(key: key);

  @override
  State<HealthLogsScreen> createState() => _HealthLogsScreenState();
}

class _HealthLogsScreenState extends State<HealthLogsScreen> {
  String _selectedType = 'BP';
  String? _selectedMemberId;

  final _valueController = TextEditingController();

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  void _addLog() async {
    if (_selectedMemberId != null && _valueController.text.isNotEmpty) {
      final log = HealthLog(
        id: const Uuid().v4(),
        familyMemberId: _selectedMemberId!,
        type: _selectedType,
        value: double.tryParse(_valueController.text) ?? 0,
        dateTime: DateTime.now(),
      );
      await Provider.of<HealthLogsProvider>(context, listen: false).addLog(log);
      _valueController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final logsProvider = Provider.of<HealthLogsProvider>(context);
    final familyProvider = Provider.of<FamilyProvider>(context);

    if (familyProvider.members.isNotEmpty && _selectedMemberId == null) {
      _selectedMemberId = familyProvider.members.first.id;
    }

    final filteredLogs = _selectedMemberId != null
        ? logsProvider.getLogsForMember(_selectedMemberId!, _selectedType)
        : <HealthLog>[];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Health Logs', style: TextStyle(color: Color(0xFF005EA4), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Selectors
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none)),
                    value: _selectedMemberId,
                    items: familyProvider.members.map((m) => DropdownMenuItem(value: m.id, child: Text(m.name))).toList(),
                    onChanged: (val) => setState(() => _selectedMemberId = val),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none)),
                    value: _selectedType,
                    items: ['BP', 'Sugar', 'Weight', 'Temp'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                    onChanged: (val) => setState(() => _selectedType = val!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Add Log Input
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _valueController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none),
                      hintText: 'Enter value for $_selectedType',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add_circle, size: 48, color: Color(0xFF006E1C)),
                  onPressed: _addLog,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // List of Logs
            Expanded(
              child: ListView.builder(
                itemCount: filteredLogs.length,
                itemBuilder: (context, index) {
                  final log = filteredLogs[index];
                  return Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: const Icon(Icons.favorite, color: Color(0xFF005EA4)),
                      title: Text('${log.value} ${log.secondaryValue ?? ''}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(DateFormat('MMM dd, yyyy - hh:mm a').format(log.dateTime)),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.grey),
                        onPressed: () {
                          logsProvider.deleteLog(log.id);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 3),
    );
  }
}
