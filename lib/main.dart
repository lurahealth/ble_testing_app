import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_test_applciation/utils/DatabaseProvider.dart';
import 'package:flutter_blue_test_applciation/utils/RestEndpoints.dart';
import 'package:flutter_blue_test_applciation/utils/RouteGenerator.dart';
import 'package:flutter_blue_test_applciation/utils/StringUtils.dart';
import 'package:workmanager/workmanager.dart';

import 'background_processes/BackgroundUpload.dart';

void main() => runApp(MyApp());

// Called by the Workman plugin. This needs to be a top level method
void callbackDispatcher() {
  print("in callback dispatcher");
  Workmanager.executeTask((task, inputData) async {
    String dir = inputData["dir"];
    switch (task) {
      case Workmanager.iOSBackgroundTask:
        print("The iOS background task was triggered");
        await doBackGroundUpload(dir);
        break;
      case StringUtils.ANDROID_PERIODIC_TASK:
        print("The Android background task was triggered");
        doBackGroundUpload(dir);
        break;
    }
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.indigo, accentColor: Colors.deepOrangeAccent),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute);
  }
}

Future<void> doBackGroundUpload(String dir) async {
  // get un-uploaded sensor data from the DB.
  List<Map<String, dynamic>> unUploadedData =
  await DatabaseProvider.db.getUnUploadedData();

  // Upload them
  Response response = await RestEndpoints.uploadData(unUploadedData);
  print(response.data.toString());

  // mark sensor data as uploaded

  return;
}
