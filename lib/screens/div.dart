import 'package:flutter/material.dart';
import 'package:turningpoint/screens/lower.dart';
import 'package:flutter/services.dart';
import 'package:turningpoint/screens/upper.dart';

class Div extends StatefulWidget {
  @override
  _JoinAppState createState() => _JoinAppState();
}

class _JoinAppState extends State<Div> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 1, length: 2);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).accentColor,
          labelColor: Theme.of(context).accentColor,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
          tabs: <Widget>[
            Tab(
              text: "루틴",
            ),
            Tab(
              text: "운동",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Upper(),
          Lower(),
        ],
      ),
    );
  }
}
