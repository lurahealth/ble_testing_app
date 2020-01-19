import 'package:flutter/material.dart';
import 'package:flutter_blue_test_applciation/provideres/DeviceDataProvider.dart';
import 'package:flutter_blue_test_applciation/utils/GraphUtils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphWidget extends StatelessWidget {
  final DeviceDataProvider provider;

  GraphWidget(this.provider);

  @override
  Widget build(BuildContext context) {
    double animationDuration = provider.animationDuration;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onHorizontalDragUpdate: provider.panGraph,
          child: SfCartesianChart(
            // Initialize category axis
            primaryXAxis: DateTimeAxis(
              minimum: provider.min,
              maximum: provider.max,
            ),
            primaryYAxis: NumericAxis(),
            trackballBehavior: TrackballBehavior(
                enable: true, activationMode: ActivationMode.singleTap),
            zoomPanBehavior:
                ZoomPanBehavior(enablePinching: true, enablePanning: false),

            series: <ChartSeries>[
              GraphDataUtils.getSplineDate(
                  provider.temperatureData, Colors.orange, animationDuration),
              GraphDataUtils.getSplineDate(
                  provider.pHData, Colors.blue, animationDuration),
              GraphDataUtils.getSplineDate(
                  provider.batteryData, Colors.red, animationDuration),
              GraphDataUtils.getSplineDate(
                  provider.connectionTimeData, Colors.green, animationDuration),
            ],
            selectionType: SelectionType.point,
          ),
        ),
      ],
    );
  }
}
