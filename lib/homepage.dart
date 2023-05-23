import 'package:Gadgatronics/particularProducts.dart';
import 'package:Gadgatronics/seeAllProducts.dart';
import 'package:Gadgatronics/shopByCategorypage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Model Class/Homeimageclass.dart';
import 'Model Class/productshowmodelclass.dart';
import 'loginpage.dart';
import 'method.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String? selectedcategory;
  String? productid;
  int Activeindex = 0;
  late bool searchbar = false;
  TextEditingController searchcontroller = TextEditingController();
  List<productmodelclass> allproducts = [];

  method ref = method();

  //logout method

  @override
  void initState() {
    print("hgf${searchcontroller.text}");
    // TODO: implement initState
    super.initState();
  }
  Future<bool> _onWillPop() async {


    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit the app?'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: (searchbar == false)
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GradientText(
                "Gadgetronics",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                colors: [
                  Colors.black,
                  Colors.brown,
                  Colors.redAccent,
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Container(
                      height: 500,
                      child: Column(
                        children: [
                          Text("working"),
                        ],
                      ),
                    );
                    setState(() {
                      searchbar = !searchbar;
                    });
                  },
                  icon: Icon(
                    Icons.search,
                    size: 30,
                  ),
                  tooltip: 'search',
                ),
              ),
            ],
          )
              : Container(
            child: TextFormField(
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              controller: searchcontroller,
              onChanged: (v) {
                setState(() {});
              },
              cursorColor: Colors.red,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.red,
                  size: 30,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      searchbar = !searchbar;
                      searchcontroller.clear();
                    });
                  },
                  // style: ButtonStyle(iconColor: MaterialStatePropertyAll(Colors.red)),
                  icon: Icon(
                    Icons.highlight_remove,
                    color: Colors.red,
                  ),
                ),
                hintText: 'Search',
                // labelText: 'Search',
                // labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                fillColor: Colors.white70,
                filled: true,
              ),
            ),
          ),
          elevation: 10,
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          // scrollDirection: Axis.horizontal,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),

              (searchcontroller.text.isNotEmpty) ?
              SizedBox(
                child: FutureBuilder<List<productmodelclass>>(
                  future: ref.productshow(),
                  builder: (context, snapshot) {
                    print("asdaf${snapshot.hasData}");
                    print("asdaf${snapshot.error}");

                    if (snapshot.hasData) {
                      allproducts = snapshot.data!;
                      List<productmodelclass> filteredProduct = allproducts;

                      if (searchcontroller.text.isNotEmpty) {
                        String query = searchcontroller.text.toLowerCase();
                        filteredProduct = filteredProduct
                            .where((element) =>
                            element.SubCategories!
                                .toLowerCase()
                                .contains(query))
                            .toList();
                      }
                      if (filteredProduct.isEmpty) {
                        return Container(
                          height: 500,
                            alignment: Alignment.center,
                            child: const Text("This Product is not available Right Now",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),));
                      }

                      return Container(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            height: 600,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(8.0),
                                scrollDirection: Axis.vertical,
                                itemCount: filteredProduct.length,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 10,
                                ),
                                itemBuilder: (context, i) {
                                  return Container(
                                    // padding: EdgeInsets.all(6.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 300,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      // snapshot.data![i].photos!.first.toString()
                                                        filteredProduct[i]
                                                            .photos!
                                                            .first
                                                            .toString()),
                                                    fit: BoxFit.contain)),
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.all(8.0),
                                        subtitle: Container(
                                          child: Column(
                                            children: [
                                              // Text(snapshot.data![i].category.toString()),
                                              Text(
                                                filteredProduct[i]
                                                    .SubCategories
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      paticularProducts(
                                                          product:
                                                          filteredProduct[
                                                          i])));
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              )

            :
              Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: FutureBuilder<List<homeimagemodelclass>>(
                      future: ref.showimageINhomepage(),
                      builder: (context, snapshot) {
                        if(snapshot.data?.length==0){
                          return Container(
                            alignment: Alignment.center,
                            child: Center(child: CupertinoActivityIndicator(color: Colors.blue,radius: double.infinity,)),
                          );
                        }
                        if (snapshot.hasData) {
                          return CarouselSlider.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i, realindex) {
                              return Container(
                                child: Image.network(
                                    snapshot.data![i].image.toString()),
                              );
                            },

                            options: CarouselOptions(
                                height: 400,
                                onPageChanged: (index, reason) =>
                                    setState(() => Activeindex = index),
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                // clipBehavior: Clip.antiAlias,
                                // animateToClosest: true,
                                scrollDirection: Axis.horizontal),
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.center,
                        child: Text("shop by category",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 70,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: FutureBuilder<List>(
                      future: ref.Filterproduct(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print("data${snapshot.data!.length}");

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) {
                              return Container(
                                  width: 200,
                                  padding: EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 6.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      print("object${snapshot.data![i]}");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  categorypage(
                                                      selectedcategory:
                                                      snapshot.data![i])));
                                    },
                                    child: Text(
                                      snapshot.data![i].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black),
                                    ),
                                  ));
                            },
                          );
                        }
                        return const CupertinoActivityIndicator();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Popular Products",
                            style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => seeallproducts()));
                          },
                          child: Text(
                            "See All",
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          )),
                    ],
                  ),
                  SizedBox(
                    child: FutureBuilder<List<productmodelclass>>(
                      future: ref.productshow(),
                      builder: (context, snapshot) {
                        print("asdaf${snapshot.hasData}");
                        print("asdaf${snapshot.error}");

                        if (snapshot.hasData) {
                          // allproducts = snapshot.data!;
                          // List<productmodelclass> filteredProduct = allproducts;
                          //
                          // if (searchcontroller.text.isNotEmpty) {
                          //   String query = searchcontroller.text.toLowerCase();
                          //   filteredProduct = filteredProduct
                          //       .where((element) =>
                          //       element.SubCategories!
                          //           .toLowerCase()
                          //           .contains(query))
                          //       .toList();
                          // }
                          // if (filteredProduct.isEmpty) {
                          //   return const Text("No Data Found");
                          // }

                          return Container(
                            child: SingleChildScrollView(
                              child: SizedBox(
                                height: 609,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridView.builder(

                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.all(8.0),
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data!.length,
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemBuilder: (context, i) {
                                      return Container(
                                        // padding: EdgeInsets.all(6.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            title: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 300,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          // snapshot.data![i].photos!.first.toString()
                                                            snapshot.data![i]
                                                                .photos!
                                                                .first
                                                                .toString()),
                                                        fit: BoxFit.contain)),
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.all(8.0),
                                            subtitle: Container(
                                              child: Column(
                                                children: [
                                                  // Text(snapshot.data![i].category.toString()),
                                                  Text(
                                                    snapshot.data![i]
                                                        .SubCategories
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          paticularProducts(
                                                              product:
                                                              snapshot.data![
                                                              i])));
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
