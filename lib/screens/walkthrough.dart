import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:turningpoint/screens/join.dart';

class Walkthrough extends StatefulWidget {
  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  List pageInfos = [
    {
      "title": "튜토리얼1",
      "body": "이앱은 아직 완성되지않은 데모버전입니다.",
      "img": "assets/tutorial/demo.png",
    },
    {
      "title": "튜토리얼2",
      "body": "운동을 시작하실때에 가능한 깔끔한 배경화면에서 시작하여주시고 \n 휴대폰이 움직이지 않도록 고정시켜주세요",
      "img": "assets/tutorial/tutorial2.png",
    },
    {
      "title": "튜토리얼3",
      "body":
          "운동을 시작하실때에 몸 전체를 화면에 보이게끔 비치하여주시고 \n 서서하는 동작은 세로로, 눕거나 엎드려서 하는동작은 가로로 휴대폰을 비치하여 주세요",
      "img": "assets/tutorial/on3.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = [
      for (int i = 0; i < pageInfos.length; i++) _buildPageModel(pageInfos[i])
    ];

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: IntroductionScreen(
            pages: pages,
            onDone: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return JoinApp();
                  },
                ),
              );
            },
            onSkip: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return JoinApp();
                  },
                ),
              );
            },
            showSkipButton: true,
            skip: Text("건너뛰기"),
            next: Text(
              "다음",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).accentColor,
              ),
            ),
            done: Text(
              "완료",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildPageModel(Map item) {
    return PageViewModel(
      title: item['title'],
      body: item['body'],
      image: Image.asset(
        item['img'],
        height: 185.0,
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).accentColor,
        ),
        bodyTextStyle: TextStyle(fontSize: 15.0),
//        dotsDecorator: DotsDecorator(
//          activeColor: Theme.of(context).accentColor,
//          activeSize: Size.fromRadius(8),
//        ),
        pageColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
