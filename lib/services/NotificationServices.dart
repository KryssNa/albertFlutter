import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

class NotificationService{
  static FlutterLocalNotificationsPlugin _notificationPlugin=FlutterLocalNotificationsPlugin();

  static void initialize(){

    _notificationPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();

    final InitializationSettings initializationSettings=  InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
          iOS: DarwinInitializationSettings()
    );
    _notificationPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }
  static onDidReceiveNotificationResponse(NotificationResponse? response) async{

  }
  static Future<void> displayText({required String title, required String body}) async{
    final id=DateTime.now().millisecondsSinceEpoch~/1000;
    final NotificationDetails notificationDetails=NotificationDetails(
      android: AndroidNotificationDetails(
        "myapp",
        "My app channel",
          channelDescription: "channel Description",
        importance: Importance.high,
        priority: Priority.high,
      ),
    );
    await _notificationPlugin.show(id, title, body, notificationDetails);

  }
  static Future<String> loadAsset(String asset, String filename) async {
    final byteData = await rootBundle.load(asset);
    final tmp = await getTemporaryDirectory();
    final file = File("${tmp.path}/${filename}");
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file.path;
  }

  static Future<void> displayImage(
      {required String title,
        required String body,
        required String icon,
        required String image}) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    var imageLoder = await loadAsset(image, 'bigpicture');
    var logoLoder = await loadAsset(image, 'smallpicture');
    AndroidBitmap<Object> notificationImage = FilePathAndroidBitmap(imageLoder);
    AndroidBitmap<Object> notificationLogo = FilePathAndroidBitmap(logoLoder);

    final styleInfo = BigPictureStyleInformation(notificationImage,
        largeIcon: notificationLogo);

    final NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails("myapp", "my app chanel",
            channelDescription: "Channel Des",
            priority: Priority.high,
            importance: Importance.high,
            styleInformation: styleInfo
        ));
    _notificationPlugin.show(id, title, body, notificationDetails);
  }


}
