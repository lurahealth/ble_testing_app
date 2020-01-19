import 'package:flutter/material.dart';
import 'package:flutter_blue_test_applciation/dialogs/AddNotesDialog.dart';
import 'package:flutter_blue_test_applciation/dialogs/ExportDialog.dart';
import 'package:flutter_blue_test_applciation/models/DateRangeModel.dart';
import 'package:flutter_blue_test_applciation/provideres/DeviceDataProvider.dart';

class ButtonRow extends StatelessWidget {
  final DeviceDataProvider provider;

  ButtonRow(this.provider);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RaisedButton(
          color: Colors.green,
          onPressed: () async {
            final String note = await _notesDialog(context);
            if(note != null && note.length > 0){
              print("We have a note: $note");
              provider.saveNote(note);
            }else{
              print("No notes");
            }
          },
          child: Row(
            children: <Widget>[
              Icon(Icons.note_add),
              Text("Add note"),
            ],
          ),
        ),
        RaisedButton(
          color: Colors.green,
          onPressed: () => provider.disconnectDevice(context),
//          onPressed: () async {
//            final DateRangeModel dates = await _exportDateRange(context);
//            if(dates != null){
//              print("We have dates");
//              provider.exportData(dates);
//            }else{
//              print("No dates");
//            }
//          },
          child: Row(
            children: <Widget>[
              Icon(Icons.share),
              Text("Export"),
            ],
          ),
        ),
      ],
    );
  }

  Future<String> _notesDialog(BuildContext context) async {
    return showDialog<String>(
        context: context,
        barrierDismissible: true,
        // dialog is dismissible with a tap on the barrier
        builder: (BuildContext context) {
          return AddNotesDialog();
        });
  }


}
