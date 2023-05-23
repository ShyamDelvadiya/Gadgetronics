import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'Signup.dart';
import 'bottomnavibar.dart';
import 'forgetpwd.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key, required this.title});


  final String title;

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  var k1 = GlobalKey<FormState>();
  bool pwdvis = true;

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


        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(widget.title),
        ),

      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/5307.jpg'), fit: BoxFit.fitHeight)
        ),
        child: Center(
          child: SingleChildScrollView(


            child: Form(

              key: k1,
              child: Column(


                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: GradientText("Welcome To Gadgetronics Login",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      gradientType: GradientType.radial,
                      radius: 6,
                      colors: const [
                        Colors.orange,
                        Colors.blue,
                        Colors.brown,
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
                        // autovalidateMode: AutovalidateMode.always,

                        validator: (key) {
                          if (key == null ||
                              key.isEmpty
                          ) {
                            return 'Write Email Id';
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
                      obscureText: pwdvis,
                      controller: pwd,
                      validator: (key) {
                        if (key!.isEmpty) {
                          return 'Write password';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(onPressed: () {
                          setState(() {
                            pwdvis = !pwdvis;
                          });
                        }, icon: Icon(
                            pwdvis ? Icons.visibility_off : Icons.visibility)),

                        prefixIcon: const Icon(Icons.lock),
                        hintText: "Enter Password",
                        labelText: "Password",
                        border: const OutlineInputBorder(),

                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const forgotpwd()));
                          }, child: const Text("Forgot Password?"))),
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
                                  .whenComplete(() =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text(
                                          "User Login Successfully"))));


                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) =>
                                      bottomnavibar(selectedindex: 0,)));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                debugPrint(
                                    'No user found for that email');
                                const snackbar = SnackBar(
                                    content: Text(
                                        'No user found for that email'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                                mail.clear();
                              } else if (e.code == 'wrong-password') {
                                debugPrint('Wrong password ');
                                const snackbar = SnackBar(
                                    content: Text('Wrong password '));
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
                      const Text("Don't have an account?",
                        style: TextStyle(
                          fontSize: 15,
                        ),

                      ),
                      TextButton.icon(onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) =>
                                const signup(title: Text('homepage'),)));
                      }, label: const Text('click here'), icon: const Icon(Icons.mail),),
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
