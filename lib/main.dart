import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:reserv_it/pages/HomePage.dart';
import 'package:reserv_it/pages/ResHomePage.dart';
import 'package:reserv_it/pages/WelcomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isResUser = false;
  bool userNotFound = true;

  Future checkUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseDatabase.instance.ref('ResUser').onValue.listen((event) {
        if (event.snapshot
            .hasChild(FirebaseAuth.instance.currentUser!.uid.toString())) {
          isResUser = true;
          userNotFound = false;
          setState(() {});
        } else {
          isResUser = false;
          userNotFound = false;
          setState(() {});
        }
      });
    } else {
      userNotFound = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: userNotFound
            ? const WelcomePage()
            : (isResUser ? const ResHomePage() : const HomePage()));
  }
}
