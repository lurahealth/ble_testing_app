import 'package:flutter_blue_test_applciation/models/DataModel.dart';
import 'package:flutter_blue_test_applciation/utils/NetworkCommon.dart';

class RestEndpoints{
  static Future uploadData(DataModel dataModel) async {
    return await new NetworkCommon()
    .dio
    .post("https://vlvwmemd96.execute-api.us-east-1.amazonaws.com/v1/sensordata",
          data: {"data": creatingTestingList(dataModel)});
  }

  static List<Map<String, dynamic>> creatingTestingList(DataModel dataModel){
    return [dataModel.toMap()];
  }
}