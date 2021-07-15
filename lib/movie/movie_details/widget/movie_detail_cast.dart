import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieDetailCast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext contex, int index) {
            // return Text(state.data.cast[index].name);
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.all(1.0),
                  height: 100,
                  width: 100,
                  color: Colors.pink,
                )
              ],
            );
          },
        )
    );
  }

}