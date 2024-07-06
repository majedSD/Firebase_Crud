import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:frebase_crud/FirebaseMessaging/push_notification_routing.dart';
import 'package:get/get.dart';

class FirebasemessageingService{
  FirebaseMessaging firebaseMessaging=FirebaseMessaging.instance;
  Future<void>requestPermision()async{
    await firebaseMessaging.requestPermission(
      sound: true,
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );
  }
  //Normally all of the user get notification
  Future<void>initialize()async {
    await requestPermision();
    //Normal//alive//open //Forground state
    FirebaseMessaging.onMessage.listen((message) {
         print(message.notification?.title);
         print(message.notification?.body);
    });
    //open//resume//background state
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.notification?.title);
      print(message.notification?.body);
      if(message.data['path']=='how to routing'){
        Get.to(const PushNotificationRouting());
      }
    });
    //dead//terminate state
    FirebaseMessaging.onBackgroundMessage(handleBackgroundNotification);
  }
  //terminate er jonno top level function
  Future<void> handleBackgroundNotification(RemoteMessage message) async {}
  //Token generate kora individuals user er kase notification patanu jai
  Future<void>getFCMToken()async{
    final String? token=await firebaseMessaging.getToken();
    print('Token=$token');
  }
  Future<void>onRefresh(Function(String)onTokenRefresh)async{
  firebaseMessaging.onTokenRefresh.listen((token){
    onTokenRefresh(token);
  });
  }
  //kuno topic a subscribe korla tumara notification dita takbe
  Future<void>subscribeToTopic(String topic)async{
   await firebaseMessaging.subscribeToTopic(topic);
  }
  //unsubscribe korle er notification dibe nah
  Future<void>unsubscribeToTopic(String topic)async{
    await firebaseMessaging.unsubscribeFromTopic(topic);
  }
}