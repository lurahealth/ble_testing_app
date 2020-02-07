import 'dart:io';
import 'package:flutter_blue_test_applciation/models/DataModel.dart';
import 'package:flutter_blue_test_applciation/utils/StringUtils.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {

  int CURRENT_DB_VERSION = 5;
  // No v2 OR V3 because I screwed up the update.
  // Change log for v4: Adding the device_id column
  // Change log for v5: Adding uploaded column

  static Database _database;
  static final DatabaseProvider db = DatabaseProvider._();

  DatabaseProvider._();

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
    }, onUpgrade: onUpgrade);
  }

  void onUpgrade (Database db, int oldVersion, int newVersion) async {
    print("Updating DB");
    if(oldVersion == 1){
      print("Updating DB from v1 to v5");
      await db.execute(StringUtils.V1_TO_V5_UPDATE_QUERY);
    }else if (oldVersion == 4) {
      print("Updating DB from v4 to v5");
      await db.execute(StringUtils.V4_TO_V5_UPDATE_QUERY);
    }
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

  Future<List<Map<String, dynamic>>> getUnUploadedData() async {
    final db = await database;
    String query = "SELECT * FROM ${StringUtils.TABLE_NAME} WHERE ${StringUtils.UPLOADED} = 0";
    print(query);
    return await db.rawQuery(query);
  }

  Future markUploaded(List<Map<String, dynamic>> updateList) async {
    final db = await database;
    Batch batch = db.batch();
    updateList.forEach((updateItem){
      batch.update(StringUtils.TABLE_NAME, updateItem);
    });
    return await batch.commit(continueOnError: true);
  }
}
