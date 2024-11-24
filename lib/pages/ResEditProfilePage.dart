import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ResEditprofilePage extends StatefulWidget {
  const ResEditprofilePage({super.key});

  @override
  State<ResEditprofilePage> createState() => _ResEditprofilePageState();
}

class _ResEditprofilePageState extends State<ResEditprofilePage> {
  String name = '', address = '', about = '', imageUrl = '';
  TextEditingController name_controller = TextEditingController();
  TextEditingController address_controller = TextEditingController();
  TextEditingController about_controller = TextEditingController();

  Future<void> addDetails() async {
    if (name_controller.text.toString() == "" &&
        address_controller.text.toString() == "" &&
        about_controller.text.toString() == "") {
      Fluttertoast.showToast(
          msg: "Please Fill All Details...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      await FirebaseDatabase.instance
          .ref("ResDetails")
          .child(FirebaseAuth.instance.currentUser!.uid.toString())
          .child('Info')
          .set({
        'Name': name_controller.text.toString(),
        'Address': address_controller.text.toString(),
        'About': about_controller.text.toString(),
        'ImgUrl': imageUrl
      });
      Fluttertoast.showToast(
          msg: "Detail Added Successfully...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        SystemNavigator.pop();
      }
    }
  }

  Future fetchDetails() async {
    FirebaseDatabase.instance.ref("ResDetails").onValue.listen((event) {
      if (event.snapshot
          .hasChild(FirebaseAuth.instance.currentUser!.uid.toString())) {
        var info = event.snapshot
            .child(FirebaseAuth.instance.currentUser!.uid.toString())
            .child('Info');
        name = info.child('Name').value.toString();
        address = info.child('Address').value.toString();
        about = info.child('About').value.toString();
        imageUrl = info.child('ImgUrl').value.toString();
        setState(() {});
      }
    });
  }

  Future uploadImage() async {
    final firebaseStorage = FirebaseStorage.instance;
    var image, file;

    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
    }
    String downloadUrl;

    if (image != null) {
      await firebaseStorage
          .ref()
          .child('images/${FirebaseAuth.instance.currentUser!.uid}/profile_img')
          .putFile(file)
          .then((snapshot) async => {
                downloadUrl = await snapshot.ref.getDownloadURL(),
                setState(() {
                  Fluttertoast.showToast(
                      msg: "Image Uploaded Successfully...",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  imageUrl = downloadUrl;
                })
              });
    } else {
      Fluttertoast.showToast(
          msg: "No Image Path Received...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 77, 55, 100),
          title: const Text('ReservIt')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: InkWell(
                    onTap: () {
                      uploadImage();
                    },
                    // ignore: unnecessary_null_comparison
                    child: (imageUrl == null && imageUrl == '')
                        ? Container(
                            width: 150,
                            height: 150,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2, blurStyle: BlurStyle.outer)
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assests/user_img.jpg')),
                            ),
                          )
                        : Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 2, blurStyle: BlurStyle.outer)
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(imageUrl)),
                            ),
                          )),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Name :- ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 70,
                        width: 230,
                        child: TextFormField(
                          controller: name_controller,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: name,
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Address :- ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 70,
                        width: 210,
                        child: TextFormField(
                          controller: address_controller,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                              hintText: address,
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Text(
                        'About :- ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 70,
                        width: 210,
                        child: TextFormField(
                          controller: about_controller,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                              hintText: about,
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      addDetails();
                    },
                    child: Container(
                      height: 60,
                      width: 150,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 77, 55, 100),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Center(
                          child: Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
