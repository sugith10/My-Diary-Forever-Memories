import 'package:diary/screens/onboarding.dart';
import 'package:diary/screens/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash', // Set the initial route to your Splash screen
      routes: {
        '/splash': (context) => Splash(),
        '/onboarding': (context) => Onbording(),
        // Define routes for other screens as needed
      },
    );
  }
}