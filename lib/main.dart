import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frebase_crud/firebase_options/firebase_options.dart';
import 'package:frebase_crud/my_app.dart';
void main()async{
 ///initialized firebase in your app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}
