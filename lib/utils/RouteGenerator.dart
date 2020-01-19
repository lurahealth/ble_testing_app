import 'package:flutter/material.dart';
import 'package:flutter_blue_test_applciation/screens/DeviceDataScreen.dart';
import 'package:flutter_blue_test_applciation/screens/DeviceScanScreen.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => DeviceScanScreen());
      case '/deviceDataScreen':
        return MaterialPageRoute(builder: (_) => DeviceDateScreen(args));
      default:
        return _errorRoute();
    }
  }



  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}