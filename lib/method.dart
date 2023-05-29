import 'dart:io';

import 'dart:math';

import 'package:admin/Model%20class/UserHomeImage.dart';
import 'package:admin/Model%20class/categoryclass.dart';
import 'package:admin/Model%20class/allusers.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'Model class/OrdersClass.dart';
import 'Model class/productmodelclass.dart';
import 'Signup.dart';
import 'Model class/admindetails.dart';

class method {
  final collection = FirebaseFirestore.instance.collection("Categories");
  final HomepageImage = FirebaseFirestore.instance.collection("HomepageImage");
  final multicollection = FirebaseFirestore.instance.collection("Product");
  final Usercollection = FirebaseFirestore.instance.collection("user");
  final admincollection = FirebaseFirestore.instance.collection("admin");
  final OrderCollection = FirebaseFirestore.instance.collection("Order");
  late DocumentReference _documentReference;
  late Future<DocumentSnapshot> _futureDocument;

  //for Deleteing image of product
  Future<void> DeleteImageOfProduct(
      {required String id, required String image}) async {
    _documentReference =
        multicollection.doc(id).collection("photos").doc(image);
    _futureDocument = _documentReference.get();
    // print("path:-${_futureDocument}");
    _documentReference.update({
      "photos": image,
    }).whenComplete(() => print("Image updated"));
  }

  //For Deleteing Product
  Future<void> DeleteProduct(String id) async {
    _documentReference = multicollection.doc(id);
    _futureDocument = _documentReference.get();
    _documentReference.delete().whenComplete(() => ScaffoldMessenger(
            child: SnackBar(
          content: Text("Product Removed"),
        )));
  }

  //For Deleteing Product
  Future<void> DeleteCategory(String id) async {
    _documentReference = collection.doc(id);
    _futureDocument = _documentReference.get();
    _documentReference.delete().whenComplete(() => ScaffoldMessenger(
            child: SnackBar(
          content: Text("Product Removed"),
        )));
  }

  //for deleting userhome page images
  Future<void> DeleteImageFromHomePageoFUser({required String id}) async {
    _documentReference = HomepageImage.doc(id);
    _futureDocument = _documentReference.get();
    _documentReference.delete().whenComplete(() => print("photo deleted"));
  }

  //homepageimage show
  Future<List<userhome>> showUserHomeImage() async {
    QuerySnapshot see = await HomepageImage.get();
    return see.docs.map((e) => userhome.fromJson(e)).toList();
  }

  //adminshow

  Future<List<adminmodel>> admindetails() async {
    QuerySnapshot show = await admincollection.get();
    return show.docs.map((e) => adminmodel.fromJson(e)).toList();
  }

  //single img file
  String? singleImgUrl;
  List<File> imglist = [];
  File? photo;

  //for multiplefile

  Reference? Storage;

  // String url='';
  Reference? multistorage;

  // for single image pick method

  Future<void> openimagepicker() async {
    final XFile? pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print("hi${pickedimage}");

    if (pickedimage != null) {
      photo = File(pickedimage.path);
      int random = Random().nextInt(10000);
      String imagename = "$random${DateTime.now().microsecondsSinceEpoch}.jpg";

      Storage = FirebaseStorage.instance.ref(imagename);
    }
    print("hiii${photo}");
  }

  //for multiple image selection method

  Future<void> selectmultipleimage() async {
    final List<XFile> SelectImages = await ImagePicker().pickMultiImage();
    if (SelectImages != null) {
      SelectImages.forEach((element) {
        imglist.add(File(element.path));
        print("multi${imglist}");
      });
    }
  }

