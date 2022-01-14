import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turningpoint/screens/main_screen.dart';
import 'package:turningpoint/screens/walkthrough.dart';

class Hasdata extends StatelessWidget {
  const Hasdata({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User> user) {
          if (user.hasData) {
            return MainScreen();
          } else {
            return Walkthrough();
          }
        });
  }
}
