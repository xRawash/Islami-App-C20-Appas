import 'package:flutter/material.dart';
import 'package:quran_app_abbas/config/theme/theme_manager.dart';
import 'package:quran_app_abbas/core/sources/routes_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final isFinishedOnboarding = prefs.getBool('is finished onboarding') ?? false;
  runApp(Islami(isFinishedOnboarding: isFinishedOnboarding));
}

class Islami extends StatelessWidget {
  final bool isFinishedOnboarding;

  const Islami({super.key, required this.isFinishedOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.light,
      darkTheme: ThemeManager.dark,
      themeMode: ThemeMode.light,
      routes: RoutesManager.routes,
      initialRoute: isFinishedOnboarding
          ? RoutesManager.mainLayout
          : RoutesManager.onboardingScreen,
    );
  }
}
