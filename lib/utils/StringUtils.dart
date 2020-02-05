import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class StringUtils{

  // Database Strings
  static final String DATABASE_NAME = "SensorData.db";
  static final String TABLE_NAME = "Data_Table";

  // columns names
  static final String ROW_ID = "row_id"; // auto incrementing primary key
  static final String PH = "pH"; // pH reading
  static final String BATTERY = "batery"; // battery voltage
  static final String TEMPERATURE = "temperature"; // temperature reading
  static final String CONNETION_TIME = "connection_time"; // time it took to connect the device
  static final String TIME_STAMP = "time_stamp"; // time stamp when the sensor reading was taken
  static final String NOTES = "notes"; // testing notes
  static final String DEVICE_ID = "device_id"; // device id of the sensor sending the data
  static final String UPLOADED = "uplaoded"; // if row has been uploaded set to 1 else set to 0

  static final String CREATE_TABLE_QUERY =
      "CREATE TABLE $TABLE_NAME ("
      "$ROW_ID INTEGER PRIMARY KEY,"
      "$DEVICE_ID TEXT,"
      "$PH REAL,"
      "$BATTERY REAL,"
      "$TEMPERATURE REAL,"
      "$CONNETION_TIME INTEGER,"
      "$NOTES TEXT,"
      "$UPLOADED REAL,"
      "$TIME_STAMP INTEGER)";

  static final String V1_TO_V4_UPDATE_QUERY =
      "ALTER TABLE $TABLE_NAME "
      "ADD COLUMN $DEVICE_ID TEXT";

  static final String V4_TO_V5_UPDATE_QUERY =
      "ALTER TABLE $TABLE_NAME "
      "ADD COLUMN $DEVICE_ID TEXT";

  static final String V1_TO_V5_UPDATE_QUERY =
      "ALTER TABLE $TABLE_NAME "
      "ADD COLUMN $DEVICE_ID TEXT,"
      "ADD COLUMN $UPLOADED REAL";

  // UUID
  static final String UART_SERVICE_UUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e";
  static final String RX_UUID = "6e400003-b5a3-f393-e0a9-e50e24dcca9e";

  // Time format
  static final DateFormat dataTableTimeFormat = DateFormat("HH:mm:ss");
  static final DateFormat csvDateTimeFormat = DateFormat("dd.MMMM.yyyy HH:mm");

  //Style
  static final TextStyle style = TextStyle(fontSize: 15);
}