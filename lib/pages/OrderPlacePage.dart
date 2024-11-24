import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reserv_it/pages/HomePage.dart';

// ignore: must_be_immutable
class OrderPlacePage extends StatefulWidget {
  var bookingDetails = {};

  OrderPlacePage({required this.bookingDetails, super.key});

  @override
  State<OrderPlacePage> createState() => _OrderPlacePageState();
}

class _OrderPlacePageState extends State<OrderPlacePage> {
  String restroName = '', tableType = '', date = '', time = '';
  int nOt = 0;

  Future fetchRestroName() async {
    await FirebaseDatabase.instance
        .ref('ResDetails')
        .child(widget.bookingDetails['RestroId'])
        .child('Info')
        .onValue
        .listen((event) {
      restroName = event.snapshot.child('Name').value.toString();
      setState(() {});
    });
  }

  Future bookTable() async {
    await FirebaseDatabase.instance
        .ref('Bookings')
        .child(widget.bookingDetails['userId'])
        .child(widget.bookingDetails['RestroId'])
        .set(widget.bookingDetails);
    await FirebaseDatabase.instance
        .ref('ResDetails')
        .child(widget.bookingDetails['RestroId'])
        .child('BookingDetails')
        .child(widget.bookingDetails['userId'])
        .set(widget.bookingDetails);
    await FirebaseDatabase.instance
        .ref('ResDetails')
        .child(widget.bookingDetails['RestroId'])
        .child('BookedTableDetails')
        .once()
        .then((DatabaseEvent e) => {
              FirebaseDatabase.instance
                  .ref('ResDetails')
                  .child(widget.bookingDetails['RestroId'])
                  .child('BookedTableDetails')
                  .child(widget.bookingDetails['tableType'])
                  .set(int.parse(e.snapshot
                          .child(widget.bookingDetails['tableType'])
                          .value
                          .toString()) +
                      int.parse(widget.bookingDetails['nFt']))
            });
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
    Fluttertoast.showToast(
        msg: "Table Booked Successfully...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.bookingDetails);
    fetchRestroName();
    tableType = widget.bookingDetails['tableType'];
    nOt = widget.bookingDetails['nFt'];
    date = widget.bookingDetails['date'];
    time = widget.bookingDetails['time'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 77, 55, 100),
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
                onTap: () {
                  bookTable();
                },
                child: Container(
                  height: 60,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromRGBO(0, 77, 55, 30)),
                  child: const Center(
                      child: Text(
                    'Confirm And Book Table',
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
