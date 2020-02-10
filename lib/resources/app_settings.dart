import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  //* AppVersionCode
  static const int app_version_code = 1;

  //* Application Strings Constant
  static const String app_name = "Devfest";
  static const String app_version = "Version 1.0.0";
  static const String app_color = "#ffd7167";

  //* Debug
  static bool isDebugMode = true;

  //* Fonts
  static const String google_sans_family = "GoogleSans";

  //* Preferences
  static SharedPreferences prefs;
  static const String darkModePref = "darkModePref";

  //* Colors
  static Color primaryAppColor = Colors.white;
  static Color secondaryAppColor = Colors.black;

  //* Images
  static const String banner_light = "assets/images/banners/banner_light.png";
  static const String banner_dark = "assets/images/banners/banner_dark.png";
  static const String dog = "assets/images/members/dog2.jpg";
  static const String cat = "assets/images/members/cat2.jpg";

  //Social medial links
  static const String facebook = "https://facebook.com/imthepk";
  static const String twitter = "https://twitter.com/imthepk";
  static const String linkedIn = "https://linkedin.com/in/imthepk";
  static const String youtube = "https://youtube.com/mtechviral";
  static const String meetup = "https://meetup.com/";

  //projects links
/*
  static const String CASSAVA_MAIN = 'http://127.0.0.1:8000/cassavas/';
  static const String LOAN_MAIN ='http://127.0.0.1:8000/loans/';
  static const String DOGCAT_MAIN = 'http://127.0.0.1:8000/dogcats/';
*/

  static const String CASSAVA_MAIN = 'http://127.0.0.1:8000/cassavas/';
  static const String LOAN_MAIN ='http://localhost:8000/loans/';
  static const String DOGCAT_MAIN = 'http://127.0.0.1:8000/dogcats/';

  //http://10.161.15.57:8000
}
