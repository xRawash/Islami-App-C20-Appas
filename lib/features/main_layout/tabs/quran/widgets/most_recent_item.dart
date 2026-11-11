import 'package:flutter/material.dart';
import 'package:quran_app_abbas/core/prefs_manager/prefs_manager.dart';
import 'package:quran_app_abbas/core/sources/assets_manager.dart';
import 'package:quran_app_abbas/core/sources/colors_manager.dart';
import 'package:quran_app_abbas/core/sources/routes_manager.dart';
import 'package:quran_app_abbas/models/sura_model.dart';

class MostRecentItem extends StatelessWidget {
   const MostRecentItem({super.key, required this.sura, required this.refreshQuranTab});
final SuraModel sura;
final void Function() refreshQuranTab;
  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: ()async{
        PrefsManager.saveSuraIndex(sura.suraIndex);
        await Navigator.pushNamed(context, RoutesManager.suraDetailsScreen,arguments: sura);
      refreshQuranTab();
        },
      child: Container(
        width: 283,
        height: 150,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 17),
        decoration: BoxDecoration(
          color: ColorsManager.gold,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Text(sura.suraNameEn, style: Theme.of(context).textTheme.labelLarge,)),
                Expanded(child: Text(sura.suraNameAr,style: Theme.of(context).textTheme.labelLarge,)),
                Expanded(child: Text(sura.versesNum,style: Theme.of(context).textTheme.labelSmall,)),
              ],
            ),
            Image.asset(ImageAssets.mostRecentCardImage)
          ],
        ),
      ),
    );
  }
}
