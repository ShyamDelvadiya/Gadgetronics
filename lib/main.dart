import 'package:admin/login.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'homepage.dart';

final user = FirebaseAuth.instance.currentUser;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter ',
        theme: ThemeData.dark(
          // primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(

          splash:
              Image.asset('asset/playstore.png', alignment: Alignment.center),

          duration: 5000,
          splashIconSize: 300,
          splashTransition: SplashTransition.fadeTransition,
          nextScreen:
              user == null ? const Loginpage(title: 'Admin') : homepage(),
        ));
  }
}
