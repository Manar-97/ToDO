import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tooodooo/UI/screens/auth/register/register_screen.dart';
import 'package:tooodooo/UI/screens/auth/reset_pass.dart';
import 'package:tooodooo/UI/screens/auth/reuse_header.dart';
import 'package:tooodooo/UI/screens/auth/user_valid_data.dart';
import 'package:tooodooo/UI/widget/cust_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHidePassword = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
            Header(title: 'login'),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'email',
                      style: formStyle,
                    ),
                    CustomTextField(
                      check: validEmail,
                      control: email,
                      hint: 'your_email',
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'password',
                      style: formStyle,
                    ),
                    CustomTextField(
                      check: validPasswordLogIn,
                      control: password,
                      hint: 'your_password',
                      isSecrete: isHidePassword,
                      passwordIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isHidePassword = !isHidePassword;
                            });
                          },
                          icon: Icon(
                            isHidePassword == true
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color(0xFFADADAD),
                          )),
                    ),
                    Row(
                      children: [
                        const Expanded(
                            child: SizedBox(
                          width: double.infinity,
                        )),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, ResetPassword.routeName);
                            },
                            child: Text(
                              'forget_password',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.quicksand(
                                  color: const Color(0xFF302F2F), fontSize: 12),
                            )),
                      ],
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
                          // signIn();
                        },
                        child: Text(
                          'login',
                          style: GoogleFonts.quicksand(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'I have account',
                          style: GoogleFonts.quicksand(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RegisterScreen.routeName);
                          },
                          child: Text(
                            'Here',
                            style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.blueAccent),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // void signIn() async {
  //   if (form.currentState?.validate() == false) {
  //     return;
  //   }
  //   var authProvider = Provider.of<AuthProvider>(context, listen: false);
  //   await authProvider.login(email.text, password.text, context);
  // }
}
