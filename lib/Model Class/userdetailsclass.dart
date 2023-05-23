import 'package:cloud_firestore/cloud_firestore.dart';

class userdetailmodel{
  final String? Name;
  final String? Mail;
  final String? Phonenumber;
  final String? Uid;
  final String? password;
  final String? id;


  userdetailmodel({this.Name,this.Mail,this.Phonenumber,this.Uid,this.password,this.id});

factory userdetailmodel.fromJson(DocumentSnapshot json)=>userdetailmodel(

  Name: json['name'],
  Mail: json['Mail'],
  Phonenumber: json['phonenumber'],
  Uid: json['userrid'],
  password: json['password'],
  id: json.id,
);


}