import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddEditTabelPage extends StatefulWidget {
  const AddEditTabelPage({super.key});

  @override
  State<AddEditTabelPage> createState() => _AddEditTabelPageState();
}

class _AddEditTabelPageState extends State<AddEditTabelPage> {
  int stn = 0;
  int ctn = 0;
  int ftn = 0;

  TextEditingController stn_controller = TextEditingController();
  TextEditingController ctn_controller = TextEditingController();
  TextEditingController ftn_controller = TextEditingController();

  Future<void> addDetails() async {
    await FirebaseDatabase.instance
        .ref("ResDetails")
        .child(FirebaseAuth.instance.currentUser!.uid.toString())
        .child('TableDetails')
        .set({
      'Stn': int.parse(stn_controller.text.toString()),
      'Ctn': int.parse(ctn_controller.text.toString()),
      'Ftn': int.parse(ftn_controller.text.toString())
    });
    await FirebaseDatabase.instance
        .ref("ResDetails")
        .child(FirebaseAuth.instance.currentUser!.uid.toString())
        .child('BookedTableDetails')
        .set({'Stn': 0, 'Ctn': 0, 'Ftn': 0});
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

  Future fetchDetails() async {
    FirebaseDatabase.instance
        .ref("ResDetails")
        .child(FirebaseAuth.instance.currentUser!.uid.toString())
        .onValue
        .listen((event) {
      if (event.snapshot.hasChild('TableDetails')) {
        stn = int.parse(
            event.snapshot.child('TableDetails').child('Stn').value.toString());
        ctn = int.parse(
            event.snapshot.child('TableDetails').child('Ctn').value.toString());
        ftn = int.parse(
            event.snapshot.child('TableDetails').child('Ftn').value.toString());
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 77, 55, 1),
        title: const Text('ReservIt'),
      ),
      // ignore: prefer_const_constructors
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: [
              const Text(
                'Enter Availabel Tables Details :-',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 80,
              ),
              Text('Currunt Value = $stn'),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: stn_controller,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    hintText: 'Enter Total No. Of Single Tables',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
              const SizedBox(
                height: 50,
              ),
              Text('Currunt Value = $ftn'),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: ftn_controller,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    hintText: 'Enter Total No. Of Family Tables',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
              const SizedBox(
                height: 50,
              ),
              Text('Currunt Value = $ctn'),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: ctn_controller,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    hintText: 'Enter Total No. Of Couples Tables',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
              const SizedBox(
                height: 80,
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
          ),
        ),
      ),
    );
  }
}
