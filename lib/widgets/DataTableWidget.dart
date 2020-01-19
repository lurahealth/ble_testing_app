import 'package:flutter/material.dart';
import 'package:flutter_blue_test_applciation/models/DataModel.dart';
import 'package:flutter_blue_test_applciation/provideres/DeviceDataProvider.dart';
import 'package:flutter_blue_test_applciation/utils/StringUtils.dart';

class DataTableWidget extends StatelessWidget {
  final DeviceDataProvider provider;

  DataTableWidget(this.provider);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: provider.allData.length,
        itemBuilder: (BuildContext context, int index) {
          DataModel dataModel = provider.allData[index];
          return Container(
            color: index.isEven ? Colors.grey[350] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  getText(
                      StringUtils.dateTimeFormat.format(dataModel.timeStamp)),
                  getText(dataModel.pH.toString()),
                  getText(dataModel.temperature.toString()),
                  getText(dataModel.battery.toString())
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Text getText(String text) {
    return Text(
      text,
      style: StringUtils.style,
    );
  }
}
