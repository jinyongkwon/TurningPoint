import 'package:flutter/material.dart';
import 'package:turningpoint/util/const.dart';
import 'package:turningpoint/util/exerciselist.dart';
import 'package:turningpoint/widgets/difficultyicon.dart';
import 'package:turningpoint/screens/routine.dart';

class RoutineProduct extends StatelessWidget {
  final String name;
  final String img;
  final bool isFav;
  final double rating;
  final int raters;
  final int index;

  RoutineProduct(
      {Key key,
      @required this.name,
      @required this.img,
      @required this.isFav,
      @required this.rating,
      @required this.index,
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
                height: MediaQuery.of(context).size.height / 3.6,
                width: MediaQuery.of(context).size.width / 2.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    "$img",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Text(
              "$name",
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
                  " ????????????",
                  style: TextStyle(
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Navigator.of(context).pushReplacementNamed('/Pushup');
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Routine(index: index);
            },
          ),
        );
      },
    );
  }
}
