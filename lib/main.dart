import 'package:flutter/material.dart';
import 'package:root/root.dart';

import 'dart:io';
import 'dart:async';

import './cardWidget.dart';

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
            title: const Text("Battery health"), // Thanks vscode
          ),
          body: Column(
            children: [
              const Padding(padding: EdgeInsets.all(5)), // Thanks vscode
              CustomCard("Root access: $_rootAccess"),
              CustomCard("Cycle count: $_cycleCount "),
              CustomCard("Full charge: $_fullCharge"),
              CustomCard("Design capacity: $_designCapacity"),
              CustomCard("Battery health: $_batteryHealth%")
            ],
          )),
    );
  }
}
