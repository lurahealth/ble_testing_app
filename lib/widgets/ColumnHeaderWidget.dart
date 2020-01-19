import 'package:flutter/material.dart';

class ColumnHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text("Time"),
        new Text("pH", style: TextStyle(color: Colors.orange),),
        new Text("Temp", style: TextStyle(color: Colors.blue),),
        new Text("Batt", style: TextStyle(color: Colors.red),),
      ],
    );
  }
}
