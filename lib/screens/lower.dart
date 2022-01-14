import 'package:flutter/material.dart';
import 'package:turningpoint/util/exerciselist.dart';
import 'package:turningpoint/widgets/exerciseproduct.dart';

class Lower extends StatefulWidget {
  @override
  _LowerState createState() => _LowerState();
}

class _LowerState extends State<Lower>
    with AutomaticKeepAliveClientMixin<Lower> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
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
                  isFav: true,
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
