import 'package:Gadgatronics/particularProducts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Model Class/productshowmodelclass.dart';
import 'method.dart';


class categorypage extends StatefulWidget {
  categorypage({Key? key, this.selectedcategory}) : super(key: key);
  String? selectedcategory;

  @override
  State<categorypage> createState() => _categorypageState();
}

class _categorypageState extends State<categorypage> {
  @override
  void initState() {
    selectedCategory = widget.selectedcategory;
    // TODO: implement initState
    print("nnnnnn${widget.selectedcategory}");
    super.initState();
  }

  method ref = method();
  String? selectedCategory;
  TextEditingController searchcontroller = TextEditingController();
  List<productmodelclass> allproducts = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.selectedcategory.toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 23, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: TextFormField(
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  controller: searchcontroller,
                  onChanged: (v) {
                    setState(() {});
                  },
                  cursorColor: Colors.red,
                  decoration: InputDecoration(

                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.red,
                      size: 30,
                    ),

                    hintText: 'Search Company.....',
                    // labelText: 'Search',
                    // labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                ),
              ),
            ),

            Container(
              height: 20,
            ),
            (searchcontroller.text.isEmpty) ?
            SizedBox(
              height: 700,
              child: FutureBuilder<List<productmodelclass>>(
                future: ref.productshow().then((value) => value
                    .where((element) => element.category == selectedCategory)
                    .toList()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      // height: 500,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 50,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => paticularProducts(
                                            product: snapshot.data![i],
                                          )));
                            },
                            title: Container(
                              child: Image.network(
                                snapshot.data![i].photos!.first.toString(),
                                fit: BoxFit.contain,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Text(
                                    snapshot.data![i].SubCategories.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ],
                              ),
                            ),
                          );

                          Column(
                            children: [],
                          );
                        },
                      ),
                    );
                  }
                  return CupertinoActivityIndicator();
                },
              ),
            )
                :             SizedBox(
              child: FutureBuilder<List<productmodelclass>>(
                future: ref.productshow().then((value) => value
                    .where((element) => element.category == selectedCategory)
                    .toList()),
                builder: (context, snapshot) {
                  print("asdaf${snapshot.hasData}");
                  print("asdaf${snapshot.error}");

                  if (snapshot.hasData) {
                    allproducts = snapshot.data!;
                    List<productmodelclass> filteredProduct = allproducts;

                    if (searchcontroller.text.isNotEmpty) {
                      String query = searchcontroller.text.toLowerCase();
                      filteredProduct = filteredProduct
                          .where((element) =>
                          element.SubCategories!
                              .toLowerCase()
                              .contains(query))
                          .toList();
                    }
                    if (filteredProduct.isEmpty) {
                      return Container(
                          height: 500,
                          alignment: Alignment.center,
                          child: const Text("This Product is not available Right Now",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),));
                    }

                    return Container(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: 600,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.all(8.0),
                              scrollDirection: Axis.vertical,
                              itemCount: filteredProduct.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, i) {
                                return Container(
                                  // padding: EdgeInsets.all(6.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 300,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    // snapshot.data![i].photos!.first.toString()
                                                      filteredProduct[i]
                                                          .photos!
                                                          .first
                                                          .toString()),
                                                  fit: BoxFit.contain)),
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(8.0),
                                      subtitle: Container(
                                        child: Column(
                                          children: [
                                            // Text(snapshot.data![i].category.toString()),
                                            Text(
                                              filteredProduct[i]
                                                  .SubCategories
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    paticularProducts(
                                                        product:
                                                        filteredProduct[
                                                        i])));
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
