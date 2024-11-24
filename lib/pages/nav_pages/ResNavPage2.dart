import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:reserv_it/pages/AddEditTablesPage.dart';
import 'package:reserv_it/pages/ResEditProfilePage.dart';
import 'package:reserv_it/pages/WelcomePage.dart';
import 'package:reserv_it/utils/FirebaseUtils.dart';

class ResNavPage2 extends StatefulWidget {
  const ResNavPage2({super.key});

  @override
  State<ResNavPage2> createState() => _ResNavPage2State();
}

class _ResNavPage2State extends State<ResNavPage2> {
  FirebaseUtils firebaseUtils = FirebaseUtils();
  String imageUrl = '';

  Future fetchDetails() async {
    FirebaseDatabase.instance.ref("ResDetails").onValue.listen((event) {
      if (event.snapshot
          .hasChild(FirebaseAuth.instance.currentUser!.uid.toString())) {
        var info = event.snapshot
            .child(FirebaseAuth.instance.currentUser!.uid.toString())
            .child('Info');
        imageUrl = info.child('ImgUrl').value.toString();
        setState(() {});
      }
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  width: double.maxFinite,
                  height: 500,
                  decoration: const BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(blurRadius: 5, blurStyle: BlurStyle.outer)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AddEditTabelPage()),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                                color: Colors.white12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2, blurStyle: BlurStyle.outer)
                                ]),
                            child: const Center(
                                child: Text(
                              'Add/Edit Tables',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ResEditprofilePage()),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                                color: Colors.white12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2, blurStyle: BlurStyle.outer)
                                ]),
                            child: const Center(
                                child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: InkWell(
                          onTap: () {
                            firebaseUtils.firebaseLogout();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WelcomePage()),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                                color: Colors.white12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2, blurStyle: BlurStyle.outer)
                                ]),
                            child: const Center(
                                child: Text(
                              'Logout',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 500),
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
                            ),
                            child: const CircularProgressIndicator(
                              color: Colors.blue,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
