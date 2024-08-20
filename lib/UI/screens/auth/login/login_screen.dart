import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../utils/dialog_utils.dart';
import '../../home/home.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String pass = "";
  String userName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Welcome back !",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(label: Text("Email")),
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text("Password"),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    signIn();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Login", style: TextStyle(fontSize: 18)),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  )),
              const SizedBox(height: 10),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RegisterScreen.routeName);
                  },
                  child: const Text("Create account",
                      style: TextStyle(fontSize: 18, color: Colors.black45))),
            ],
          ),
        ),
      ),
    );
  }

  void signIn()async {
    try {
      showLoading(context);
      final credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      if (context.mounted) {
        hideLoading(context);
        Navigator.pushNamed(context, Home.routeName);
      }
    } on FirebaseAuthException catch (authError) {
      String message;
      print("Error=========${authError.code}");
      if (authError.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (authError.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
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
    }
    // showLoading(context);
    // await Future.delayed(const Duration(seconds: 1));
    // hideLoading(context);
    // showMessage(context,title: "title",body: "body",posButtomTitle:"Ok");
  }
}
