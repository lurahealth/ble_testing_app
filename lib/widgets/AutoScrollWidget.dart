import 'package:flutter/material.dart';
import 'package:flutter_blue_test_applciation/provideres/DeviceDataProvider.dart';

class AutoScrollWidget extends StatelessWidget {
  final DeviceDataProvider provider;

  AutoScrollWidget(this.provider);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text("Auto Scroll"),
        Switch(
            value: provider.autoScroll ,
            onChanged: provider.toggleAutoScroll
        )
      ],
    );
  }
}
