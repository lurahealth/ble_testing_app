import 'package:flutter_blue_test_applciation/utils/StringUtils.dart';

class DataModel{
  final num pH;
  final num battery;
  final num temperature;
  final num connectionTime;
  final DateTime timeStamp;
  final String notes;
  final String deviceId;

  DataModel(this.pH,
            this.battery,
            this.temperature,
            this.connectionTime,
            this.timeStamp,
            this.notes,
            this.deviceId);

  Map<String, dynamic> toMap(){
    return {
      StringUtils.PH: pH,
      StringUtils.BATTERY: battery,
      StringUtils.TEMPERATURE: temperature,
      StringUtils.CONNETION_TIME: connectionTime,
      StringUtils.TIME_STAMP: (timeStamp.millisecondsSinceEpoch/1000000.0),
      StringUtils.NOTES: notes,
      StringUtils.DEVICE_ID: deviceId
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map){
    return DataModel(
      map[StringUtils.PH],
      map[StringUtils.BATTERY],
      map[StringUtils.TEMPERATURE],
      map[StringUtils.CONNETION_TIME],
      DateTime.fromMillisecondsSinceEpoch(map[StringUtils.TIME_STAMP]),
      map[StringUtils.NOTES],
      map[StringUtils.DEVICE_ID]
    );
  }
}