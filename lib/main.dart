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
    });
  }

  @override
  void initState() {
    super.initState();
    checkRoot();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Root access test"),
          ),
          body: Column(
            children: [
              Text("Root access status: $_rootAccess"),
              Text("Cycle count: $_cycleCount "),
              Text("Full charge: $_fullCharge")
            ],
          )),
    );
  }
}
