import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tooodooo/UI/screens/auth/login/login_screen.dart';
import 'package:tooodooo/UI/screens/auth/reuse_header.dart';
import 'package:tooodooo/UI/screens/auth/user_valid_data.dart';
import 'package:tooodooo/UI/widget/cust_text_field.dart';
import 'package:tooodooo/UI/widget/dialogs.dart';

class ResetPassword extends StatefulWidget {
  static const String routeName = 'resetPassword';

  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle formStyle = GoogleFonts.quicksand(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(title: "reset_password"),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: form,
                child: Padding(
                  padding: const EdgeInsets.only(top: 130),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "email",
                        style: formStyle,
                      ),
                      CustomTextField(
                        check: validEmail,
                        control: email,
                        hint: "your_email",
                        type: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color(0xFF5D9CEC),
                            borderRadius: BorderRadius.circular(50)),
                        child: TextButton(
                          onPressed: () {
                            resetPassword();
                          },
                          child: Text(
                            "send_link",
                            style: GoogleFonts.quicksand(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void resetPassword() async {
    if (form.currentState?.validate() == false) {
      return;
    }
    try {
      Dialogs.showLoadingDialog(context, "loading");
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
      Dialogs.closeMessageDialog(context);
      Dialogs.showMessageDialog(
          context, "password_dialog",
          icon: const Icon(
            Icons.check_circle_sharp,
            color: Colors.green,
            size: 30,
          ),
          positiveActionText: "ok",
          positiveAction: () {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          });
    } on FirebaseAuthException catch (e) {
      Dialogs.showMessageDialog(context, 'Something went wrong , ${e.code}',
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