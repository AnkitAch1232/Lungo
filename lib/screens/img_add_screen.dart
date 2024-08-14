// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImgAddScreen extends StatefulWidget {
  const ImgAddScreen({super.key});

  @override
  State<ImgAddScreen> createState() => _ImgAddScreenState();
}

class _ImgAddScreenState extends State<ImgAddScreen> {
  File? pickedFile;
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
            ),
            InkWell(
              child: Container(
                height: 54,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1),
                ),
                child: Center(child: Text("Download Image")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
