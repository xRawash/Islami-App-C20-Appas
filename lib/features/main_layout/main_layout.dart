import 'package:flutter/material.dart';
import 'package:quran_app_abbas/core/sources/assets_manager.dart';
import 'package:quran_app_abbas/core/sources/colors_manager.dart';
import 'package:quran_app_abbas/features/main_layout/tabs/hadith/hadith.dart';
import 'package:quran_app_abbas/features/main_layout/tabs/sebha/sebha.dart';
import 'package:quran_app_abbas/features/main_layout/tabs/radio/radio.dart' as MyRadio;
import 'package:quran_app_abbas/features/main_layout/tabs/time/time.dart';

import 'tabs/quran/quran.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  List<Widget> tabs = [
    Quran(),
    Hadith(),
    Sebha(),
    MyRadio.Radio(),
    Time()

  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: tabs[selectedIndex],
      bottomNavigationBar: _buildBottomNavBar
    );
  }

  void _onTab(int tappedIndex){
    setState(() {
      selectedIndex = tappedIndex;
    });
  }
  Widget get _buildBottomNavBar=>
      BottomNavigationBar(

        currentIndex: selectedIndex,
        onTap: _onTab,

        items: [
          BottomNavigationBarItem(
              icon: _buildIcon(icon: IconAssets.quran, isSelected: selectedIndex == 0),label: "Quran"),
          BottomNavigationBarItem(icon: _buildIcon(icon: IconAssets.hadith, isSelected: selectedIndex == 1),label: "Hadith"),
          BottomNavigationBarItem(icon: _buildIcon(icon: IconAssets.sebha, isSelected: selectedIndex == 2),label: "Sebha"),
          BottomNavigationBarItem(icon:_buildIcon(icon: IconAssets.radio, isSelected: selectedIndex == 3),label: "Radio"),
          BottomNavigationBarItem(icon: _buildIcon(icon: IconAssets.time, isSelected: selectedIndex == 4),label: "Time"),


        ]
    );


  Widget _buildIcon({required bool isSelected, required String icon}){

    return isSelected ?   Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
        decoration: BoxDecoration(
         color: ColorsManager.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(66)
        ),
        child: ImageIcon(AssetImage(icon))): ImageIcon(AssetImage(icon));
  }
}
