// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:diary/controllers/app_preference_db_ops_hive.dart';
import 'package:diary/presentation/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {


    Timer(const Duration(seconds: 2), () async {
      
      final onboardingStatus =
          await AppPreferenceFunctions().getOnboardingStatus();

      if (onboardingStatus == null || onboardingStatus.showOnboarding == true) {
        Navigator.pushReplacementNamed(context, '/onboarding');
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainScreen(),
          ),
        );
      }
    });

    return Scaffold(
      body: Center(
        child: Image(
          image: Theme.of(context).brightness == Brightness.light
              ? const AssetImage(
                  'assets/images/forever_memories_logo/forever_memories_logo_black.png',
                )
              : const AssetImage(
                  'assets/images/forever_memories_logo/forever_memories_logo_white.png',
                ),
        ),
      ),
    );
  }
}
