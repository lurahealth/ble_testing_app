import 'package:flutter/material.dart';
import 'package:flutter_blue_test_applciation/provideres/DeviceDataProvider.dart';
import 'package:flutter_blue_test_applciation/widgets/AutoScrollWidget.dart';
import 'package:flutter_blue_test_applciation/widgets/WidthWidget.dart';

class GraphControlWidget extends StatelessWidget {
  final DeviceDataProvider provider;

  GraphControlWidget(this.provider);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        WidthWidget(provider),
        AutoScrollWidget(provider)
      ],
    );
  }
}
