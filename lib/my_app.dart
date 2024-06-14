import 'package:flutter/material.dart';
import 'package:frebase_crud/firebase_crud_screen.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: FirebaseCrudAppScreen(),
      title: 'Firebase Crud App',
      color: Colors.pink,
    );
  }
}
