import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tooodooo/UI/screens/auth/login/login_screen.dart';
import 'package:tooodooo/UI/screens/home/home.dart';
import 'package:tooodooo/db/provider/auth_provider.dart';
import 'package:tooodooo/db/provider/my_provider.dart';

class Splash extends StatefulWidget {
  static const String routeName = 'splash';

  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    var settingProvider = Provider.of<MyProvider>(context);
    Future.delayed(const Duration(seconds: 2), () {
      navigate(context);
    });
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(settingProvider.isDark()
                  ? 'assets/splashdark.png'
                  : 'assets/splash.png'),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  void navigate(BuildContext context) async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.isLogedBefore()) {
       authProvider.getUserData();
      Navigator.pushReplacementNamed(context, Home.routeName);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }
}
