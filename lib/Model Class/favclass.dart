import 'package:cloud_firestore/cloud_firestore.dart';

class favmodelclass {
  String? category;
  String? Subcategory;
  String? price;
  String? discount;
  String? photo;
  String? id;

  favmodelclass(
      {this.category,
      this.discount,
      this.price,
      this.photo,
      this.Subcategory,
      this.id});

  factory favmodelclass.fromJson(DocumentSnapshot json) => favmodelclass(
        category: json['Category'],
        Subcategory: json['SubCategory'],
        price: json['Price'],
        discount: json['Discount Price'],
        photo: json['photo'],
        id: json.id,
      );
}
