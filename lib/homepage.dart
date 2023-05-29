import 'dart:developer';
import 'dart:math';
import 'package:admin/AddCategory.dart';
import 'package:admin/Model%20class/admindetails.dart';
import 'package:admin/User%20Order%20Details.dart';
import 'package:admin/adminprofile.dart';
import 'package:admin/login.dart';
import 'package:admin/main.dart';
import 'package:admin/method.dart';
import 'package:admin/Addproducts.dart';
import 'package:admin/Categoryshow.dart';
import 'package:admin/productshow.dart';

import 'package:admin/homepage Banner show .dart';

import 'package:admin/usershow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'drawer.dart';
// import 'package:image_picker/image_picker.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final FirebaseAuth admin = FirebaseAuth.instance;
  method ref = method();

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

  //logout method
  logout() async {
    await admin.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Loginpage(title: "Admin Login")));
  }





  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit the app?'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:_onWillPop,
      child: Scaffold(
        appBar: AppBar(),
        // backgroundColor: Colors.blueGrey,

        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                // decoration: BoxDecoration(
                //     shape: BoxShape.rectangle,
                //     border: Border.all(
                //         color: Colors.yellowAccent,
                //         width: 2,
                //         style: BorderStyle.solid)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          primary: Colors.cyanAccent,
                          foregroundColor: Colors.black),
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => addcategory()));
                        });

                      },
                      child: Text(
                        "Add Category",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                // decoration: BoxDecoration(
                //     shape: BoxShape.rectangle,
                //     border: Border.all(color: Colors.yellowAccent, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          primary: Colors.cyanAccent,
                          foregroundColor: Colors.black),
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => multipleData()));
                        });

                      },
                      child: Text(
                        "Add Products",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                // decoration: BoxDecoration(
                //     shape: BoxShape.rectangle,
                //     border:
                //         Border.all(color: Colors.yellowAccent, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: Colors.cyanAccent,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryShow()));
                        });

                      },
                      child: Text(
                        "Category details",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              Container(
                width: 10,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  // decoration: BoxDecoration(
                  //     shape: BoxShape.rectangle,
                  //     border:
                  //         Border.all(color: Colors.yellowAccent, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: Colors.cyanAccent,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => usershow()));
                          });

                        },
                        child: Text(
                          'User Details',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        )),
                  )), Container(
                width: 10,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  // decoration: BoxDecoration(
                  //     shape: BoxShape.rectangle,
                  //     border:
                  //         Border.all(color: Colors.yellowAccent, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: Colors.cyanAccent,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserOrders()));

                          });
                        },
                        child: Text(
                          'User Order details',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        )),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  // decoration: BoxDecoration(
                  //     shape: BoxShape.rectangle,
                  //     border:
                  //         Border.all(color: Colors.yellowAccent, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: Colors.cyanAccent,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserHomeScreenImageShow()));

                          });
                        },
                        child: Text(
                          'User Home Screen Image',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        )),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  // decoration: BoxDecoration(
                  //     shape: BoxShape.rectangle,
                  //     border:
                  //         Border.all(color: Colors.yellowAccent, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: Colors.cyanAccent,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => seeallproducts()));

                          });
                        },
                        child: Text(
                          'Product Details',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        )),
                  )),

            ],
          ),
        ),

        drawer: Navidrawer(),
      ),
    );
  }
}

