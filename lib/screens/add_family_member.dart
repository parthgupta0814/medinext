import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/family_member.dart';
import '../providers/family_provider.dart';

class AddFamilyMemberScreen extends StatefulWidget {
  const AddFamilyMemberScreen({Key? key}) : super(key: key);

  @override
  State<AddFamilyMemberScreen> createState() => _AddFamilyMemberScreenState();
}

class _AddFamilyMemberScreenState extends State<AddFamilyMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _diseasesController = TextEditingController();

  String _gender = 'Male';
  String? _bloodGroup;
  String? _photoPath; // We would use image_picker here later

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emergencyContactController.dispose();
    _allergiesController.dispose();
    _diseasesController.dispose();
    super.dispose();
  }

  void _saveMember() {
    if (_formKey.currentState!.validate()) {
      final newMember = FamilyMember(
        id: const Uuid().v4(),
        name: _nameController.text,
        age: int.tryParse(_ageController.text) ?? 0,
        gender: _gender,
        bloodGroup: _bloodGroup ?? 'Unknown',
        allergies: _allergiesController.text.isNotEmpty ? _allergiesController.text : null,
        diseases: _diseasesController.text.isNotEmpty ? _diseasesController.text : null,
        emergencyContact: _emergencyContactController.text.isNotEmpty ? _emergencyContactController.text : null,
        photoPath: _photoPath,
      );

      Provider.of<FamilyProvider>(context, listen: false).addMember(newMember);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // surface
      appBar: AppBar(
        title: const Text('Add Family Member', style: TextStyle(color: Color(0xFF005EA4))), // primary
        backgroundColor: Colors.white, // surface/80
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
              const Text(
                'Create New Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF191C1D)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Securely add a family member to manage their health records and medication schedules locally on this device.',
                style: TextStyle(color: Color(0xFF404752)),
              ),
              const SizedBox(height: 32),

              // Avatar
              Row(
                children: [
                   Container(
                     width: 96,
                     height: 96,
                     decoration: BoxDecoration(
                       color: const Color(0xFFE7E8E9),
                       shape: BoxShape.circle,
                       border: Border.all(color: Colors.white, width: 4),
                     ),
                     child: const Icon(Icons.person, size: 48, color: Color(0xFF707783)),
                   ),
                   const SizedBox(width: 24),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       const Text('Member Photo', style: TextStyle(fontWeight: FontWeight.bold)),
                       const SizedBox(height: 4),
                       TextButton.icon(
                         onPressed: () {
                           // Pick image
                         },
                         icon: const Icon(Icons.upload, size: 18),
                         label: const Text('Upload'),
                         style: TextButton.styleFrom(iconColor: const Color(0xFF005EA4), foregroundColor: const Color(0xFF005EA4)),
                       )
                     ],
                   )
                ],
              ),
              const SizedBox(height: 32),

              // Form fields
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  filled: true,
                  fillColor: Color(0xFFE1E3E4),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Name required' : null,
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ageController,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        filled: true,
                        fillColor: Color(0xFFE1E3E4),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Blood Group',
                        filled: true,
                        fillColor: Color(0xFFE1E3E4),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none),
                      ),
                      value: _bloodGroup,
                      items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) {
                        setState(() { _bloodGroup = val; });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              const Text('Gender', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF404752))),
              const SizedBox(height: 8),
              Row(
                children: [
                  _genderButton('Male'),
                  const SizedBox(width: 8),
                  _genderButton('Female'),
                  const SizedBox(width: 8),
                  _genderButton('Other'),
                ],
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _emergencyContactController,
                decoration: const InputDecoration(
                  labelText: 'Emergency Contact',
                  prefixIcon: Icon(Icons.call, color: Color(0xFF005EA4)),
                  filled: true,
                  fillColor: Color(0xFFE1E3E4),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),

              // Health history
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: const Color(0xFFF3F4F5), borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Allergies', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8F4A00))),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _allergiesController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none),
                        hintText: 'List any allergies...',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: const Color(0xFFF3F4F5), borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Medical Conditions', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF006E1C))),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _diseasesController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none),
                        hintText: 'List chronic diseases...',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _saveMember,
                  icon: const Icon(Icons.save),
                  label: const Text('Save Family Member', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF005EA4),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _genderButton(String text) {
    bool isSelected = _gender == text;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() { _gender = text; });
        },
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFD3E4FF) : const Color(0xFFE1E3E4),
            border: isSelected ? Border.all(color: const Color(0xFF005EA4), width: 2) : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? const Color(0xFF001C38) : const Color(0xFF404752),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
