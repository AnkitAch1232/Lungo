import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_demo/services/storage_sevices.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImgAddScreen extends StatefulWidget {
  const ImgAddScreen({super.key});

  @override
  State<ImgAddScreen> createState() => _ImgAddScreenState();
}

class _ImgAddScreenState extends State<ImgAddScreen> {
  File? pickedFile;
  String? downloadUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Picker"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();

                if (result != null) {
                  setState(() {
                    pickedFile = File(result.files.single.path!);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Image Picked"),
                    ),
                  );
                } else {
                  // User canceled the picker
                }
              },
              child: Container(
                height: 54,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1),
                ),
                child: Center(child: Text("Pick Image")),
              ),
            ),
            Container(
              height: 264,
              width: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1),
              ),
              child: pickedFile == null
                  ? Center(
                      child: Text("Please pick  a file"),
                    )
                  : Image.file(
                      pickedFile!,
                      fit: BoxFit.fill,
                    ),
            ),
            InkWell(
              onTap: () async {
                String url = await StorageSevices().uploadImage(pickedFile!);
                setState(() {
                  downloadUrl = url;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("Uploaded Successfully"),
                  ),
                );
              },
              child: Container(
                height: 54,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1),
                ),
                child: Center(child: Text("Upload Image")),
              ),
            ),
            Container(
                height: 184,
                width: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1),
                ),
                child: downloadUrl != null
                    ? Image.network(downloadUrl!)
                    : Center(
                        child: Text("No image to show"),
                      )),
            InkWell(
              onTap: () async {
                if (downloadUrl != null) {
                  await StorageSevices().downloadImage(downloadUrl!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Downloaded Successfully"),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      "Image not selected",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ));
                }
              },
              child: Container(
                height: 54,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1),
                ),
                child: Center(
                  child: Text("Download Image"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
