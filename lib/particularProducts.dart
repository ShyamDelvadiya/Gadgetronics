import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'BuyProductPage.dart';
import 'Model Class/productshowmodelclass.dart';
import 'bottomnavibar.dart';
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

  void share(BuildContext context) async {
    await FlutterShare.share(
      title: 'share this product',
      text:
          '${widget.product!.SubCategories}\nPrice:-${widget.product!.discount}',
      linkUrl: 'Photo:-${widget.product!.photos!.first}',
      chooserTitle: 'Share this Product',
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        primary: Colors.orange,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      setState(() {
                        ref.Favroiteadd(
                                category: widget.product!.category.toString(),
                                subCategory:
                                    widget.product!.SubCategories.toString(),
                                productid: widget.product!.productid.toString(),
                                price: widget.product!.price.toString(),
                                discount: widget.product!.discount.toString(),
                                photo: widget.product!.photos!.first.toString())
                            .whenComplete(() => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        bottomnavibar(selectedindex: 2)),
                                (route) => false));
                      });
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>cart()));

                      const snackBar = SnackBar(
                        duration: Duration(milliseconds: 500),
                          content: Text(
                        "Added to Favroite",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.orange),
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    label: Text("Favroite"),
                    icon: Icon(Icons.favorite),
                  ),
                ),
                Container(
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        primary: Colors.yellow,
                        foregroundColor: Colors.black),
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>cart()));
                      ref
                          .cartaddcollection(
                              category: widget.product!.category.toString(),
                              subCategory:
                                  widget.product!.SubCategories.toString(),
                              productid: widget.product!.productid.toString(),
                              price: widget.product!.price.toString(),
                              discount: widget.product!.discount.toString(),
                              photo: widget.product!.photos!.first.toString())
                          .whenComplete(() => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => bottomnavibar(
                                        selectedindex: 1,
                                      )),
                              (route) => false));

                      const snackBar = SnackBar(
                        duration: Duration(milliseconds: 500),
                          content: Text(
                        "Added to Cart",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.yellow),
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>bottomnavibar()));
                    },
                    label: Text("Add to Cart"),
                    icon: Icon(Icons.shopping_cart),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: Colors.orange,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => buyProduct(
                                productname:
                                    widget.product!.SubCategories.toString(),
                                productImage:
                                    widget.product!.photos!.first.toString(),
                                productPrice:
                                    widget.product!.discount.toString())));
                  },
                  label: Text("Buy Now"),
                  icon: Icon(Icons.shopping_bag),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          widget.product!.SubCategories.toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 23, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topRight,
              child: IconButton(
                iconSize: 30,
                visualDensity: VisualDensity.comfortable,
                color: Colors.orange,
                tooltip: "Share",
                onPressed: () {
                  share(context);
                },
                icon: Icon(Icons.share),
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              CarouselSlider.builder(
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
              // Container(
              //   alignment: Alignment.bottomLeft,
              //   child: IconButton(
              //     onPressed: () {
              //       ref.Favroiteadd(widget.product!);
              //
              //
              //     },
              //     icon: Icon(Icons.favorite_border),
              //   ),
              // )
            ],
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
                  decoration: TextDecoration.lineThrough,
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
