

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Model Class/Cartmodelcalss.dart';
import 'Model Class/Homeimageclass.dart';
import 'Model Class/MyOrders.dart';
import 'Model Class/categoriesmodelclass.dart';
import 'Model Class/favclass.dart';
import 'Model Class/productshowmodelclass.dart';
import 'Model Class/userdetailsclass.dart';

// import 'loginpage.dart';

class method {
  final Usercollection = FirebaseFirestore.instance.collection("user");
  final ImagecollectionHomepage =
      FirebaseFirestore.instance.collection("HomepageImage");
  final CategoriesCollection =
      FirebaseFirestore.instance.collection("Categories");
  final Productcollection = FirebaseFirestore.instance.collection("Product");
  final Cartcollection = FirebaseFirestore.instance.collection("Cart");
  final Favroitecollection = FirebaseFirestore.instance.collection("Favorite");
  final ParticularUserCartcollection =
      FirebaseFirestore.instance.collection("usercartcollection");

  final OrderDetailsCollection = FirebaseFirestore.instance.collection("Order");

  late DocumentReference _documentReference;
  late Future<DocumentSnapshot> _futureDocument;

  Future<void> cancelOrder({required String id}) async {
    _documentReference =
        OrderDetailsCollection
            .doc(id);
    _futureDocument = _documentReference.get();
    _documentReference.delete().whenComplete(() => print("OrderCanceled"));
  }

  Future<void> removeformcart({required String id}) async {
    _documentReference =
        Cartcollection.doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("usercartcollection")
            .doc(id);
    _futureDocument = _documentReference.get();
    print("id${id}");
    _documentReference.delete().whenComplete(() => print("Removed From Cart"));
  }

  //for removing fromfavroites
  Future<void> removeFromFavroites({required String id}) async {
    _documentReference =
        Favroitecollection.doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("UserFavroiteCollection")
            .doc(id);
    _futureDocument = _documentReference.get();
    print("favid${id}");
    _documentReference
        .delete()
        .whenComplete(() => print("Removed From Favroites"));
  }

  // for Orders show
  Future<List<OrderModelClass>> showOrderDetails() async {
    QuerySnapshot show = await OrderDetailsCollection.orderBy('timestamp',descending: true).get();

    return show.docs.map((e) => OrderModelClass.formJson(e)).toList();
  }

  //for showing images in homepage
  Future<List<homeimagemodelclass>> showimageINhomepage() async {
    QuerySnapshot image = await ImagecollectionHomepage.get();
    return image.docs.map((e) => homeimagemodelclass.fromJson(e)).toList();
  }

  //for showing current user
  Future<List<userdetailmodel>> showuserdetails() async {
    QuerySnapshot show = await Usercollection.get();
    return show.docs.map((e) => userdetailmodel.fromJson(e)).toList();
  }

  //                For getting collection of categorymethod
  Future<List<showcategoryclass>> logos() async {
    QuerySnapshot response = await CategoriesCollection.get();
    return response.docs.map((e) => showcategoryclass.fromJson(e)).toList();
  }

  Future<List<productmodelclass>> productshow() async {
    QuerySnapshot product = await Productcollection.get();
    Filterproduct();

    return product.docs.map((e) => productmodelclass.formJson(e)).toList();
  }


  //for cart show
  Future<List<cartmodelclass>> cartshow() async {
    QuerySnapshot<Map<String, dynamic>> Cart =
        await Cartcollection.doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("usercartcollection")
            .get();
    return Cart.docs.map((e) => cartmodelclass.formJson(e)).toList();
  }

  Future<List<favmodelclass>> favshow() async {
    QuerySnapshot<Map<String, dynamic>> Favroite =
        await Favroitecollection.doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("UserFavroiteCollection")
            .get();
    return Favroite.docs.map((e) => favmodelclass.fromJson(e)).toList();
  }

