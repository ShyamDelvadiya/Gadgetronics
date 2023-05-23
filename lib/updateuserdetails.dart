import 'package:Gadgatronics/userdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'method.dart';

class userupdate extends StatefulWidget {
  userupdate(this.name, this.mail, this.password, this.Phonenumber, this.id,
      {Key? key})
      : super(key: key);
  String? name;
  String? mail;
  String? password;
  String? Phonenumber;
  String? id;

  @override
  State<userupdate> createState() => _userupdateState();
}

class _userupdateState extends State<userupdate> {
  TextEditingController Name = TextEditingController();
  TextEditingController Mail = TextEditingController();
  TextEditingController Phoneno = TextEditingController();
  TextEditingController Pwd = TextEditingController();
  var k = GlobalKey<FormState>();
  method ref = method();
  User? user = FirebaseAuth.instance.currentUser;
  bool _isUpdateing = false;

  Future<void> updateuser() async {
    try {
      await FirebaseFirestore.instance.collection("user").doc(Id).update({
        "Mail": Mail.text,
        "name": Name.text,
        "password": Pwd.text,
        "phonenumber": Phoneno.text,
      });
      await user!.updateEmail(Mail.text);
      await user!.updatePassword(Pwd.text);

      print("user details updated");
      const snackBar =
          SnackBar(content: Text("User Details are successfully updated"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on FirebaseException catch (e) {
      print("something went wrong $e");
    }
  }

  @override
  void initState() {
    Name.text = widget.name!;
    Mail.text = widget.mail!;
    Phoneno.text = widget.Phonenumber!;
    Pwd.text = widget.password!;
    Id = widget.id!;

    // TODO: implement initState
    super.initState();
  }

  final Usercollection = FirebaseFirestore.instance.collection("user");

  String? Id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Update your details here",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Form(
        key: k,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CircleAvatar(
                //   backgroundColor: Colors.red,
                //   radius: 200,
                // ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    controller: Name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Provide User-Name";
                      }
                      if (value.contains(' ')) {
                        return 'Name cannot contain whitespace';
                      }
                      if (value.length < 2) {
                        return "provide Proper Name";
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.people),
                      labelText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    controller: Mail,
                    validator: (key) {
                      if (key!.trim().isEmpty) {
                        return 'Write Email Id';
                      }
                      if (key.contains(' ')) {
                        return 'Remove whitespace';
                      }

                      if (!key.contains('@gmail.com') ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(key)) {
                        return "Write valid Email ID";
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.mail),
                        labelText: "Mail",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    controller: Pwd,
                    validator: (k2) {
                      if (k2!.isEmpty) {
                        return "Provide Password";
                      }
                      if (k2.contains(' ')) {
                        return 'Password cannot contain whitespace';
                      }
                      if (k2.length < 6) {
                        return "password must be minimum 5 characters";
                      }
                      if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          .hasMatch(k2)) {
                        return "Password should contain Capital, small letter & Number & Special";
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password),
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    controller: Phoneno,
                    validator: (k2) {
                      if (k2!.isEmpty) {
                        return "Enter Mobile number";
                      }
                      if (!RegExp(r"^[6789]\d{9}$").hasMatch(k2)) {
                        return 'Please enter a valid Indian mobile number';
                      }
                      if (k2.length > 10 || k2.length < 10) {
                        return "enter valid number";
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        labelText: "Phone no",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {
                      _isUpdateing = true;
                    });

                    Future.delayed(Duration(seconds: 10),(){
                      setState(() {
                        _isUpdateing=false;
                      });

                    });

                    if (k.currentState!.validate()) {
                      setState(() {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Your Details are updated"),
                          duration: Duration(milliseconds: 2000),
                        ));
                        updateuser().then((value) =>
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const userdetails()),
                                (route) => false));
                      });

                      // await Usercollection.doc(Id).update(
                      //   "name":Name.text,
                      //   "Mail":Mail.text,
                      //
                      // );
                    }
                  },
                  icon: _isUpdateing? Container(): const Icon(Icons.update),
                  label: _isUpdateing
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            LinearProgressIndicator(),
                          ],
                        )
                      : const Text('Update'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: Colors.black,
                    foregroundColor: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
