import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_test_applciation/models/DataModel.dart';
import 'package:flutter_blue_test_applciation/models/SplineData.dart';
import 'package:flutter_blue_test_applciation/utils/DatabaseProvider.dart';
import 'package:flutter_blue_test_applciation/utils/StringUtils.dart';

class DeviceDataProvider with ChangeNotifier {
  final BluetoothDevice device;
  double pH;
  double temperature;

  double battery;
  double connectionTime;
  List<SplineData> temperatureData = <SplineData>[];
  List<SplineData> batteryData = <SplineData>[];
  List<SplineData> pHData = <SplineData>[];
  List<SplineData> connectionTimeData = <SplineData>[];
  List<DataModel> allData = <DataModel>[];
  List<DataRow> rows = <DataRow>[];
  String notes;
  bool error = false;
  String errorMessage = "";
  double animationDuration = 0;
  int width = 5;
  static DateTime currentTime = DateTime.now();
  DateTime min = currentTime;
  DateTime max = currentTime.add(Duration(seconds: 5));
  bool dataLoaded = false;
  bool autoScroll = true;

  DateTime startTime;
  DateTime endTime;

  DeviceDataProvider(this.device);

  Future<void> getData() async {
    if (!dataLoaded) {
      dataLoaded = true;
      print("getting data");
      // get list of services from device
      List<BluetoothService> services = await device.discoverServices();

      // get the uart service by its UUID
      BluetoothService uartService = getUartService(services);

      // get a list of characteristics from the UART service
      List<BluetoothCharacteristic> characteristics = uartService
          .characteristics;

      // get the Rx service by uts UUID
      BluetoothCharacteristic rx = getRxCharacteristic(characteristics);

      rx.value.listen(onDataReceived, onError: onErrorReceivingData);

      // not sure what this does, but we don't get anything out of the device till this is set
      rx.setNotifyValue(true);
    }
  }

  void clearData() {
    pH = null;
    temperature = null;
    battery = null;
    connectionTime = null;
  }

  void onDataReceived(List<int> value) {
    clearData();
    String data = utf8.decode(value);
    print("Raw Data $data");
    List<String> readings = data.split(",");
    pH = double.parse(readings[0]);
    temperature = double.parse(readings[1]);
    battery = double.parse(readings[2]);
    if (readings.length > 3) {
      connectionTime = double.parse(readings[3]);
    }

    insertData();


    if (autoScroll) {
      calculateMixMaxTimes();
    }
    notifyListeners();
  }

  void insertData(){
    DateTime now = DateTime.now();
    setStartAndEndTime(now);
    DataModel dataModel = new DataModel(
        pH, battery, temperature, connectionTime, now, notes);
    DBProvider.db.insertSensorData(dataModel);
    notes = null;
    allData.insert(0, dataModel);
//    if(allData.length > 400){
//      deleteOldData();
//    }
    temperatureData.add(SplineData.fromLiveData(now, temperature));
    pHData.add(SplineData.fromLiveData(now, pH));
    batteryData.add(SplineData.fromLiveData(now, battery));
    connectionTimeData.add(SplineData.fromLiveData(now, connectionTime));
  }

  void onErrorReceivingData(error) {
    print("Error receiving data: $error");
    error = true;
    errorMessage = error.toString();
    notifyListeners();
  }

  BluetoothService getUartService(List<BluetoothService> services) =>
      services.firstWhere((services) =>
      services.uuid.toString() == StringUtils.UART_SERVICE_UUID);


  BluetoothCharacteristic getRxCharacteristic(
      List<BluetoothCharacteristic> characteristics) =>
      characteristics.firstWhere(
              (c) =>
          c.uuid.toString() == StringUtils.RX_UUID);

  Future<void> disconnect() async {
    await device.disconnect();
  }

  void increaseWidth() {
    width ++;
    if (autoScroll) {
      calculateMixMaxTimes();
    }
    notifyListeners();
  }

  void decreaseWidth() {
    if (width > 5) {
      width --;
    }
    if (autoScroll) {
      calculateMixMaxTimes();
    }
    notifyListeners();
  }

  List<DataColumn> getColumns() {
    return [
      DataColumn(
          label: Text("Time stamp"),
          numeric: true,
          tooltip: "Date time value"),
      DataColumn(
          label: Text("ph"),
          numeric: true,
          tooltip: "pH value"),
      DataColumn(
          label: Text("Temprature"),
          numeric: true,
          tooltip: "Temprature value"),
      DataColumn(
          label: Text("Battery"),
          numeric: true,
          tooltip: "Battery value")
    ];
  }

  void calculateMixMaxTimes() {
    if (allData.length <= width) {
      if (allData.length == 0) {
        min = DateTime.now();
        max = min.add(Duration(seconds: width));
      } else {
        min = allData.last.timeStamp;
        max = min.add(Duration(seconds: width));
      }
    } else {
      max = allData.first.timeStamp;
      min = max.subtract(Duration(seconds: width));
    }
  }

  void toggleAutoScroll(bool value) {
    autoScroll = value;
    notifyListeners();
  }

  void panGraph(DragUpdateDetails details) {
    autoScroll = false;
    notifyListeners();
    if (details.primaryDelta < 0 &&
        min.isAfter(startTime)) {
      max = max.subtract(Duration(seconds: 2));
      min = max.subtract(Duration(seconds: width));
    } else if (details.primaryDelta > 0 && max.isBefore(endTime)) {
      max = max.add(Duration(seconds: 2));
      min = max.subtract(Duration(seconds: width));
    }
  }

  void setStartAndEndTime(DateTime now) {
    if (startTime == null) {
      startTime = now;
    }
    endTime = now;
  }

  void deleteOldData() {
    allData.removeRange(300, allData.length-1);
    pHData.removeRange(0,100);
    print(pHData.length);
    temperatureData.removeRange(0,100);
    batteryData.removeRange(0,100);
    connectionTimeData.removeRange(0,100);
  }

  void saveNote(String note) {
    this.notes = note;
  }

  void disconnectDevice(BuildContext context) {
    print("Disconnecting device press");
  }
}
