import 'package:flutter/material.dart';
import 'package:quran_app_abbas/core/sources/assets_manager.dart';
import 'package:quran_app_abbas/core/sources/colors_manager.dart';
import 'package:quran_app_abbas/models/hadith_model.dart';

class HadithDetailsScreen extends StatelessWidget {
  const HadithDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HadithModel hadith = ModalRoute.of(context)!.settings.arguments as HadithModel;
    return Scaffold(
      appBar: AppBar(title: Text(hadith.title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(ImageAssets.imgLeftCorner),
                Text(
                 hadith.title,
                  style: TextStyle(
                    color: ColorsManager.gold,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Image.asset(ImageAssets.imgRightCorner),
              ],
            ),

            Expanded(
              child: Text(hadith.content, style: TextStyle(fontSize: 22, color: ColorsManager.gold),textDirection: TextDirection.rtl,)
            ),
          ],
        ),
      ),
    );
  }
}
