import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'bottomnavibar.dart';
import 'loginpage.dart';
// import 'package:splashscreen/splashscreen.dart';

final user = FirebaseAuth.instance.currentUser;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gadgatronics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/playstore.png'),
          // splash: Image.network(
          //     'https://generated-icons.nyc3.cdn.digitaloceanspaces.com/images/a504404b-ca1b-4e05-a0d0-3f4f1bd6d13d.png?timestamp=1678438504652'
          //         ),
          splashIconSize: 200,
          splashTransition: SplashTransition.fadeTransition,
          duration: 3000,
          nextScreen:
              user == null ? const Loginpage(title: 'Login Page') : bottomnavibar(selectedindex: 0,)),
    );
  }
}
//