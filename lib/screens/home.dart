import 'package:flutter/material.dart';
import 'package:turningpoint/screens/div.dart';
import 'package:turningpoint/widgets/exerciseproduct.dart';
import 'package:turningpoint/widgets/home_category.dart';
import 'package:turningpoint/widgets/slider_item.dart';
import 'package:turningpoint/util/exerciselist.dart';
import 'package:turningpoint/util/categories.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var carouselSlider = CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height / 2.4,
        autoPlay: true,
//                enlargeCenterPage: true,
        viewportFraction: 1.0,
//              aspectRatio: 2.0,
      ),
      items: map<Widget>(
        exercises,
        (index, i) {
          Exerciselist exercise = exercises[index];
          return SliderItem(
            index: index,
            img: exercise.img,
            isFav: false,
            name: exercise.name,
            rating: 5.0,
            raters: 23,
          );
        },
      ).toList(),
    );

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Text(
              "오늘의 미션",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10.0),

            Container(
              height: 65.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categories == null ? 0 : 1,
                itemBuilder: (BuildContext context, int index) {
                  Map cat = categories[3];
                  return HomeCategory(
                    icon: cat['icon'],
                    title: cat['name'],
                    isHome: true,
                  );
                },
              ),
            ),

            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "AI추천 운동",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextButton(
                  child: Text(
                    "더보기",
                    style: TextStyle(
//                      fontSize: 22,
//                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return Div();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 10.0),

            //Slider Here

            carouselSlider,
            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "운동",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextButton(
                  child: Text(
                    "더보기",
                    style: TextStyle(
//                      fontSize: 22,
//                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
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
              itemCount: exercises == null ? 0 : exercises.length,
              itemBuilder: (BuildContext context, int index) {
//                exercise exercise = exercise.fromJson(exercises[index]);
                Exerciselist exercise = exercises[index];
//                print(exercises);
//                print(exercises.length);
                return ExerciseProduct(
                  index: index,
                  img: exercise.img,
                  isFav: false,
                  name: exercise.name,
                  rating: 5.0,
                  raters: 23,
                );
              },
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
