import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:owsomevpn/app_pref/apppreferences.dart';
import 'package:owsomevpn/screens/splass_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.initHive();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Owsome Vpn',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          useMaterial3: true,
        ),
        // home: OnboardingScreen()
        home: SplashScreen());
  }
}
