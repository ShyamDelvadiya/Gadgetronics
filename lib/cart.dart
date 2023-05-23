
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'BuyProductPage.dart';
import 'Model Class/Cartmodelcalss.dart';
import 'bottomnavibar.dart';
import 'method.dart';
import 'seeAllProducts.dart';

class cart extends StatefulWidget {
  cart({
    Key? key,
  }) : super(key: key);

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {


  method ref = method();



  final user = FirebaseAuth.instance.currentUser!.uid;
  int totalDiscountPrize = 0;
  int quantity=1;


  void Increment(){
    setState(() {
      if(quantity < 2){
        quantity++;
      }if(quantity <= 2){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cant Increse more")));
      }
    });
  }

  void Decrement(){
    setState(() {
      if(quantity > 1){
        quantity--;
      }
    });
  }


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
                                .removeformcart(id: Id)
                                .whenComplete(() =>
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Removed From Cart"),
                                      duration: Duration(milliseconds: 700),
                                    )))
                                .whenComplete(() =>
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => bottomnavibar(
                                                selectedindex: 1)),
                                        (route) => false));
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
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GradientText(
            "Cart",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
            colors: [
              Colors.deepOrangeAccent,
              Colors.black,
              Colors.redAccent,
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: FutureBuilder<List<cartmodelclass>>(
                future: ref.cartshow(),
                builder: (context, snaphot) {
                  print("cart${snaphot.data}");
                  print("error${snaphot.error}");

                  if (snaphot.hasData) {
                    for (int i = 0; i < snaphot.data!.length; i++) {

                      totalDiscountPrize +=
                          int.parse(snaphot.data![i].discount.toString());
                    }
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Total Amount:-${totalDiscountPrize}/-",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold,color: Colors.redAccent),
                              )),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                      ],
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
            Container(
              child: FutureBuilder<List<cartmodelclass>>(
                future: ref.cartshow(),
                builder: (context, snaphot) {
                  print("cart${snaphot.data}");
                  print("error${snaphot.error}");

                  if (snaphot.data?.length == 0) {
                    return Column(
                      children: [
                        Container(
                          height: 400,
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => seeallproducts()));
                            },
                            child: Text(
                              "ShortList Some Products By Clicking Here...",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  if (snaphot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 700,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: snaphot.data!.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                // height: 300,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                        color: Colors.black, width: 1)),

                                child: Column(
                                  children: [
                                    Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(alignment: Alignment.center,

                                            child: Image.network(
                                                snaphot.data![i].photo.toString(),fit: BoxFit.cover,),
                                            height: 150,
                                            width: 150,

                                          ),
                                        ),
                                        Container(width: 30,),
                                        // Container(
                                        //   child: Column(
                                        //     children: [
                                        //       Text("Quantity:-",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                        //       Row(
                                        //         children: [
                                        //           IconButton(onPressed: (){
                                        //             Increment();
                                        //           }, icon: Icon(Icons.add)),
                                        //           Container(alignment: Alignment.center,
                                        //             width: 30,
                                        //             height: 40,
                                        //             child: Text("$quantity",style: Theme.of(context).textTheme.headlineMedium,),
                                        //
                                        //
                                        //
                                        //
                                        //           ),
                                        //           IconButton(onPressed: (){
                                        //             Decrement();
                                        //           }, icon: Icon(Icons.remove)),
                                        //
                                        //         ],
                                        //       ),
                                        //
                                        //
                                        //     ],
                                        //   ),
                                        // ),

                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snaphot.data![i].Subcategory!.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),

                                    Text(
                                      "M.R.P:-${snaphot.data![i].discount}/-",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Container(
                                            height: 50,
                                            child: ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                shadowColor: Colors.red,
                                                  shape:
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          20)),
                                                  primary: Colors.yellow,
                                                  foregroundColor:
                                                  Colors.black),
                                              onPressed: () {
                                                setState(() {
                                                  ItemRemovedailogbox(
                                                      Id: snaphot.data![i].id
                                                          .toString());
                                                });
                                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>cart()));
                                              },
                                              label: Text("Remove"),
                                              icon: Icon(Icons.delete),
                                            ),
                                          ),
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
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            buyProduct(
                                                              productPrice: snaphot
                                                                  .data![i]
                                                                  .discount
                                                                  .toString(),
                                                              productImage:
                                                              snaphot
                                                                  .data![
                                                              i]
                                                                  .photo
                                                                  .toString(),
                                                              productname: snaphot
                                                                  .data![i]
                                                                  .Subcategory
                                                                  .toString(),
                                                              cartid:snaphot.data![i].id.toString()
                                                            )));

                                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>cart()));
                                              },
                                              label: Text("Buy"),
                                              icon: Icon(Icons.shop),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),


                                  ],

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
