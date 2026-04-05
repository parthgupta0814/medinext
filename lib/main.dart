import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/hive_service.dart';
import 'providers/family_provider.dart';
import 'providers/medicine_provider.dart';
import 'providers/health_logs_provider.dart';
import 'providers/prescription_provider.dart';
import 'providers/appointment_provider.dart';
import 'services/notification_service.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize internal storage first
  await HiveService.init();

  // Initialize notifications
  await NotificationService.init();

  runApp(const MediNestApp());
}

class MediNestApp extends StatelessWidget {
  const MediNestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FamilyProvider()),
        ChangeNotifierProvider(create: (_) => MedicineProvider()),
        ChangeNotifierProvider(create: (_) => HealthLogsProvider()),
        ChangeNotifierProvider(create: (_) => PrescriptionProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
      ],
      child: MaterialApp(
        title: 'MediNest',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFF8F9FA),
          fontFamily: 'Roboto',
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
