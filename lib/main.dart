import 'package:flutter/material.dart';
import 'package:root/root.dart';
import 'package:device_info_plus/device_info_plus.dart';

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
  var _batteryHealth = "- ";

  var _fullChargeReadable = "- mAh";
  var _designCapacityReadable = "- mAh";

  var _deviceName;
  var _deviceAndroidVersion;
  var _deviceManufacturer;

  Future<void> getDeviceInfo() async {
    AndroidDeviceInfo deviceInfo = await DeviceInfoPlugin().androidInfo;

    setState(() {
      _deviceName = deviceInfo.device;
      _deviceManufacturer = deviceInfo.manufacturer;
      _deviceAndroidVersion = deviceInfo.version.release;
    });
  }

  Future<void> checkRoot() async {
    bool result = await Root.isRooted() as bool;

    setState(() {
      _rootAccess = result;
      checkCycleCount();
      checkFullCharge();
      getDeviceInfo();
    });
  }

  Future<void> checkCycleCount() async {
    String res =
        await Root.exec(cmd: 'cat /sys/class/power_supply/battery/cycle_count')
            as String;

    setState(() {
      _cycleCount = res.replaceAll("\n", "");
    });
  }

  Future<void> checkFullCharge() async {
    String res =
        await Root.exec(cmd: 'cat /sys/class/power_supply/battery/charge_full')
            as String;

    setState(() {
      _fullCharge = res;
      _fullChargeReadable =
          "${(int.parse(res) / 1000).toStringAsFixed(0)} mAh"; // Truly amazing
      checkHealth();
    });
  }

  Future<void> checkHealth() async {
    String designCapacity = await Root.exec(
            cmd: 'cat /sys/class/power_supply/battery/charge_full_design')
        as String;

    try {
      int designCapacityInt = int.parse(designCapacity);
      int fullChargeInt = int.parse(_fullCharge);

      double batteryHealth = (fullChargeInt / designCapacityInt) * 100;

      setState(() {
        _designCapacityReadable =
            "${(int.parse(designCapacity) / 1000).toStringAsFixed(0)} mAh";
        _batteryHealth = batteryHealth.toStringAsFixed(1);
      });
    } on FormatException {
      setState(() {
        _batteryHealth = "Could not fetch battery health";
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
      theme: ThemeData(useMaterial3: true, brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      themeMode: ThemeMode.system,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Battery health",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            toolbarHeight: 120,
          ),
          body: ListView(
            children: [
              const Padding(padding: EdgeInsets.all(3)), // Thanks vscode

              // Battery info widgets
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                child: const Text(
                  "Battery info",
                  style: TextStyle(
                    fontSize: 30,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomCard("Battery health: $_batteryHealth%"),
              CustomCard("Cycle count: $_cycleCount "),
              CustomCard("Full charge: $_fullChargeReadable"),
              CustomCard("Design capacity: $_designCapacityReadable"),

              // Device info widgets
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                child: const Text(
                  "Device info",
                  style: TextStyle(
                    fontSize: 30,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomCard("Device: $_deviceName"),
              CustomCard("Manufacturer: $_deviceManufacturer"),
              CustomCard("Android version: $_deviceAndroidVersion"),
            ],
          )),
    );
  }
}
