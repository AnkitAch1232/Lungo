import 'package:flutter/material.dart';

import '../screens/login_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 800), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
    return Scaffold(
      backgroundColor: const Color(0xff25CE09),
      body: Center(
        child: Container(
          height: 72,
          width: 68.21,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: const Center(
              child: Text(
            "L",
            style: TextStyle(
              fontSize: 42,
              color: Color(0xff25CE09),
            ),
          )),
        ),
      ),
    );
  }
}
