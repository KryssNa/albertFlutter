import 'package:flutter/material.dart';
import 'package:kryssna/services/NotificationServices.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationDemo extends StatefulWidget {
  const NotificationDemo({super.key});

  @override
  State<NotificationDemo> createState() => _NotificationDemoState();
}

class _NotificationDemoState extends State<NotificationDemo> {
  Future<void> setupFCM()async{
    FirebaseMessaging.instance.getInitialMessage().then((message) => print(message));
    FirebaseMessaging.instance.getToken().then((value) => print("fcm :: "+value.toString()));

    FirebaseMessaging.onMessage.listen((message) {
     if(message.notification!= null){

       print(message.notification!.body);
       print(message.notification!.title);

     }
    });
  }
  @override
  void initState() {
    super.initState();
    setupFCM();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Demo"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
               NotificationService.displayText(title: "Hello title", body: "hello body");
              },
              child: const Text("Notification text only")),
          ElevatedButton(
              onPressed: () {
                NotificationService.displayImage(title: "title", body: "body", icon: "Icons.add", image: "image");
              },
              child: const Text("Notification with image")),
        ],
      ),
    );
  }
}
