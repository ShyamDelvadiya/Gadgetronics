
import 'package:admin/adminprofile.dart';
import 'package:admin/homepage.dart';
import 'package:admin/method.dart';
import 'package:admin/usershow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Banner for homepage.dart';
import 'Model class/admindetails.dart';
import 'login.dart';

class Navidrawer extends StatelessWidget {
  Navidrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Header(context),
              Menuitems(context),
            ],
          ),
        ),
      );
  method ref = method();

  Widget Header(context) => Container(
      height: 150,
      color: Colors.blue.shade700,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // height: 200,
          child: FutureBuilder<List<adminmodel>>(
            future: ref.admindetails().then((value) => value
                .where((element) =>
                    element.mail == FirebaseAuth.instance.currentUser?.email)
                .toList()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data![i].name.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          snapshot.data![i].mail.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        // Text("Phonenumber:-${snapshot.data![i].phonenumber.toString()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        // Text("Password:-${snapshot.data![i].password.toString()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      ],
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ));

  Widget Menuitems(context) => SafeArea(
    child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.home_filled),
              title: SizedBox(
                  child: Text('Home')),

              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => homepage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text('My Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => adminprofile()));
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Add Image to Homepage'),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>imageforhomepage()));
              },
            ),
            const Divider(
              color: Colors.black,
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                final FirebaseAuth admin = FirebaseAuth.instance;

                logout() async {
                  await admin.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Loginpage(title: "Admin Login")),(route) => false,);
                }

                logoutdialogbox() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text("Are you sure you want to logout?"),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                logout();
                              },
                              child: Text("Logout")),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                        ],
                      );
                    },
                  );
                }

                logoutdialogbox();
              },
            ),
          ],
        ),
  );
}
