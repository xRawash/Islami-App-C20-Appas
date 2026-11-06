import 'package:flutter/cupertino.dart';
import 'package:quran_app_abbas/features/main_layout/main_layout.dart';
import 'package:quran_app_abbas/features/main_layout/tabs/hadith/hadith_details_screen.dart';
import 'package:quran_app_abbas/features/onboarding_screen/onboarding_screen.dart';
import 'package:quran_app_abbas/features/sura_details/sura_details_screen.dart';

abstract class RoutesManager{
  static const String mainLayout = '/mainLayout';
  static const String suraDetailsScreen = '/suraDetailsScreen';
  static const String hadithDetailsScreen = '/hadithDetailsScreen';
  static const String onboardingScreen = '/onboardingScreen';


  static Map<String, WidgetBuilder> routes ={
    mainLayout : (context)=> MainLayout(),
    suraDetailsScreen : (context)=> SuraDetailsScreen(),
    hadithDetailsScreen:(_)=> HadithDetailsScreen(),
    onboardingScreen:(_)=> OnboardingScreen()
  };
}