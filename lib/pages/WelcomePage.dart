// ignore: file_names
import 'package:flutter/material.dart';
import 'package:reserv_it/pages/LoginPage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assests/wp_img_1.png'),
          const SizedBox(
            height: 120,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Hey!\nFoodie',
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: Container(
                  height: 150,
                  width: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assests/wp_btn.png'))),
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: const Color.fromRGBO(0, 77, 55, 100),
    );
  }
}
