import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> onBackgroundMessege(RemoteMessage message) async{
  await Firebase.initializeApp();

  if(message.data.containsKey('data')){
    final data = message.data ['data'];
  }

  if(message.data.containsKey('notification')){
    final notification = message.data ['notification'];
  }
}
class FCM {
  final streamCtrl = StreamController<String>.broadcast();
  final titleCtrl = StreamController<String>.broadcast();
  final bodyCtrl = StreamController<String>.broadcast();


  setNotification(){
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessege);

    forgroundNotification();

    backgroundNotification();

    terminateNotification();

  }
  forgroundNotification(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if(message.data.containsKey('data')){
        streamCtrl.sink.add(message.data['data']);
      }

      if(message.data.containsKey('notification')){
        streamCtrl.sink.add(message.data['notification']);
      }
      
      titleCtrl.sink.add(message.notification!.title!);
      bodyCtrl.sink.add(message.notification!.body!);
    });
  }

  backgroundNotification(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if(message.data.containsKey('data')){
        streamCtrl.sink.add(message.data['data']);
      }

      if(message.data.containsKey('notification')){
        streamCtrl.sink.add(message.data['notification']);
      }

      titleCtrl.sink.add(message.notification!.title!);
      bodyCtrl.sink.add(message.notification!.body!);
    });
  }

  terminateNotification() async{
    RemoteMessage?  initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if(initialMessage != null){
      if(initialMessage.data.containsKey('data')){
        streamCtrl.sink.add(initialMessage.data['data']);
      }

      if(initialMessage.data.containsKey('notification')){
        streamCtrl.sink.add(initialMessage.data['notification']);

        titleCtrl.sink.add(initialMessage.notification!.title!);
        bodyCtrl.sink.add(initialMessage.notification!.body!);
      }
    }
    dispose(){
      streamCtrl.close;
      titleCtrl.close;
      bodyCtrl.close;
    }
  }
}
