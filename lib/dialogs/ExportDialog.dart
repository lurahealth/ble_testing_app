import 'package:flutter/material.dart';
import 'package:flutter_blue_test_applciation/provideres/ExportDIalogProvider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExportDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final ExportDialogProvider provider = Provider.of<ExportDialogProvider>(context);

    var fromDateTextEditingController = TextEditingController( text: provider.fromDateString);

    final fromDateField = TextField(
        controller: fromDateTextEditingController,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.calendar_today,
            ),
            border: OutlineInputBorder(),
            hintText: "Enter from date",
            labelText: "From Date",
        ),
        onTap: () {
          {
            DatePicker.showDateTimePicker(context, showTitleActions: true,
                onConfirm: (date) {
                  fromDateTextEditingController.text = "From Date";
                  provider.setFromDate(date);
                });
          }
        },
        readOnly: true);

    var toDateTextEditingController = TextEditingController( text: provider.toDateString);

    final toDateField = TextField(
        controller: toDateTextEditingController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.calendar_today,
          ),
          border: OutlineInputBorder(),
          hintText: "Enter to date",
          labelText: "To Date",
        ),
        onTap: () {
          {
            DatePicker.showDateTimePicker(context, showTitleActions: true,
                onConfirm: (date) {
                  fromDateTextEditingController.text = "To Date";
                  provider.setToDate(date);
                });
          }
        },
        readOnly: true);

    final exportButton = FlatButton(
      onPressed: () => provider.exportData(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Export Data",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.deepOrangeAccent,),
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
            style: TextStyle(color: Colors.deepOrangeAccent,),
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

