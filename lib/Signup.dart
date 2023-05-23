import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'loginpage.dart';

class signup extends StatefulWidget {
  const signup({Key? key, required Text title}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var key = GlobalKey<FormState>();
  bool pwdvisible = true;

  TextEditingController name = TextEditingController();
  TextEditingController mailsign = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  final collection = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up Page',
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/5307.jpg'), fit: BoxFit.fitHeight)),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment:  CrossAxisAlignment.center,

                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: GradientText("Welcome to Gadgetronics Signup",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        gradientType: GradientType.radial,
                        radius: 5,
                        colors: [
                          Colors.purple,
                          Colors.orange,
                          Colors.green,
                          Colors.red,
                          Colors.blue,
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: name,
                      textInputAction: TextInputAction.next,
                      // inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],

                      validator: (k2) {
                        if (k2!.trim().isEmpty) {
                          return "Provide User-Name";
                        }  if (k2.contains(' ')) {
                          return 'Name cannot contain whitespace';
                        }
                        else if (k2.trim().length < 2) {
                          return "provide Proper User-Name";
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.people),
                        hintText: "Enter Name",
                        labelText: "Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: mailsign,
                      textInputAction: TextInputAction.next,


                      validator: (key) {
                        if (key!.trim().isEmpty) {
                          return 'Write Email Id';
                        }  if (key.contains(' ')) {
                          return 'Remove whitespace';
                        }
                        else if (!key.contains('@gmail.com') ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(key)) {
                          return "Write valid Email ID";
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        hintText: "Enter E-mail",
                        labelText: "E-mail",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,

                      controller: mobile,
                      validator: (k2) {
                        if (k2!.trim().isEmpty) {
                          return "Enter Mobile number";
                        } else if (k2.length > 10 || k2.length < 10) {
                          return "enter valid number";
                        }else if (!RegExp(r"^[6789]\d{9}$").hasMatch(k2)) {
                          return 'Please enter a valid Indian mobile number';
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mobile_friendly),
                        hintText: "Enter Mobile No.",
                        labelText: "Mobile NO",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: pwdvisible,
                      controller: password,
                      validator: (k2) {
                        if (k2!.trim().isEmpty) {
                          return "write something";
                        }  if (k2.contains(' ')) {
                          return 'Password cannot contain whitespace';
                        }
                        else if (k2.trim().length < 6) {
                          return "password must be minimum 5 characters";
                        } else if (!RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(k2)) {
                          return "Password should contain Capital, small letter & Number & Special";
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                pwdvisible = !pwdvisible;
                              });
                            },
                            icon: Icon(pwdvisible
                                ? Icons.visibility_off
                                : Icons.visibility)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton.icon(
                          icon: Icon(Icons.account_circle_rounded),
                          onPressed: () async {
                            if (key.currentState!.validate()) {
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: mailsign.text,
                                        password: password.text);

                                collection
                                    .collection("user")
                                    .doc(FirebaseAuth
                                        .instance.currentUser?.phoneNumber)
                                    .set({
                                  "name": name.text,
                                  "phonenumber": mobile.text,
                                  "password": password.text,
                                  "Mail": mailsign.text,
                                  "userrid":
                                      FirebaseAuth.instance.currentUser?.uid,
                                }).whenComplete(() =>  ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                  Text("User Successfully Created"),
                                ))).whenComplete(() => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Loginpage(title: "Login Page"))));



                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'Successful Signup') {
                                  debugPrint("User successfully signup");
                                  const snackBar = SnackBar(
                                      content:
                                          Text("User successfully signup"));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  name.clear();
                                  mobile.clear();
                                  print("User have created account");
                                } else if (e.code == 'weak-password') {
                                  debugPrint(
                                      'The password provided is too weak');
                                  const snackbar = SnackBar(
                                      content: Text(
                                          'The password provided is too weak'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                  password.clear();
                                } else if (e.code == 'email-already-in-use') {
                                  const snackbar = SnackBar(
                                      content: Text('email-already-in-use '));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                  mailsign.clear();
                                }
                              }
                            }
                          },
                          label: Text('Sign UP')),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "if you have account ?",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Loginpage(title: "Login Page")));
                        },
                        label:
                            Text('click here', style: TextStyle(fontSize: 20)),
                        icon: Icon(Icons.mail),
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
