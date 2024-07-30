import 'package:flutter/material.dart';

import '../screens/login_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 200), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
    return Scaffold(
      backgroundColor: Color(0xff25CE09),
      body: Center(
        child: Container(
          height: 72,
          width: 68.21,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xff25CE09),
          ),
          child: Center(
              child: Text(
            "L",
            style: TextStyle(
              fontSize: 42,
              color: Colors.white,
            ),
          )),
        ),
      ),
    );
  }
}
