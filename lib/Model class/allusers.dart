import 'package:cloud_firestore/cloud_firestore.dart';
class alluser{
 final String? Mail;
 final String? Name;
 final String? phonenumber;
 final String? Userid;
 final String? usercollectionid;
 String? password;

 alluser({this.Mail,this.Name,this.phonenumber,this.Userid,this.usercollectionid,this.password});

 factory alluser.fromJson(DocumentSnapshot json) =>alluser(
  Mail: json['Mail'],
  Name: json['name'],
  phonenumber: json['phonenumber'],
  Userid: json['userrid'],
  usercollectionid: json.id,
  password: json['password'],
 );

}