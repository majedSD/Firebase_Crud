import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frebase_crud/FirebaseMessaging/FirebaseMessageingService.dart';
import 'package:frebase_crud/firebase_options/firebase_options.dart';
import 'package:frebase_crud/my_app.dart';

void main() async {
  ///initialized firebase in your app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  ///All of use for push notification
  await FirebasemessageingService().initialize();
  await FirebasemessageingService().getFCMToken();
  await FirebasemessageingService().subscribeToTopic('programming-hero');
  await FirebasemessageingService().onRefresh((token){
    //TODO--something send to api
  });
  runApp(const MyApp());
}
