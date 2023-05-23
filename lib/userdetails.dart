import 'package:Gadgatronics/bottomnavibar.dart';
import 'package:Gadgatronics/updateuserdetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'Model Class/userdetailsclass.dart';
import 'method.dart';

class userdetails extends StatefulWidget {
  const userdetails({Key? key}) : super(key: key);

  @override
  State<userdetails> createState() => _userdetailsState();
}

class _userdetailsState extends State<userdetails> {
  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  method ref = method();


  _0nwillScope()async{
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>bottomnavibar(selectedindex: 3)), (route) => false);
    return false;
  }





  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _0nwillScope(),

      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                setState(() {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => bottomnavibar(selectedindex: 3)),
                      (route) => false);
                });
              },
              icon: const Icon(Icons.arrow_back)),
          title: GradientText(
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
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 800,
                child: FutureBuilder<List<userdetailmodel>>(
                  future: ref.showuserdetails().then((value) => value
                      .where((element) =>
                          element.Uid == FirebaseAuth.instance.currentUser?.uid)
                      .toList()),
                  builder: (context, snapshot) {
                    print("hi${snapshot.hasData}");

                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, i) {
                            final item = snapshot.data?[i];
                            ref.showuserdetails();
                            print("id${snapshot.data![i].id}");

                            return Column(
                              children: [
                                Container(
                                  height: 200,
                                ),
                                ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Name:-${snapshot.data![i].Name.toString()}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Divider(
                                        color: Colors.black,
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "password:-${snapshot.data![i].password.toString()}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.black,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "MailId:-${snapshot.data![i].Mail.toString()}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.black,
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "PhoneNO:-${snapshot.data![i].Phonenumber.toString()}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.black,
                                      ),

                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        child: ElevatedButton.icon(
                                            icon: const Icon(Icons.update),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          userupdate(
                                                            snapshot.data![i].Name
                                                                .toString(),
                                                            snapshot.data![i].Mail
                                                                .toString(),
                                                            snapshot
                                                                .data![i].password
                                                                .toString(),
                                                            snapshot.data![i]
                                                                .Phonenumber
                                                                .toString(),
                                                            snapshot.data![i].id
                                                                .toString(),
                                                          )));
                                            },
                                            label: const Text("Update")),
                                      ),

                                      // TextFormField(
                                      //
                                      //   // controller: name,
                                      //   decoration: InputDecoration(
                                      //     labelText: "hi",
                                      //   ),
                                      //
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          });
                    } else {
                      return Center(
                        child: Column(
                          children: [
                            const CircularProgressIndicator(),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
