import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_flutter/pages/Auth/login.pages.dart';
import 'package:recipe_flutter/pages/home/index.home.dart';
import 'package:recipe_flutter/services/prefreences.services.dart';
import 'package:recipe_flutter/utilities/colors.dart';
import 'package:recipe_flutter/utilities/images.dart';
import 'package:recipe_flutter/widgets/them_elevated_button.widgets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  StreamSubscription<User?>? _listener;
  @override
  void initState() {
    initSplash();
    super.initState();
  }

  //this function to load context befor call build function
  void initSplash() async {
    await Future.delayed(Duration(seconds: 5));

    _listener = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print(user);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (__) => LoginPage()));
      } else {
        print(user);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (__) => HomePage()));
      }
    });

    void dispose() {
      _listener?.cancel();
    }
//to resolve mounted problem
// if(context.mounted)
// {
// UserRe
// }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagesPathApp.backgroundImage),
                  fit: BoxFit.cover)),
        ),
        Container(
            decoration: BoxDecoration(
          color: Colors.black54,
        )),
        SingleChildScrollView(
          child: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 150, left: 80, right: 80),
                        child: Image.asset(ImagesPathApp.logoImage),
                      ),
                      Text(
                        "Cooking Done The Esay Way",
                        style:
                            TextStyle(color: ColorApp.whiteColor, fontSize: 18),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ThemeElevatedButton(
                              buttonText: "Register",
                              onPressedAction: () {},
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('loginScreen');
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: ColorApp.whiteColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                              style: TextButton.styleFrom(
                                fixedSize: Size(300, 50),
                              ),
                            ),
                          ],
                        ),
                        height: 300,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
