import 'package:flutter/material.dart';
import 'package:root/root.dart';

import 'dart:io';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _rootAccess = false;
  var _cycleCount = "-";
  var _fullCharge = "-";
  var _batteryHealth = "-";
  var _designCapacity = "-";

  Future<void> checkRoot() async {
    bool result = await Root.isRooted() as bool;

    setState(() {
      _rootAccess = result;
      checkCycleCount();
      checkFullCharge();
    });
  }

  Future<void> checkCycleCount() async {
    String res =
        await Root.exec(cmd: 'cat /sys/class/power_supply/battery/cycle_count')
            as String;

    setState(() {
      _cycleCount = res;
    });
  }

  Future<void> checkFullCharge() async {
    String res =
        await Root.exec(cmd: 'cat /sys/class/power_supply/battery/charge_full')
            as String;

    setState(() {
      _fullCharge = res;
      checkHealth();
    });
  }

  Future<void> checkHealth() async {
    String designCapacity = await Root.exec(
            cmd: 'cat /sys/class/power_supply/battery/charge_full_design')
        as String;

    print(designCapacity);

    try {
      int designCapacityInt = int.parse(designCapacity);
      int fullChargeInt = int.parse(_fullCharge);

      double batteryHealth = (fullChargeInt / designCapacityInt) * 100;

      setState(() {
        _designCapacity = designCapacity;
        _batteryHealth = batteryHealth.toStringAsFixed(2);
      });
    } on FormatException {
      setState(() {
        _batteryHealth = "Could not fetch battery health";
        _designCapacity = "Something went wrong.";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkRoot();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Battery health"),
          ),
          body: Column(
            children: [
              Text("Root access status: $_rootAccess"),
              Text("Cycle count: $_cycleCount "),
              Text("Full charge: $_fullCharge"),
              Text("Design capacity: $_designCapacity"),
              Text("Battery health: $_batteryHealth%")
            ],
          )),
    );
  }
}
