import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'OrderPlacePage.dart';

// ignore: must_be_immutable
class RestroPage extends StatefulWidget {
  String restroId;

  RestroPage({required this.restroId, super.key});

  @override
  State<RestroPage> createState() => _RestroPageState();
}

class _RestroPageState extends State<RestroPage> {
  String dropdownvalue = 'Single Table (Stn)';
  var items = [
    'Single Table (Stn)',
    'Couple Table (Ctn)',
    'Family Table (Ftn)',
  ];
  String selectedTableType = '';
  DatabaseReference resRef = FirebaseDatabase.instance.ref("ResDetails");
  bool result = false, lastResult = false;
  DateTime selectedDate = DateTime.now();
  TextEditingController not_controller = TextEditingController();
  int availTable = 0, totalTable = 0, bookedTable = 0;

  Future checkTable() async {
    await resRef.onValue.listen((event) {
      resRef
          .child(widget.restroId)
          .child('BookedTableDetails')
          .onValue
          .listen((event) {
        resRef.child(widget.restroId).child('TableDetails').onValue.listen((e) {
          if (int.parse(
                  event.snapshot.child(selectedTableType).value.toString()) ==
              int.parse(e.snapshot.child(selectedTableType).value.toString())) {
            totalTable = int.parse(
                event.snapshot.child(selectedTableType).value.toString());
            bookedTable =
                int.parse(e.snapshot.child(selectedTableType).value.toString());
            result = true;
            setState(() {});
          } else {
            result = false;
            setState(() {});
          }
        });
      });
    });
  }

  // Future lastTableCheck() async {
  //   if (int.parse(not_controller.text.toString()) <
  //       (totalTable - bookedTable)) {
  //     lastResult = true;
  //     setState(() {});
  //   } else {
  //     availTable = totalTable - bookedTable;
  //     lastResult = false;
  //     setState(() {});
  //   }
  // }

  void bookTable() {
    var bookingDetails = {};
    // lastTableCheck();
    // if (lastResult) {
    if (not_controller.text.toString() != '') {
      bookingDetails['RestroId'] = widget.restroId;
      bookingDetails['userId'] =
          FirebaseAuth.instance.currentUser!.uid.toString();
      bookingDetails['tableType'] = selectedTableType;
      bookingDetails['nFt'] = int.parse(not_controller.text.toString());
      bookingDetails['date'] = DateFormat("dd-MM-yyyy").format(selectedDate);
      bookingDetails['time'] = DateFormat("hh:mm:ss").format(selectedDate);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OrderPlacePage(
                  bookingDetails: bookingDetails,
                )),
      );
    } else {
      Fluttertoast.showToast(
          msg: "Please Fill All Details...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    // } else {
    //   Fluttertoast.showToast(
    //       msg: "Sorry only $availTable tables are availabel...",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // }
  }

  Widget createContainer(String tableType) {
    setState(() {
      selectedTableType = tableType;
    });
    checkTable();
    if (result) {
      return Container(
          width: double.maxFinite,
          child: const Center(
            child: Text(
              'Sorry... Table Is Not Availlabel',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ));
    } else {
      return Container(
        width: double.maxFinite,
        child: Column(
          children: [
            const Text(
              'Enter No. Of Table : ',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: TextFormField(
                controller: not_controller,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () async {
                await showCupertinoModalPopup<void>(
                  context: context,
                  builder: (_) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      height: 200,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.dateAndTime,
                        onDateTimeChanged: (value) {
                          setState(() {
                            selectedDate = value;
                          });
                        },
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromRGBO(0, 77, 55, 30)),
                child: const Center(
                    child: Text(
                  'Choose Date And Time',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Picked Date And Time :- \n $selectedDate',
              textAlign: TextAlign.center,
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
                  'Book Table',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 77, 55, 100),
        title: const Text('ReservIt'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
          child: Column(
            children: [
              const Center(
                  child: Text(
                'Reserve Your Table :-',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Select Table Type : ',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 35, right: 35),
                height: 60,
                width: double.maxFinite,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 77, 55, 100), width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  value: dropdownvalue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              if (dropdownvalue == 'Single Table (Stn)') createContainer('Stn'),
              if (dropdownvalue == 'Couple Table (Ctn)') createContainer('Ctn'),
              if (dropdownvalue == 'Family Table (Ftn)') createContainer('Ftn'),
            ],
          ),
        ),
      ),
    );
  }
}
