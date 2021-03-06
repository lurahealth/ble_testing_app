import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_test_applciation/dialogs/ExportDialog.dart';
import 'package:flutter_blue_test_applciation/provideres/DeviceDataProvider.dart';
import 'package:flutter_blue_test_applciation/provideres/DeviceStateProvider.dart';
import 'package:flutter_blue_test_applciation/provideres/ExportDIalogProvider.dart';
import 'package:flutter_blue_test_applciation/widgets/ButtonRow.dart';
import 'package:flutter_blue_test_applciation/widgets/DataTableWidget.dart';
import 'package:flutter_blue_test_applciation/widgets/GraphContolWidget.dart';
import 'package:flutter_blue_test_applciation/widgets/GraphWidget.dart';
import 'package:flutter_blue_test_applciation/widgets/ColumnHeaderWidget.dart';
import 'package:provider/provider.dart';

class DeviceDateScreen extends StatelessWidget {
  final BluetoothDevice device;

  DeviceDateScreen(this.device);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(
            create: (_) => DeviceStateProvider(device).connectToDevice(),
            initialData: BluetoothDeviceState.connecting),
        ChangeNotifierProvider(
          create: (_) => DeviceDataProvider(device, device.name),
        )
      ],
      child: DeviceDateWidget(),
    );
  }
}

class DeviceDateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BluetoothDeviceState deviceState =
        Provider.of<BluetoothDeviceState>(context);
    final DeviceDataProvider provider =
        Provider.of<DeviceDataProvider>(context);
    if (deviceState == BluetoothDeviceState.connected) {
      provider.getData();
    }else if(provider.connected){
      provider.disconnect();
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 20,),
          SizedBox(
              height: 200,
              child: FittedBox(
                fit: BoxFit.fill,
                  child: GraphWidget(provider)
              )
          ),
          GraphControlWidget(provider),
          SizedBox(height: 20,),
          ColumnHeaderWidget(),
          DataTableWidget(provider),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonRow(provider),
          ),
          AnimatedContainer(
            color: (deviceState == BluetoothDeviceState.connected)
                ? Colors.green // if connected to device, show green
                : Colors.redAccent, // else show red
            duration: Duration(milliseconds: 100),
            child: Center(child: Text(deviceState.toString())),
          )
        ],
      ),
    );
  }


}
