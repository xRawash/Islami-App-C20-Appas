import 'package:flutter/material.dart';
import 'package:quran_app_abbas/core/sources/colors_manager.dart';

class VerseItem extends StatelessWidget {
  const VerseItem({super.key, required this.verse});
  final String verse;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(12),
      //   color: ColorsManager.white,
      // ),
      child: Text(
        verse,
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: ColorsManager.gold,
        ),
      ),
    );
  }
}

