import 'package:csv/csv.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_test_applciation/models/DateRangeModel.dart';
import 'package:flutter_blue_test_applciation/utils/DatabaseProvider.dart';
import 'package:flutter_blue_test_applciation/utils/StringUtils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show File, Platform, sleep;

class DeviceScanProvider with ChangeNotifier {
  List<ScanResult> scanResults = [];
  PermissionHandler _permissionHandler;
  FlutterBlue _flutterBlue;

  Future<String> scanForDevices() async {
    if (await permissionCheck(PermissionGroup.locationAlways)) {
      scanResults = [];
      if (_flutterBlue == null) {
        _flutterBlue = FlutterBlue.instance;
      } else {
        _flutterBlue.stopScan();
      }
      // Start scanning
      _flutterBlue.startScan(timeout: Duration(seconds: 4));
      _flutterBlue.scanResults.listen(onScanResult);
    } else {
      print("No Location permission");
    }

    return "Return";
  }

  void onScanResult(List<ScanResult> scanResults) {
    scanResults.forEach((result){
      String name = result.device.name;
      if(name != null && name.length > 0 && !(this.scanResults.contains(result))){
        this.scanResults.add(result);
      }
    });
    notifyListeners();
  }

  Future<bool> permissionCheck(PermissionGroup permission) async {
    if (_permissionHandler == null) {
      _permissionHandler = PermissionHandler();
    }

    // check for location permission
    var permissionStatus =
        await _permissionHandler.checkPermissionStatus(permission);
    if (permissionStatus != PermissionStatus.granted) {
      var result = await _permissionHandler.requestPermissions([permission]);
      if (result[permission] == PermissionStatus.granted) {
        return true;
      } else
        return false;
    } else {
      return true;
    }
  }

  void connectToDevice(BuildContext context, BluetoothDevice device) {
    _flutterBlue.stopScan();
    if (Platform.isAndroid) {
      sleep(const Duration(seconds: 1));
    }
    Navigator.pushNamed(context, "/deviceDataScreen", arguments: device);
  }






}
