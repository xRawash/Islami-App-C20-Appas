import 'package:flutter/material.dart';
import 'package:quran_app_abbas/core/sources/assets_manager.dart';
import 'package:quran_app_abbas/core/sources/colors_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Sebha extends StatefulWidget {
  const Sebha({super.key});

  @override
  State<Sebha> createState() => _SebhaState();
}

class _SebhaState extends State<Sebha> with SingleTickerProviderStateMixin {
  late PageController _praisesController;
  int praisesNum = 0;
  int currentPageIndex = 0;
  List<String> praises = [
    "سبحان الله",
    "الحمد لله",
    "لا إله إلا الله",
    "الله أكبر",
  ];
  late AnimationController _controller;
  double _turns = 0;
  @override
  void initState() {
    super.initState();
    _praisesController = PageController();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _praisesController.dispose();
    super.dispose();
  }

  void praisesController() {
    setState(() {
      _turns += 1 / 30;
      if (praisesNum < 30) {
        praisesNum++;
      } else {
        praisesNum = 0;
        if (currentPageIndex < praises.length - 1) {
          _praisesController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          _praisesController.animateToPage(
            0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(ImageAssets.sebhaBg),
        Column(
          spacing: 40,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(ImageAssets.islamiLogo),
            Text(
              "سَبِّحِ اسْمَ رَبِّكَ الأعلى",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _praisesController,
                itemCount: praises.length,
                onPageChanged: (newIndex) {
                  setState(() {
                    currentPageIndex = newIndex;
                  });
                },
                itemBuilder: (context, index) => Column(
                  children: [
                    Image.asset(ImageAssets.sebhaHead),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedRotation(
                          turns: _turns,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          child: Image.asset(ImageAssets.sebhaBody),
                        ),
                        Column(
                          spacing: 20,
                          children: [
                            Text(
                              praises[index],
                              style: TextStyle(
                                fontSize: 30,

                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                praisesController();
                              },
                              style: TextButton.styleFrom(
                                overlayColor: ColorsManager.gold,
                              ),
                              child: Text(
                                "$praisesNum",
                                style: TextStyle(
                                  fontSize: 30,

                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SmoothPageIndicator(
                controller: _praisesController,
                count: praises.length,
                effect: WormEffect(
                  activeDotColor: ColorsManager.gold,
                  dotColor: ColorsManager.ofWhite,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
                onDotClicked: (index) {
                  _praisesController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
