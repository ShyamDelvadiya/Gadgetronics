import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModelClass {
  String? prize;
  String? state;
  String? city;
  String? address;
  String? pincode;
  String? productname;
  String? mail;
  String? username;
  String? phonenumber;
  String? paymentMode;
  String? CardNO;
  String? CVV;
  String? ExpireyDate;
String? Id;
String? UID;
String? date;
String? status;
int? quantity;


  OrderModelClass(
      {this.ExpireyDate,
      this.state,
      this.CVV,
      this.CardNO,
      this.paymentMode,
      this.phonenumber,
      this.username,
      this.productname,
      this.pincode,
      this.city,
      this.prize,
      this.mail,
      this.address,
        this.Id,
        this.UID,
        this.date,
        this.status,
        this.quantity


      });


  factory OrderModelClass.formJson(DocumentSnapshot json)=>OrderModelClass(

    username: json['User-Name'],
    mail: json['User-Email'],
    phonenumber: json['User-PhoneNumber'],
    address: json['Address'],
    state: json['State'],
    pincode: json['PinCode'],
    city: json['City'],
    paymentMode: json['Payment-Mode'],
    productname: json['Product-Name'],
    prize: json['Product-Price'],
    Id:json.id,
    UID: json['UID'],
    date: json['Date&time'],
    status: json['Status'],
    quantity: json['Quantity'],







  );
}
