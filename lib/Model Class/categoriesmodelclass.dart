import 'package:cloud_firestore/cloud_firestore.dart';
class showcategoryclass {
  final  String? categories;
  final  String? brand;
  final String? photo;
// final String? Description;

  showcategoryclass(
      { this.brand,
        this.categories,
        this.photo,

      });

  factory showcategoryclass.fromJson(DocumentSnapshot json)=> showcategoryclass(
    categories: json['categories'],
    brand: json['Brand'],
    photo: json['Photo'],

  );

}
