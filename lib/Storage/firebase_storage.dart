import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:frebase_crud/Storage/storage_image_show_scree.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageScreen extends StatefulWidget {
  const FirebaseStorageScreen({super.key});

  @override
  State<FirebaseStorageScreen> createState() => _FireState();
}

class _FireState extends State<FirebaseStorageScreen> {
  XFile? pickImage;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> addImage() async {
    pickImage = await ImagePicker().pickImage(source: ImageSource.camera);
    Reference rf = firebaseStorage
        .ref()
        .child('laptops/${DateTime.now().millisecondsSinceEpoch}');
    await rf.putFile(File(pickImage!.path)).then((value) {
      Get.showSnackbar(const GetSnackBar(
        title: 'Success',
        message: 'Successfully uploaded',
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ));
    }).onError((error, stackTrace) {
      Get.showSnackbar(const GetSnackBar(
        title: 'Failed',
        message: 'Failed uploaded',
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
      ));
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const StorageImageShowScreen());
              },
              icon: const Icon(Icons.arrow_forward))
        ],
        title: const Text('Firebase Storage Screen'),
        backgroundColor: Colors.cyanAccent,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                addImage();
              },
              child: const Text('P I C K E D image'),
            ),
          ],
        ),
      ),
    );
  }
}
