import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quran_app_abbas/models/azkar_item.dart';

class LoadAzkar {
  static Future<List<AzkarItem>> loadAzkar(String azkarId) async {
    String jsonString = await rootBundle.loadString('assets/files/azkar/$azkarId.json');
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => AzkarItem.fromJson(e as Map<String, dynamic>)).toList();
  }
}
