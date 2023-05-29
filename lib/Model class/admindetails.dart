import 'package:cloud_firestore/cloud_firestore.dart';

class adminmodel{
  String? name;
  String? mail;
  String? password;
  String? phonenumber;

  adminmodel({this.name,this.password,this.mail,this.phonenumber});

factory adminmodel.fromJson(DocumentSnapshot json)=>adminmodel(

  name: json['name'],
  mail: json['Mail'],
  password: json['password'],
  phonenumber: json['phonenumber'],


);

}