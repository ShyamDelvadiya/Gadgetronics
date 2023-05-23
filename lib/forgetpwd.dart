import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loginpage.dart';


class forgotpwd extends StatefulWidget {
  const forgotpwd({Key? key}) : super(key: key);

  @override
  State<forgotpwd> createState() => _forgotpwdState();
}

class _forgotpwdState extends State<forgotpwd> {
  final gmail = TextEditingController();
  var email = "";
  var key = GlobalKey<FormState>();


  resetpwd() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
              content:Text("password is sent on your email",style: TextStyle(fontSize: 18),),


          ));
    } on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found') {
        print("No user found for that mail.");
        ScaffoldMessenger.of(context)
            .showSnackBar(
            SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text("No user found",style: TextStyle(fontSize: 18),)));

      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(key: key,
        child: Column(
          children: [

            Container(
              height: 90,
            ),
            Container(
                child: Text(
                  "Enter your registered mail below",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Container(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (k1) {
                  if (k1!.isEmpty) {
                    return "Write something";
                  }
                },
                controller: gmail,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.mail),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (key.currentState!.validate()) {
                    setState(() {
                      email = gmail.text;
                    });
                    resetpwd();
                  }
                },
                child: Text("Send Password")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Now click here to login",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Loginpage(title: "Login")));
                    },
                    child: Text(
                      "Login",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
