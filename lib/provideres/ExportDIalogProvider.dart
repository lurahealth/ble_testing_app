import 'dart:io';

import 'package:csv/csv.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_test_applciation/utils/DatabaseProvider.dart';
import 'package:flutter_blue_test_applciation/utils/StringUtils.dart';
import 'package:path_provider/path_provider.dart';

class ExportDialogProvider with ChangeNotifier{
  DateTime from;
  DateTime to;
  bool exporting = false;

  void setFromDate(DateTime value){
    this.from = value;
  }

  void setToDate(DateTime value){
    this.to = value;
  }

  Future<void> exportData(BuildContext context) async {
    exporting = true;
    notifyListeners();
    int fromInt = from.millisecondsSinceEpoch;
    int toInt = to.millisecondsSinceEpoch;

    DBProvider db = DBProvider.db;
    List<Map<String, dynamic>> rows = await db.getDataByDateRange(fromInt, toInt);
    List<List<dynamic>> data = [];
    data.add(["time","Device_Id","pH","temperature","battery","connection time","notes"]);
    print(rows.length);
    rows.forEach((row){
      DateTime time = DateTime.fromMillisecondsSinceEpoch(row[StringUtils.TIME_STAMP]);
      String timeSTRING = StringUtils.dataTableTimeFormat.format(time);
      data.add([
        timeSTRING,
        row[StringUtils.DEVICE_ID],
        row[StringUtils.PH],
        row[StringUtils.TEMPERATURE],
        row[StringUtils.BATTERY],
        row[StringUtils.CONNETION_TIME],
        row[StringUtils.NOTES]
      ]);
    });

    String csv = const ListToCsvConverter().convert(data);
    var file = await _localFile;
    await file.writeAsString('$csv');

    exporting = false;
    notifyListeners();

    final ByteData bytes = await rootBundle.load(file.path);

    await Share.file('Csv export', 'csv.txt', bytes.buffer.asUint8List(), 'text/csv');

    Navigator.pop(context);

  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/csv.txt');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}