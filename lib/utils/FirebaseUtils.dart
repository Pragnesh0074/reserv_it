import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reserv_it/pages/HomePage.dart';
import 'package:reserv_it/pages/ResHomePage.dart';

class FirebaseUtils {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference userRef = FirebaseDatabase.instance.ref("User");
  DatabaseReference resUserRef = FirebaseDatabase.instance.ref("ResUser");

  void userLogin(String email, pass, BuildContext buildContext) {
    auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((result) {
      Navigator.pushReplacement(
        buildContext,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }).catchError((err) {
      Fluttertoast.showToast(
          msg: "Login Failed...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void userSignup(String name, email, pass, BuildContext buildContext) {
    auth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((result) {
      userRef
          .child(result.user!.uid)
          .set({"name": name, "email": email}).then((res) {
        Navigator.pushReplacement(
          buildContext,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    }).catchError((err) {
      Fluttertoast.showToast(
          msg: "Signup Failed...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  void firebaseLogout() {
    FirebaseAuth.instance.signOut();
  }

  void resLogin(String userId, email, pass, BuildContext buildContext) {
    resUserRef.once().then((DatabaseEvent e) => {
          if (e.snapshot.hasChild(userId))
            {
              auth
                  .signInWithEmailAndPassword(email: email, password: pass)
                  .then((result) {
                Navigator.pushReplacement(
                  buildContext,
                  MaterialPageRoute(builder: (context) => const ResHomePage()),
                );
              }).catchError((err) {
                Fluttertoast.showToast(
                    msg: "Login Failed...",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0);
              })
            }
        });
  }
}
