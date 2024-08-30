import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tooodooo/UI/screens/auth/firebase_auth_error.dart';
import 'package:tooodooo/UI/screens/auth/login/login_screen.dart';
import 'package:tooodooo/UI/screens/auth/reuse_header.dart';
import 'package:tooodooo/UI/screens/auth/user_valid_data.dart';
import 'package:tooodooo/UI/widget/cust_text_field.dart';
import 'package:tooodooo/UI/widget/dialogs.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isHidePassword = true;
  bool isHideConfirmpassword = true;

  @override
  Widget build(BuildContext context) {
    TextStyle formStyle = GoogleFonts.quicksand(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(title: 'registration'),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'name',
                        style: formStyle,
                      ),
                      CustomTextField(
                        control: name,
                        hint:'registration_name_hint',
                        type: TextInputType.name,
                        check: validName,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text('email',
                        style: formStyle,
                      ),
                      CustomTextField(
                        check: validEmail,
                        control: email,
                        hint: 'registration_email_hint',
                        type: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text('registration_phone_hint',
                        style: formStyle,
                      ),
                      CustomTextField(
                        check: validPhone,
                        control: phone,
                        hint: 'registration_phone_hint',
                        type: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text('password',
                        style: formStyle,
                      ),
                      CustomTextField(
                        check: validPassword,
                        control: password,
                        hint: 'registration_password_hint',
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
                      const SizedBox(
                        height: 30,
                      ),
                      Text('config_password',
                        style: formStyle,
                      ),
                      CustomTextField(
                        check: validConfirmPassword,
                        control: confirmPassword,
                        hint:'config_password_hint',
                        isSecrete: isHideConfirmpassword,
                        passwordIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isHideConfirmpassword = !isHideConfirmpassword;
                              });
                            },
                            icon: Icon(
                              isHideConfirmpassword == true
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color(0xFFADADAD),
                            )),
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
                            // signUp();
                          },
                          child: Text('registration',
                            style: GoogleFonts.quicksand(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  String? validConfirmPassword(String? checkPassword) {
    if (password.text == checkPassword) {
      return null;
    } else
      return 'not typical';
  }

  // void signUp() async {
  //   if (formKey.currentState?.validate() == false) {
  //     return;
  //   }
  //   var authProvider = Provider.of<AuthProvider>(context, listen: false);
  //   try {
  //     Dialogs.showLoadingDialog(context,'loading');
  //     await authProvider.registration(email.text, password.text, name.text);
  //     Dialogs.closeMessageDialog(context);
  //     Dialogs.showMessageDialog(
  //       context,
  //       "registration_dialog",
  //       isClosed: false,
  //       positiveActionText:"ok",
  //       positiveAction: () {
  //         Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  //       },
  //       icon: const Icon(
  //         Icons.check_circle_sharp,
  //         color: Colors.green,
  //         size: 30,
  //       ),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     Dialogs.closeMessageDialog(context);
  //     if (e.code == FireAuthErrors.weakPassword) {
  //       Dialogs.showMessageDialog(context, 'weak password',
  //           isClosed: false,
  //           positiveActionText: 'ok',
  //           icon: const Icon(
  //             Icons.dangerous,
  //             color: Colors.red,
  //             size: 30,
  //           ));
  //     } else if (e.code == FireAuthErrors.emailExcist) {
  //       Dialogs.showMessageDialog(context, 'Email alredy excist',
  //           isClosed: false,
  //           positiveActionText: 'ok',
  //           icon: const Icon(
  //             Icons.dangerous,
  //             color: Colors.red,
  //             size: 30,
  //           ));
  //     } else {
  //       Dialogs.showMessageDialog(context, 'Something went wrong , ${e.code}',
  //           isClosed: false,
  //           positiveActionText: 'ok',
  //           icon: const Icon(
  //             Icons.dangerous,
  //             color: Colors.red,
  //             size: 30,
  //           ));
  //     }
  //   }
  // }
}
