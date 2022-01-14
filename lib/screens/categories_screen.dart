import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:turningpoint/caloriecheck/main.dart';
import 'package:turningpoint/util/categories.dart';
import 'package:turningpoint/util/routinelist.dart';
import 'package:turningpoint/widgets/routineproduct.dart';
import 'package:turningpoint/widgets/home_category.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String catie = "Drinks";
  @override
  Widget build(BuildContext context) {
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
          "오늘의 미션",
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
            InkWell(
              child: Container(
                height: 65.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories == null ? 0 : categories.length - 1,
                  itemBuilder: (BuildContext context, int index) {
                    Map cat = categories[index];
                    return HomeCategory(
                      icon: cat['icon'],
                      title: cat['name'],
                      isHome: false,
                    );
                  },
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Check();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 20.0),
            Divider(),
            SizedBox(height: 10.0),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: routines == null ? 0 : routines.length,
              itemBuilder: (BuildContext context, int index) {
                Routinelist routine = routines[index];
                return RoutineProduct(
                  img: routine.img,
                  isFav: false,
                  name: routine.name,
                  rating: 5.0,
                  raters: 23,
                  index: index,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
