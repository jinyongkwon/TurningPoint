import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:turningpoint/screens/calender.dart';
import 'package:turningpoint/screens/database.dart';
import 'package:turningpoint/screens/div.dart';
import 'package:turningpoint/screens/home.dart';
import 'package:turningpoint/screens/profile.dart';
import 'package:turningpoint/util/const.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: Databaseservice().users,
      initialData: null,
      child: WillPopScope(
        onWillPop: () => Future.value(true),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              Constants.appName,
            ),
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.sms,
                  size: 22.0,
                ),
                onPressed: () {
                  setState(() async {
                    await launch("http://pf.kakao.com/_TvhRs/chat",
                        forceSafariVC: false, forceWebView: false);
                  });
                },
                tooltip: "Chatbot",
              ),
            ],
          ),
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: onPageChanged,
            children: <Widget>[
              Home(),
              Div(),
              TableEventsExample(),
              Profile(),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(width: 7),
                IconButton(
                  icon: Icon(
                    Icons.home,
                    size: 24.0,
                  ),
                  color: _page == 0
                      ? Theme.of(context).accentColor
                      : Theme.of(context).textTheme.caption.color,
                  onPressed: () => _pageController.jumpToPage(0),
                ),
                IconButton(
                  icon: Icon(
                    Icons.fitness_center,
                    size: 24.0,
                  ),
                  color: _page == 1
                      ? Theme.of(context).accentColor
                      : Theme.of(context).textTheme.caption.color,
                  onPressed: () => _pageController.jumpToPage(1),
                ),
                IconButton(
                  icon: Icon(
                    Icons.event_available,
                    size: 24.0,
                  ),
                  color: _page == 2
                      ? Theme.of(context).accentColor
                      : Theme.of(context).textTheme.caption.color,
                  onPressed: () => _pageController.jumpToPage(2),
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings_applications,
                    size: 24.0,
                  ),
                  color: _page == 3
                      ? Theme.of(context).accentColor
                      : Theme.of(context).textTheme.caption.color,
                  onPressed: () => _pageController.jumpToPage(3),
                ),
                SizedBox(width: 7),
              ],
            ),
            color: Theme.of(context).primaryColor,
            shape: CircularNotchedRectangle(),
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
