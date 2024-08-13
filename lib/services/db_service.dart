import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/models/product_model.dart';

class DbService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future addProduct(ProductModel product) async {
    try {
      await db.collection("Products").add(product.toFirestore()).then(
        (value) {
          print("The document is created successfulyy with id${value.id}");
        },
      );
    } catch (e) {
      return "Unable to add document because of $e";
    }
  }

  Future editProduct(ProductModel model) async {
    print("The new model is ${model.id}");
    // await db
    //     .collection("Products")
    //     .doc(model.id)
    //     .update(model.toFirestore())
    //     .then(
    //   (value) {
    //     print("Product updated successfully");
    //   },
    // );

    await db
        .collection("Products")
        .doc(model.id)
        .set(model.toFirestore(), SetOptions(merge: true));
  }

  Future deleteProduct(String id) async {
    await db.collection("Products").doc(id).delete().then((value) {
      print("Deleted Successfully wuth following value");
    });
  }

  Future<List<ProductModel>> getAllProduct() async {
    List<ProductModel> allProduct = [];
    try {
      await db.collection("Products").get().then((qsnapshot) {
        var allDocs = qsnapshot.docs;

        print(allDocs);

        for (var doc in allDocs) {
          db.collection("Products").doc(doc.id).set(
            {
              'id': doc.id,
            },
            SetOptions(merge: true),
          );
          ProductModel productModel = ProductModel.fromFirebase(doc.data());
          allProduct.add(productModel);
        }
        print(allProduct);
        // return allProduct;
      });
    } catch (e) {
      print("Unable to find data because of $e");
    }
    return allProduct;
  }
}