  //for checking product alreaady exists or not
  Future<bool> checkifproductExists(
      String selectedCategory, String selectedSubCategory) async {
    QuerySnapshot snapshot = await multicollection
        .where("Category", isEqualTo: selectedCategory)
        .where('Sub-category', isEqualTo: selectedSubCategory)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  // for uploading product details in collection
  Future<bool> multidata(
    String description,
    List<String> file,
    String selectedCategory,
    String selectedSubCategory,
    String price,
    String discount,
    String selectedCompanyname,
  ) async {
    bool detailsexists =
        await checkifproductExists(selectedCategory, selectedSubCategory);
    if (detailsexists) {
      print("This type of brand already exists in database");
      return false;
    }

    await multicollection.add({
      "Sub-category": selectedSubCategory,
      "Category": selectedCategory,
      "decription": description,
      "photos": file,
      "price": price,
      "Discount": discount,
      "Company": selectedCompanyname,
    }).then((value) => print("details added"));
    return true;
  }

  Future<String> uploadFile(File file) async {
    int random = Random().nextInt(10000);
    String imageName = "$random${DateTime.now().microsecondsSinceEpoch}.jpg";
    multistorage = FirebaseStorage.instance.ref(imageName);
    await multistorage!.putFile(file);
    String url = await multistorage!.getDownloadURL();
    return url;
  }

  //for checking whether the details exist or not
  Future<bool> checkifDetailsExists(String brand, String categories) async {
    QuerySnapshot snapshot = await collection
        .where("Brand", isEqualTo: brand)
        .where('categories', isEqualTo: categories)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  //for adding Banner in homepage

  Future<void> addimageInHomepage() async {
    await Storage!.putFile(photo!);
    singleImgUrl = await Storage!.getDownloadURL();
    await HomepageImage.add({"Image": singleImgUrl});
  }

  //method for collection of single image and storing in database
  Future<bool> addcategory(
      String categories, String brand, String CompanyName) async {
    bool detailsexists = await checkifDetailsExists(brand, categories);
    if (detailsexists) {
      print("This type of brand already exists in database");
      return false;
    }
    if (Storage == null || photo == null) {
      print("Storage is null & singleimg file is null");
      return false;
    }

    await Storage!.putFile(photo!);
    singleImgUrl = await Storage!.getDownloadURL();
    await collection.add({
      "categories": categories,
      "Brand": brand,
      "CompanyName": CompanyName,
      "Photo": singleImgUrl,
    }).then((value) => print("details added"));
    return true;
  }

  // for displaying data of single img in display
  Future<List<addcategoryclass>> logos() async {
    QuerySnapshot response = await collection.get();
    return response.docs.map((e) => addcategoryclass.fromJson(e)).toList();
  }

//  for user display

  Future<List<alluser>> showalluser() async {
    QuerySnapshot show = await Usercollection.get();
    return show.docs.map((e) => alluser.fromJson(e)).toList();
  }

  // for removing doplicate in category and subcategory and companyname

  Future<List<String?>> showCompanyName(String selectedSubCategory) async {
    List<String?> removeduplicate = [];
    List<addcategoryclass> list = await logos().then((value) => value
        .where((element) => element.brand == selectedSubCategory)
        .toList());
    for (int i = 0; i < list.length; i++) {
      removeduplicate.add(list[i].companyname);
    }
    Set<String?> convertListtoSet = removeduplicate.toSet();
    List<String?> convertSettoList = convertListtoSet.toList();
    return convertSettoList;
  }

  Future<List<String?>> showCategories() async {
    List<String?> removeDoplicate = [];
    List<addcategoryclass> list = await logos();
    for (int i = 0; i < list.length; i++) {
      removeDoplicate.add(list[i].categories);
    }
    print("sa$removeDoplicate");

    Set<String?> convertListToSet = removeDoplicate.toSet();
    List<String?> convertSetToList = convertListToSet.toList();
    print("ada${convertSetToList}");

    return convertSetToList;
  }

  Future<List<String?>> showSubCategories(String selectedCategory) async {
    List<String?> removeDoplicate = [];
    List<addcategoryclass> list = await logos().then((value) => value
        .where((element) => element.categories == selectedCategory)
        .toList());
    print("subcategories${selectedCategory}");
    for (int i = 0; i < list.length; i++) {
      removeDoplicate.add(list[i].brand);
    }
    Set<String?> convertListToSet = removeDoplicate.toSet();
    List<String?> convertSetToList = convertListToSet.toList();
    return convertSetToList;
  }

//  for showing Orders Details

  Future<List<OrderModelClass>> OrderDetails() async {
    QuerySnapshot show =
        await OrderCollection.orderBy('timestamp', descending: true).get();
    return show.docs.map((e) => OrderModelClass.formJson(e)).toList();
  }

//  For showing Products
  Future<List<productmodelclass>> productsee() async {
    QuerySnapshot product = await multicollection.get();
    // Filterproduct();

    return product.docs.map((e) => productmodelclass.formJson(e)).toList();
  }

  Future<List<String?>> Filterproduct() async {
    List<String?> removeDoplicate = [];
    List<productmodelclass> list = await productsee();
    for (int i = 0; i < list.length; i++) {
      removeDoplicate.add(list[i].category);
    }
    // print("currentcategorylist$removeDoplicate");

    Set<String?> convertListToSet = removeDoplicate.toSet();
    List<String?> convertSetToList = convertListToSet.toList();
    // print("filteredcategorylist${convertSetToList}");

    return convertSetToList;
  }
}
