import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPovider extends ChangeNotifier {
  Color mainColor = Colors.blue;
  void changeThemeColor(Color color) {
    mainColor = color;
    notifyListeners();
  }

  
   static SharedPreferences? sharedPreferences;
  static final String? name = sharedPreferences!.getString('name');
    static final dynamic acctBal =
        sharedPreferences!.getDouble('acctBal');
    static final dynamic rate =
        sharedPreferences!.getDouble('rate');
    static final String? city = sharedPreferences!.getString('city');
    static final String? fleet = sharedPreferences!.getString('fleet');
    static final String? image = sharedPreferences!.getString('image');
    static final String? id = sharedPreferences!.getString('id');
    static final String? firebaseUserId =
        sharedPreferences!.getString('firebaseUserId');
    static final String? category =
        sharedPreferences!.getString('category');
    static final String? phoneNumber =
        sharedPreferences!.getString('phoneNumber');
    static final String? email = sharedPreferences!.getString('email');
}

