import 'package:quran_app_abbas/models/prayer_item.dart';

class PrayerTimesModel {
  final String gregorianDate;
  final String weekday;
  final String hijriDate;
  final List<PrayerItem> prayers;

  PrayerTimesModel({
    required this.gregorianDate,
    required this.weekday,
    required this.hijriDate,
    required this.prayers,
  });

  int getNearestPrayerIndex() {
    DateTime now = DateTime.now();
    int nearestIndex = 0;
    Duration smallestFutureDiff = const Duration(days: 999);

    for (int i = 0; i < prayers.length; i++) {
      PrayerItem prayer = prayers[i];
      DateTime? prayerTime = _parsePrayerTime(prayer.time, prayer.period, now);
      if (prayerTime != null) {
        Duration diff = prayerTime.difference(now);
        if (!diff.isNegative) {
          if (diff < smallestFutureDiff) {
            smallestFutureDiff = diff;
            nearestIndex = i;
          }
        }
      }
    }

    if (smallestFutureDiff.inDays < 999) {
      return nearestIndex;
    } else {
      return 0;
    }
  }

  DateTime? _parsePrayerTime(String timeStr, String period, DateTime referenceDate) {
    List<String> parts = timeStr.split(':');
    if (parts.length < 2) return null;
    int hour = int.tryParse(parts[0]) ?? 0;
    int minute = int.tryParse(parts[1]) ?? 0;

    if (period == 'PM' && hour < 12) hour += 12;
    if (period == 'AM' && hour == 12) hour = 0;

    return DateTime(
      referenceDate.year,
      referenceDate.month,
      referenceDate.day,
      hour,
      minute,
    );
  }

  factory PrayerTimesModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final timings = data['timings'] as Map<String, dynamic>;
    final date = data['date'];
    final gregorian = date['gregorian'];
    final hijri = date['hijri'];

    String day = gregorian['day'] ?? '';
    String monthEn = gregorian['month']['en'] ?? '';
    String monthShort = monthEn.length >= 3 ? monthEn.substring(0, 3) : monthEn;
    String year = gregorian['year'] ?? '';
    String gregorianFormatted = "$day $monthShort, $year";

    String weekdayEn = gregorian['weekday']['en'] ?? '';


    String hDay = hijri['day'] ?? '';
    String hMonthEn = hijri['month']['en'] ?? '';
    String hMonthShort = hMonthEn.length >= 3 ? hMonthEn.substring(0, 3) : hMonthEn;
    String hYear = hijri['year'] ?? '';
    String hijriFormatted = "$hDay $hMonthShort, $hYear";

    List<PrayerItem> prayerList = [];
    final prayerKeys = [
      {'key': 'Fajr', 'name': 'FAJR'},
      {'key': 'Sunrise', 'name': 'SUNRISE'},
      {'key': 'Dhuhr', 'name': 'DHUHR'},
      {'key': 'Asr', 'name': 'ASR'},
      {'key': 'Maghrib', 'name': 'MAGHRIB'},
      {'key': 'Isha', 'name': 'ISHA'},
    ];

    for (var p in prayerKeys) {
      String rawTime = timings[p['key']] ?? '00:00';

      List<String> parts = rawTime.split(':');
      int hour = int.tryParse(parts[0]) ?? 0;
      int minute = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;

      String period = hour >= 12 ? 'PM' : 'AM';
      int formattedHour = hour % 12;
      if (formattedHour == 0) formattedHour = 12;

      String hourStr = formattedHour.toString().padLeft(2, '0');
      String minStr = minute.toString().padLeft(2, '0');

      prayerList.add(
        PrayerItem(
          name: p['name']!,
          time: "$hourStr:$minStr",
          period: period,
        ),
      );
    }

    return PrayerTimesModel(
      gregorianDate: gregorianFormatted,
      weekday: weekdayEn,
      hijriDate: hijriFormatted,
      prayers: prayerList,
    );
  }
}
