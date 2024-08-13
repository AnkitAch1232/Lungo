import 'package:firebase_demo/models/product_model.dart';
//import 'package:firebase_demo/services/auth_service.dart';
import 'package:firebase_demo/services/db_service.dart';
import 'package:flutter/material.dart';

class CreateProduct extends StatefulWidget {
  ProductModel? product;
  CreateProduct({super.key, this.product});

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
  void initState() {
    if (widget.product != null) {
      _nameController.text = widget.product!.name!;
      _priceController.text = widget.product!.price!.toString();
      _brandController.text = widget.product!.brand!;
      _manufactureDateController.text = widget.product!.manufacturedDate!;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? "Create product" : "Edit Product"),
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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.datetime,
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
                      // id: widget.product!.id??"NUll",
                      name: _nameController.text,
                      price: int.parse(
                        _priceController.text,
                      ),
                      brand: _brandController.text,
                      manufacturedDate: _manufactureDateController.text,
                    );
                    try {
                      if (widget.product != null) {
                        ProductModel pro = ProductModel(
                          id: widget.product!.id ?? "NUll",
                          name: _nameController.text,
                          price: int.parse(
                            _priceController.text,
                          ),
                          brand: _brandController.text,
                          manufacturedDate: _manufactureDateController.text,
                        );
                        await DbService().editProduct(pro);
                      }

                      if (widget.product == null) {
                        await DbService().addProduct(pro);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            widget.product == null
                                ? "Created Successfully"
                                : "Edited Successfully",
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      throw Exception(e.toString());
                    }
                  },
                  child: Text(widget.product == null
                      ? "Add Product"
                      : "Update Product"))
            ],
          ),
        ),
      ),
    );
  }
}
