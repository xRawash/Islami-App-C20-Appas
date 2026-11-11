import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app_abbas/core/sources/assets_manager.dart';
import 'package:quran_app_abbas/core/sources/colors_manager.dart';
import 'package:quran_app_abbas/models/sura_model.dart';

class SuraDetailsScreen extends StatefulWidget {
  const SuraDetailsScreen({super.key});

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  late SuraModel sura;
  String combinedVerses = "";
  bool isLoading = true;

  Future<void> loadSuraVerses(String index) async {
    String key = "assets/files/suras/$index.txt";
    String suraContent = await rootBundle.loadString(key);
    List<String> suraLines = suraContent.split('\n');
    List<String> formattedVerses = [];
    for (int i = 0; i < suraLines.length; i++) {
      String line = suraLines[i].trim();
      if (line.isNotEmpty) {
        formattedVerses.add("$line ﴿${i + 1}﴾");
      }
    }

    String resultText = formattedVerses.join(" ");
    if (index != "1" && index != "9") {
      resultText = "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ\n\n$resultText";
    }

    if (mounted) {
      setState(() {
        combinedVerses = resultText;
        isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sura = ModalRoute.of(context)!.settings.arguments as SuraModel;
    if (isLoading && combinedVerses.isEmpty) {
      loadSuraVerses(sura.suraIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(sura.suraNameEn)),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                kToolbarHeight -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  isLoading
                      ? const SizedBox(
                          height: 300,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: ColorsManager.gold,
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: ColorsManager.gold,
                              width: 2,
                            ),
                            color: ColorsManager.black,
                          ),
                          child: Text(
                            combinedVerses,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              color: ColorsManager.gold,
                              fontSize: 22,
                              height: 1.8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                  const Spacer(),
                  const SizedBox(height: 16),
                  Image.asset(
                    ImageAssets.imgBottomDecoration,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
