import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App homepage"),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: Text("Signout"),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(FirebaseAuth.instance.currentUser!.displayName ?? "No Name"),
          Text(FirebaseAuth.instance.currentUser!.email ?? "no EMail"),
        ],
      ),
    );
  }
}
