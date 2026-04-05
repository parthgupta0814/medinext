import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/medicine.dart';
import '../providers/medicine_provider.dart';
import '../widgets/bottom_nav.dart';
import 'add_medicine_screen.dart';

class MedicinesListScreen extends StatelessWidget {
  const MedicinesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Medicines', style: TextStyle(color: Color(0xFF005EA4), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Consumer<MedicineProvider>(
        builder: (context, provider, child) {
          final medicines = provider.medicines; // Ideally filter by today's date
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: medicines.length + 1,
            itemBuilder: (context, index) {
              if (index == medicines.length) {
                return _buildAddMedicineCard(context);
              }
              return _buildMedicineCard(context, medicines[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddMedicineScreen()));
        },
        backgroundColor: const Color(0xFF005EA4),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }

  Widget _buildMedicineCard(BuildContext context, Medicine medicine) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: const Color(0xFFD3E4FF), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.medication, color: Color(0xFF005EA4)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(medicine.medicineName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF191C1D))),
                    Text('${medicine.dosage} • ${medicine.frequency}', style: const TextStyle(fontSize: 12, color: Color(0xFF707783))),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFE1E3E4), borderRadius: BorderRadius.circular(12)),
                child: Text('Next: ${medicine.reminderTimes.isNotEmpty ? medicine.reminderTimes[0] : "N/A"}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF404752))),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFFF3F4F5), borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('MEAL INFO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF707783))),
                      const SizedBox(height: 4),
                      Text(medicine.beforeAfterMeal, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF191C1D))),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFFF3F4F5), borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('FOR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF707783))),
                      const SizedBox(height: 4),
                      const Text('Family Member', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF191C1D))), // Will look up member name
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Taken'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006E1C),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () {},
                child: const Text('Skip', style: TextStyle(color: Color(0xFF707783), fontWeight: FontWeight.bold)),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAddMedicineCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const AddMedicineScreen()));
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFC0C7D4), style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: const [
            Icon(Icons.medication, color: Color(0xFF707783)),
            SizedBox(height: 8),
            Text('Add Medicine Routine', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF191C1D))),
            Text('Set up a new medication and reminder', style: TextStyle(fontSize: 12, color: Color(0xFF707783)), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
