import 'dart:math';

import 'package:admin/drawer.dart';
import 'package:admin/homepage.dart';
import 'package:admin/particularProducts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Model class/productmodelclass.dart';
import 'method.dart';

class seeallproducts extends StatefulWidget {
  const seeallproducts({Key? key}) : super(key: key);

  @override
  State<seeallproducts> createState() => _seeallproductsState();
}

class _seeallproductsState extends State<seeallproducts> {
  method ref = method();
  final Random _random = Random();
  TextEditingController searchcontroller = TextEditingController();
  List<productmodelclass> allproducts = [];

  ProductDeleteDialogbox({required String Id}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Are Your Sure You Want to  Delete This Product"),
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            print("productId:-${Id}");
                            ref.DeleteProduct(Id)
                                .then((value) => ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                        SnackBar(content: Text("Product Deleted"),duration: Duration(milliseconds: 1000),)))
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

  Future<bool> _onWillpop() async {
    return await Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => homepage()), (route) => false);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillpop,
      child: Scaffold(
        drawer: Navidrawer(),
        appBar: AppBar(
          title: Text("All Products"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: 700,
              child: FutureBuilder<List<productmodelclass>>(
                future: ref.productsee(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        final color=Color.fromARGB(
                          255,
                          _random.nextInt(255),
                          _random.nextInt(255),
                          _random.nextInt(255),
                        );
                        var p = snapshot.data![i];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(

                            decoration: BoxDecoration(

                                shape: BoxShape.rectangle,
                                border: Border.all(color:color,width: 2)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Image.network(
                                          p.photos!.first.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                        height: 100,
                                      ),
                                      Text(p.SubCategories.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              ProductDeleteDialogbox(
                                                  Id: snapshot.data![i].productid
                                                      .toString());
                                            });
                                          },
                                          child: Text("Delete")),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        paticularProducts(
                                                          product:
                                                              snapshot.data![i],
                                                        )));
                                          },
                                          child: Text("Update")),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
