import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app_abbas/core/sources/assets_manager.dart';
import 'package:quran_app_abbas/core/sources/colors_manager.dart';
import 'package:quran_app_abbas/features/sura_details/widget/verse_item.dart';
import 'package:quran_app_abbas/models/sura_model.dart';

class SuraDetailsScreen extends StatefulWidget {
  const SuraDetailsScreen({super.key});

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  late SuraModel sura;
  List<String> suraVerses = [];

  Future<void> loadSuraVerses(String index) async {
    String key = "assets/files/suras/$index.txt";
    String suraContent = await rootBundle.loadString(key);
    List<String> suraLines = suraContent.split('\n');
    List<String> loadedVerses = [];
    for (int i = 0; i < suraLines.length; i++) {
      String line = suraLines[i].trim();
      if (line.isNotEmpty) {
        loadedVerses.add("$line ﴿${i + 1}﴾");
      }
    }
    if (mounted) {
      setState(() {
        suraVerses = loadedVerses;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sura = ModalRoute.of(context)!.settings.arguments as SuraModel;
    if (suraVerses.isEmpty) {
      loadSuraVerses(sura.suraIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(sura.suraNameEn)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(ImageAssets.imgLeftCorner),
                    Image.asset(ImageAssets.imgRightCorner),
                  ],
                ),
                Text(
                  sura.suraNameAr,
                  style: const TextStyle(
                    color: ColorsManager.gold,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: suraVerses.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.gold,
                    ),
                  )
                : ListView.builder(
                    itemCount: suraVerses.length,
                    itemBuilder: (context, index) => VerseItem(
                      verse: suraVerses[index],
                    ),
                  ),
          ),
          Image.asset(ImageAssets.imgBottomDecoration),
        ],
      ),
    );
  }
}

