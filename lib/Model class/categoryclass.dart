import 'package:cloud_firestore/cloud_firestore.dart';
class addcategoryclass {
final  String? categories;
final  String? brand;
final String? photo;
final String? companyname;
String? Id;
// final String? Description;

  addcategoryclass(
      { this.brand,
      this.categories,
       this.photo,
        this.companyname,
        this.Id

      });

 factory addcategoryclass.fromJson(DocumentSnapshot json)=> addcategoryclass(
   categories: json['categories'],
   brand: json['Brand'],
   photo: json['Photo'],
   companyname: json['CompanyName'],
   Id: json.id,
 );

}
