import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:reserv_it/pages/OrderDetails.dart';

class UserNavPage2 extends StatefulWidget {
  const UserNavPage2({super.key});

  @override
  State<UserNavPage2> createState() => _UserNavPage2State();
}

class _UserNavPage2State extends State<UserNavPage2> {
  bool isListFetch = false;
  var bookingList = [], restroIdList = [];

  Future fetchBookings() async {
    FirebaseDatabase.instance
        .ref('Bookings')
        .child(FirebaseAuth.instance.currentUser!.uid.toString())
        .onValue
        .listen((event) async {
      for (DataSnapshot s in event.snapshot.children) {
        restroIdList.add(s.key.toString());
        FirebaseDatabase.instance
            .ref('ResUser')
            .child(s.key.toString())
            .onValue
            .listen((event) {
          bookingList.add(event.snapshot.child('name').value.toString());
          setState(() {});
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBookings();
    setState(() {
      isListFetch = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bookingList.isEmpty
          ? const Center(
              child: Text(
              'No Booking Availables...',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ))
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Bookings :-',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    isListFetch
                        ? SizedBox(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            child: ListView.builder(
                                itemCount: bookingList.length,
                                itemBuilder: ((context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderDetails(
                                                      restroId:
                                                          restroIdList[index],
                                                    )),
                                          );
                                        },
                                        child: Container(
                                          width: double.maxFinite,
                                          height: 80,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 2,
                                                  blurStyle: BlurStyle.outer)
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              bookingList[index],
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
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
            ),
    );
  }
}
