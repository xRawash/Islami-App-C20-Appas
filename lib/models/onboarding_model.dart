import 'package:flutter/material.dart';
import 'package:quran_app_abbas/core/sources/assets_manager.dart';

class OnboardingModel {
  Image pageImage;
  String? pageLabel;
  String? pageDescription;
  OnboardingModel({
    required this.pageImage,
    this.pageLabel,
    this.pageDescription,
  });
  static List<OnboardingModel> onboarding = [
    OnboardingModel(
      pageImage: Image.asset(ImageAssets.onboardingPage1),
      pageDescription: "Welcome To Islmi App",
    ),
    OnboardingModel(
      pageImage: Image.asset(ImageAssets.onboardingPage2),
      pageLabel: "Welcome To Islami",
      pageDescription: "We Are Very Excited To Have You In Our Community",
    ),
    OnboardingModel(
      pageImage: Image.asset(ImageAssets.onboardingPage3),
      pageLabel: "Reading the Quran",
      pageDescription: "Read, and your Lord is the Most Generous",
    ),
    OnboardingModel(
      pageImage: Image.asset(ImageAssets.onboardingPage4),
      pageLabel: "Bearish",
      pageDescription: "Praise the name of your Lord, the Most High",
    ),
    OnboardingModel(
      pageImage: Image.asset(ImageAssets.onboardingPage5),
      pageLabel: "Holy Quran Radio",
      pageDescription:
          "You can listen to the Holy Quran Radio through the application for free and easily",
    ),
  ];
}
