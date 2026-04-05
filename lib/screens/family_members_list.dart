import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/family_provider.dart';
import '../widgets/bottom_nav.dart';
import 'add_family_member.dart';

class FamilyMembersListScreen extends StatelessWidget {
  const FamilyMembersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Family Members', style: TextStyle(color: Color(0xFF191C1D), fontWeight: FontWeight.w800)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Color(0xFF191C1D)),
      ),
      body: Consumer<FamilyProvider>(
        builder: (context, provider, child) {
          final members = provider.members;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: members.length + 1, // +1 for Add Member card
            itemBuilder: (context, index) {
              if (index == members.length) {
                return _buildAddMemberCard(context);
              }
              final member = members[index];
              return _buildMemberCard(context, member);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddFamilyMemberScreen()));
        },
        backgroundColor: const Color(0xFF005EA4),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }

  Widget _buildMemberCard(BuildContext context, member) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE1E3E4),
              image: member.photoPath != null
                  ? DecorationImage(image: NetworkImage(member.photoPath!), fit: BoxFit.cover) // We'll adapt for local later using FileImage
                  : null,
            ),
            child: member.photoPath == null ? const Icon(Icons.person, size: 32, color: Colors.grey) : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF191C1D)),
                ),
                Text(
                  member.gender + ' • ' + member.age.toString() + ' Years',
                  style: const TextStyle(fontSize: 12, color: Color(0xFF707783)),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD3E4FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(member.bloodGroup, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF001C38))),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF707783)),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _buildAddMemberCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const AddFamilyMemberScreen()));
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFC0C7D4), style: BorderStyle.solid), // dashed isn't native easiest
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: const [
            Icon(Icons.person_add, color: Color(0xFF707783)),
            SizedBox(height: 8),
            Text('Add Caregiver', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF191C1D))),
            Text('Invite another adult to manage the sanctuary', style: TextStyle(fontSize: 12, color: Color(0xFF707783)), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
