import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turningpoint/providers/app_provider.dart';
import 'package:turningpoint/screens/database.dart';
import 'package:turningpoint/util/const.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userStatus;
  @override
  void initState() {
    super.initState();
    setUserStatus();
  }

  Future<void> setUserStatus() async {
    userStatus = FirebaseAuth.instance.currentUser;
    setState(() {});
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    setUserStatus();
  }

  @override
  Widget build(BuildContext context) {
    final _users = Provider.of<QuerySnapshot>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: InkWell(
                    onTap: () {},
                    child: Image.network(
                      "${FirebaseAuth.instance.currentUser.photoURL}",
                      fit: BoxFit.cover,
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "${FirebaseAuth.instance.currentUser.displayName}",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "${FirebaseAuth.instance.currentUser.email}",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              logout();
                            },
                            child: Text(
                              "로그아웃",
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).accentColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  flex: 3,
                ),
              ],
            ),
            Divider(),
            Container(height: 15.0),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "내 정보".toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "이름",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                "${FirebaseAuth.instance.currentUser.displayName}",
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 20.0,
                ),
                onPressed: () {},
                tooltip: "Edit",
              ),
            ),
            ListTile(
              title: Text(
                "이메일",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                "${FirebaseAuth.instance.currentUser.email}",
              ),
            ),
            ListTile(
              title: Text(
                "전화번호",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                "010-8649-6498",
              ),
            ),
            ListTile(
              title: Text(
                "성별",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                "여자",
              ),
            ),
            ListTile(
              title: Text(
                "생년월일",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                "2000-03-23",
              ),
            ),
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? SizedBox()
                : ListTile(
                    title: Text(
                      "다크모드",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    trailing: Switch(
                      value: Provider.of<AppProvider>(context).theme ==
                              Constants.lightTheme
                          ? false
                          : true,
                      onChanged: (v) async {
                        if (v) {
                          Provider.of<AppProvider>(context, listen: false)
                              .setTheme(Constants.darkTheme, "dark");
                        } else {
                          Provider.of<AppProvider>(context, listen: false)
                              .setTheme(Constants.lightTheme, "light");
                        }
                      },
                      activeColor: Theme.of(context).accentColor,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
