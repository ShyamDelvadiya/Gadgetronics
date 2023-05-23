import 'package:Gadgatronics/particularProducts.dart';
import 'package:flutter/material.dart';

import 'Model Class/productshowmodelclass.dart';
import 'method.dart';


class seeallproducts extends StatefulWidget {
  const seeallproducts({Key? key}) : super(key: key);

  @override
  State<seeallproducts> createState() => _seeallproductsState();
}

class _seeallproductsState extends State<seeallproducts> {
  method ref = method();
  TextEditingController searchcontroller = TextEditingController();
  List<productmodelclass> allproducts = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Products"),
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

                    hintText: 'Search Your Product.....',
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

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: FutureBuilder<List<productmodelclass>>(
                  future: ref.productshow(),
                  builder: (context, snapshot) {
                    print("asdaf${snapshot.hasData}");
                    print("asdaf${snapshot.error}");
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: SizedBox(
                          height: 700,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              clipBehavior: Clip.hardEdge,
                              // physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.all(8.0),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 15,
                              ),
                              itemBuilder: (context, i) {
                                return Stack(
                                    fit: StackFit.passthrough,
                                    children: [
                                  Container(
                                    // padding: EdgeInsets.all(6.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        snapshot.data![i]
                                                            .photos!.first
                                                            .toString()),
                                                    fit: BoxFit.contain)),
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.all(10.0),
                                        subtitle: Container(
                                          child: Column(
                                            children: [
                                              // Text(snapshot.data![i].category.toString()),
                                              Text(
                                                snapshot
                                                    .data![i].SubCategories
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold,
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
                                                          product: snapshot
                                                              .data![i])));
                                        },
                                      ),
                                    ),
                                  ),


                                    ]);
                              },
                            ),
                          ),
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ):
            SizedBox(
              child: FutureBuilder<List<productmodelclass>>(
                future: ref.productshow(),
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
