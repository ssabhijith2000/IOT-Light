import 'package:flutter/material.dart';
import 'package:lights_on/iot/iot_core.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'note',
      home: Home(),

    );
  }
}

