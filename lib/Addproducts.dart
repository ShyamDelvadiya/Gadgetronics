//this file is for adding multiple data and images
import 'dart:math';
import 'dart:io';

import 'package:admin/drawer.dart';
import 'package:admin/homepage.dart';
import 'package:admin/method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import 'Model class/categoryclass.dart';

class multipleData extends StatefulWidget {
  const multipleData({Key? key}) : super(key: key);

  @override
  State<multipleData> createState() => _multipleDataState();
}

class _multipleDataState extends State<multipleData> {
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController discount = TextEditingController();
  method ref = method();
  var key = GlobalKey<FormState>();
  List<String> file = [];
  TextEditingController addcatagoryController = new TextEditingController();
  TextEditingController addcompanyController = new TextEditingController();
  TextEditingController addsubcatagoryController = new TextEditingController();
  bool _isloading = false;
  bool _isUpdateingimage = false;

  // late List<addcategoryclass> allcategorydata;
  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedCompanyname;
  String selectedmultiplecatagory = "";
  String selectedmultipleSubcatagory = "";
  String selectedmultipleCompany = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Products"),
      ),
      drawer: Navidrawer(),
      // backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: key,
            child: Column(
              children: [
                Container(
                  height: 30,
                ),

                FutureBuilder<List>(
                  future: ref.showCategories(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Select Product category"),
                            ),
                            InputDecorator(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                              isEmpty: selectedCategory == null,

                              // for multiple selection
                              // child: TextField(
                              //   readOnly: true,
                              //   controller: addcatagoryController,
                              //   onTap: () async{
                              //     await _showMultiSelectcategory(context, snapshot.data!);
                              //   },
                              // ),
                              child: DropdownButtonFormField(
                                value: selectedCategory,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedCategory = newValue;
                                    selectedSubCategory = null;
                                    selectedCompanyname = null;

                                    print(
                                        "selectProductCategory${selectedCategory}");
                                  });
                                },
                                items: snapshot.data!
                                    .map((e) => DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(
                                          e,
                                          style: const TextStyle(fontSize: 14),
                                        )))
                                    .toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return "Select a category";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            if (selectedCategory != null)
                              FutureBuilder<List>(
                                future:
                                    ref.showSubCategories(selectedCategory!),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CupertinoActivityIndicator(),
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                                "Select Product Sub-category"),
                                          ),
                                          InputDecorator(
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder()),
                                            isEmpty:
                                                selectedSubCategory == null,
                                            // for multiple select
                                            //  child: TextField(
                                            //    readOnly: true,
                                            //    controller: addsubcatagoryController,
                                            //    onTap: (){
                                            //      _showmultiSubcategory(context,snapshot.data!);
                                            //    },
                                            //  ),

                                            child: DropdownButtonFormField(
                                              value: selectedSubCategory,
                                              isDense: true,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedSubCategory =
                                                      newValue;
                                                  selectedCompanyname = null;
                                                  print(
                                                      "selectProductCategory${selectedSubCategory}");
                                                });
                                              },
                                              items: snapshot.data!
                                                  .map((e) =>
                                                      DropdownMenuItem<String>(
                                                          value: e,
                                                          child: Text(
                                                            e,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        14),
                                                          )))
                                                  .toList(),
                                              validator: (value) {
                                                if (value == null) {
                                                  return "Select a Sub-category";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          if (selectedSubCategory != null)
                                            FutureBuilder<List>(
                                              future: ref.showCompanyName(
                                                  selectedSubCategory!),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {
                                                  return const CupertinoActivityIndicator();
                                                }
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                              "Select Company Name"),
                                                        ),
                                                        InputDecorator(
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder()),
                                                          isEmpty:
                                                              selectedCompanyname ==
                                                                  null,
                                                          // for selecting multiple choice
                                                          //  child: TextField(
                                                          //    readOnly: true,
                                                          //    controller: addcompanyController,
                                                          //    onTap: (){
                                                          //      _showmultiCompany(context, snapshot.data!);
                                                          //    },
                                                          //  ),
                                                          child:
                                                              DropdownButtonFormField(
                                                            value:
                                                                selectedCompanyname,
                                                            isDense: true,
                                                            items: snapshot
                                                                .data!
                                                                .map((e) => DropdownMenuItem<
                                                                        String>(
                                                                    value: e,
                                                                    child: Text(
                                                                      e,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                    )))
                                                                .toList(),
                                                            validator: (value) {
                                                              if (value ==
                                                                  null) {
                                                                return "Select Company name";
                                                              }
                                                            },
                                                            onChanged:
                                                                (newvalue) {
                                                              setState(() {
                                                                selectedCompanyname =
                                                                    newvalue;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    minLines: 4,
                    controller: description,
                    style: const TextStyle(fontSize: 35),
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
                      // hintText: "Description.....",
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
                    style: const TextStyle(fontSize: 35),
                    textInputAction: TextInputAction.next,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: const TextStyle(fontSize: 35),
                    keyboardType: TextInputType.phone,
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

                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      // primary: Colors.black,
                      // foregroundColor: Colors.green,
                    ),
                    onPressed: () {
                      ref
                          .selectmultipleimage()
                          .then((value) => setState(() {}));
                    },
                    icon: const Icon(Icons.photo),
                    label: const Text("Select Multiple images")),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child:  (ref.photo==null) ? Container(
                //
                //     decoration: BoxDecoration(
                //         border: Border.all(color: Colors.black,width: 3)
                //     ),
                //     alignment: Alignment.center,
                //     // color: Colors.red,
                //     width: 500,
                //     height: 500,
                //     child: Text("Select an image",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                //   ) :

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
                          color: Colors.white,
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

                // ElevatedButton(onPressed: ()async{
                // }, child: Text("Submit")),

                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        // primary: Colors.black,
                        // foregroundColor: Colors.green,
                      ),
                      onPressed: () async {
                        int random = Random().nextInt(10000);
                        String id =
                            "$random${DateTime.now().microsecondsSinceEpoch}";
                        if (selectedCategory == null &&
                            selectedSubCategory == null &&
                            selectedCompanyname == null &&
                            description.text.isEmpty &&
                            price.text.isEmpty &&
                            discount.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Select All fields to Continue")));
                        } else if (ref.imglist.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Select Image")));
                        } else {
                          setState(() {
                            _isloading = true;
                          });
                          Future.delayed(const Duration(seconds: 7), () {
                            setState(() {
                              _isloading = false;
                            });
                          });
                        }

                        if (key.currentState!.validate()) {
                          key.currentState!.save();
                          for (int i = 0; i < ref.imglist.length; i++) {
                            String url = await ref.uploadFile(ref.imglist[i]);
                            file.add(url);
                            if (i == ref.imglist.length - 1) {
                              if (await ref.multidata(
                                description.text,
                                file,
                                selectedCategory!,
                                selectedSubCategory!,
                                price.text,
                                discount.text,
                                selectedCompanyname!,
                              )) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const homepage())).then((value) =>  ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                    content: Text("Data Uploaded"))));

                              }
                              if (await ref.checkifproductExists(
                                  selectedCategory!, selectedSubCategory!)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Data Already exists")));
                              }

                              print("xyz${file}");
                            }
                          }
                        }
                        print("asd${selectedCategory}");
                        print("subcate${selectedSubCategory}");

                        // description.clear();
                        // price.clear();
                        // discount.clear();
                        // imageCache.clear();
                        // setState(() {
                        //   selectedCategory=null;
                        //   selectedSubCategory=null;
                        //
                        // });
                      },
                      child: _isloading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Uploading data...",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
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
                              "Upload",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // _showMultiSelectcategory(BuildContext context, items) async {
  //   List<MultiSelectItem<String>> dropdownmenu = [];
  //   for (int i = 0; i < items.length; i++) {
  //     dropdownmenu!.add(MultiSelectItem(items[i], items[i]));
  //   }
  //   await showDialog(
  //     context: context,
  //     builder: (ctx) {
  //       return MultiSelectDialog(
  //           items: dropdownmenu!,
  //           onConfirm: (values) {
  //             values.removeAt(0);
  //             selectedmultiplecatagory = (values).join("/");
  //             addcatagoryController.text = selectedmultiplecatagory!;
  //           },
  //           initialValue: [""]);
  //     },
  //   );
  // }
  //
  // _showmultiSubcategory(BuildContext context, item) async {
  //   List<MultiSelectItem<String>> dropdownmenu = [];
  //   for (int i = 0; i < item.length; i++) {
  //     dropdownmenu!.add(MultiSelectItem(item[i], item[i]));
  //   }
  //   await showDialog(
  //       context: context,
  //       builder: (ctx) {
  //         return MultiSelectDialog(
  //             items: dropdownmenu,
  //             onConfirm: (values) {
  //               values.removeAt(0);
  //               selectedmultipleSubcatagory = (values).join("/");
  //               addsubcatagoryController.text = selectedmultipleSubcatagory!;
  //             },
  //             initialValue: [""]);
  //       });
  // }
  //
  // _showmultiCompany(BuildContext context, item) async {
  //   List<MultiSelectItem<String>> dropdownmenu = [];
  //   for (int i = 0; i < item.length; i++) {
  //     dropdownmenu!.add(MultiSelectItem(item[i], item[i]));
  //   }
  //   await showDialog(
  //       context: context,
  //       builder: (ctx) {
  //         return MultiSelectDialog(
  //             items: dropdownmenu,
  //             separateSelectedItems: true,
  //             onConfirm: (List<String> values) {
  //               setState(() {
  //                 // selectedmultipleCompany = values as String;
  //                 values.removeAt(0);
  //                 selectedmultipleCompany = (values).join("/");
  //                 addcompanyController.text = selectedmultipleCompany!;
  //               });
  //             },
  //             initialValue: [""]);
  //       });
  // }
}
