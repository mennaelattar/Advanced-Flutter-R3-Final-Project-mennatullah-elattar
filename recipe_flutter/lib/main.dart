import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter/pages/home/index.home.dart';
import 'package:recipe_flutter/pages/single_recipe/index.single_recipe.dart';
import 'package:recipe_flutter/providers/ads.provider.dart';
import 'package:recipe_flutter/providers/auth.provider.dart';
import 'package:recipe_flutter/providers/ingredient.provider.dart';
import 'package:recipe_flutter/providers/recipes.provider.dart';
import 'package:recipe_flutter/utilities/colors.dart';
import 'package:recipe_flutter/utilities/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  //to ensure all widget in app is initialized
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("error ===== ${e}");
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppAuthProvider()),
      ChangeNotifierProvider(create: (context) => AdsProvider()),
      ChangeNotifierProvider(create: (context) => RecipesProvider()),
      ChangeNotifierProvider(create: (context) => IngredientsProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.grey.shade200,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          colorScheme: ColorScheme.fromSeed(seedColor: ColorApp.mainColor)),
      home: SingleRecipe(),
      routes: RoutesApp.routes,
    );
  }
}
