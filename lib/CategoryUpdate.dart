import 'package:admin/method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'Categoryshow.dart';
import 'homepage.dart';

class CategoryUpdate extends StatefulWidget {
  CategoryUpdate(
      {Key? key,
      this.Category,
      this.SubCategory,
      this.Companyname,
      this.Categoryid,
      this.Image})
      : super(key: key);
  String? Category;
  String? SubCategory;
  String? Companyname;
  String? Categoryid;
  String? Image;

  @override
  State<CategoryUpdate> createState() => _CategoryUpdateState();
}

class _CategoryUpdateState extends State<CategoryUpdate> {
  @override
  void initState() {
    category.text = widget.Category!;
    subcategory.text = widget.SubCategory!;
    companyname.text = widget.Companyname!;

    // TODO: implement initState
    super.initState();
  }

  TextEditingController category = TextEditingController();
  TextEditingController subcategory = TextEditingController();
  TextEditingController companyname = TextEditingController();
  method ref = method();
  var key = GlobalKey<FormState>();
  final collection = FirebaseFirestore.instance.collection("Categories");
  bool _isloading = false;

  // bool imagepicker=true;

  Future<void> updateCategoryDetails({
    required String id,
  }) async {
    try {
      await collection.doc(id).update({
        "categories": category.text,
        "Brand": subcategory.text,
        "CompanyName": companyname.text,
      }).whenComplete(() => ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Details Updated"))));
    } on FirebaseException catch (e) {
      print("Issue ON Updating:-$e");
    }
  }

  Future<void> updateCategoryphotoDetails(
      {required String id, required String? imageUrl}) async {
    try {
      await collection.doc(id).update({
        "Photo": imageUrl,
      }).whenComplete(() => ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("photo Updated"))));
    } on FirebaseException catch (e) {
      print("Issue ON Updating:-$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton.icon(
            onPressed: () async {
              setState(() {
                _isloading = true;
              });
              Future.delayed(const Duration(seconds: 10), () {
                setState(() {
                  _isloading = false;
                });
              });
              if (key.currentState!.validate()) {
                setState(() {
                  updateCategoryDetails(
                    id: widget.Categoryid.toString(),
                  ).whenComplete(() => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const CategoryShow()),
                      (route) => false));
                });
              }
            },
            icon: const Icon(
              Icons.update_sharp,
              color: Colors.orangeAccent,
            ),
            label: _isloading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Uploading...",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircularProgressIndicator(
                        color: Colors.white,
                      )
                    ],
                  )
                : const Text(
                    "Update",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent),
                  )),
      ),
      appBar: AppBar(
        title: const Text("Category Update"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [
              Container(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  controller: category,
                  validator: (k1) {
                    if (k1!.isEmpty) {
                      return "Provide Category";
                    }
                    if (k1.contains(' ')) {
                      return 'Cannot contain whitespace';
                    }

                    if (!RegExp(r'^[A-Z][a-zA-Z ]+$').hasMatch(k1)) {
                      return "write first letter capital";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.lightBlueAccent,

                    // hoverColor: Colors.white,
                    filled: false,
                    labelText: "Categories",

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  controller: subcategory,
                  validator: (k1) {
                    if (k1!.isEmpty) {
                      return "Provide Sub-Category";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.lightBlueAccent,
                    filled: false,
                    labelText: "Sub-category",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  controller: companyname,
                  validator: (k1) {
                    if (k1!.isEmpty) {
                      return "Provide CompanyName";
                    }
                    if (k1.contains(' ')) {
                      return 'Cannot contain whitespace';
                    }
                    if (!RegExp(r'^[A-Z][a-zA-Z ]+$').hasMatch(k1)) {
                      return "write first letter capital";
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.lightBlueAccent,
                    filled: false,
                    // hintText: "",
                    labelText: "Company Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    // backgroundColor: Colors.black,
                    // foregroundColor: Colors.deepPurple,
                  ),
                  onPressed: () {
                    ref.openimagepicker().then((value) => setState(() {}));
                  },
                  label: const Text(
                    "Select an image",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  icon: const Icon(Icons.image)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: (ref.photo == null)
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 3)),
                        alignment: Alignment.center,
                        // color: Colors.red,
                        width: 500,
                        height: 500,
                        child: const Text(
                          "Select an image",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(
                        // decoration: BoxDecoration(border: Border.all()),
                        alignment: Alignment.center,
                        width: 400,
                        height: 300,
                        color: Colors.white,
                        child: Image.file(ref.photo!, fit: BoxFit.fill)),
              ),
              ElevatedButton.icon(
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      await ref.Storage!.putFile(ref.photo!);
                      ref.singleImgUrl = await ref.Storage!.getDownloadURL();
                      setState(() {
                        updateCategoryphotoDetails(
                          id: widget.Categoryid.toString(),
                          imageUrl: ref.singleImgUrl,
                        ).whenComplete(() => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CategoryShow()),
                            (route) => false));
                      });
                    } else {
                      return null;
                    }
                  },
                  icon: const Icon(
                    Icons.update_sharp,
                    color: Colors.orangeAccent,
                  ),
                  label: const Text(
                    "Update Image",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
