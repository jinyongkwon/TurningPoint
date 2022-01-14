import 'package:flutter/material.dart';
import 'package:turningpoint/util/routinelist.dart';
import 'package:turningpoint/widgets/routineproduct.dart';

class Upper extends StatefulWidget {
  @override
  _UpperState createState() => _UpperState();
}

class _UpperState extends State<Upper>
    with AutomaticKeepAliveClientMixin<Upper> {
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
              itemCount: routines == null ? 0 : routines.length,
              itemBuilder: (BuildContext context, int index) {
//                exercise exercise = exercise.fromJson(exercises[index]);
                Routinelist routine = routines[index];
//                print(exercises);
//                print(exercises.length);
                return RoutineProduct(
                  index: index,
                  img: routine.img,
                  isFav: true,
                  name: routine.name,
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
