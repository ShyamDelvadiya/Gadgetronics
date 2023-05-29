import 'package:admin/ProductUpdatePage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Model class/productmodelclass.dart';
import 'homepage.dart';
import 'method.dart';

class paticularProducts extends StatefulWidget {
  productmodelclass? product;

  paticularProducts({Key? key, this.product}) : super(key: key);

  @override
  State<paticularProducts> createState() => _paticularProductsState();
}

class _paticularProductsState extends State<paticularProducts> {
  method ref = method();
  int activeIndex = 0;
  int? Index;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductUpdatePage(
            Category:widget.product!.category.toString(),
            SubCategory:widget.product!.SubCategories.toString(),
            Company:widget.product!.Company.toString(),
            Description:widget.product!.description.toString(),
            Discount:widget.product!.discount.toString(),
            price:widget.product!.price.toString(),
            Id:widget.product!.productid.toString()


          )));
        },child:Text("Update"), ),
      ),

      appBar: AppBar(
        title: Text(
          widget.product!.SubCategories.toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 23, color: Colors.black),
        ),

        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ListTile(
            onTap: (){
              print("particularimage${widget.product!.photos![activeIndex]}");
              ref.DeleteImageOfProduct(id:widget.product!.productid.toString(),image:widget.product!.photos![activeIndex].toString());


            },

            title: CarouselSlider.builder(
                options: CarouselOptions(
                  height: 350,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration:
                  const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index),
                ),
                itemCount: widget.product!.photos!.length,
                itemBuilder: (context, index, realIndex) {
                  print("img...${widget.product!.photos![index].toString()}");
                  return Container(
                    child: Image.network(
                        widget.product!.photos![index].toString()),
                  );
                }),
          ),
          AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: widget.product!.photos!.length,
          ),
          Container(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product!.SubCategories.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.product!.description.toString(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ),
          Container(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                "M.R.P:-${widget.product!.price}/-",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  // decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Discounted price:-${widget.product!.discount}/-",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
