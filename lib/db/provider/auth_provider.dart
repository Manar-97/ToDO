import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tooodooo/UI/screens/auth/firebase_auth_error.dart';
import 'package:tooodooo/UI/screens/auth/login/login_screen.dart';
import 'package:tooodooo/UI/screens/home/home.dart';
import 'package:tooodooo/UI/widget/dialogs.dart';
import 'package:tooodooo/db/functions/user_fun.dart';
import 'package:tooodooo/db/model/user_dm.dart' as appuser;

class AuthProvider extends ChangeNotifier {
  User? fireUser;

  appuser.UserDM? user;

  Future<void> registration(
      String email,
      String password,
      String name,
      ) async {
    var user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    var newUser = appuser.UserDM(id: user.user?.uid, userName: name, email: email);
    await UserFun.addUser(newUser);
    user.user?.sendEmailVerification();
  }

  login(String email, String password, BuildContext context) async {
    try {
      Dialogs.showLoadingDialog(context, "Loading",
          isCanceled: false);
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Dialogs.closeMessageDialog(context);
      fireUser = result.user;
      if (fireUser?.email == true) {
        user = await UserFun.getUser(result.user?.uid);
        Navigator.pushReplacementNamed(context, Home.routeName);
      } else {
        Dialogs.showMessageDialog(context, "verify",
            icon: const Icon(
              Icons.dangerous,
              color: Colors.red,
              size: 30,
            ));
      }
    } on FirebaseAuthException catch (e) {
      Dialogs.closeMessageDialog(context);
      if (e.code == FireAuthErrors.userNotFound) {
        Dialogs.showMessageDialog(context, 'email or password is wrong',
            isClosed: false,
            positiveActionText: 'ok',
            icon: const Icon(
              Icons.dangerous,
              color: Colors.red,
              size: 30,
            ));
      } else if (e.code == FireAuthErrors.wrongPassword) {
        Dialogs.showMessageDialog(context, 'email or password is wrong',
            isClosed: false,
            positiveActionText: 'ok',
            icon: const Icon(
              Icons.dangerous,
              color: Colors.red,
              size: 30,
            ));
      } else {
        Dialogs.showMessageDialog(context, 'email or password is wrong',
            isClosed: false,
            positiveActionText: 'ok',
            icon: const Icon(
              Icons.dangerous,
              color: Colors.red,
              size: 30,
            ));
      }
    }
  }

  signOut(BuildContext context) async {
    user = null;
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  bool isLogedBefore() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> getUserData() async {
    fireUser = FirebaseAuth.instance.currentUser;
    user = await UserFun.getUser(fireUser?.uid);
  }
}