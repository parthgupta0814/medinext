import 'package:flutter/material.dart';
import 'family_members_list.dart';
import 'medicines_list_screen.dart';
import 'health_logs_screen.dart';
import 'prescription_vault_screen.dart';

// Placeholder standard colors from DESIGN.md
const Color primaryColor = Color(0xFF005EA4);
const Color secondaryColor = Color(0xFF006E1C);
const Color tertiaryColor = Color(0xFF8F4A00);
const Color surfaceColor = Color(0xFFF8F9FA);
const Color surfaceContainerLow = Color(0xFFF3F4F5);
const Color surfaceContainerLowest = Color(0xFFFFFFFF);
const Color onSurface = Color(0xFF191C1D);

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surfaceColor,
      appBar: AppBar(
        backgroundColor: surfaceColor,
        elevation: 0,
        title: const Text(
          'Good Morning',
          style: TextStyle(
            color: onSurface,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: onSurface),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Medicine Summary
            _buildMedicineSummary(),
            const SizedBox(height: 24),
            
            // Quick Actions
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: onSurface,
              ),
            ),
            const SizedBox(height: 12),
            _buildQuickActions(),
            const SizedBox(height: 24),

            // Main Navigation Cards
            const Text(
              'Your Sanctuary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: onSurface,
              ),
            ),
            const SizedBox(height: 12),
            _buildNavigationGrid(context),
            const SizedBox(height: 24),

            // Privacy Indicator
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.shield_outlined, size: 16, color: Color(0xFF404752)),
                    SizedBox(width: 8),
                    Text(
                      'End-to-End Encrypted Sanctuary',
                      style: TextStyle(fontSize: 12, color: Color(0xFF404752)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicineSummary() {
    return Row(
      children: [
        _buildSummaryCard('Pending', '3', tertiaryColor),
        const SizedBox(width: 12),
        _buildSummaryCard('Taken', '5', secondaryColor),
        const SizedBox(width: 12),
        _buildSummaryCard('Missed', '0', Colors.grey.shade600),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceContainerLowest,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: onSurface.withOpacity(0.04),
              blurRadius: 24,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF404752),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildActionChip(Icons.person_add, 'Add Member', () {}),
          const SizedBox(width: 12),
          _buildActionChip(Icons.medication, 'Add Medicine', () {}),
          const SizedBox(width: 12),
          _buildActionChip(Icons.monitor_heart, 'Add Vitals', () {}),
        ],
      ),
    );
  }

  Widget _buildActionChip(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: surfaceContainerLowest,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: primaryColor),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildNavCard('Today\'s Medicines', Icons.calendar_today, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const MedicinesListScreen()));
            }),
            const SizedBox(width: 16),
            _buildNavCard('Family Members', Icons.family_restroom, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const FamilyMembersListScreen()));
            }),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildNavCard('Health Logs', Icons.insights, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const HealthLogsScreen()));
            }),
            const SizedBox(width: 16),
            _buildNavCard('Prescription Vault', Icons.receipt_long, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const PrescriptionVaultScreen()));
            }),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildNavCard('Upcoming Appointments', Icons.event, () {}),
            const SizedBox(width: 16),
            Expanded(child: SizedBox()), // Empty slot to keep grid layout 
          ],
        )
      ],
    );
  }

  Widget _buildNavCard(String title, IconData icon, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: surfaceContainerLow,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 28, color: primaryColor),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
