import 'package:diary/infrastructure/providers/provider_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BuidDot extends StatelessWidget {
  final int index;
  final OnboardingState onboardingState;
  final BuildContext context;

  const BuidDot({ required this.index, required this.onboardingState, required  this.context, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.sp,
      width: onboardingState.currentIndex == index ? 25.sp : 10.sp,
      margin: EdgeInsets.only(right: 5.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: const Color.fromRGBO(226, 232, 240, 1),
      ),
    );
  }
}


Container buildDot(int index, BuildContext context, OnboardingState onboardingState) {
    
    return Container(
      height: 10.sp,
      width: onboardingState.currentIndex == index ? 25.sp : 10.sp,
      margin: EdgeInsets.only(right: 5.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: const Color.fromRGBO(226, 232, 240, 1),
      ),
    );
  }