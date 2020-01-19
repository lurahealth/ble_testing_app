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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
      children: <Widget>[
        RaisedButton(
          color: Colors.lightBlue ,
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
              SizedBox(width: 10,),
              Text("Add note"),
            ],
          ),
        ),
        RaisedButton(
          color: Colors.lightBlue ,
          onPressed: () => provider.disconnectDevice(context),
          child: Row(
            children: <Widget>[
              Icon(Icons.bluetooth_disabled),
              SizedBox(width: 10,),
              Text("Disconnect"),
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
