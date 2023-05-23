import 'package:Gadgatronics/userdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'HelpCenter.dart';
import 'Model Class/userdetailsclass.dart';
import 'MyOrdersPage.dart';
import 'Signup.dart';
import 'bottomnavibar.dart';
import 'cart.dart';
import 'loginpage.dart';
import 'method.dart';

class useraccount extends StatefulWidget {
  const useraccount({Key? key}) : super(key: key);

  @override
  State<useraccount> createState() => _useraccountState();
}

class _useraccountState extends State<useraccount> {
  method ref = method();
  final FirebaseAuth user = FirebaseAuth.instance;

  logout() async {
    await user.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Loginpage(title: "User Login")),
        (route) => false);
  }

  logoutdialogbox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Are you sure you want to logout?"),
          actions: [
            ElevatedButton(
                onPressed: () {
                  logout();
                },
                child: Text("Logout")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GradientText(
          "Gadgetronics",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          colors: [
            Colors.black,
            Colors.brown,
            Colors.redAccent,
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container(height: 100,
            //   ),
            Container(
              height: 50,
              child: FutureBuilder<List<userdetailmodel>>(
                future: ref.showuserdetails().then((value) =>value
                    .where((element) =>
                        element.Uid == FirebaseAuth.instance.currentUser?.uid)
                    .toList()),
                builder: (context, snapshot) {
                  print("hi${snapshot.hasData}");
                  if (snapshot.data?.length == null) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        TextButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                          builder: (context) =>
                                              signup(title: Text("Signup")))
                                      as String,
                                  (route) => false);
                            },
                            child: Text(
                                "Make An Account To Use full App Services")),
                      ],
                    );
                  }

                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          final item = snapshot.data?[i];
                          ref.showuserdetails();

                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 10,
                                ),
                                Text(
                                  "Hi ${snapshot.data![i].Name.toString()} how are you?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOrders()));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        foregroundColor: Colors.black,
                      ),
                      icon: Icon(Icons.bookmark_border_sharp),
                      label: Text(
                        "My Orders",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => bottomnavibar(
                                      selectedindex: 0,
                                    )));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        foregroundColor: Colors.black,
                      ),
                      icon: Icon(Icons.shop),
                      label: Text(
                        "Shop Again",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => bottomnavibar(
                                          selectedindex: 2,
                                        )));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            foregroundColor: Colors.black,
                          ),
                          icon: Icon(Icons.shopping_cart),
                          label: Text(
                            "Your Wishlist",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => helpcenter()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      foregroundColor: Colors.black,
                    ),
                    icon: Icon(Icons.help_center),
                    label: Text(
                      "Help Center",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: 100,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account Setting",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => userdetails()));
                            },
                            icon: Icon(Icons.account_circle),
                            label: Text("My Profile")),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton.icon(
                            onPressed: () {
                              logoutdialogbox();
                            },
                            icon: Icon(Icons.logout),
                            label: Text("Logout")),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
