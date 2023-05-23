import 'package:flutter/material.dart';

class helpcenter extends StatefulWidget {
  const helpcenter({Key? key}) : super(key: key);

  @override
  State<helpcenter> createState() => _helpcenterState();
}

class _helpcenterState extends State<helpcenter> {
String Email="admin@gmail.com";
String? recipient;
String? subject;






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(

          children: [
            Container(height: 300,
                alignment: Alignment.center,
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("For any help Plzz Contact Us"),
                    Text("admin@gmail.com"),




                  ],
                )),


          ],
        ),
      ),

    );
  }
}












