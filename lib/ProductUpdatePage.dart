import 'package:admin/homepage.dart';
import 'package:admin/method.dart';
import 'package:admin/particularProducts.dart';
import 'package:admin/productshow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import 'Categoryshow.dart';

class ProductUpdatePage extends StatefulWidget {
  ProductUpdatePage(
      {Key? key,
      this.Category,
      this.SubCategory,
      this.Company,
      this.Description,
      this.Discount,
      this.price,
      this.Id})
      : super(key: key);

  String? Category;
  String? SubCategory;
  String? Company;
  String? Description;
  String? Discount;
  String? price;
  String? Id;

  @override
  State<ProductUpdatePage> createState() => _ProductUpdatePageState();
}

class _ProductUpdatePageState extends State<ProductUpdatePage> {
  @override
  void initState() {
    category.text = widget.Category!;
    subcategory.text = widget.SubCategory!;
    company.text = widget.Company!;
    description.text = widget.Description!;
    discount.text = widget.Discount!;
    price.text = widget.price!;
    id = widget.Id!;

    super.initState();
  }

  TextEditingController category = TextEditingController();
  TextEditingController subcategory = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController price = TextEditingController();
  String? id;
  method ref = method();
  final multicollection = FirebaseFirestore.instance.collection("Product");
  var key = GlobalKey<FormState>();
  List<String> file = [];
  bool _isloading = false;
  bool _isupdatingimage = false;

  //method For Updating ProductDetails

  Future<void> updateproductDetails() async {
    try {
      await multicollection.doc(id).update({
        "Category": category.text,
        "Sub-category": subcategory.text,
        "decription": description.text,
        "price": price.text,
        "Discount": discount.text,
        "Company": company.text,
      }).whenComplete(() => ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Details Updated"))));
    } on FirebaseException catch (e) {
      print("Issue ON Updating:-$e");
    }
  }

  Future<void> updateproductphotoDetails(
      {required String id, required List<String> imagelist}) async {
    try {
      await multicollection.doc(id).update({
        "photos": imagelist,
      }).whenComplete(() => ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Photos Updated"))));
    } on FirebaseException catch (e) {
      print("Issue ON Updating:-$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          child: ElevatedButton.icon(
              onPressed: () {
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
                    updateproductDetails().whenComplete(() =>
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const seeallproducts()),
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
              label: _isloading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Updating...",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
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
                      "Update",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent),
                    ))),
      appBar: AppBar(
        title: const Text("Update Products"),
        centerTitle: true,
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
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  controller: category,
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
                  controller: subcategory,
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
                  controller: company,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: description,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  validator: (k1) {
                    if (k1!.isEmpty) {
                      return "Provide Description";
                    }
                  },
                  decoration: const InputDecoration(
                    // fillColor: Colors.lightBlueAccent,

                    // hoverColor: Colors.white,
                    // filled: true,
                    labelText: "Description",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (k1) {
                    if (k1!.isEmpty) {
                      return "Provide the discount price";
                    }
                    if (k1.contains(' ')) {
                      return 'Cannot contain whitespace';
                    }
                  },
                  controller: discount,
                  decoration: const InputDecoration(
                    labelText: "Discount",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.phone,
                  validator: (k1) {
                    if (k1!.isEmpty) {
                      return "Provide the price";
                    }
                    if (k1.contains(' ')) {
                      return 'Cannot contain whitespace';
                    }
                  },
                  controller: price,
                  decoration: const InputDecoration(
                    labelText: "Price",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    // primary: Colors.black,
                    // foregroundColor: Colors.green,
                  ),
                  onPressed: () {
                    ref.selectmultipleimage().then((value) => setState(() {}));
                  },
                  icon: const Icon(Icons.photo),
                  label: const Text("Select Multiple images")),
              (ref.imglist.isEmpty)
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
                      // margin: const EdgeInsets.all(),
                      // color: Colors.red,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.black,
                      )),
                      height: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemCount: ref.imglist.length,
                          itemBuilder: (BuildContext context, int index) {
                            print("object${ref.imglist.length}");

                            return Image.file(
                              File(ref.imglist[index].path),
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                        // ),
                      ),
                    ),
              ElevatedButton.icon(
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      setState(() {
                        _isupdatingimage =true;
                      });
                      Future.delayed(const Duration(seconds: 20),() {
                        setState(() {
                          _isupdatingimage=false;
                        });
                      },);
                      key.currentState!.save();
                      for (int i = 0; i < ref.imglist.length; i++) {
                        String url = await ref.uploadFile(ref.imglist[i]);
                        file.add(url);
                        if (i == ref.imglist.length - 1) {
                          setState(() {
                            updateproductphotoDetails(
                                    id: widget.Id.toString(), imagelist: file)
                                .whenComplete(() =>
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const seeallproducts()),
                                        (route) => false));
                          });
                        }
                      }
                    }
                    if (file.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text("Select Image"),
                        action: SnackBarAction(
                            label: "ok",
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            }),
                      ));
                    }

                  },
                  icon: const Icon(
                    Icons.update_sharp,
                    color: Colors.orangeAccent,
                  ),
                  label: _isupdatingimage? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Updating...",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      SizedBox(width: 10,),
                      CircularProgressIndicator(color: Colors.white,),
                    ],
                  ):
                  const Text(
                    "Update Images",
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
