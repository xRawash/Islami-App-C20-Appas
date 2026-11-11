import 'package:quran_app_abbas/core/sources/assets_manager.dart';

class AzkarModel {
  String name;
  String id;
  String imagePath;
  AzkarModel({required this.name, required this.id, required this.imagePath});
  static List<AzkarModel> azkarCategories = [
    AzkarModel(name: "Morning Azkar", id: "morningAzkar", imagePath: ImageAssets.morningAzkarBg),
    AzkarModel(name: "Evening Azkar", id: "eveningAzkar", imagePath: ImageAssets.eveningAzkarBg),
    AzkarModel(name: "Waking Azkar", id: "wakingAzkar", imagePath: ImageAssets.wakingAzkarBg),
    AzkarModel(name: "Sleeping Azkar", id: "sleepingAzkar", imagePath: ImageAssets.sleepingAzkarBg),
    AzkarModel(name: "After Prayers Azkar", id: "afterPrayersAzkar", imagePath: ImageAssets.afterPrayersAzkar),
    AzkarModel(name: "Quran Prayers", id: "quranPrayers", imagePath: ImageAssets.quranPrayers),
    AzkarModel(name: "Prophets Prayers", id: "prophetsPrayers", imagePath: ImageAssets.prophetsAzkar),
    AzkarModel(name: "Tsabeeh", id: "tsabeeh", imagePath: ImageAssets.tsabeeh),
  ];
}