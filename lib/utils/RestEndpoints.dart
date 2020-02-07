import 'package:flutter_blue_test_applciation/utils/NetworkCommon.dart';

class RestEndpoints{
  static Future uploadData(List<Map<String, dynamic>> unUploadedData) async {

    print("In rest endpoints");

    Map<String, dynamic> data = {"data": unUploadedData};

    return await new NetworkCommon()
    .dio
    .post("https://vlvwmemd96.execute-api.us-east-1.amazonaws.com/v1/sensordata",
          data: data);
  }
}