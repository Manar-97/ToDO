import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tooodooo/UI/screens/auth/login/login_screen.dart';
import 'package:tooodooo/UI/screens/auth/register/register_screen.dart';
import 'package:tooodooo/UI/screens/home/home.dart';
import 'package:tooodooo/UI/screens/home/tabs/list/todo_task/edit_todo.dart';
import 'package:tooodooo/UI/screens/splash/splash.dart';
import 'package:tooodooo/UI/utils/App_Theme.dart';
import 'package:tooodooo/db/provider/auth_provider.dart';
import 'package:tooodooo/db/provider/my_provider.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(
        create: (context) => MyProvider(
            pref.getBool('isDark'), pref.getBool('isEnglish') ?? true)),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: Provider.of<MyProvider>(context).mode,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      locale: Locale(Provider.of<MyProvider>(context).local),
      routes: {
        Splash.routeName: (_) => const Splash(),
        Home.routeName: (_) => const Home(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
        EditTask.routeName: (_) => const EditTask(),
      },
      initialRoute: Home.routeName,
    );
  }
}
