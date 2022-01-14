import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:turningpoint/poseestimation/main.dart';
import 'package:turningpoint/util/const.dart';
import 'package:turningpoint/util/routinelist.dart';
import 'package:turningpoint/widgets/difficultyicon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

int check;

class Routine extends StatefulWidget {
  final int index;
  Routine({Key key, @required this.index, img, name}) : super(key: key);

  @override
  _RoutineState createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {
  bool isFav = false;
  YoutubePlayerController _controller;

  void runYoutubePlayer() {
    _controller = YoutubePlayerController(
        initialVideoId: routines[widget.index].url,
        flags: YoutubePlayerFlags(
          enableCaption: false,
          isLive: false,
          autoPlay: false,
        ));
  }

  @override
  void initState() {
    runYoutubePlayer();
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  callPermission() async {
    await Permission.camera.request();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "운동",
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
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: YoutubePlayerBuilder(
                          player: YoutubePlayer(
                            controller: _controller,
                          ),
                          builder: (context, player) {
                            return Scaffold(
                              body: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  player,
                                ],
                              ),
                            );
                          })),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              routines[widget.index].name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  SmoothStarRating(
                    starCount: 5,
                    color: Constants.ratingBG,
                    allowHalfRating: true,
                    rating: routines[widget.index].difficulty,
                    size: 10.0,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "운동강도",
                    style: TextStyle(
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "운동시 주의사항",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            SizedBox(height: 10.0),
            Text(
              routines[widget.index].precautions,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
      bottomNavigationBar: TextButton(
        child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.camera_alt,
            size: 24.0,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            '운동을해봅시다',
            style: TextStyle(fontWeight: FontWeight.w300),
          )
        ]),
        onPressed: () {
          callPermission();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Pose();
              },
            ),
          );
        },
      ),
    );
  }
}
