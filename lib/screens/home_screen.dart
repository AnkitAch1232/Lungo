// ignore_for_file: prefer_const_constructors

import 'package:firebase_demo/models/product_model.dart';
import 'package:firebase_demo/screens/create_product.dart';
import 'package:firebase_demo/screens/img_add_screen.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateProduct(),
            ),
          );
        },
        child: Column(
          children: const [
            Expanded(
              child: Icon(
                Icons.add,
                size: 27,
              ),
            ),
            Text(
              "New",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("all Product"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ImgAddScreen(),
                ),
              );
            },
            icon: Text("Hello Brother"),
          ),
        ],
      ),
      body: FutureBuilder(
          future: DbService().getAllProduct(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Errorrrrrrr"),
              );
            }
            if (snapshot.hasData) {
              var data = snapshot.data as List<ProductModel>;
              print("the data is " + data.length.toString());
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70,
                      width: 348,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 23,
                              child: Text("${index + 1}"),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Name: ${data[index].name!}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "Price: Rs ${data[index].price.toString()}",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                                "Are you sure u want ot delete this product?"),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await DbService()
                                                      .deleteProduct(
                                                          data[index].id!);
                                                  Navigator.pop(context);
                                                  setState(
                                                    () {},
                                                  );
                                                },
                                                child: Text("Yes"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("No"),
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 22,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CreateProduct(
                                          product: data[index],
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 22,
                                  )),
                            ],
                          ),
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
          }),
    );
  }
}
