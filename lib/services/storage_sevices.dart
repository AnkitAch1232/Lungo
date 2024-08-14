import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class StorageSevices {
  uploadImage(File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last.split('.').first;
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
      UploadTask upload = storageRef.putFile(imageFile);
      TaskSnapshot uploadTask = await upload.whenComplete(() {});

      String downloadLink = await uploadTask.ref.getDownloadURL();

      return downloadLink;
    } catch (e) {
      print("Unable to upload image due to $e");
    }
  }

  downloadImage(String imageUrl) async {
    var response = await Dio()
        .get(imageUrl, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "hello");
    print(result);
  }
}
