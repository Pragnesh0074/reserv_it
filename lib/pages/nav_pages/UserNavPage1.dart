import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:reserv_it/pages/RestroPage.dart';

class UserNavPage1 extends StatefulWidget {
  const UserNavPage1({super.key});

  @override
  State<UserNavPage1> createState() => _UserNavPage1State();
}

class _UserNavPage1State extends State<UserNavPage1> {
  var nameList = [], addressList = [], imageUrlList = [], restroIdList = [];
  bool isResListFetch = false;

  Future makeRestroList() async {
    FirebaseDatabase.instance.ref('ResUser').onValue.listen((event) {
      for (DataSnapshot s in event.snapshot.children) {
        FirebaseDatabase.instance
            .ref("ResDetails")
            .child(s.key.toString())
            .child('Info')
            .onValue
            .listen((e) {
          restroIdList.add(s.key.toString());
          nameList.add(e.snapshot.child('Name').value.toString());
          addressList.add(e.snapshot.child('Address').value.toString());
          imageUrlList.add(e.snapshot.child('ImgUrl').value.toString());
          setState(() {});
        });
      }
    });
  }

  ImageProvider<Object> loadImage(int index) {
    if (imageUrlList.isNotEmpty) {
      return NetworkImage(imageUrlList[index]);
    } else {
      return const AssetImage('assests/user_img.jpg');
    }
  }

  @override
  void initState() {
    super.initState();
    makeRestroList();
    setState(() {
      isResListFetch = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Availabel Restaurants :-',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            isResListFetch
                ? SizedBox(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: ListView.builder(
                        itemCount: nameList.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RestroPage(
                                            restroId: restroIdList[index],
                                          )),
                                );
                              },
                              child: Container(
                                width: double.maxFinite,
                                height: 100,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        blurStyle: BlurStyle.outer)
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: double.maxFinite,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          image: DecorationImage(
                                              image: loadImage(index),
                                              fit: BoxFit.cover)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 30),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            nameList[index],
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            addressList[index],
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        })),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                    color: Colors.green,
                  )),
          ],
        ),
      ),
    ));
  }
}
