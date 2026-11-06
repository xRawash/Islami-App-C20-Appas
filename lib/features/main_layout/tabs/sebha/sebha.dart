import 'package:flutter/material.dart';
import 'package:quran_app_abbas/core/sources/assets_manager.dart';
import 'package:quran_app_abbas/core/sources/colors_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Sebha extends StatefulWidget {
  const Sebha({super.key});

  @override
  State<Sebha> createState() => _SebhaState();
}

class _SebhaState extends State<Sebha> {
  late PageController _praisesController;
  int currentPageIndex = 0;

  final List<String> praisesKeys = [
    "سبحان الله",
    "الحمد لله",
    "لا إله إلا الله",
    "الله أكبر",
  ];

  late List<int> praisesCounts;
  double _turns = 0;

  @override
  void initState() {
    super.initState();
    _praisesController = PageController();
    praisesCounts = List.filled(praisesKeys.length, 0);
  }

  @override
  void dispose() {
    _praisesController.dispose();
    super.dispose();
  }

  void _onSebhaTap() {
    setState(() {
      _turns += 1 / 33;
      praisesCounts[currentPageIndex]++;
      if (praisesCounts[currentPageIndex] >= 33) {
        praisesCounts[currentPageIndex] = 0;
        int nextIndex = (currentPageIndex + 1) % praisesKeys.length;
        _praisesController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          ImageAssets.sebhaBg,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 16),
              Image.asset(ImageAssets.islamiLogo),
              const SizedBox(height: 12),
              const Text(
                "سَبِّحِ اسْمَ رَبِّكَ الأعلى",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: PageView.builder(
                  controller: _praisesController,
                  itemCount: praisesKeys.length,
                  onPageChanged: (newIndex) {
                    setState(() {
                      currentPageIndex = newIndex;
                      _turns = 0;
                    });
                  },
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: _onSebhaTap,
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: [
                        Image.asset(ImageAssets.sebhaHead),
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AnimatedRotation(
                                turns: _turns,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                                child: Image.asset(ImageAssets.sebhaBody),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    praisesKeys[index],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "${praisesCounts[index]}",
                                    style: const TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SmoothPageIndicator(
                  controller: _praisesController,
                  count: praisesKeys.length,
                  effect: const WormEffect(
                    activeDotColor: ColorsManager.gold,
                    dotColor: ColorsManager.ofWhite,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                  onDotClicked: (index) {
                    _praisesController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

