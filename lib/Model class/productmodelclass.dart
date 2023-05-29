import 'package:cloud_firestore/cloud_firestore.dart';

class productmodelclass {
  String? category;
  String? SubCategories;
  String? description;
  List<String>? photos;
  String? productid;
  String? price;
  String? discount;
  String? Company;

  productmodelclass(
      {this.category,
        this.description,
        this.photos,
        this.SubCategories,
        this.productid,
        this.price,
        this.discount,
        this.Company});

  factory productmodelclass.formJson(DocumentSnapshot json) =>
      productmodelclass(
        category: json['Category'],
        SubCategories: json['Sub-category'],
        description: json['decription'],
        photos: List<String>.from(json['photos']),
        productid: json.id,
        price: json['price'],
        discount: json['Discount'],
        Company: json['Company'],
      );
}
