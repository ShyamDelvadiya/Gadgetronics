import 'package:admin/forgetpassword.dart';
import 'package:admin/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'Signup.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key, required this.title});

  final String title;

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  var k1 = GlobalKey<FormState>();
  bool pwdvisi = true;
  TextEditingController mail = TextEditingController();
  TextEditingController pwd = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 50,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/login.jpg'),
              fit: BoxFit.cover,
            )),
        child: Center(
          child: Form(
            key: k1,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: GradientText(
                      "Welcome To Admin Login",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      gradientType: GradientType.radial,
                      radius: 6,
                      colors: [
                        Colors.orange,
                        Colors.red,
                        Colors.black,
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: TextFormField(
                        style:
                        const TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 20),
                        // autovalidateMode: AutovalidateMode.always,

                        validator: (key) {
                          if (key == null || key.isEmpty) {
                            return 'Write EMail Id';
                          } else if (!key.contains('@gmail.com') ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(key)) {
                            return "Write valid Email ID";
                          }
                        },
                        controller: mail,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          hintText: "Enter E-mail",
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                      obscureText: pwdvisi,
                      controller: pwd,
                      validator: (key) {
                        if (key!.isEmpty || key == null) {
                          return 'write something';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: "Enter Password",
                          labelText: "Password",
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  pwdvisi = !pwdvisi;
                                });
                              },
                              icon: Icon(pwdvisi
                                  ? Icons.visibility_off
                                  : Icons.visibility))),
                    ),
                  ),
                  Container(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (
                                        context) => const forgetpassword()));
                          },
                          child: const Text("Forgot Password?"))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.login),
                        onPressed: () async {
                          if (k1.currentState!.validate()) {
                            try {

                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                  email: mail.text, password: pwd.text)
                                  .then((value) =>
                                  ScaffoldMessenger.of(
                                      context)
                                      .showSnackBar(const SnackBar(
                                      content:
                                      Text("User Login Successfully"))));
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const homepage()));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                debugPrint('No user found for that email');
                                const snackbar = SnackBar(
                                    content:
                                    Text('No user found for that email'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                                mail.clear();
                              } else if (e.code == 'wrong-password') {
                                debugPrint('Wrong password ');
                                const snackbar =
                                SnackBar(content: Text('Wrong password '));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                                pwd.clear();
                              }
                            }
                          }
                        },
                        label: const Text("Login"),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const signup(
                                    title: Text(""),
                                  )));
                        },
                        label: const Text('click here'),
                        icon: const Icon(Icons.mail),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
