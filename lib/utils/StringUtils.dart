import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class StringUtils{

  // Database Strings
  static final String DATABASE_NAME = "SensorData.db";
  static final String TABLE_NAME = "Data_Table";

  // columns names
  static final String ROW_ID = "row_id";
  static final String PH = "ph";
  static final String BATTERY = "battery";
  static final String TEMPERATURE = "temperature";
  static final String CONNETION_TIME = "connection_time";
  static final String TIME_STAMP = "time_stamp";
  static final String NOTES = "notes";
  static final String DEVICE_ID = "device_id";

  static final String CREATE_TABLE_QUERY =
      "CREATE TABLE $TABLE_NAME ("
      "$ROW_ID INTEGER PRIMARY KEY,"
      "$DEVICE_ID TEXT,"
      "$PH REAL,"
      "$BATTERY REAL,"
      "$TEMPERATURE REAL,"
      "$CONNETION_TIME INTEGER,"
      "$NOTES TEXT,"
      "$TIME_STAMP INTEGER)";

  static final String V1_TO_V4_UPDATE_QUERY =
      "ALTER TABLE $TABLE_NAME "
      "ADD COLUMN $DEVICE_ID TEXT";

  // UUID
  static final String UART_SERVICE_UUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e";
  static final String RX_UUID = "6e400003-b5a3-f393-e0a9-e50e24dcca9e";

  // Time format
  static final DateFormat dataTableTimeFormat = DateFormat("HH:mm:ss");
  static final DateFormat csvDateTimeFormat = DateFormat("dd.MMMM.yyyy HH:mm");

  //Style
  static final TextStyle style = TextStyle(fontSize: 15);
}