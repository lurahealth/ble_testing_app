import 'package:flutter/material.dart';
import 'package:flutter_blue_test_applciation/provideres/DeviceDataProvider.dart';

class WidthWidget extends StatelessWidget {

  final DeviceDataProvider provider;

  WidthWidget(this.provider);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: provider.increaseWidth,
        ),
        Text("Width: ${provider.width.toString()}"),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: provider.decreaseWidth,
        ),
      ],
    );
  }
}
