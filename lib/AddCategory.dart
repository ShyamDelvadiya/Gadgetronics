// this file is for adding single image and details
import 'dart:io';

import 'package:admin/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';
import 'method.dart';

class addcategory extends StatefulWidget {
  const addcategory({Key? key}) : super(key: key);

  @override
  State<addcategory> createState() => _addcategoryState();
}

class _addcategoryState extends State<addcategory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController categories = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController CompanyName = TextEditingController();
  var validators = GlobalKey<FormState>();
  method ref = method();
  bool _isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
      ),
      drawer: Navidrawer(),
      // backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Form(
          key: validators,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  controller: categories,
                  validator: (k1) {
                    if (k1!.isEmpty) {
                      return "write something";
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
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  controller: brand,
                  validator: (k1) {
                    if (k1!.isEmpty) {
                      return "Provide Sub-Category";
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
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  controller: CompanyName,
                  validator: (k1) {
                    if (k1!.isEmpty) {
                      return "write something";
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
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    // primary: Colors.black,
                    // foregroundColor: Colors.deepPurple,
                  ),
                  onPressed: () async {
                    if (ref.photo == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Image is not selected")));
                    }

                    if (validators.currentState!.validate()) {
                      setState(() {
                        _isloading = true;
                      });
                      Future.delayed(const Duration(seconds: 5), () {
                        setState(() {
                          _isloading = false;
                        });
                      });
                      ref
                          .addcategory(
                              categories.text, brand.text, CompanyName.text)
                          .whenComplete(() => ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Text("Details Added"))))
                          .whenComplete(() => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const homepage())));

                      // ref.checkifDetailsExists(brand.text,categories.text);
                    }
                  },
                  child: _isloading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Uploading...",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ],
                        )
                      : const Text(
                          "submit",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30,),
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
