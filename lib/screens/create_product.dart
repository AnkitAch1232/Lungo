import 'package:firebase_demo/models/product_model.dart';
import 'package:firebase_demo/services/auth_service.dart';
import 'package:flutter/material.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _manufactureDateController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(),
                  helperText: "Enter product name",
                ),
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  hintText: "Price",
                  border: OutlineInputBorder(),
                  helperText: "Enter product Price",
                ),
              ),
              TextFormField(
                controller: _brandController,
                decoration: InputDecoration(
                  hintText: "Brand",
                  border: OutlineInputBorder(),
                  helperText: "Enter product brand",
                ),
              ),
              TextFormField(
                controller: _manufactureDateController,
                decoration: InputDecoration(
                  hintText: "Manufacture Date",
                  border: OutlineInputBorder(),
                  helperText:
                      "Enter product manufacture Date in the format of MM-DD-YY",
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    ProductModel pro = ProductModel(
                      name: _nameController.text,
                      price: int.parse(_priceController.toString()),
                      brand: _brandController.text,
                      manufacturedDate: _manufactureDateController.text,
                    );
                    try {
                      await AuthService().addProduct();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            "Created Successfully",
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      throw Exception(e.toString());
                    }
                  },
                  child: Text("Add Product"))
            ],
          ),
        ),
      ),
    );
  }
}
