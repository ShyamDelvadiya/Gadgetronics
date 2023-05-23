
import 'package:Gadgatronics/seeAllProducts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Model Class/MyOrders.dart';
import 'TrackMyOrder.dart';
import 'method.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  method ref = method();
  TextEditingController ordercancelation = TextEditingController();
  var key = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!.uid;

  OrderCancelationIssueDialogbox(String id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: Border.all(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid,
                strokeAlign: double.infinity),
            title: Text("Why Do you Want to Cancel Order?"),
            children: [
              Form(
                key: key,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "plzz Provide your Issue";
                          }
                        },
                        controller: ordercancelation,
                        decoration: InputDecoration(
                          hintText: "Your issue reagarding Canceling Order??",
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: ElevatedButton(
                              onPressed: () {
                                if (key.currentState!.validate()) {
                                  setState(() {
                                    print("idsd..${id}");
                                    ref
                                        .cancelOrder(id: id)
                                        .whenComplete(
                                            () => Navigator.pop(context))
                                        .whenComplete(
                                            () => ordercancelation.clear());
                                  });
                                }
                              },
                              child: Text("Submit")),
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        Container(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Close")),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  DialogboxForOrderCancel({required String id}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Are you sure You Want to cancel Order??"),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);

                            OrderCancelationIssueDialogbox(id);
                          });
                        },
                        child: Text("Yes")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
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
        title: Text('My Orders'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 800,
              child: FutureBuilder<List<OrderModelClass>>(
                future: ref.showOrderDetails().then((value) =>
                    value.where((element) => element.Uid == user).toList()),
                builder: (context, snapshot) {
                  if (snapshot.data?.length == 0) {
                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            seeallproducts()));
                              },
                              child: Text(
                                "Order Something,see some products by clicking here..",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                        ],
                      ),
                    );
                  }

                  if (snapshot.hasData) {
                    print("geting${snapshot.hasData}");
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        print("user${snapshot.data![i].username}");
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![i].productname.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Quantity:-${snapshot.data![i].quantity.toString()}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Total Price:-${snapshot.data![i].prize}/-",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orangeAccent),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TrackingOrderScreen(
                                                              product: snapshot
                                                                  .data![i],
                                                            )));
                                              });
                                              print(
                                                  "idorder${snapshot.data![i].id}");
                                            },
                                            child: Text("Track My Order")),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                DialogboxForOrderCancel(
                                                    id: snapshot.data![i].id
                                                        .toString());
                                              });
                                            },
                                            child: Text("Cancel")),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: const CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
