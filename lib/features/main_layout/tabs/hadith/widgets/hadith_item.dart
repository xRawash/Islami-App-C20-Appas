import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app_abbas/core/sources/assets_manager.dart';
import 'package:quran_app_abbas/core/sources/colors_manager.dart';
import 'package:quran_app_abbas/core/sources/routes_manager.dart';
import 'package:quran_app_abbas/models/hadith_model.dart';

class HadithItem extends StatefulWidget {
 const HadithItem({super.key, required this.index});

 final int index;

  @override
  State<HadithItem> createState() => _HadithItemState();
}

class _HadithItemState extends State<HadithItem> {
  HadithModel? hadith;

  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() async {
    await loadHadith(widget.index);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(
          context,
          RoutesManager.hadithDetailsScreen,
          arguments: hadith,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),

        decoration: BoxDecoration(
          color: ColorsManager.gold,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(ImageAssets.imgLeftCorner, color: Colors.black),
                    Image.asset(
                      ImageAssets.imgRightCorner,
                      color: Colors.black,
                    ),
                  ],
                ),
                Text(
                  hadith?.title ?? "",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.black,
                  ),
                ),
              ],
            ),
            Expanded(
              child: hadith == null
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Text(
                        hadith!.content,
                        maxLines: 10,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future <void> loadHadith(int index) async {
    String key = "assets/files/hadith/h$index.txt";
    String hadithContent = await rootBundle.loadString(key);
    List<String> hadithLines = hadithContent.split('\n');
    String title = hadithLines[0];
    hadithLines.removeAt(0);
    String content = hadithLines.join();
    hadith = HadithModel(title: title, content: content);

    await Future.delayed(Duration(milliseconds: 500));
    setState(() {});
  }
}
