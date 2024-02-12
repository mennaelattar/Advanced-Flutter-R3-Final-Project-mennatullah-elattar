import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter/providers/auth.provider.dart';
import 'package:recipe_flutter/utilities/colors.dart';
import 'package:recipe_flutter/utilities/images.dart';
import 'package:recipe_flutter/widgets/them_elevated_button.widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false).providerInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 80, right: 80, top: 100),
                      child: Image.asset(ImagesPathApp.logoImage),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Register",
                      style: TextStyle(
                          color: ColorApp.whiteColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Consumer<AppAuthProvider>(
                        builder: (context, appAuthProviderObj, child) {
                          return Form(
                              key: appAuthProviderObj.registerKey,
                              child: Column(
                                children: [
                                  //full name
                                  TextFormField(
                                    controller:
                                        appAuthProviderObj.fullNameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please Enter Your Full Name";
                                      }
                                    },
                                    style:
                                        TextStyle(color: ColorApp.whiteColor),
                                    decoration: InputDecoration(
                                        hintText: "Full Name",
                                        hintStyle: TextStyle(
                                            color: ColorApp.whiteColor),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.solid,
                                                color: ColorApp.whiteColor,
                                                width: 1)),
                                        filled: false,
                                        prefixIcon: Icon(
                                          Icons.person_2_outlined,
                                          color: ColorApp.whiteColor,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: appAuthProviderObj
                                        .emailAddressController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please Enter Your Email";
                                      }
                                      if (!EmailValidator.validate(value)) {
                                        return "Please Enter A Valid Email";
                                      }
                                    },
                                    style:
                                        TextStyle(color: ColorApp.whiteColor),
                                    decoration: InputDecoration(
                                        hintText: "Email Address",
                                        hintStyle: TextStyle(
                                            color: ColorApp.whiteColor),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.solid,
                                                color: ColorApp.whiteColor,
                                                width: 1)),
                                        filled: false,
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                          color: ColorApp.whiteColor,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    obscureText:
                                        appAuthProviderObj.passwordVisability,
                                    controller:
                                        appAuthProviderObj.passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please Enter Your Password";
                                      }
                                      if (value.length <= 6) {
                                        return "This Password Is too Short";
                                      }
                                    },
                                    style:
                                        TextStyle(color: ColorApp.whiteColor),
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                            color: ColorApp.whiteColor),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.solid,
                                                color: ColorApp.whiteColor,
                                                width: 1)),
                                        filled: false,
                                        prefixIcon: Icon(
                                          Icons.lock_clock_outlined,
                                          color: ColorApp.whiteColor,
                                        ),
                                        suffixIcon: InkWell(
                                          child: Icon(
                                            appAuthProviderObj
                                                    .passwordVisability
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility,
                                            color: ColorApp.whiteColor,
                                          ),
                                          onTap: () {
                                            appAuthProviderObj
                                                    .passwordVisability
                                                ? appAuthProviderObj
                                                    .passwordVisability = false
                                                : appAuthProviderObj
                                                    .passwordVisability = true;
                                            setState(() {});
                                          },
                                        )),
                                  ),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  ThemeElevatedButton(
                                      buttonText: 'Register',
                                      onPressedAction: () {
                                        appAuthProviderObj.signUp(context);
                                        //to remove the keyboard after typing
                                        FocusScope.of(context).unfocus();
                                      }),
                                ],
                              ));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        "Already Registered? ",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed('loginScreen');
                        },
                        child: Text(
                          "Singn In",
                          style: TextStyle(
                              color: ColorApp.mainColor, fontSize: 18),
                        ),
                      )
                    ])
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
