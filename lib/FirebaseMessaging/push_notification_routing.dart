import 'package:flutter/material.dart';

class PushNotificationRouting extends StatefulWidget {
  const PushNotificationRouting({super.key});

  @override
  State<PushNotificationRouting> createState() => _PushNotificationRoutingState();
}
class _PushNotificationRoutingState extends State<PushNotificationRouting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push notification routing'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.cyanAccent,
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: Card(
            child:Image.network('https://media.licdn.com/dms/image/D5612AQHeyVhg9rY_rA/article-cover_image-shrink_720_1280/0/1717134675043?e=2147483647&v=beta&t=AZo_UAt27V3pRXKOdpOPsmaaIgXfmcaT_OFLglk01i4'),
          ),
        ),
      ),
    );
  }
}
