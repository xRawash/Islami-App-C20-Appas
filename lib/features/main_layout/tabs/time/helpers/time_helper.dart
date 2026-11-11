import 'package:flutter/material.dart';
import 'package:quran_app_abbas/core/services/prayer_times_service.dart';
import 'package:quran_app_abbas/models/prayer_times_model.dart';

class TimeHelper {
  static Future<PrayerTimesModel?> loadPrayerTimes(BuildContext context) async {
    return await PrayerTimesService.fetchPrayerTimes(context);
  }
}
