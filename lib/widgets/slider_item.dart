import 'package:flutter/material.dart';
import 'package:turningpoint/screens/exercise.dart';
import 'package:turningpoint/util/const.dart';
import 'package:turningpoint/util/exerciselist.dart';
import 'package:turningpoint/widgets/difficultyicon.dart';

class SliderItem extends StatelessWidget {
  final String name;
  final int index;
  final String img;
  final bool isFav;
  final double rating;
  final int raters;

  SliderItem(
      {Key key,
      @required this.name,
      @required this.index,
      @required this.img,
      @required this.isFav,
      @required this.rating,
      @required this.raters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3.2,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    exercises[index].img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Text(
              exercises[index].name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
              ),
              maxLines: 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
            child: Row(
              children: <Widget>[
                SmoothStarRating(
                  starCount: 5,
                  color: Constants.ratingBG,
                  allowHalfRating: true,
                  rating: exercises[index].difficulty,
                  size: 10.0,
                ),
                Text(
                  "운동강도",
                  style: TextStyle(
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Exercise(index: index);
            },
          ),
        );
      },
    );
  }
}
