import 'package:cloud_firestore/cloud_firestore.dart';

class homeimagemodelclass{
  String? image;

  homeimagemodelclass({this.image});

  factory homeimagemodelclass.fromJson(DocumentSnapshot json)=>homeimagemodelclass(
    image: json['Image'],
  );
}