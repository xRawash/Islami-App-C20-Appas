import 'package:quran_app_abbas/models/sura_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {

  static late SharedPreferences prefs;

  static Future<void> init () async {
   prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveOnboardingStatus() async{
    await prefs.setBool('is finished onboarding', true);
  }

  static Future<bool> getOnboardingStatus() async{
    return prefs.getBool('is finished onboarding') ?? false;
  }

  static void saveSuraIndex(String index) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> mostRecentSurasIndex = prefs.getStringList("mostRecentSurasKey") ?? [];

    if(mostRecentSurasIndex.contains(index)){
      mostRecentSurasIndex.remove(index);
    }
    mostRecentSurasIndex.add(index);
    prefs.setStringList("mostRecentSurasKey", mostRecentSurasIndex);

  }

  static Future<List<SuraModel>> getMostRecentSuras() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> mostRecentSurasIndex = prefs.getStringList("mostRecentSurasKey") ?? [];
    List<SuraModel> mostRecentSuras = [];
    for (int i = 0; i < mostRecentSurasIndex.length; i++) {
      int index = int.parse(mostRecentSurasIndex[i]);
      SuraModel sura = SuraModel.suras[index-1];
      mostRecentSuras.add(sura);
    }
    return mostRecentSuras.reversed.toList();
  }
}
