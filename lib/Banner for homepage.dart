import 'package:admin/homepage.dart';
import 'package:admin/method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class imageforhomepage extends StatefulWidget {
  const imageforhomepage({Key? key}) : super(key: key);

  @override
  State<imageforhomepage> createState() => _imageforhomepageState();
}

class _imageforhomepageState extends State<imageforhomepage> {
  method ref = method();
  bool _isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Homepage Banner Add"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    // backgroundColor: Colors.black,
                    // foregroundColor: Colors.deepPurple,
                  ),
                  onPressed: () {
                    ref.openimagepicker().then((value) => setState(() {}));
                  },
                  label: const Text(
                    "Select an image",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  icon: const Icon(Icons.image)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (ref.photo == null)
                  ? Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 3)),
                      alignment: Alignment.center,
                      // color: Colors.red,
                      width: 500,
                      height: 500,
                      child: const Text(
                        "Select an image",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(
                      // decoration: BoxDecoration(border: Border.all()),
                      alignment: Alignment.center,
                      width: 400,
                      height: 300,
                      color: Colors.white,
                      child: Image.file(ref.photo!, fit: BoxFit.fill)),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  // primary: Colors.black,
                  // foregroundColor: Colors.deepPurple,
                ),
                onPressed: () async {

                  if (ref.photo == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Plzz Select Image")));
                  } else {
                    setState(() {
                      setState(() {
                        _isloading = true;
                      });
                      Future.delayed(const Duration(seconds: 10), () {
                        setState(() {
                          _isloading = false;
                        });
                      });
                      ref
                          .addimageInHomepage()
                          .whenComplete(() => ScaffoldMessenger.of(context)
                              .showSnackBar(
                                  const SnackBar(content: Text("Image Added"))))
                          .whenComplete(() => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const homepage())));
                    });
                  }
                },
                child: _isloading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Updating...",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ],
                      )
                    : const Text(
                        "Upload",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
          ],
        ),
      ),
    );
  }
}
