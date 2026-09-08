import 'package:flutter/cupertino.dart';
import 'package:quran_app_abbas/features/main_layout/main_layout.dart';
import 'package:quran_app_abbas/features/sura_details/sura_details_screen.dart';

abstract class RoutesManager{
static const String mainLayout = '/mainLayout';
static const String suraDetailsScreen = '/suraDetailsScreen';


  static Map<String, WidgetBuilder> routes ={
mainLayout : (context)=> MainLayout(),
suraDetailsScreen : (context)=> SuraDetailsScreen(),
  };
}