import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter/providers/auth.provider.dart';
import 'package:recipe_flutter/utilities/colors.dart';
import 'package:recipe_flutter/utilities/images.dart';
import 'package:recipe_flutter/widgets/them_elevated_button.widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // late GlobalKey<FormState> loginKey;
  // late TextEditingController emailAddressController;
  // late TextEditingController passwordController;
  // bool passwordVisability = true;

  @override
  void initState() {
    // loginKey = GlobalKey<FormState>();
    // emailAddressController = TextEditingController();
    // passwordController = TextEditingController();
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
                      "Sign In",
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
                              key: appAuthProviderObj.loginKey,
                              child: Column(
                                children: [
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
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: () {
                                        print("press");
                                      },
                                      child: Text(
                                        'Forget Password ?',
                                        style: TextStyle(
                                            color: ColorApp.blueColor),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  ThemeElevatedButton(
                                      buttonText: 'Sign In',
                                      onPressedAction: () {
                                        appAuthProviderObj.login(context);
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
                        "Don't hove an account? ",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed('registerScreen');
                        },
                        child: Text(
                          "Register",
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
