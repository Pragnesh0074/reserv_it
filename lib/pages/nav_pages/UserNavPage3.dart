import 'package:flutter/material.dart';
import 'package:reserv_it/pages/UserEditProfilePage.dart';

import '../../utils/FirebaseUtils.dart';
import '../WelcomePage.dart';

class UserNavPage3 extends StatefulWidget {
  const UserNavPage3({super.key});

  @override
  State<UserNavPage3> createState() => _UserNavPage3State();
}

class _UserNavPage3State extends State<UserNavPage3> {
  FirebaseUtils firebaseUtils = FirebaseUtils();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  width: double.maxFinite,
                  height: 500,
                  decoration: const BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(blurRadius: 5, blurStyle: BlurStyle.outer)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UserEditProfilePage()),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                                color: Colors.white12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2, blurStyle: BlurStyle.outer)
                                ]),
                            child: const Center(
                                child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: InkWell(
                          onTap: () {
                            firebaseUtils.firebaseLogout();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WelcomePage()),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                                color: Colors.white12,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2, blurStyle: BlurStyle.outer)
                                ]),
                            child: const Center(
                                child: Text(
                              'Logout',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 500),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      boxShadow: [
                        BoxShadow(blurRadius: 2, blurStyle: BlurStyle.outer)
                      ],
                      image: DecorationImage(
                          image: AssetImage('assests/user_img.jpg')),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
