import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_test_applciation/models/DateRangeModel.dart';
import 'package:flutter_blue_test_applciation/provideres/DeviceDataProvider.dart';
import 'package:intl/intl.dart';

class GetDateDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final format = DateFormat("yyyy-MM-dd HH:mm");
    DateTime fromDate;
    DateTime toDate;

    final fromDateField = DateTimeField(
      onChanged: ( DateTime value) => fromDate = value,
      decoration: InputDecoration(
          labelText: "From",
      ),
      format: format,
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime:
            TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      },
    );

    final toDateField = DateTimeField(
      onChanged: (DateTime value) => toDate = value,
      decoration: InputDecoration(
        labelText: "To",
      ),
      format: format,
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime:
            TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.combine(date, time);
        } else {
          return currentValue;
        }
      },
    );

    final exportButton = FlatButton(
      onPressed: () {
        Navigator.pop(context, DateRangeModel(fromDate, toDate));
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Export Data",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    final cancelButton = FlatButton(
      onPressed: () => Navigator.pop(context) ,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Cancel",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Set date range for sensor data export",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),),
          ),
          SizedBox(height: 40,),
          fromDateField,
          SizedBox(height: 20,),
          toDateField,
          SizedBox(height: 20,),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              cancelButton,
              exportButton,
            ],
          ),
        ],
      ),
    );
  }
}

