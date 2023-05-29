import 'package:admin/Model%20class/allusers.dart';
import 'package:admin/drawer.dart';
import 'package:admin/method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class usershow extends StatefulWidget {
  const usershow({Key? key}) : super(key: key);

  @override
  State<usershow> createState() => _usershowState();
}

class _usershowState extends State<usershow> {
  method ref = method();
  final Random random = Random();
  final Usercollection = FirebaseFirestore.instance.collection("user");

// Function to delete a user from Firebase Authentication using their email and password


  Future<void> deleteUser(String email, String password, String id) async {

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await Usercollection.doc(id)
          .delete()
          .whenComplete(() => userCredential.user?.delete())
          .whenComplete(() => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("User Deleted"))));


    print('User deleted successfully');
  }


  deleteuserdialogbox(
      {required String email, required String password, required String Id}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Do you want to remove User"),
          actions: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    deleteUser(email, password, Id);
                  });
                },
                child: Text("Yes")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No")),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Users"),
        centerTitle: true,
      ),
      drawer: Navidrawer(),
      // backgroundColor: Colors.blueGrey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: FutureBuilder<List<alluser>>(
              future: ref.showalluser(),
              builder: (context, snapshot) {
                print("hi${snapshot.hasData}");
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        final color = Color.fromARGB(
                          255,
                          random.nextInt(256),
                          random.nextInt(256),
                          random.nextInt(256),
                        );
                        return InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // color: color,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border:
                                    Border.all(color: Colors.black, width: 2),
                              ),
                              child: ListTile(
                                title: Text(
                                  "User name:-${snapshot.data![i].Name.toString()}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.lightBlue),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Mail:-${snapshot.data![i].Mail.toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      "Phone no:-${snapshot.data![i].phonenumber.toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    // Text(
                                    //   "User-id:-${snapshot.data![i].Userid.toString()}",
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 20),
                                    // ),
                                  ],
                                ),
                                trailing: Container(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            deleteuserdialogbox(
                                              email: snapshot.data![i].Mail
                                                  .toString(),
                                              password: snapshot
                                                  .data![i].password
                                                  .toString(),
                                              Id: snapshot
                                                  .data![i].usercollectionid
                                                  .toString(),
                                            );
                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                        ))),
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
        // child: Text("User:-${user}"),
      ),
    );
  }
}
