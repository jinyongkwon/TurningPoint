import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
// import 'package:opengl/opengl.dart';
import 'home.dart';

List<CameraDescription> cameras;

class Pose extends StatefulWidget {
  @override
  _Pose createState() => _Pose();
}

class _Pose extends State<Pose> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: pose(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return HomePage(cameras);
          }),
    );
  }

  Future<Null> pose() async {
    cameras = await availableCameras();
  }
}
