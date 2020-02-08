import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_test_applciation/utils/DatabaseProvider.dart';
import 'package:flutter_blue_test_applciation/utils/StringUtils.dart';
import 'package:path_provider/path_provider.dart';

class ExportDialogProvider with ChangeNotifier{
  DateTime from;
  String fromDateString;
  DateTime to;
  String toDateString;
  bool exporting = false;

  void setFromDate(DateTime value){
    this.from = value;
    fromDateString = StringUtils.csvDateTimeFormat.format(from);
    notifyListeners();
  }

  void setToDate(DateTime value){
    this.to = value;
    toDateString = StringUtils.csvDateTimeFormat.format(to);
    notifyListeners();
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

    //final ByteData bytes = await rootBundle.load(file.path);
    final Uint8List bytes = file.readAsBytesSync();

    await Share.file('Csv export', 'csv.txt', bytes, 'text/csv');

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