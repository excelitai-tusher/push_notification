import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'notification.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';

  @override
  void initState() {
    final FirebaseMessaging = FCM();
    FirebaseMessaging.setNotification();
    FirebaseMessaging.streamCtrl.stream.listen(_changeData);
    FirebaseMessaging.titleCtrl.stream.listen(_changeTitle);
    FirebaseMessaging.bodyCtrl.stream.listen(_changeBody);

    super.initState();
  }
  _changeData(String msg) {
    setState(() => notificationData = msg);
  }
    _changeTitle(String msg) {
      setState(() => notificationTitle = msg);
    }
      _changeBody(String msg) {
        setState(() => notificationBody = msg);
      }
        @override
        Widget build(BuildContext context) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Flutter Notification Details",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 20,),
                  Text("Notification Title: $notificationTitle",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text("Notification Body: $notificationBody",
                    style: Theme.of(context).textTheme.headline6,
                  ),

                ],
              ),
            ),
          );
        }
      }

