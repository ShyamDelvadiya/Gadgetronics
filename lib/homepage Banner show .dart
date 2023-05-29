import 'package:admin/Model%20class/UserHomeImage.dart';
import 'package:admin/drawer.dart';
import 'package:admin/method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Banner for homepage.dart';

class UserHomeScreenImageShow extends StatefulWidget {
  const UserHomeScreenImageShow({Key? key}) : super(key: key);

  @override
  State<UserHomeScreenImageShow> createState() =>
      _UserHomeScreenImageShowState();
}

class _UserHomeScreenImageShowState extends State<UserHomeScreenImageShow> {
  method ref = method();

  ImagedeleteDialogBox({required String Id}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Are Your Sure You Want to  Delete This Iamge"),
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ref.DeleteImageFromHomePageoFUser(id: Id)
                          .whenComplete(() => ScaffoldMessenger.of(context)
                              .showSnackBar(
                                  SnackBar(content: Text("Image Deleted"))))
                          .whenComplete(() => Navigator.pop(context));
                    });
                  },
                  child: Text("Yes")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User HomePage Screen Image"),
        centerTitle: true,
      ),
      drawer: Navidrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 700,
              child: FutureBuilder<List<userhome>>(
                future: ref.showUserHomeImage(),
                builder: (context, snapshot) {

                  if(snapshot.data?.length==0){
                    return Center(child: Column(
                      children: [
                        Container(
                          height: 200,
                        ),
                        TextButton(onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>imageforhomepage()));
                        }, child: Text("HomeScreen is Empty.Click On this to add",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                      ],
                    ));
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(color: Colors.black)),
                            child: ListTile(
                              title: Container(
                                child: Image.network(
                                    snapshot.data![i].image.toString()),
                                height: 200,
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    print("id:_${snapshot.data![i].id}");
                                    setState(() {
                                      ImagedeleteDialogBox(
                                          Id: snapshot.data![i].id.toString(),);
                                    });
                                  },
                                  icon: Icon(Icons.delete)),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
