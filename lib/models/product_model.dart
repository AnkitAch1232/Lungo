class ProductModel {
  String? name;
  String? id;
  int? price;
  String? brand;
  String? manufacturedDate;

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

  toFirestore() {
    Map<String, dynamic> firebaseData = {};
    firebaseData['id'] = id;
    firebaseData['name'] = name;
    firebaseData['price'] = price;
    firebaseData['manufactured_data'] = manufacturedDate;
    firebaseData['brand'] = brand;

    return firebaseData;
  }
}
