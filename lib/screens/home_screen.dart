import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/models/product_model.dart';
import 'package:firebase_demo/screens/create_product.dart';
import 'package:firebase_demo/services/auth_service.dart';
import 'package:firebase_demo/services/db_service.dart';
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
        title: Text(
          "App homepage",
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              // await FirebaseAuth.instance.signOut();
              await AuthService().signOut();
            },
            child: Text("Signout"),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 55,
              width: 348,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("UserName:"),
                      Text(FirebaseAuth.instance.currentUser!.displayName ??
                          "No Name"),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Email:"),
                      Text(FirebaseAuth.instance.currentUser!.email ??
                          "no EMail"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 5,
              child: Container(
                child: FutureBuilder(
                  future: DbService().getAllProduct(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error occurs while getting the data"),
                      );
                    }
                    if (snapshot.hasData) {
                      List<ProductModel> product =
                          snapshot.data as List<ProductModel>;
                      return ListView.builder(
                        itemCount: product.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 54,
                              width: 348,
                              child: Row(
                                children: [
                                  //Circle
                                  Expanded(
                                      flex: 1,
                                      child: CircleAvatar(
                                        radius: 23,
                                        child: Text("Id" ?? "${index + 1}"),
                                      )),
                                  //Content
                                  Expanded(
                                      flex: 4,
                                      child: Column(
                                        children: [
                                          Text("Product name"),
                                          Text("Product Brand"),
                                          Text("Product "),
                                        ],
                                      )),
                                  //Icons
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () async {
                                                await DbService()
                                                    .editProduct();
                                              },
                                              child: Icon(Icons.edit)),
                                          ElevatedButton(
                                              onPressed: () async {
                                                await DbService()
                                                    .deleteSelectedProduct();
                                              },
                                              child: Icon(Icons.delete)),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateProduct(),
            ),
          );
        },
        child: Column(
          children: [
            Icon(Icons.add),
            Text("Add New Product"),
          ],
        ),
      ),
    );
  }
}
