import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/models/product_model.dart';

class DbService{

  FirebaseFirestore db = FirebaseFirestore.instance;
  Future addProduct(ProductModel product)async{
    try{await db.collection("Products").add(product.toFirestore()).then((value) {
      print("The document is created successfulyy with id${value.id}");
    });}catch(e){
      return "Unable to add document because of $e";
    }
  }

  Future editProduct()async{
    // await
  }
  Future deleteSelectedProduct()async{
    // await
  }


  Future getAllProduct()async{
  // await  
  }
}