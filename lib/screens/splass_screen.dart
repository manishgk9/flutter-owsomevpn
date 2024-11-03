import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owsomevpn/app_pref/apppreferences.dart';
import 'package:owsomevpn/on_board/on_barding_screen.dart';
import 'package:owsomevpn/pages/home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      AppPreferences.isIntrowed
          ? Get.off(() => HomeScreen())
          : Get.off(() => OnboardingScreen());
    });
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 35, 28, 66), // Dark background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Shield Icon with circular border effect
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.shield, // Shield icon
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Title Text
            Text(
              'Owsome Vpn App',
              style: TextStyle(
                color: const Color.fromARGB(255, 83, 155, 130),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Subtitle Text
            Text(
              'You can access steaming portals',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 40),
            // Footer Text
            Text(
              'Security - Access - Privacy',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
