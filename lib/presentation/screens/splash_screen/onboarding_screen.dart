import 'package:animate_do/animate_do.dart';
import 'package:diary/controllers/app_preference_db_ops_hive.dart';
import 'package:diary/providers/provider_onboarding.dart';
import 'package:diary/models/app_preference_db_model.dart';
import 'package:diary/models/content_model.dart';
import 'package:diary/presentation/screens/main_screen/main_screen.dart';
import 'package:diary/presentation/screens/splash_screen/widget/onboarding_dot.dart';
import 'package:diary/presentation/util/get_colors.dart';
import 'package:diary/presentation/util/onboarding_screen_functions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class Onbording extends StatelessWidget {
  Onbording({super.key, required this.onboardingState});

  final PageController pageController = PageController(initialPage: 0);
  final OnboardingState onboardingState;

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = GetColors().getThemeMode(context);

    return Scaffold(
      body: PopScope(
        canPop: false,
        child: Column(
          children: [
            const Spacer(),
            Lottie.asset(
              OnboardingScreenFunctions().getLottieJsonFileName(themeMode),
              width: double.infinity,
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: OnboardingContentList().contents.length,
                onPageChanged: (int index) {
                  onboardingState.updateIndex(index);
                },
                itemBuilder: (_, i) {
                  return Column(
                    children: [
                      Text(
                        OnboardingContentList().contents[i].title,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height >= 800
                                ? 30.0
                                : 25.0,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 1.5.h),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(
                         OnboardingContentList().contents[i].discription,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height >= 800
                                ? 20.0
                                : 15.0,
                            color: OnboardingScreenFunctions()
                                .getDescriptionColor(context),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
               OnboardingContentList().contents.length,
                (index) => BuidDot(
                    index: index,
                    context: context,
                    onboardingState: onboardingState),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  if (onboardingState.currentIndex ==  OnboardingContentList().contents.length - 1) {
                     AppPreferenceCtrl()
                    .showOnboarding(AppPreference(showOnboarding: false));
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MainScreen(),
                      ),
                    );
                  } else {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 10),
                      curve: Curves.bounceIn,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Satoshi',
                  ),
                  backgroundColor: const Color(0xFF835DF1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: FadeInUp(
                  delay: const Duration(milliseconds: 600),
                  duration: const Duration(milliseconds: 700),
                  child: Text(
                    onboardingState.currentIndex ==  OnboardingContentList().contents.length - 1
                        ? "Continue"
                        : "Next",
                    style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {       
                 AppPreferenceCtrl()
                    .showOnboarding(AppPreference(showOnboarding: false));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MainScreen(),
                  ),
                );
              },
              child: FadeInUp(
                delay: const Duration(milliseconds: 1000),
                duration: const Duration(milliseconds: 1000),
                child: const Text(
                  'Skip',
                  style: TextStyle(color: Color.fromARGB(255, 150, 169, 194)),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
