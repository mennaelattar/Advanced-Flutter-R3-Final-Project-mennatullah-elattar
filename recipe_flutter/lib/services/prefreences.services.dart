import 'package:shared_preferences/shared_preferences.dart';

//singltone
//make abstract class and static of property to make only one instance from this class to move with it in all project
abstract class prefreencesServices {
  static SharedPreferences? prefs;

  static bool checkUser() {
    return prefs?.getBool('isLogedIn') ?? false;
  }
}
