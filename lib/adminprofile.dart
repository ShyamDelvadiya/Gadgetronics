import 'package:admin/method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Model class/admindetails.dart';
import 'drawer.dart';

class adminprofile extends StatefulWidget {
  const adminprofile({Key? key}) : super(key: key);

  @override
  State<adminprofile> createState() => _adminprofileState();
}

class _adminprofileState extends State<adminprofile> {
  method ref = method();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Navidrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                child: FutureBuilder<List<adminmodel>>(
                  future: ref.admindetails().then((value) => value
                      .where((element) =>
                          element.mail ==
                          FirebaseAuth.instance.currentUser?.email)
                      .toList()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.person),
                                    ),
                                    Text(
                                      "Name:-${snapshot.data![i].name.toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                const Divider(color: Colors.black,),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.mail),
                                    ),
                                    Text(
                                      "Mail:-${snapshot.data![i].mail.toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 20),
                                    ),
                                  ],
                                ),
                                const Divider(color: Colors.black,),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.phone),
                                    ),
                                    Text(
                                      "Phonenumber:-${snapshot.data![i].phonenumber.toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 20),
                                    ),
                                  ],
                                ),
                                const Divider(color: Colors.black,),

                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.lock),
                                    ),
                                    Text(
                                      "Password:-${snapshot.data![i].password.toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
