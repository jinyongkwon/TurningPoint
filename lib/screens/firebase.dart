import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:turningpoint/screens/splash.dart';

class Firebaseinit extends StatefulWidget {
  _FirebaseinitState createState() => _FirebaseinitState();
}

class _FirebaseinitState extends State<Firebaseinit> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return Center(
        child: Text('파이어베이스init실패'),
      );
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return SplashScreen();
  }
}
