import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_test_applciation/provideres/ExportDIalogProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExportDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final ExportDialogProvider provider = Provider.of<ExportDialogProvider>(context);

    final format = DateFormat("yyyy-MM-dd HH:mm");

    final fromDateField = DateTimeField(
      onChanged: provider.setFromDate ,
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
      onChanged: provider.setToDate ,
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
      onPressed: () => provider.exportData(context),
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

    final exportMessage = new Text(
      "Export in progress, this could take a while. Please be patient",
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Stack(
        children: <Widget>[
          Visibility(
            visible: provider.exporting,
            child: exportMessage,
          ),
          Visibility(
            visible: !provider.exporting ,
            child: Column(
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
          ),
        ],
      ),
    );
  }
}

