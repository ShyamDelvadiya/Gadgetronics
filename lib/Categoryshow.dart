import 'dart:math';

import 'package:admin/Model%20class/categoryclass.dart';
import 'package:admin/drawer.dart';
import 'package:admin/method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CategoryUpdate.dart';
import 'homepage.dart';

class CategoryShow extends StatefulWidget {
  const CategoryShow({Key? key}) : super(key: key);

  @override
  State<CategoryShow> createState() => _CategoryShowState();
}

class _CategoryShowState extends State<CategoryShow> {
  method ref = method();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Random random = Random();


  Future<bool> _onWillpop() async {
    return await Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => homepage()), (route) => false);
  }

  CategoryDeleteDialogbox({required String Id}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Are Your Sure You Want to  Delete This Category?"),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            print("categoryId:-${Id}");
                            ref.DeleteCategory(Id)
                                .whenComplete(() =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text("Category Removed"))))
                                .whenComplete(() => Navigator.pop(context));
                          });
                        },
                        child: Text("Yes")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("No")),
                  ),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillpop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Category Show"),
          centerTitle: true,
        ),
        drawer: Navidrawer(),
        // backgroundColor: Colors.blueGrey,
        body: Center(
          child: Container(
            child: FutureBuilder<List<addcategoryclass>>(
              future: ref.logos(),
              builder: (context, snapshot) {
                print("hi${snapshot.hasData}");
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            child: ListTile(
                              title: Text(
                                "categorires:-${snapshot.data![i].categories.toString()}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sub-Category:-${snapshot.data![i].brand.toString()}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  // Text(
                                  //   "Description:-${snapshot.data![i].Description.toString()}",
                                  //   style:const TextStyle(
                                  //       fontWeight: FontWeight.bold, fontSize: 20),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Logo:-",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              height: 200,
                                              width: 100,
                                              child: Image.network(
                                                snapshot.data![i].photo
                                                    .toString(),
                                                fit: BoxFit.fill,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            CategoryDeleteDialogbox(
                                                Id: snapshot.data![i].Id
                                                    .toString());
                                          },
                                          child: Text("Delete")),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryUpdate(
                                              Category:snapshot.data![i].categories.toString(),
                                              SubCategory:snapshot.data![i].brand.toString(),
                                              Companyname:snapshot.data![i].companyname.toString(),
                                              Categoryid:snapshot.data![i].Id.toString(),
                                              Image:snapshot.data![i].photo.toString()
                                            )));
                                          },
                                          child: Text("UpdateDetails")),
                                    ],
                                  ),
                                ],
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
          // child: Text("User:-${user}"),
        ),
      ),
    );
  }
}
