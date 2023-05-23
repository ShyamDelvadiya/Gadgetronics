import 'package:cloud_firestore/cloud_firestore.dart';

class cartmodelclass{
  String? category;
  String? Subcategory;
  String? price;
  String? discount;
  String? photo;
  String? id;
  String? userid;


   cartmodelclass({this.category,this.discount,this.price,this.photo,this.Subcategory,this.id,this.userid});

   factory cartmodelclass.formJson(DocumentSnapshot json)=>cartmodelclass(
     category: json['Category'],
     Subcategory: json['SubCategory'],
     price: json['price'],
     discount: json['Discount'],
     photo: json['image'],
     id: json.id,
     userid: json['userid'],
   );

}