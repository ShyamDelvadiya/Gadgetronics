import 'package:admin/Model%20class/OrdersClass.dart';
import 'package:admin/OrderUpdate.dart';
import 'package:admin/method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class UserOrders extends StatefulWidget {
  const UserOrders({Key? key}) : super(key: key);

  @override
  State<UserOrders> createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  method ref = method();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navidrawer(),
      appBar: AppBar(
        title: Text("Order Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 750,
              child: FutureBuilder<List<OrderModelClass>>(
                future: ref.OrderDetails(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("geting${snapshot.data!.length}");
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        final a = snapshot.data![i];
                        // print("user${snapshot.data![i].Id}");
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(color: Colors.black)),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name:-${a.username}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Mail:-${a.mail}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "PhoneNumber:-${a.phonenumber}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Address:-${a.address}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "City:-${a.city}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "State:-${a.state}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Divider(color: Colors.black, thickness: 2),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Product-Name:-${a.productname}",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.brown),
                                  ),
                                  Text(
                                    "Payment-Mode:-${a.paymentMode}",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.brown),
                                  ),
                                  Text(
                                    "Product Quantity:-${a.quantity}",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.brown),
                                  ),
                                  Text(
                                    "Payment-Done:-${a.prize}/-",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.brown),
                                  ),
                                  Text(
                                    "Product ID:-${a.Id}/-",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.brown),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                            BeveledRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.elliptical(
                                                        20, 10))))),
                                    onPressed: () {
                                      setState(() {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateOrderPage(
                                          details:a,


                                        )));
                                      });

                                    },
                                    child: Text("Update Order",style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),),
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