  //          For removing duplicate from collection of category
  Future<List<String?>> FilteredCategories() async {
    List<String?> removeDoplicate = [];
    List<showcategoryclass> list = await logos();
    for (int i = 0; i < list.length; i++) {
      removeDoplicate.add(list[i].categories);
    }
    // print("currentcategorylist$removeDoplicate");

    Set<String?> convertListToSet = removeDoplicate.toSet();
    List<String?> convertSetToList = convertListToSet.toList();
    // print("filteredcategorylist${convertSetToList}");

    return convertSetToList;
  }

  //*********** for adding to Favorite
  Future<bool> checkifproductExistsInFavorite(
      String category, String subCategory) async {
    QuerySnapshot snapshot =
        await Favroitecollection.where("Category", isEqualTo: category)
            .where("SubCategory", isEqualTo: subCategory)
            .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<bool> Favroiteadd(
      {required String category,
      required String subCategory,
      required String productid,
      required String price,
      required String discount,
      required String photo}) async {
    bool favexists =
        await checkifproductExistsInFavorite(category, subCategory);
    if (favexists) {
      print("Already in favroites");
      return false;
    }

    await Favroitecollection.doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("UserFavroiteCollection")
        .doc(productid)
        .set({
      "product": productid,
      "Category": category,
      "SubCategory": subCategory,
      "Price": price,
      "Discount Price": discount,
      "photo": photo,
    }).then((value) => print("Added to Favroite"));
    return true;
  }

  //**************** For adding in cart

  Future<bool> checkifproductExistsInCart(
      String category, String subCategory) async {
    QuerySnapshot snapshot =
        await Cartcollection.where("Category", isEqualTo: category)
            .where('SubCategory', isEqualTo: subCategory)
            .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<bool> cartaddcollection(
      {required String category,
      required String subCategory,
      required String productid,
      required String price,
      required String discount,
      required String photo}) async {
    bool InCartDetailsExists =
        await checkifproductExistsInCart(category, subCategory);
    if (InCartDetailsExists) {
      print("Already in cart");
      return false;
    }
    await Cartcollection.doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("usercartcollection")
        .doc(productid)
        .set({
      "Category": category,
      "SubCategory": subCategory,
      "price": price,
      "Discount": discount,
      "image": photo,
      "userid": FirebaseAuth.instance.currentUser!.uid,
    }).then((value) => print("cart details added"));
    return true;
  }

  //for OrderCollection
  Future<void> OrderCollection(
      String prize,
      String state,
      String city,
      String address,
      String pincode,
      String productname,
      String mail,
      String username,
      String phonenumber,
      String paymentMode,
      String CardNO,
      String CVV,
      String ExpireyDate, String? status, int quantity,) async {
    await OrderDetailsCollection.add({
      "Address": address,
      "State": state,
      "PinCode": pincode,
      "City": city,
      "Product-Name": productname,
      "Product-Price": prize,
      "User-Name": username,
      "User-Email": mail,
      "User-PhoneNumber": phonenumber,
      "Payment-Mode": paymentMode,
      "Card-no": CardNO,
      "CVV": CVV,
      "ExpireyDate": ExpireyDate,
      "UID": FirebaseAuth.instance.currentUser!.uid.toString(),
      "Date&time": DateTime.now().toString(),
      "Status":status,
      "timestamp":Timestamp.now(),
      "Quantity":quantity,

    });
  }

  //for  filtering product

  Future<List<String?>> FilterCompanynames() async {
    List<String?> removeduplicate = [];
    List<productmodelclass> list = await productshow();
    for (int i = 0; i < list.length; i++) {
      removeduplicate.add(list[i].Company);
    }
    Set<String?> convertListtoSet = removeduplicate.toSet();
    List<String?> convertSettoList = convertListtoSet.toList();
    return convertSettoList;
  }

  Future<List<String?>> Filterproduct() async {
    List<String?> removeDoplicate = [];
    List<productmodelclass> list = await productshow();
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
