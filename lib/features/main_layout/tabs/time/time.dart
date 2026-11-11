import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:quran_app_abbas/core/sources/assets_manager.dart';
import 'package:quran_app_abbas/core/sources/colors_manager.dart';
import 'package:quran_app_abbas/core/sources/routes_manager.dart';
import 'package:quran_app_abbas/features/main_layout/tabs/time/helpers/time_helper.dart';
import 'package:quran_app_abbas/models/azkar_model.dart';
import 'package:quran_app_abbas/models/prayer_times_model.dart';

class Time extends StatefulWidget {
  const Time({super.key});

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  PrayerTimesModel? prayerTimes;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isLoading && prayerTimes == null) {
      _loadPrayerTimes();
    }
  }

  Future<void> _loadPrayerTimes() async {
    PrayerTimesModel? model = await TimeHelper.loadPrayerTimes(context);
    if (mounted) {
      setState(() {
        prayerTimes = model;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          ImageAssets.timeBg,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(child: Image.asset(ImageAssets.islamiLogo)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: ColorsManager.gold,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 180,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: ColorsManager.black,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Text(
                                      prayerTimes?.gregorianDate ?? "",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Pray Time\n${prayerTimes?.weekday ?? ""}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      prayerTimes?.hijriDate ?? "",
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            CarouselSlider.builder(
                              itemCount: prayerTimes?.prayers.length ?? 6,
                              itemBuilder: (context, index, realIndex) {
                                final prayer = prayerTimes!.prayers[index];

                                return Container(
                                  width: 104,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                    horizontal: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF202020),
                                        Color(0xFFB19768),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            prayer.name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            prayer.time,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            prayer.period,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                initialPage: prayerTimes?.getNearestPrayerIndex() ?? 0,
                                height: 140,
                                viewportFraction: 0.3,
                                enlargeFactor: 0.2,
                                enableInfiniteScroll: false,
                                enlargeCenterPage: true,
                                autoPlayAnimationDuration: const Duration(
                                  milliseconds: 300,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Azkar",
                  style: TextStyle(
                    color: ColorsManager.gold,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: AzkarModel.azkarCategories.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesManager.azkarScreen,
                        arguments: AzkarModel.azkarCategories[index],
                      );
                    },
                    child: Card(
                      color: ColorsManager.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: const BorderSide(
                          width: 2,
                          color: ColorsManager.gold,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.asset(
                                AzkarModel.azkarCategories[index].imagePath,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AzkarModel.azkarCategories[index].name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
