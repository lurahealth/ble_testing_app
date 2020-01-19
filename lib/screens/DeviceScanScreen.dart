import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_test_applciation/dialogs/GetDatesDialog.dart';
import 'package:flutter_blue_test_applciation/models/DateRangeModel.dart';
import 'package:flutter_blue_test_applciation/provideres/DevicesScanProvider.dart';
import 'package:provider/provider.dart';

class DeviceScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DeviceScanProvider>(
      create: (_) => DeviceScanProvider(),
      child: DeviceScanWidget(),
    );
  }
}

class DeviceScanWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeviceScanProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: new Text("Device scan"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              final DateRangeModel dates = await _exportDateRange(context);
              if (dates != null) {
                print("We have dates");
                provider.exportData(dates);
              } else {
                print("No dates");
              }
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: provider.scanForDevices,
        child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              thickness: 1.5,
            ),
            itemCount: provider.scanResults.length,
            itemBuilder: (BuildContext context, int index) {
             ScanResult result = provider.scanResults[index];
             BluetoothDevice device = result.device;
              return Padding(
                padding: const EdgeInsets.all(32.0),
                child: GestureDetector(
                  onTap: () => provider.connectToDevice(context, device) ,
                  child: Column(
                    children: <Widget>[
                      new Text("RSSI ${result.rssi}"),
                      new Text("Name: ${device.name}"),
                      new Text(device.type.toString())
                    ],
                  )
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: provider.scanForDevices ,
        child: Icon(Icons.bluetooth_searching),
        ),
    );
  }

  Future<DateRangeModel> _exportDateRange(BuildContext context) async {
    return showDialog<DateRangeModel>(
        context: context,
        barrierDismissible: true,
        // dialog is dismissible with a tap on the barrier
        builder: (BuildContext context) {
          return GetDateDialog();
        });
  }
}

