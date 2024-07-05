import 'package:flutter/material.dart';
import 'package:frebase_crud/Authentication/sign_in_screen.dart';
import 'package:frebase_crud/Cloud_Firestore/firebase_crud_screen.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: SignInScreen(),
      title: 'Firebase Crud App',
      color: Colors.pink,
      debugShowCheckedModeBanner: false,
    );
  }
}
