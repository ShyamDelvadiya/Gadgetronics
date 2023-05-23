import 'package:Gadgatronics/useraccount.dart';
import 'package:flutter/material.dart';

import 'Model Class/Cartmodelcalss.dart';
import 'cart.dart';
import 'favorite.dart';
import 'homepage.dart';
import 'method.dart';

class bottomnavibar extends StatefulWidget {
  int? selectedindex = 0;

  bottomnavibar({
    Key? key,required this.selectedindex
  }) : super(key: key);

  @override
  State<bottomnavibar> createState() => _bottomnavibarState();
}

class _bottomnavibarState extends State<bottomnavibar> {
  // int? selectedindex;
  method ref = method();
  List<Widget> widgetspage = [
    homepage(),
    cart(),
    favroite(),
    useraccount(),
  ];


  Future<bool> _onWillPop() async {

    if(widget.selectedindex==0){
      return true;
    }

    widget.selectedindex=0;
    setState(() {

    });
    return false;
    // return (await showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: Text('Are you sure?'),
    //     content: Text('Do you want to exit the app?'),
    //     actions: <Widget>[
    //       ElevatedButton(
    //         onPressed: () => Navigator.of(context).pop(false),
    //         child: Text('No'),
    //       ),
    //       ElevatedButton(
    //         onPressed: () => Navigator.of(context).pop(true),
    //         child: Text('Yes'),
    //       ),
    //     ],
    //   ),
    // )) ??
    //     false;
  }


  @override
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(

          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          currentIndex: widget.selectedindex!.toInt(),
          onTap: (vale) {
            setState(() {
              widget.selectedindex = vale;
            });
          },
          items: [
            const BottomNavigationBarItem(


              icon: Icon(Icons.home),
              backgroundColor: Colors.blue,
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.blue,

              icon: Badge(
                // largeSize: 30,
                // alignment: AlignmentDirectional.topCenter,
                label: FutureBuilder<List<cartmodelclass>>(
                  future: ref.cartshow(),
                  builder: (context, snaphot) {
                    print("cart${snaphot.data}");
                    print("error${snaphot.error}");

                    if (snaphot.hasData) {
                      return Text(snaphot.data!.length.toString());
                    }
                    return Text("0");
                  },
                ),

                child: Icon(Icons.shopping_cart),
              ),
              // backgroundColor: Colors.red,
              label: 'cart',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.blue,

              icon: Icon(Icons.favorite),
              // backgroundColor: Colors.blue,
              label: 'Favroite',
            ),
            const BottomNavigationBarItem(
              backgroundColor: Colors.blue,


              icon: Icon(Icons.account_circle_outlined),
              // backgroundColor: Colors.blue,
              label: 'Account',
            ),
          ],
        ),
        body: widgetspage.elementAt(widget.selectedindex!.toInt()),
      ),
    );
  }
}
