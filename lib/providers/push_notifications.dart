import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotifications {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  initNotifications() {
    _firebaseMessaging.requestPermission();
    _firebaseMessaging.getToken().then((token){
      print("=====FCM TOKEN =======");
      print(token);
    });
  }

}