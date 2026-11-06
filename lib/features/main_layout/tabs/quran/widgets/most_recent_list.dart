
import 'package:flutter/material.dart';
import 'package:quran_app_abbas/core/extensions/context_ex.dart';
import 'package:quran_app_abbas/core/prefs_manager/prefs_manager.dart';
import 'package:quran_app_abbas/features/main_layout/tabs/quran/widgets/most_recent_item.dart';
import 'package:quran_app_abbas/models/sura_model.dart';

class MostRecentList extends StatefulWidget {
  const MostRecentList({super.key, required this.refreshQuranTab});
  final void Function() refreshQuranTab;
  @override
  State<MostRecentList> createState() => MostRecentListState();
}

class MostRecentListState extends State<MostRecentList> {
  List<SuraModel> mostRecentSuras = [];

void fillMostRecentSuras()async{
  mostRecentSuras = await PrefsManager.getMostRecentSuras();
  setState(() {

  });
}
@override
  void initState() {
    super.initState();
    fillMostRecentSuras();
  }
  @override
  void didUpdateWidget(covariant MostRecentList oldWidget) {
    super.didUpdateWidget(oldWidget);
    fillMostRecentSuras();
  }



  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: mostRecentSuras.isNotEmpty,
      child: SizedBox(
        height: context.getHeight * 0.17,

        child: Column(
          children: [
            Text("Most Recently", style: Theme.of(context).textTheme.titleSmall),
            SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 5),
                itemBuilder: (context, index) =>
                    MostRecentItem(sura: mostRecentSuras[index], refreshQuranTab: widget.refreshQuranTab,),
                itemCount: mostRecentSuras.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
