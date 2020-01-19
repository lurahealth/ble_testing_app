import 'dart:io';
import 'package:flutter_blue_test_applciation/models/DataModel.dart';
import 'package:flutter_blue_test_applciation/utils/StringUtils.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {

  int CURRENT_DB_VERSION = 1;

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, StringUtils.DATABASE_NAME);
    return await openDatabase(path, version: CURRENT_DB_VERSION, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute(StringUtils.CREATE_TABLE_QUERY);
    });
  }

  Future insertSensorData(DataModel dataModel) async {
    final db = await database;
    db.insert(StringUtils.TABLE_NAME, dataModel.toMap());
  }

  Future<List<Map<String, dynamic>>> getDataByDateRange(int from, int to) async {

    final db = await database;
    String query = "SELECT * FROM ${StringUtils.TABLE_NAME} WHERE ${StringUtils.TIME_STAMP} >= $from and ${StringUtils.TIME_STAMP} <= $to";
    print(query);
    return await db.rawQuery(query);
  }
}
