import 'package:flutter/material.dart';
import 'package:quran_app_abbas/core/extensions/context_ex.dart';
import 'package:quran_app_abbas/core/sources/assets_manager.dart';
import 'package:quran_app_abbas/core/sources/colors_manager.dart';
import 'package:quran_app_abbas/features/main_layout/tabs/quran/helpers/quran_helper.dart';
import 'package:quran_app_abbas/features/main_layout/tabs/quran/widgets/most_recent_list.dart';
import 'package:quran_app_abbas/features/main_layout/tabs/quran/widgets/sura_item.dart';
import 'package:quran_app_abbas/models/sura_model.dart';

class Quran extends StatefulWidget {
  const Quran({super.key});

  @override
  State<Quran> createState() => QuranState();
}

class QuranState extends State<Quran> {
  int currentPage = 1;
  List<SuraModel> displayedSuras = [];
  List<SuraModel> currentSourceList = SuraModel.suras;
  late ScrollController _scrollController;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _loadInitialPage();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadInitialPage() {
    currentPage = 1;
    displayedSuras = QuranHelper.getInitialSuras(currentSourceList);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _loadMoreSuras();
    }
  }

  void _loadMoreSuras() {
    if (isLoadingMore) return;
    if (displayedSuras.length >= currentSourceList.length) return;

    setState(() {
      isLoadingMore = true;
    });

    Future.delayed(const Duration(milliseconds: 150), () {
      if (!mounted) return;
      setState(() {
        currentPage++;
        displayedSuras = QuranHelper.loadMoreSuras(currentSourceList, displayedSuras, currentPage);
        isLoadingMore = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(ImageAssets.quranTabBg)),
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(ImageAssets.islamiLogo),
            SizedBox(height: context.getHeight * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                onChanged: (input) {
                  showFilteredList(input);
                },
                cursorColor: ColorsManager.ofWhite,
                style: const TextStyle(color: ColorsManager.ofWhite, fontSize: 18),
                decoration: InputDecoration(
                  labelText: "Sura name",
                  prefixIcon: ImageIcon(AssetImage(IconAssets.quran)),
                ),
              ),
            ),
            SizedBox(height: context.getHeight * 0.02),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MostRecentList(refreshQuranTab: refreshQuranTab),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => SuraItem(
                sura: displayedSuras[index],
                refreshQuranTab: refreshQuranTab,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              separatorBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                height: 2,
                color: ColorsManager.ofWhite,
              ),
              itemCount: displayedSuras.length,
            ),
            if (isLoadingMore)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: ColorsManager.gold,
                  ),
                ),
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void refreshQuranTab() {
    setState(() {});
  }

  void showFilteredList(String input) {
    currentSourceList = QuranHelper.filterSuras(input);
    _loadInitialPage();
    setState(() {});
  }
}
