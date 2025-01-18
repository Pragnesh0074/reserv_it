import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserEditProfilePage extends StatefulWidget {
  const UserEditProfilePage({super.key});

  @override
  State<UserEditProfilePage> createState() => _UserEditProfilePageState();
}

class _UserEditProfilePageState extends State<UserEditProfilePage> {
  String name = '';
  TextEditingController name_controller = TextEditingController();

  Future<void> addDetails() async {
    if (name_controller.text.toString() == "") {
      Fluttertoast.showToast(
          msg: "Please Fill All Details...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      await FirebaseDatabase.instance
          .ref("UserDetails")
          .child(FirebaseAuth.instance.currentUser!.uid.toString())
          .child('Info')
          .set({
        'Name': name_controller.text.toString(),
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
    FirebaseDatabase.instance.ref("UserDetails").onValue.listen((event) {
      if (event.snapshot
          .hasChild(FirebaseAuth.instance.currentUser!.uid.toString())) {
        name = event.snapshot
            .child(FirebaseAuth.instance.currentUser!.uid.toString())
            .child('Info')
            .child('Name')
            .value
            .toString();
        setState(() {});
      }
    });
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
          backgroundColor: const Color.fromRGBO(0, 77, 55, 1),
          title: const Text('ReservIt')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    boxShadow: [
                      BoxShadow(blurRadius: 2, blurStyle: BlurStyle.outer)
                    ],
                    image: DecorationImage(
                        image: AssetImage('assests/user_img.jpg')),
                  ),
                ),
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
                          color: Color.fromRGBO(0, 77, 55, 1),
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
