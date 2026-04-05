import 'package:flutter/material.dart';
import 'home_dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _rotateAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeDashboard()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Surface color
      body: Stack(
        children: [
          // Background Mesh equivalents
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF005EA4).withOpacity(0.05), // Primary
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF006E1C).withOpacity(0.05), // Secondary
              ),
            ),
          ),

          SafeArea(
             child: Column(
               children: [
                 const Spacer(),
                 // Center Identity
                 Center(
                   child: Column(
                     children: [
                       AnimatedBuilder(
                         animation: _controller,
                         builder: (context, child) {
                           return Transform.scale(
                             scale: _scaleAnimation.value,
                             child: Transform.rotate(
                               angle: _rotateAnimation.value,
                               child: child,
                             ),
                           );
                         },
                         child: Container(
                           width: 96,
                           height: 96,
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(32),
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.black.withOpacity(0.04),
                                 blurRadius: 32,
                                 offset: const Offset(0, 8),
                               ),
                             ],
                             border: Border.all(color: Colors.white.withOpacity(0.4)),
                           ),
                           child: const Center(
                             child: Icon(
                               Icons.health_and_safety, // home_health alternative
                               size: 48,
                               color: Color(0xFF005EA4),
                             ),
                           ),
                         ),
                       ),
                       const SizedBox(height: 32),
                       const Text(
                         'MediNest',
                         style: TextStyle(
                           fontSize: 36,
                           fontWeight: FontWeight.w800,
                           color: Color(0xFF005EA4),
                           letterSpacing: -1,
                         ),
                       ),
                       const SizedBox(height: 12),
                       Container(
                         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                         decoration: BoxDecoration(
                           color: const Color(0xFFF3F4F5),
                           borderRadius: BorderRadius.circular(20),
                         ),
                         child: const Text(
                           'FAMILY HEALTH ORGANIZED',
                           style: TextStyle(
                             fontSize: 10,
                             fontWeight: FontWeight.w600,
                             letterSpacing: 1.5,
                             color: Color(0xFF404752),
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
                 const Spacer(),
                 
                 // Footer
                 Padding(
                   padding: const EdgeInsets.only(bottom: 48.0),
                   child: Column(
                     children: [
                       const Text(
                         'SECURING WORKSPACE...',
                         style: TextStyle(
                           fontSize: 10,
                           fontWeight: FontWeight.w600,
                           letterSpacing: 2,
                           color: Color(0xFF707783),
                         ),
                       ),
                       const SizedBox(height: 16),
                       Container(
                         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                         decoration: BoxDecoration(
                           color: Colors.white.withOpacity(0.6),
                           borderRadius: BorderRadius.circular(12),
                           border: Border.all(color: Colors.white),
                         ),
                         child: Row(
                           mainAxisSize: MainAxisSize.min,
                           children: const [
                             Icon(
                               Icons.enhanced_encryption,
                               size: 16,
                               color: Color(0xFF006E1C),
                             ),
                             SizedBox(width: 8),
                             Text(
                               'End-to-End Encrypted Sanctuary',
                               style: TextStyle(
                                 fontSize: 11,
                                 fontWeight: FontWeight.w500,
                                 color: Color(0xFF404752),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 )
               ],
             ),
          ),
        ],
      ),
    );
  }
}
