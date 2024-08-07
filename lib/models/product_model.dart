import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? name;
  String? id;
  int? price;
  String? brand;
  String? manufacturedDate;
  String? imgUrl;

  ProductModel({
    this.brand,
    this.id,
    this.manufacturedDate,
    this.name,
    this.price,
  });

  ProductModel.fromFirebase(Map<String, dynamic> data) {
    brand = data['name'];
    id = data['id'];
    price = data['price'];
    name = data['name'];
    manufacturedDate = data['manufactured_data'];
  }

  ToFirestore(ProductModel model) {
    Map<String, dynamic> firebaseData = {};
    firebaseData['id'] = model.id;
    firebaseData['name'] = model.name;
    firebaseData['price'] = model.price;
    firebaseData['manufactured_data'] = model.manufacturedDate;
    firebaseData['brand'] = model.brand;

    return firebaseData;
  }
}
