import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reserv_it/pages/HomePage.dart';

// ignore: must_be_immutable
class OrderDetails extends StatefulWidget {
  String restroId;
  OrderDetails({required this.restroId, super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String restroName = '', tableType = '', date = '', time = '';
  int nOt = 0;

  Future fetchRestroName() async {
    FirebaseDatabase.instance
        .ref('ResDetails')
        .child(widget.restroId)
        .child('Info')
        .onValue
        .listen((event) {
      restroName = event.snapshot.child('Name').value.toString();
      setState(() {});
    });
  }

  Future fetchDetails() async {
    FirebaseDatabase.instance
        .ref('Bookings')
        .child(FirebaseAuth.instance.currentUser!.uid.toString())
        .child(widget.restroId)
        .onValue
        .listen((event) {
      tableType = event.snapshot.child('tableType').value.toString();
      date = event.snapshot.child('date').value.toString();
      time = event.snapshot.child('time').value.toString();
      nOt = int.parse(event.snapshot.child('nFt').value.toString());
      setState(() {});
    });
  }

  Future deleteBooking() async {
    await FirebaseDatabase.instance
        .ref('ResDetails')
        .child(widget.restroId)
        .child('BookingDetails')
        .child(FirebaseAuth.instance.currentUser!.uid.toString())
        .remove();
    await FirebaseDatabase.instance
        .ref('Bookings')
        .child(FirebaseAuth.instance.currentUser!.uid.toString())
        .child(widget.restroId)
        .remove();
    Fluttertoast.showToast(
        msg: "Booking Cancel...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRestroName();
    fetchDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 77, 55, 1),
        title: const Text('ReservIt'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
        child: Center(
          child: Column(
            children: [
              const Text(
                'Booking Details',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Restaurant Name :- $restroName',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Table Type :- $tableType',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'No. Of Tables :- $nOt',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Date :- $date',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Time :- $time',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 60,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromRGBO(0, 77, 55, 30)),
                  child: const Center(
                      child: Text(
                    'Cancel Booking',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
