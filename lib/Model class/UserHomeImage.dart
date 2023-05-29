import 'package:cloud_firestore/cloud_firestore.dart';

class userhome{
  String? image;
  String? id;


  userhome({this.image,this.id});



  factory userhome.fromJson(DocumentSnapshot json)=> userhome(
    image: json['Image'],
    id: json.id
  );
}