// import 'dart:html';


import 'package:Gadgatronics/seeAllProducts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'Model Class/favclass.dart';
import 'bottomnavibar.dart';
import 'method.dart';

class favroite extends StatefulWidget {
  const favroite({Key? key}) : super(key: key);

  @override
  State<favroite> createState() => _favroiteState();
}

class _favroiteState extends State<favroite> {
  method ref = method();

  ItemRemovedailogbox({required String Id}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Are you Sure you want To remove this item?"),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            ref
                                .removeFromFavroites(id: Id)
                                .whenComplete(() =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Removed From Favroite"))))
                                .whenComplete(() => Navigator.pop(context));
                          });
                        },
                        child: Text("yes")),
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GradientText(
          "Favroite",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          colors: [
            Colors.black,
            Colors.brown,
            Colors.redAccent,
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: FutureBuilder<List<favmodelclass>>(
                future: ref.favshow(),
                builder: (context, snapshot) {
                  print("favroite${snapshot.data}");
                  print("favroiteerror${snapshot.error}");

                  if (snapshot.data?.length == 0) {
                    return Container(
                      alignment: Alignment.center,
                      height: 400,
                      child: TextButton(
                          child: Text(
                            "Still Empty Add Your Favroite Product By Clicking Here",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          onPressed: () {
                            setState(() {
                              ref.favshow();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => seeallproducts()));
                            });
                          }),
                    );
                  }
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 700,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                // height: 300,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                        color: Colors.black, width: 1)),
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.data![i].category!.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.deepPurple),
                                    ),
                                  ),
                                  // subtitle: Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Container(child: Text(snapshot.data![i].decription.toString())),
                                  // ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(
                                        //   "M.R.P:-${snapshot.data![i].price}/-",
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.bold,
                                        //       color: Colors.red,
                                        //       fontSize: 18,
                                        //       decoration:
                                        //       TextDecoration.lineThrough),
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snapshot.data![i].Subcategory
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "M.R.P:-${snapshot.data![i].discount}/-",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),

                                        Row(
                                          children: [
                                            GFIconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () {
                                                  setState(() {
                                                    ItemRemovedailogbox(
                                                        Id: snapshot.data![i].id
                                                            .toString());
                                                  });
                                                },
                                              type: GFButtonType.solid,
                                              boxShadow: BoxShadow(blurStyle: BlurStyle.solid,color: Colors.red,blurRadius: 5,spreadRadius: 2),


                                            ),
                                            // Container(
                                            //   height: 50,
                                            //   // child: ElevatedButton.icon(
                                            //   //   style: ElevatedButton.styleFrom(
                                            //   //       shape: RoundedRectangleBorder(
                                            //   //           borderRadius: BorderRadius.circular(20)),
                                            //   //       primary: Colors.yellow,
                                            //   //       foregroundColor: Colors.black),
                                            //   //   onPressed: () {
                                            //   //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>cart()));
                                            //   //     ref.removeFromFavroites(id:snapshot.data![i].id.toString());
                                            //   //
                                            //   //   },
                                            //   //   label: Text(""),
                                            //   //   icon: Icon(Icons.delete),
                                            //   // ),
                                            //   child: IconButton(
                                            //     icon: Icon(Icons.delete),
                                            //     color: Colors.black,
                                            //     onPressed: () {
                                            //
                                            //     },
                                            //     style: ButtonStyle(
                                            //         shape: MaterialStatePropertyAll(
                                            //             CircleBorder(
                                            //                 side: BorderSide(
                                            //                     color: Colors
                                            //                         .black,
                                            //                     style:
                                            //                         BorderStyle
                                            //                             .solid,
                                            //                     width: 2)))),
                                            //   ),
                                            // ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 50,
                                              child: ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(

                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    primary: Colors.orange,
                                                    foregroundColor:
                                                        Colors.black),
                                                onPressed: () {
                                                  setState(() {
                                                    ref
                                                        .cartaddcollection(
                                                          category: snapshot
                                                              .data![i].category
                                                              .toString(),
                                                          subCategory: snapshot
                                                              .data![i]
                                                              .Subcategory
                                                              .toString(),
                                                          productid: snapshot
                                                              .data![i].id
                                                              .toString(),
                                                          price: snapshot
                                                              .data![i].price
                                                              .toString(),
                                                          discount: snapshot
                                                              .data![i].discount
                                                              .toString(),
                                                          photo: snapshot
                                                              .data![i].photo
                                                              .toString(),
                                                        )
                                                        .whenComplete(() => ref
                                                            .removeFromFavroites(
                                                                id: snapshot
                                                                    .data![i].id
                                                                    .toString()))
                                                        .whenComplete(() =>
                                                            ScaffoldMessenger.of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                  "Added To Cart"),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      500),
                                                            )))
                                                        .whenComplete(() =>
                                                            Navigator.pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        bottomnavibar(selectedindex: 1)),
                                                                (route) => false));
                                                  });
                                                },
                                                label: Text("Add to Cart"),
                                                icon: Icon(Icons.shop),

                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  trailing: Container(
                                    height: 100,
                                    width: 100,
                                    child: Image.network(
                                      snapshot.data![i].photo.toString(),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                  return Center(
                      child: CupertinoActivityIndicator(
                    color: Colors.black,
                    radius: 20,
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
