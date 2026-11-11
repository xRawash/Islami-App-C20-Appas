import 'package:flutter/material.dart';
import 'package:quran_app_abbas/config/theme/theme_manager.dart';
import 'package:quran_app_abbas/core/prefs_manager/prefs_manager.dart';
import 'package:quran_app_abbas/core/sources/routes_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsManager.init();
  final isFinishedOnboarding = await PrefsManager.getOnboardingStatus();
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
      themeMode: ThemeMode.system,
      onGenerateRoute: RoutesManager.onGenerateRoute,
      initialRoute: isFinishedOnboarding
          ? RoutesManager.mainLayout
          : RoutesManager.onboardingScreen,
    );
  }
}
