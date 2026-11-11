import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app_abbas/core/utils/dialog_utils.dart';
import 'package:quran_app_abbas/models/prayer_times_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerTimesService {
  static const String baseUrl = 'https://api.aladhan.com/v1/timings';
  static const String cachedPrayerTimesKey = 'cached_prayer_times';
  static const String cachedDateKey = 'cached_prayer_date';

  static Future<PrayerTimesModel?> fetchPrayerTimes(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!context.mounted) return null;
      String todayStr = DateTime.now().toIso8601String().substring(0, 10);
      String? savedDate = prefs.getString(cachedDateKey);
      String? savedJson = prefs.getString(cachedPrayerTimesKey);


      if (savedDate == todayStr && savedJson != null) {
        final Map<String, dynamic> data = jsonDecode(savedJson);
        return PrayerTimesModel.fromJson(data);
      }

      Position? position = await _getCurrentPosition();
      if (!context.mounted) return null;
      double lat = position?.latitude ?? 30.0444;
      double lng = position?.longitude ?? 31.2357;

      final url = Uri.parse('$baseUrl?latitude=$lat&longitude=$lng');
      final response = await http.get(url);
      if (!context.mounted) return null;

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        await prefs.setString(cachedPrayerTimesKey, jsonEncode(data));
        await prefs.setString(cachedDateKey, todayStr);
        if (!context.mounted) return null;
        return PrayerTimesModel.fromJson(data);
      } else {
        DialogUtils.showErrorDialog(
          context: context,
          title: "API Error",
          message: "Failed to load prayer times (Status code: ${response.statusCode}). Using default location.",
        );
      }
    } catch (e) {
      if (context.mounted) {
        DialogUtils.showErrorDialog(
          context: context,
          title: "Connection Error",
          message: "Unable to fetch prayer times. Please check your internet connection.",
        );
      }
    }
    return null;
  }

  static Future<Position?> _getCurrentPosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 5),
        ),
      );
    } catch (e) {
      return null;
    }
  }
}
