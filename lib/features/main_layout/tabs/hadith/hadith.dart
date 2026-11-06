import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:quran_app_abbas/core/extensions/context_ex.dart';
import 'package:quran_app_abbas/core/sources/assets_manager.dart';
import 'package:quran_app_abbas/features/main_layout/tabs/hadith/widgets/hadith_item.dart';

class Hadith extends StatelessWidget {
  const Hadith({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(ImageAssets.hadithTabBg))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(ImageAssets.islamiLogo),
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                height: context.getWidth,
                viewportFraction: 0.7,
                enlargeFactor: 0.2,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                autoPlayAnimationDuration: Duration(milliseconds: 300),
              ),
              items: List.generate(50, (index) => index+1).map((index) {
                return HadithItem(index: index,);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}