import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'bottomnavibar.dart';
import 'method.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({Key? key,
    this.Prize,
    this.ProductName,
    this.Address,
    this.City,
    this.Pincode,
    this.state,
    this.Username,
    this.UserMail,
    this.UserPhonenumber,
    this.productImage, this.Quantity,this.CartID})
      : super(key: key);
  String? Prize;
  String? Address;
  String? ProductName;
  String? City;
  String? Pincode;
  String? state;
  String? Username;
  String? UserMail;
  String? UserPhonenumber;
  String? productImage;
  int? Quantity;
  String? CartID;



  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  var key = GlobalKey<FormState>();
  TextEditingController accountno = TextEditingController();
  TextEditingController Cvv = TextEditingController();
  TextEditingController ExpireyDate = TextEditingController();
  String? status;
  String? OrderCancel;
  bool? radiobutton;
  String? val;
  method ref = method();

  PaymentConfirmation() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Are You Sure You Want To pay From ${val}?"),
            children: [
              Form(
                key: key,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          print('payment..${val}');

                          setState(() {
                            const snackBar =
                            SnackBar(content: Text("Order Placed"),elevation: double.infinity);
                            ref.OrderCollection(
                              widget.Prize.toString(),
                              widget.state.toString(),
                              widget.City.toString(),
                              widget.Address.toString(),
                              widget.Pincode.toString(),
                              widget.ProductName.toString(),
                              widget.UserMail.toString(),
                              widget.Username.toString(),
                              widget.UserPhonenumber.toString(),
                              val.toString(),
                              accountno.text.toString(),
                              Cvv.text.toString(),
                              ExpireyDate.text.toString(),
                              status,
                              widget.Quantity!.toInt(),
                            ).then((value) => ref.removeformcart(id: widget.CartID.toString()))
                                .whenComplete(() => Navigator.pop(context))
                                .whenComplete(() =>
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar))
                                .whenComplete(() =>
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) =>
                                        bottomnavibar(selectedindex: 3)), (
                                        route) => false));
                          });
                        }
                      },
                      child: Text("Yes")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      print("idc${widget.CartID}");
                      Navigator.pop(context);
                    },
                    child: Text("No")),
              ),
            ],
          );
        });
  }

  CardDetailsdialogbox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(14.0),
          title: Text("Enter Your Credit Or Debit Card details"),
          children: [
            Form(
              key: key,
              child: Column(
                children: [
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      CredirCardInputFormat()
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Write Account Number";
                      }
                      if (value.length < 16) {
                        return "Invalid Number";
                      }
                    },
                    controller: accountno,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.credit_card),
                      border: OutlineInputBorder(),
                      labelText: "Account Number",
                    ),
                  ),
                  Divider(),
                  Row(
                    children: [
                      Container(
                        width: 70,
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3)
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "provide CVV";
                            }
                            if (value.length < 3) {
                              return "Invalid CVV";
                            }
                          },
                          controller: Cvv,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "CVV",
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      Container(
                        child: Expanded(
                          child: TextFormField(
                            readOnly: true,
                            showCursor: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Write Expiery Date";
                              }
                            },
                            controller: ExpireyDate,
                            onTap: () async {
                              final pickeddate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2051));

                              if (pickeddate != null) {
                                setState(() {
                                  ExpireyDate.text =
                                      formatDate(
                                          pickeddate, [mm, '/', yyyy]);
                                });
                              }
                            },

                            // keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.calendar_month),
                              border: OutlineInputBorder(),
                              labelText: "ExpireyMonth",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (key.currentState!.validate()) {
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Done")),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              val = "BHIM UPI";
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Cancel")),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  popupdialogbox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(14.0),
          title: Text("Select Any Payment Method To Complete Order...."),
          children: [
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text("OK")),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Payment Loby",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Icon(Icons.currency_rupee)
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: GradientText(
                  "Choose Payment Option",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  colors: [
                    Colors.lightBlueAccent,
                    Colors.lightGreen,
                    Colors.deepOrange,
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Text(
              "Total Price:-${widget.Prize}/-",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.orange),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    Text(
                      "For Paying Online Select Below Option",
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    RadioListTile(
                      // tileColor: Colors.lightBlueAccent,
                      title: Text("BHIM UPI"),
                      value: "BHIM UPI",
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value!;
                        });
                      },
                      activeColor: Colors.red,
                    ),
                    RadioListTile(
                      // tileColor: Colors.lightBlueAccent,
                      title: Text("G-Pay"),
                      value: "G-Pay",
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value!;
                        });
                      },
                      activeColor: Colors.red,
                    ),
                    RadioListTile(
                      // tileColor: Colors.lightBlueAccent,
                      title: Text("Phone-Pay"),
                      value: "Phone-Pay",
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value!;
                        });
                      },
                      activeColor: Colors.red,
                    ),
                    RadioListTile(
                      // tileColor: Colors.lightBlueAccent,
                      title: Text("Paytm"),
                      value: "Paytm",
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value!;
                        });
                      },
                      activeColor: Colors.red,
                    ),
                    RadioListTile(
                      // tileColor: Colors.lightBlueAccent,
                      title: Text("COD(Cash-On-Delivery)"),
                      value: "COD(Cash-On-Delivery)",
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value!;
                        });
                      },
                      activeColor: Colors.red,
                    ),
                    RadioListTile(
                      // tileColor: Colors.lightBlueAccent,
                      title: Text("Pay through Credit Card or Debit card"),
                      value: "CreditCard/DebitCard",
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value!;
                          CardDetailsdialogbox();
                          print("value..${val}");
                        });
                      },
                      activeColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (val == null) {
                    return popupdialogbox();

                    // Text("select");
                  }
                  else {
                    PaymentConfirmation(); // .whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrders())));

                  }
                },
                child: Text("Pay")),
          ],
        ),
      ),
    );
  }
}

class CredirCardInputFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    String enterdata = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < enterdata.length; i++) {
      buffer.write(enterdata[i]);
      int index = i + 1;
      if (index % 4 == 0 && enterdata.length != index) {
        buffer.write(" ");
      }
    }
    return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: buffer
            .toString()
            .length));
  }
}
