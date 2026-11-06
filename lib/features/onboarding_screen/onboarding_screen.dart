import 'package:flutter/material.dart';
import 'package:quran_app_abbas/core/prefs_manager/prefs_manager.dart';
import 'package:quran_app_abbas/core/sources/assets_manager.dart';
import 'package:quran_app_abbas/core/sources/colors_manager.dart';
import 'package:quran_app_abbas/core/sources/routes_manager.dart';
import 'package:quran_app_abbas/models/onboarding_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<OnboardingModel> pages = OnboardingModel.onboarding;
  late PageController _pageController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Image.asset(ImageAssets.islamiLogo)),
            SizedBox(height: 16),
            Expanded(
              flex: 9,
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (newIndex) {
                  selectedIndex = newIndex;
                  setState(() {});
                },
                itemBuilder: ((context, index) => Column(
                  spacing: 10,
                  children: [
                    pages[index].pageImage,
                    Text(
                      pages[index].pageLabel ?? "",
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 16),
                    Text(
                      pages[index].pageDescription ?? "",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                )),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    selectedIndex != 0
                        ? TextButton(
                            onPressed: () {
                              setState(() {
                                _pageController.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              });
                            },
                            style: TextButton.styleFrom(
                              overlayColor: ColorsManager.white,
                            ),
                            child: Text(
                              "Back",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          )
                        : Text(""),
                    Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: pages.length,
                        onDotClicked: ((index) => setState(() {
                          _pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        })),
                        effect: WormEffect(
                          dotHeight: 7,
                          dotWidth: 7,
                          dotColor: ColorsManager.ofWhite,
                          activeDotColor: ColorsManager.gold,
                        ),
                      ),
                    ),
                    selectedIndex != pages.length - 1
                        ? TextButton(
                            onPressed: () {
                              setState(() {
                                _pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              });
                            },
                            style: TextButton.styleFrom(
                              overlayColor: ColorsManager.white,
                            ),
                            child: Text(
                              "Next",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          )
                        : TextButton(
                            onPressed: () async {
                             PrefsManager.saveOnboardingStatus();
                              if (context.mounted) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  RoutesManager.mainLayout,
                                );
                              }
                            },
                            style: TextButton.styleFrom(
                              overlayColor: ColorsManager.white,
                            ),
                            child: Text(
                              "Finish",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
