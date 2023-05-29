import 'package:admin/Model%20class/OrdersClass.dart';
import 'package:admin/method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class UpdateOrderPage extends StatefulWidget {
  OrderModelClass? details;

  UpdateOrderPage({Key? key, this.details}) : super(key: key);

  @override
  State<UpdateOrderPage> createState() => _UpdateOrderPageState();
}

class _UpdateOrderPageState extends State<UpdateOrderPage> {
  method ref = method();
  String? selectedStatus;

  List<String> status = [
    "Order Confirmed",
    "shipped",
    "Out for Delivery",
    "Delivered",
  ];

  List<DropdownMenuItem<String>> dropdownItems = [
    DropdownMenuItem(
      child: Text(
        "Order Confirmed",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
      ),
      value: "Order Confirmed",
    ),
  ];

  //for updating status
  Future<void> updateStatus() async {
    try {
      print("id${widget.details!.Id}");
      await FirebaseFirestore.instance
          .collection("Order")
          .doc(widget.details!.Id)
          .update({
        "Status": selectedStatus,
      });
    } on FirebaseException catch (e) {
      print("Error in Updating Status$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Navidrawer(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          width: 30,
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  updateStatus();
                });
                print("SelectedStatus${selectedStatus}");
              },
              child: Text("Update")),
        ),
      ),
      appBar: AppBar(
        title: Text("Order Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.all(8.0)),
              Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.black,
                      )),
                  alignment: Alignment.center,
                  child: Text(
                    "ProductId:-${widget.details!.Id}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("CustomerName:-${widget.details!.username}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("CustomerAddress:-${widget.details!.address}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Product-Name:-${widget.details!.productname}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Product-Quantity:-${widget.details!.quantity}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Order Date&Time:-${widget.details!.date}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("City:-${widget.details!.city}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                  ),
                  Container(
                    width: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("State:-${widget.details!.state}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                  ),
                ],
              ),
              Divider(color: Colors.black, thickness: 1),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Order Status",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan),
                    )),
              ),
              InputDecorator(
                decoration: InputDecoration(border: OutlineInputBorder()),
                child: DropdownButtonFormField(
                  value: selectedStatus,

                  items: dropdownItems,

                  // items: status
                  //     .map((e) =>
                  //     DropdownMenuItem(
                  //           child: Text(
                  //             e,
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 20,
                  //                 color: Colors.blue),
                  //           ),
                  //           value: e,
                  //       enabled: false,
                  //         ))
                  //     .toList(),

                  onChanged: (newValue) {
                    setState(() {
                      selectedStatus = newValue;
                      dropdownItems.clear();
                      dropdownItems.add(
                        DropdownMenuItem(
                          child: Text(
                            selectedStatus!,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
                          ),
                          value: selectedStatus,
                        ),
                      );
                      if (selectedStatus != "Delivered") {

                        dropdownItems.add(
                          DropdownMenuItem(
                            child: Text(
                              status[status.indexOf(selectedStatus!) + 1],
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
                            ),
                            value: status[status.indexOf(selectedStatus!) + 1],
                          ),
                        );
                      }
                    });

                  },
                ),
              ),
              Container(
                height: 30,
              ),
              Text(
                "Order Progress:-${widget.details!.status}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
