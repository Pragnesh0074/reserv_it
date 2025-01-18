import 'package:flutter/material.dart';
import 'package:reserv_it/pages/nav_pages/ResNavPage1.dart';
import 'nav_pages/ResNavPage2.dart';

class ResHomePage extends StatefulWidget {
  const ResHomePage({super.key});
  @override
  State<ResHomePage> createState() => _ResHomePageState();
}

class _ResHomePageState extends State<ResHomePage> {
  int currIndex = 0;
  final pages = const [ResNavPage1(), ResNavPage2()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 77, 55, 1),
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
          backgroundColor: const Color.fromRGBO(0, 77, 55, 1),
          selectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Setting'),
          ]),
    );
  }
}
