import 'package:flutter/material.dart';
import 'package:recipe_flutter/pages/Auth/login.pages.dart';
import 'package:recipe_flutter/pages/Auth/register.pages.dart';
import 'package:recipe_flutter/pages/home/index.home.dart';
import 'package:recipe_flutter/pages/splash.pages.dart';

class RoutesApp {
  static Map<String, Widget Function(BuildContext)> routes = {
    "splashScreen": (context) => SplashPage(),
    "loginScreen": (context) => LoginPage(),
    "registerScreen": (context) => RegisterPage(),
    "homeScreen": (context) => HomePage()
  };
}
