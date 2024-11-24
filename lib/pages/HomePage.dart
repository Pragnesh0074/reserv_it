import 'package:flutter/material.dart';
import 'package:reserv_it/pages/nav_pages/UserNavPage1.dart';
import 'package:reserv_it/pages/nav_pages/UserNavPage2.dart';
import 'package:reserv_it/utils/FirebaseUtils.dart';

import 'nav_pages/UserNavPage3.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseUtils firebaseUtils = FirebaseUtils();
  int currIndex = 0;
  final pages = const [UserNavPage1(), UserNavPage2(), UserNavPage3()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 77, 55, 100),
        title: const Text('ReservIt'),
      ),
      body: Center(
        child: pages.elementAt(currIndex), //New
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currIndex,
          onTap: (value) {
            setState(() {
              currIndex = value;
            });
          },
          backgroundColor: const Color.fromRGBO(0, 77, 55, 100),
          selectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.note_add), label: 'Reservations'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Setting'),
          ]),
    );
  }
}
