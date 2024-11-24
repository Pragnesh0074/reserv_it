import 'package:flutter/material.dart';

import '../utils/FirebaseUtils.dart';

class ResLoginPage extends StatefulWidget {
  const ResLoginPage({super.key});

  @override
  State<ResLoginPage> createState() => _ResLoginPageState();
}

class _ResLoginPageState extends State<ResLoginPage> {
  FirebaseUtils firebaseUtils = FirebaseUtils();
  TextEditingController email_controller = TextEditingController();
  TextEditingController pass_controller = TextEditingController();
  TextEditingController user_id_controller = TextEditingController();

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
                          const EdgeInsets.only(left: 30, right: 30, top: 30),
                      child: TextFormField(
                        controller: user_id_controller,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            hintText: 'Enter User Id',
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
                        firebaseUtils.resLogin(
                            user_id_controller.text.toString().trim(),
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: const Color.fromRGBO(0, 77, 55, 100),
    );
  }
}
