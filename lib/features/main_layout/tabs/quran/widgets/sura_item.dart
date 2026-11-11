import 'package:flutter/material.dart';
import 'package:quran_app_abbas/core/prefs_manager/prefs_manager.dart';
import 'package:quran_app_abbas/core/sources/assets_manager.dart';
import 'package:quran_app_abbas/core/sources/colors_manager.dart';
import 'package:quran_app_abbas/core/sources/routes_manager.dart';
import 'package:quran_app_abbas/models/sura_model.dart';

class SuraItem extends StatelessWidget {
  const SuraItem({super.key, required this.sura, required this.refreshQuranTab });
final SuraModel sura;
final void Function() refreshQuranTab;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        PrefsManager.saveSuraIndex(sura.suraIndex);
       await Navigator.pushNamed(
           context,
           RoutesManager.suraDetailsScreen,
       arguments: sura,
       );
       refreshQuranTab();
      },
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(ImageAssets.suraNumberFrame),
              Text(sura.suraIndex, style: TextStyle(fontSize: 16,color: ColorsManager.ofWhite, fontWeight: FontWeight.bold),),
            ],
          ),
          SizedBox(width: 8,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(sura.suraNameEn, style: Theme.of(context).textTheme.titleSmall),
              Text("${sura.versesNum} Verses", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12)),
            ],
          ),
          Spacer(),
          Text(sura.suraNameAr, style: Theme.of(context).textTheme.titleSmall),




        ],
      ),
    );
  }
}
