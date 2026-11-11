import 'package:quran_app_abbas/models/sura_model.dart';

class QuranHelper {
  static const int pageSize = 15;

  static List<SuraModel> getInitialSuras(List<SuraModel> sourceList) {
    int limit = pageSize < sourceList.length ? pageSize : sourceList.length;
    return sourceList.sublist(0, limit);
  }

  static List<SuraModel> loadMoreSuras(List<SuraModel> sourceList, List<SuraModel> currentDisplayed, int currentPage) {
    if (currentDisplayed.length >= sourceList.length) return currentDisplayed;
    int nextLimit = (currentPage + 1) * pageSize;
    if (nextLimit > sourceList.length) {
      nextLimit = sourceList.length;
    }
    return sourceList.sublist(0, nextLimit);
  }

  static List<SuraModel> filterSuras(String input) {
    if (input.isEmpty) {
      return SuraModel.suras;
    } else {
      return SuraModel.suras
          .where((sura) =>
              sura.suraNameEn.toLowerCase().contains(input.toLowerCase()) ||
              sura.suraNameAr.contains(input))
          .toList();
    }
  }
}
