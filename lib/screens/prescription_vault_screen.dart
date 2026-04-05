import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
// import 'package:image_picker/image_picker.dart'; 
import '../models/prescription.dart';
import '../models/family_member.dart';
import '../providers/prescription_provider.dart';
import '../providers/family_provider.dart';
import '../widgets/bottom_nav.dart';

class PrescriptionVaultScreen extends StatefulWidget {
  const PrescriptionVaultScreen({Key? key}) : super(key: key);

  @override
  State<PrescriptionVaultScreen> createState() => _PrescriptionVaultScreenState();
}

class _PrescriptionVaultScreenState extends State<PrescriptionVaultScreen> {
  String? _selectedMemberId;

  void _uploadPrescription() async {
    // In actual implementation, we would use ImagePicker here.
    // For now we simulate an upload success if a member is selected.
    if (_selectedMemberId != null) {
      final p = Prescription(
        id: const Uuid().v4(),
        familyMemberId: _selectedMemberId!,
        imagePath: 'mock_path.jpg',
        title: 'Uploaded Prescription',
        uploadDate: DateTime.now(),
      );
      await Provider.of<PrescriptionProvider>(context, listen: false).addPrescription(p);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Simulated upload success')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final prescriptionProvider = Provider.of<PrescriptionProvider>(context);
    final familyProvider = Provider.of<FamilyProvider>(context);

    if (familyProvider.members.isNotEmpty && _selectedMemberId == null) {
      _selectedMemberId = familyProvider.members.first.id;
    }

    final filteredPrescriptions = _selectedMemberId != null
        ? prescriptionProvider.getPrescriptionsForMember(_selectedMemberId!)
        : <Prescription>[];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Prescription Vault', style: TextStyle(color: Color(0xFF005EA4), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none)),
              value: _selectedMemberId,
              items: familyProvider.members.map((m) => DropdownMenuItem(value: m.id, child: Text(m.name))).toList(),
              onChanged: (val) => setState(() => _selectedMemberId = val),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
                itemCount: filteredPrescriptions.length + 1,
                itemBuilder: (context, index) {
                  if (index == filteredPrescriptions.length) {
                    return InkWell(
                      onTap: _uploadPrescription,
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey, style: BorderStyle.solid), borderRadius: BorderRadius.circular(12)),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload_file, size: 48, color: Colors.grey),
                            SizedBox(height: 8),
                            Text('Upload', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    );
                  }
                  final doc = filteredPrescriptions[index];
                  return Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 4))]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: const BorderRadius.vertical(top: Radius.circular(12))),
                            child: const Center(child: Icon(Icons.image, color: Colors.grey, size: 48)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(doc.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center),
                        )
                      ],
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
