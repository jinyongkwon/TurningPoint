import 'package:flutter/material.dart';
import 'dart:math' as math;

String _print_string = '터닝포인트 ';

var pu_ready = 0, pu_count = 0, pu = 0;
var sq_ready = 0, sq_count = 0, sq_up = 0, sq = 0;
var pl_ready = 0, pl_count = 0, pl = 0;

var startTime;
double pl_time = 0;
double pl_time2 = 0;
double pl_time3 = 0;
var time_start = 0;
var stime = 0;

const BOTTOM_SHEET_RADIUS = Radius.circular(24.0);
const BORDER_RADIUS_BOTTOM_SHEET = BorderRadius.only(
    topLeft: BOTTOM_SHEET_RADIUS, topRight: BOTTOM_SHEET_RADIUS);

class KeyPoints extends StatelessWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;

  var nose, leftShoulder, leftElbow, leftWrist, leftHip, leftKnee, leftAnkle;
  var rightShoulder, rightElbow, rightWrist, rightHip, rightKnee, rightAnkle;
  var pu_1, pu_2, pu_3, pu_4;
  var sq_1, sq_2;
  var pl_1, pl_2, pl_3;
  double last = 0;

  KeyPoints(this.results, this.previewH, this.previewW, this.screenH,
      this.screenW, this.model);

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderKeypoints() {
      var lists = <Widget>[];
      results.forEach((re) {
        var list = re["keypoints"].values.map<Widget>((k) {
          var _x = k["x"];
          var _y = k["y"];
          var scaleW, scaleH, x, y;
          //_print_string = _x < 0.2 ? "junior su" : "senior su";

          if (screenH / screenW > previewH / previewW) {
            scaleW = screenH / previewH * previewW;
            scaleH = screenH;
            var difW = (scaleW - screenW) / scaleW;
            x = (_x - difW / 2) * scaleW;
            y = _y * scaleH;
          } else {
            scaleH = screenW / previewW * previewH;
            scaleW = screenW;
            var difH = (scaleH - screenH) / scaleH;
            x = _x * scaleW;
            y = (_y - difH / 2) * scaleH;
          }

          // To solve mirror problem on front camera
          if (x > 320) {
            var temp = x - 320;
            x = 320 - temp;
          } else {
            var temp = 320 - x;
            x = 320 + temp;
          }

          //Start timer
          if (stime == 0) {
            time_start = new DateTime.now().millisecondsSinceEpoch;
            stime = 1;
          }
          if (stime == 1) {
            int time_end = new DateTime.now().millisecondsSinceEpoch;
            double st_time = (time_end - time_start) / 1000;
            double t = 5 - double.parse(st_time.toStringAsFixed(0));
            _print_string = '시작 $t초 전';
            if (t <= 0) {
              pu = 1;
              stime = 2;
              _print_string = '시작합니다!';
            }
          }
/*
          if (k["part"] == 'nose') {
            nose = [x, y];
          }
          */
          if (k["part"] == 'leftShoulder') {
            leftShoulder = [x, y];
          }
          if (k["part"] == 'leftElbow') {
            leftElbow = [x, y];
          }
          if (k["part"] == 'leftWrist') {
            leftWrist = [x, y];
          }
          if (k["part"] == 'leftKnee') {
            leftKnee = [x, y];
          }
          if (k["part"] == 'leftHip') {
            leftHip = [x, y];
          }
          if (k["part"] == 'leftAnkle') {
            leftAnkle = [x, y];
          }
          if (k["part"] == 'rightShoulder') {
            rightShoulder = [x, y];
          }
          if (k["part"] == 'rightElbow') {
            rightElbow = [x, y];
          }
          if (k["part"] == 'rightWrist') {
            rightWrist = [x, y];
          }
          if (k["part"] == 'rightHip') {
            rightHip = [x, y];
          }
          if (k["part"] == 'rightKnee') {
            rightKnee = [x, y];
          }
          if (k["part"] == 'rightAnkle') {
            rightAnkle = [x, y];
          }

          double angle(double ax, double bx, double cx, double ay, double by,
              double cy) {
            double aa, bb, cc;
            double ang, temp;

            aa = math.sqrt(math.pow(ax - cx, 2) + math.pow(ay - cy, 2));
            bb = math.sqrt(math.pow(ax - bx, 2) + math.pow(ay - by, 2));
            cc = math.sqrt(math.pow(bx - cx, 2) + math.pow(by - cy, 2));

            temp = (math.pow(bb, 2) + math.pow(cc, 2) - math.pow(aa, 2)) /
                (2 * bb * cc);
            ang = math.acos(temp);
            ang = ang * (180 / 3.141592);
            return ang;
          }

          //print('angle:');
          //print(angle(1,2,2,0,0,3));
////////////////////////////////////////////////////////////// 푸쉬업
          void pushup() {
            if ((rightShoulder != null) && // 1. 어깨 손목 팔꿈치
                (rightWrist != null) &&
                (rightElbow != null)) {
              pu_1 = angle(rightShoulder[0], rightWrist[0], rightElbow[0],
                  rightShoulder[1], rightWrist[1], rightElbow[1]);
            }
            if ((rightKnee != null) && // 2. 무릎 힙 어깨 // 자세 교정
                (rightHip != null) &&
                (rightShoulder != null)) {
              pu_2 = angle(rightKnee[0], rightHip[0], rightShoulder[0],
                  rightKnee[1], rightHip[1], rightShoulder[1]);
            }
            if ((rightWrist != null) && // 3. 손목 팔꿈치 어깨
                (rightElbow != null) &&
                (rightShoulder != null)) {
              pu_3 = angle(rightWrist[0], rightElbow[0], rightShoulder[0],
                  rightWrist[1], rightElbow[1], rightShoulder[1]);
            }
            if ((rightElbow != null) && // 4. 팔꿈치 어깨 무릎 // 카운트 보조
                (rightShoulder != null) &&
                (rightKnee != null)) {
              pu_4 = angle(rightElbow[0], rightShoulder[0], rightKnee[0],
                  rightElbow[1], rightShoulder[1], rightKnee[1]);
            }
/*
            if (pu_1 != null && pu_2 != null && pu_3 != null && pu_4 != null) {
              pu_1 = double.parse(pu_1.toStringAsFixed(0));
              pu_2 = double.parse(pu_2.toStringAsFixed(0));
              pu_3 = double.parse(pu_3.toStringAsFixed(0));
              pu_4 = double.parse(pu_4.toStringAsFixed(0));
              _print_string = '$pu_1\n$pu_2 \n$pu_3\n$pu_4';
            }
*/

            if (pu_ready == 0) {
              if (pu_1 != null &&
                  pu_2 != null &&
                  pu_3 != null &&
                  pu_4 != null) {
                if (pu_1 > 50 &&
                    pu_1 < 70 &&
                    pu_2 > 100 &&
                    pu_2 < 140 &&
                    pu_3 <= 150 &&
                    pu_4 <= 75) {
                  _print_string = "엉덩이 내리세요 \n$pu_count / 15";
                }
                if (pu_1 > 50 &&
                    pu_1 < 70 &&
                    pu_2 > 140 &&
                    pu_2 < 160 &&
                    pu_3 <= 150 &&
                    pu_4 <= 75) {
                  _print_string = "엉덩이 올리세요 \n$pu_count / 15";
                }
                if ((pu_1 < 15 &&
                    pu_2 > 160 &&
                    pu_2 < 180 &&
                    pu_3 > 150 &&
                    pu_3 < 180 &&
                    pu_4 <= 75)) {
                  pu_ready = 2;
                }
              }
            }
            if ((pu_ready == 1)) {
              if (pu_1 != null &&
                  pu_2 != null &&
                  pu_3 != null &&
                  pu_4 != null) {
                if (pu_1 > 50 &&
                    pu_1 < 70 &&
                    pu_2 > 140 &&
                    pu_2 < 180 &&
                    pu_3 <= 150 &&
                    pu_4 <= 8) {
                  _print_string = "올라가세요 \n$pu_count / 15";
                  pu_ready = 0;
                }
              }
            }
            //print(pu_count);
            if (pu_ready == 2) {
              if (pu_1 != null &&
                  pu_2 != null &&
                  pu_3 != null &&
                  pu_4 != null) {
                if ((pu_1 < 15 &&
                    pu_2 > 160 &&
                    pu_2 < 180 &&
                    pu_3 > 150 &&
                    pu_3 < 180 &&
                    pu_4 <= 75)) {
                  pu_count += 1;
                  _print_string = "내려가세요 \n$pu_count / 15";
                  pu_ready = 1;
                }
              }
            }
          }

          if (pu == 1) {
            pushup();
          }

/////////////////////////////////////////////////////////스쿼트
          void squat() {
            if ((rightElbow != null) && // 1. 팔꿈치 어깨 힙
                (rightShoulder != null) &&
                (rightHip != null)) {
              sq_1 = angle(rightElbow[0], rightShoulder[0], rightHip[0],
                  rightElbow[1], rightShoulder[1], rightHip[1]);
            }
            if ((rightHip != null) && // 2. 힙 무릎 발목
                (rightKnee != null) &&
                (rightAnkle != null)) {
              sq_2 = angle(rightHip[0], rightKnee[0], rightAnkle[0],
                  rightHip[1], rightKnee[1], rightAnkle[1]);
            }

            //if (sq_1 != null) print('111111: $sq_1');
            //if (sq_2 != null) print('222222: $sq_2');
            if (sq_ready == 0) {
              if (sq_1 != null) {
                if (sq_1 > 70 && sq_1 < 90) {
                  _print_string = "스쿼트 준비완료 \n";
                  sq_ready = 1;
                  pu = 1;
                  pl = 1;
                }
              }
            }
            if ((sq_ready == 1) && (sq_up == 0)) {
              if (sq_2 != null) {
                if (sq_2 < 130) {
                  _print_string = "골반 더 내려가세요 \n $sq_count / 15";
                  if (sq_2 < 90) {
                    sq_up = 1;
                    sq_ready = 2;
                    _print_string = "올라가세요 \n $sq_count / 15";
                  }
                }
              }
            }
            //print(sq_count);
            if (sq_up == 1) {
              if (sq_2 != null) {
                if (sq_2 > 165 && sq_2 < 180) {
                  sq_count += 1;
                  _print_string = "내려가세요 \n $sq_count / 15";
                  sq_up = 0;
                  sq_ready = 1;
                }
              }
            }
            if (sq_count >= 15) {
              sq_up = 15;
              _print_string = "수고하셨습니다. \n $sq_count / 15";
            }
          }

/*
          if (sq == 10) {
            squat();
            if (sq_count >= 15) {
             pl = 10;
              sq = 11;
            }
          }
*/
/////////////////////////////////////////////////////////플랭크
          void plank() {
            if ((rightKnee != null) && // 1. 무릎 힙 어깨
                (rightHip != null) &&
                (rightShoulder != null)) {
              pl_1 = angle(rightKnee[0], rightHip[0], rightShoulder[0],
                  rightKnee[1], rightHip[1], rightShoulder[1]);
            }
            if ((rightWrist != null) && // 2. 손목 팔꿈치 무릎
                (rightElbow != null) &&
                (rightKnee != null)) {
              pl_2 = angle(rightWrist[0], rightElbow[0], rightKnee[0],
                  rightWrist[1], rightElbow[1], rightKnee[1]);
            }
            if ((rightHip != null) && // 3. 힙 어깨 팔꿈치
                (leftShoulder != null) &&
                (rightElbow != null)) {
              pl_3 = angle(rightHip[0], leftShoulder[0], rightElbow[0],
                  rightHip[1], leftShoulder[1], rightElbow[1]);
            }
/*
            if (pl_1 != null && pl_2 != null && pl_3 != null) {
              pl_1 = double.parse(pl_1.toStringAsFixed(0));
              pl_2 = double.parse(pl_2.toStringAsFixed(0));
              pl_3 = double.parse(pl_3.toStringAsFixed(0));
              _print_string = '$pl_1 \n$pl_2 \n$pl_3';
            }
*/
            //if (pl_1 != null) print('111111: $pl_1');
            //if (pl_2 != null) print('222222: $pl_2');

            if (pl_ready == 0) {
              if (pl_1 != null && pl_2 != null && pl_3 != null) {
                if (pl_1 > 150 &&
                    pl_1 < 185 &&
                    pl_2 > 135 &&
                    pl_2 < 180 &&
                    pl_3 < 43) {
                  _print_string = " 힙 올려주세요 \n$pl_time2 초";
                } else if (pl_1 > 150 &&
                    pl_1 < 185 &&
                    pl_2 > 135 &&
                    pl_2 < 180 &&
                    pl_3 > 73) {
                  _print_string = " 힙 내려주세요 \n$pl_time2 초";
                } else if (pl_1 > 150 &&
                    pl_1 < 185 &&
                    pl_2 > 135 &&
                    pl_2 < 180 &&
                    pl_3 > 43 &&
                    pl_3 < 73) {
                  pl_ready = 1;
                  startTime = new DateTime.now().millisecondsSinceEpoch;
                } else {
                  _print_string = '$pl_time2 초';
                }
              }
            }
            if (pl_ready == 1) {
              if (pl_1 != null && pl_2 != null && pl_3 != null) {
                if (pl_1 > 150 &&
                    pl_1 < 185 &&
                    pl_2 > 135 &&
                    pl_2 < 180 &&
                    pl_3 > 43 &&
                    pl_3 < 73) {
                  int endTime = new DateTime.now().millisecondsSinceEpoch;
                  last = (endTime - startTime) / 1000;
                  if (pl_time3 > 0) {
                    pl_time = last + pl_time3;
                  } else {
                    pl_time = last;
                  }
                } else {
                  pl_time3 = pl_time;
                  last = 0;
                  pl_ready = 0;
                }
              }
              pl_time2 = double.parse(pl_time.toStringAsFixed(0));
              _print_string = '$pl_time2 초';
            }
          }
/*
          if (pl == 10) plank();
*/
          //_print_string = _x < 0.2 ? "junior su" : "senior su";
/*    
          if(nose != null){
            print('nose:');
            print(nose[0]);
          }
          if(leftShoulder != null){
            print('leftSholuder:');
            print(leftShoulder[0]);
          }
          if(leftElbow != null){
            print('leftElbow:');
            print(leftElbow[0]);
          }

          if(leftWrist != null){
            print('leftWrist:');
            print(leftWrist[0]);
          }
          if(leftHip != null){
            print('leftHip:');
            print(leftHip[0]);
          }
          if(leftAnkle != null){
            print('leftAnkle:');
            print(leftAnkle[0]);
          }
*/
          //print('leftEye');
          //print(leftEye);

          //print('nose x: $k["x"]');
          //print(k["x"]);
          //print(k["part"]);

          return Positioned(
            left: x - 280, //280
            top: y - 50, //50
            width: 100,
            height: 15,
            child: Container(
              child: Text(
                // "●", // this point!
                "● ${k["part"]}",
                style: TextStyle(
                  color: Color.fromRGBO(200, 0, 0, 1.0),
                  fontSize: 12.0,
                ),
              ),
            ),
          );
        }).toList();

        lists..addAll(list);
      });
      return lists;
    }

    return Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 0, 32.0, 16.0),
            child: Text(
              _print_string.toString(),
              style: TextStyle(
                fontSize: 37,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent[400].withOpacity(1),
              ),
            ),
          ),
        ],
      ),
      Stack(
        children: _renderKeypoints(),
      ),
    ]);
  }
}
