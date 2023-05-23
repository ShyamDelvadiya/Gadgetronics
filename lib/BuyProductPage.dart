import 'dart:convert';

import 'package:Gadgatronics/paymentDetailPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model Class/userdetailsclass.dart';
import 'method.dart';

class buyProduct extends StatefulWidget {
  buyProduct({
    Key? key,
    this.productname,
    this.productImage,
    this.productPrice, this.cartid,
  }) : super(key: key);
  String? productname;
  String? productImage;
  String? productPrice;
  String? cartid;

  @override
  State<buyProduct> createState() => _buyProductState();
}

class _buyProductState extends State<buyProduct> {

  method ref = method();
  var key = GlobalKey<FormState>();
  TextEditingController Address = TextEditingController();
  TextEditingController City = TextEditingController();
  TextEditingController PinCode = TextEditingController();
  TextEditingController state = TextEditingController();
  String? _city;
  String? _state;
  int quantity=1;




  void Increment(){
    setState(() {
      if(quantity < 2){
        quantity++;
      }if(quantity <= 2){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Can't Add Further More Quantity")));
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





  Future<void> _getCityAndState(String pinCode) async {
    final url = Uri.parse('https://api.postalpincode.in/pincode/$pinCode');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)[0];
      final postOffice = jsonData['PostOffice'][0];
      setState(() {
        _city = postOffice['District'];
        _state = postOffice['State'];
      });
    } else {
      setState(() {
        _city = '';
        _state = '';
      });
    }
  }



  int TotalPrice(){
  return  
    int.parse(widget.productPrice.toString())*quantity;
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Details For Your Order"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black, width: 2,style: BorderStyle.solid),
                  ),

                  child:Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.productname.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Container(
                        child: Column(

                          children: [
                            Text(
                              "Total Prize:-${TotalPrice().toStringAsFixed(2)}/-",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            Divider(),
                            Container(
                              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Quantity:-",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                  ),
                                  Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(onPressed: (){
                                        Increment();
                                        // print("total${TotalPrice().toStringAsFixed(2)}");
                                      }, icon: Icon(Icons.add)),
                                      Container(alignment: Alignment.center,
                                        width: 30,
                                        height: 40,
                                        child: Text("$quantity",style: Theme.of(context).textTheme.headlineMedium,),




                                      ),
                                      IconButton(onPressed: (){
                                        Decrement();
                                      }, icon: Icon(Icons.remove)),

                                    ],
                                  ),


                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 200,
                        child: Image.network(
                          widget.productImage.toString(),
                        ),
                      ),
                    ],
                  ),



                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 2,

              ),
              Container(
                height: 800,
                child: FutureBuilder<List<userdetailmodel>>(
                  future: ref.showuserdetails().then((value) => value
                      .where((element) =>
                          element.Uid == FirebaseAuth.instance.currentUser?.uid)
                      .toList()),
                  builder: (context, snapshot) {
                    print("hi${snapshot.hasData}");

                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, i) {
                            print("id${snapshot.data![i].id}");

                            return Column(
                              children: [
                                Container(),
                                ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Name:-${snapshot.data![i].Name.toString()}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.lightBlue,
                                              fontSize: 25),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "E-Mail:-${snapshot.data![i].Mail.toString()}",
                                          style: TextStyle(
                                              color: Colors.lightBlue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "PhoneNO:-${snapshot.data![i].Phonenumber.toString()}",
                                          style: TextStyle(
                                              color: Colors.lightBlue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.streetAddress,
                                    validator: (v) {
                                      if (v!.isEmpty) {
                                        return "Provide Address";
                                      }if(v.startsWith(" ")){
                                        return "Remove WhiteSpace from front";
                                      }
                                    },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.lightBlue),
                                    controller: Address,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Address",
                                        hintText: "Enter Your Address Here",
                                        labelStyle: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)
                                        // prefixText: "Addres:-"
                                        ),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: TextFormField(
                                            validator: (v) {
                                              if (v!.isEmpty) {
                                                return "Provide State";
                                              }if(v.contains(" ")){
                                                return "Remove White Space";
                                              }
                                            },
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.lightBlue),
                                            controller: TextEditingController(text: _city),

                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "State",
                                                // hintText: "Enter Your Address Here",
                                                labelStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold)
                                                // prefixText: "Addres:-"
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            validator: (v) {
                                              if (v!.isEmpty) {
                                                return "Provide PinCode";
                                              }if(v.contains(" ")){
                                                return "White Space Not Allowed";
                                              }
                                            },

                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.lightBlue),
                                            keyboardType: TextInputType.number,
                                            controller: PinCode,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: "PinCode",
                                              labelStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onChanged: (value){
                                              if(value.length == 6){
                                                _getCityAndState(value);
                                              }else{
                                                setState(() {
                                                  _city='';
                                                  _state='';
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                // Text("City:-${_city}"),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: TextFormField(
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return "Provide City";
                                        }if(v.contains(" ")){
                                          return "White Space Not Allowed";
                                        }
                                      },
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.lightBlue),
                                      controller: TextEditingController(text: _state),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "City",
                                          // hintText: "Enter Your Address Here",
                                          labelStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)
                                          // prefixText: "Addres:-"
                                          ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if (key.currentState!.validate()) {
                                        print("city${_city}");

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentPage(
                                                      Prize:
                                                          TotalPrice().toStringAsFixed(2),
                                                      ProductName: widget
                                                          .productname
                                                          .toString(),
                                                      Address: Address.text
                                                          .toString(),
                                                      City:_city.toString(),

                                                      Pincode: PinCode.text
                                                          .toString(),
                                                      state:
                                                          _state.toString(),
                                                      Username: snapshot
                                                          .data![i].Name
                                                          .toString(),
                                                      UserMail: snapshot.data![i].Mail.toString(),
                                                      UserPhonenumber:snapshot.data![i].Phonenumber
                                                          .toString(),
                                                      productImage:widget.productImage.toString(),
                                                      Quantity:quantity.toInt(),
                                                      CartID:widget.cartid.toString()


                                                    )));
                                      }
                                    },
                                    child: Text("Confirm")),
                              ],
                            );
                          });
                    } else {
                      return Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
