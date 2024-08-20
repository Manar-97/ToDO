import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tooodooo/UI/screens/auth/login/login_screen.dart';
import 'package:tooodooo/UI/utils/dialog_utils.dart';
import '../../../../model/user_dm.dart';
import '../../../utils/constants.dart';
import '../../home/home.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = "";
  String password = "";
  String username = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Welcome To ToDo App",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(label: Text("User Name")),
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text("Email")),
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text("Password"),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.09),
              ElevatedButton(
                  onPressed: () {
                    signUp();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Create account", style: TextStyle(fontSize: 18)),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                  child: const Text("I already have an account",
                      style: TextStyle(fontSize: 18, color: Colors.black45))),
            ],
          ),
        ),
      ),
    );
  }

  void signUp() async {
    try {
      showLoading(context);
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserDM.currentUser =
          UserDM(id: credential.user!.uid, email: email, userName: username);
      registerUserInFireStore(UserDM.currentUser!);
      if (context.mounted) {
        hideLoading(context);
        Navigator.pushNamed(context, Home.routeName);
      }
    } on FirebaseAuthException catch (authError) {
      String message;
      print("Error=========${authError.code}");
      if (authError.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (authError.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
      } else {
        message = Constants.defaultErrorMessage;
      }
      if (context.mounted) {
        hideLoading(context);
        showMessage(context,
            title: "Error", body: message, posButtonTitle: "ok");
      }
    } catch (e) {
      if (context.mounted) {
        hideLoading(context);
        showMessage(context,
            title: "Error",
            body: Constants.defaultErrorMessage,
            posButtonTitle: "ok");
      }
      else{"Failed to create user: $e";}
    }
  }

  void registerUserInFireStore(UserDM user) async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference newUserDoc = collectionReference.doc(user.id);
    await newUserDoc.set(user.toJson());
  }
}
