import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:turningpoint/caloriecheck/ui/home_view.dart';

class Check extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Object Detection TFLite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          body: FutureBuilder(
              future: calorie(), // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return HomeView();
              })),
    );
  }
}

Future<Null> calorie() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
