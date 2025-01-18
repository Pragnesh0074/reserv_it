import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:reserv_it/pages/ResBookingDetails.dart';

class ResNavPage1 extends StatefulWidget {
  const ResNavPage1({super.key});

  @override
  State<ResNavPage1> createState() => _ResNavPage1State();
}

class _ResNavPage1State extends State<ResNavPage1> {
  bool isListFetch = false;
  var bookingList = [], userIdList = [];

  Future fetchBookingList() async {
    FirebaseDatabase.instance
        .ref('ResDetails')
        .child(FirebaseAuth.instance.currentUser!.uid.toString())
        .child('BookingDetails')
        .onValue
        .listen((event) async {
      for (DataSnapshot s in event.snapshot.children) {
        userIdList.add(s.key.toString());
        FirebaseDatabase.instance
            .ref('UserDetails')
            .child(s.key.toString())
            .child('Info')
            .onValue
            .listen((event) {
          bookingList.add(event.snapshot.child('Name').value.toString());
          setState(() {});
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBookingList();
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
                'Any Booking Is Not Availabel',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reserved Table Details :-',
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
                                                    ResBookingDetails(
                                                      userId: userIdList[index],
                                                      userName:
                                                          bookingList[index],
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
