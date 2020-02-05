import 'package:flutter_blue_test_applciation/utils/StringUtils.dart';

class DataModel{
  final num pH;
  final num battery;
  final num temperature;
  final num connectionTime;
  final DateTime timeStamp;
  final String notes;
  final bool uploaded;
  final String deviceId;

  DataModel(this.pH,
      this.battery,
      this.temperature,
      this.connectionTime,
      this.timeStamp,
      this.notes,
      this.deviceId,
      this.uploaded);

  Map<String, dynamic> toMap(){
    return {
      StringUtils.PH: pH,
      StringUtils.BATTERY: battery,
      StringUtils.TEMPERATURE: temperature,
      StringUtils.CONNETION_TIME: connectionTime,
      StringUtils.TIME_STAMP: timeStamp.millisecondsSinceEpoch,
      StringUtils.NOTES: notes,
      StringUtils.DEVICE_ID: deviceId,
      StringUtils.UPLOADED: uploaded? 1 :0
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
        map[StringUtils.DEVICE_ID],
        (map[StringUtils.UPLOADED] == 1)? true:false
    );
  }
}