import 'package:flutter/material.dart';
import 'package:reserv_it/pages/ResLoginPage.dart';

import '../utils/FirebaseUtils.dart';
import 'SignUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseUtils firebaseUtils = FirebaseUtils();
  TextEditingController email_controller = TextEditingController();
  TextEditingController pass_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Center(
                child: Image.asset(
                  'assests/logo.png',
                  height: 250,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                height: 400,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 50),
                      child: TextFormField(
                        controller: email_controller,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            hintText: 'Enter Email',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        controller: pass_controller,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            hintText: 'Enter Password',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        firebaseUtils.userLogin(
                            email_controller.text.toString().trim(),
                            pass_controller.text.toString().trim(),
                            context);
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromRGBO(0, 77, 55, 30)),
                        child: const Center(
                            child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // ignore: prefer_const_constructors
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('New User ?  ',
                            style: TextStyle(fontSize: 15)),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'SignUp',
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ResLoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Restaurant Login',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: const Color.fromRGBO(0, 77, 55, 1),
    );
  }
}
