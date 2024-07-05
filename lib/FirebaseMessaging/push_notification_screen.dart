import 'package:flutter/material.dart';

class FirebasePushNotification extends StatefulWidget {
  const FirebasePushNotification({super.key});

  @override
  State<FirebasePushNotification> createState() => _FirebasePushNotificationState();
}

class _FirebasePushNotificationState extends State<FirebasePushNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase push notification'),
        backgroundColor: Colors.cyanAccent,
        foregroundColor: Colors.black,

      ),
    );
  }
}
