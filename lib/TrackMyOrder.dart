import 'dart:math';

import 'package:flutter/material.dart';

import 'package:im_stepper/stepper.dart';

import 'Model Class/MyOrders.dart';

class TrackingOrderScreen extends StatefulWidget {
  OrderModelClass? product;

  TrackingOrderScreen({Key? key, this.product}) : super(key: key);

  @override
  State<TrackingOrderScreen> createState() => _TrackingOrderScreenState();
}

class _TrackingOrderScreenState extends State<TrackingOrderScreen> {
  int? randomnumber = Random().nextInt(1000);
  int? ActiveStep=0;
  @override
  void initState() {
    super.initState();
    switch (widget.product!.status) {
      case "Order Confirmed":
        ActiveStep = 0;
        break;
      case "shipped":
        ActiveStep = 1;
        break;
      case "Out for Delivery":
        ActiveStep = 2;
        break;
      case "Delivered":
        ActiveStep = 3;
        break;
    }
  }



  List<TrackOrderList> trackOrderList = [
    TrackOrderList(
        title: "Order Confirmed ", subtitle: "your order has been placed"),

    TrackOrderList(title: "shipped", subtitle: "your item has been shipped"),
    TrackOrderList(
        title: "Out for Delivery", subtitle: "your order is out for delivery"),
    TrackOrderList(
        title: "Delivered", subtitle: "your order has been delivered")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Order Tracking'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product-Id:-${widget.product!.id}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'Order #${randomnumber}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.8,
                width: MediaQuery.of(context).size.width / 6,
                child: IconStepper(
                  direction: Axis.vertical,
                  enableNextPreviousButtons: false,
                  enableStepTapping: false,
                  stepColor: Colors.grey,
                  activeStep: ActiveStep!.toInt(),
                  activeStepColor: Colors.green,
                  stepReachedAnimationDuration:
                  const Duration(seconds: 1),
                  activeStepBorderColor: Colors.white,
                  activeStepBorderWidth: 0.0,
                  activeStepBorderPadding: 0.0,
                  previousButtonIcon: const Icon(Icons.arrow_back),
                  lineColor: Colors.green,
                  scrollingDisabled: true,
                  lineLength: 70.0,
                  lineDotRadius: 2.0,
                  stepRadius: 16.0,
                  icons: const [
                    Icon(
                      Icons.radio_button_checked,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Container(
                  height: 410,

                  child: ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    physics: NeverScrollableScrollPhysics(),

                    itemCount: trackOrderList.length,
                    itemBuilder: (context, index) {
                      final item= trackOrderList[index];
                      return Column(
                        children: [
                          Container(
                            height: 33,
                          ),
                          ListTile(
                            title: Text(item.title),
                            subtitle: Text(item.subtitle),
                          ),
                        ],
                      );


                    },
                  ),
                ),
              ),
            ],
          ),


          (ActiveStep==3)?
              Container(width:50,child: ElevatedButton(onPressed: (){}, child: Text("OK")))
              : Container(),

        ],
      ),
    );
  }
}

class TrackOrderList {
  final String title;
  final String subtitle;

  TrackOrderList({required this.title, required this.subtitle});
}
