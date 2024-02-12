import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppAuthProvider extends ChangeNotifier {
  GlobalKey<FormState>? registerKey;
  GlobalKey<FormState>? loginKey;

  TextEditingController? fullNameController;
  TextEditingController? emailAddressController;
  TextEditingController? passwordController;
  bool passwordVisability = true;

  void providerInit() {
    registerKey = GlobalKey<FormState>();
    loginKey = GlobalKey<FormState>();

    fullNameController = TextEditingController();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
  }

  void providerDispose() {
    registerKey = null;
    loginKey = null;
    fullNameController = null;
    emailAddressController = null;
    passwordController = null;
    passwordVisability = true;
  }

  void openRegisterPage(BuildContext context) {
    providerDispose();
    Navigator.of(context).pushReplacementNamed("registerScreen");
  }

  void openLoginPage(BuildContext context) {
    providerDispose();
    Navigator.of(context).pushReplacementNamed("loginScreen");
  }

  Future<void> signUp(BuildContext context) async {
    try {
      if (registerKey?.currentState?.validate() ?? false) {
        var credintials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailAddressController!.text,
                password: passwordController!.text);
        if (credintials.user != null) {
          print(fullNameController!.text);
          await credintials.user?.updateDisplayName(fullNameController!.text);
          await credintials.user?.reload();
          providerDispose();
          Navigator.of(context).pushReplacementNamed("homeScreen");
        } else {
          print("no");
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {}
  }

  Future<void> login(BuildContext context) async {
    try {
      if (loginKey?.currentState?.validate() ?? false) {
        var credintials = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailAddressController!.text,
                password: passwordController!.text);
        if (credintials.user != null) {
          providerDispose();
          Navigator.of(context).pushReplacementNamed("homeScreen");
        } else {
          print("no");
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {}
  }

  void signOut(BuildContext context) {
    FirebaseAuth.instance.signOut().then(
        (value) => Navigator.of(context).pushReplacementNamed("loginScreen"));
    providerDispose();
  }
}
