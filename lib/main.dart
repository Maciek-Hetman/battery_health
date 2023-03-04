import 'package:battery_health/device_info_view.dart';
import 'package:battery_health/no_battery_info_view.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:root/root.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'dart:async';

import './battery_health_view.dart';
import './loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _materialBlue = const Color(0x002196f3);

  var _rootAccess = false;
  var _cycleCount = "-";
  var _fullCharge = "-";
  var _batteryHealth = "- ";

  var _fullChargeReadable = "- mAh";
  var _designCapacityReadable = "- mAh";

  var _deviceName;
  var _deviceAndroidVersion;
  var _deviceManufacturer;
  var _deviceBoard;
  var _deviceBrand;

  final List<Widget> _pages = [
    const LoadingScreen(),
    const LoadingScreen(),
  ];
  int _index = 0;

  Future<void> getDeviceInfo() async {
    AndroidDeviceInfo deviceInfo = await DeviceInfoPlugin().androidInfo;

    setState(() {
      _deviceName = deviceInfo.device;
      _deviceManufacturer = deviceInfo.manufacturer;
      _deviceAndroidVersion = deviceInfo.version.release;
      _deviceBoard = deviceInfo.board;
      _deviceBrand = deviceInfo.brand;
    });
  }

  Future<void> checkRoot() async {
    bool result = await Root.isRooted() as bool;
    _rootAccess = result;

    if (_rootAccess == true) {
      await checkCycleCount();
      await checkFullCharge();
      await getDeviceInfo();

      setState(() {
        _pages[0] = BatteryHealthView(
            _batteryHealth,
            _cycleCount,
            _fullChargeReadable,
            _designCapacityReadable,
            _deviceName,
            _deviceManufacturer,
            _deviceAndroidVersion,
            _rootAccess);

        _pages[1] = DeviceInfoView(_deviceName, _deviceManufacturer,
            _deviceAndroidVersion, _deviceBoard, _deviceBrand, _rootAccess);
      });
    } else {
      await getDeviceInfo();
      setState(() {
        _pages[0] = NoBatteryInfoView(_rootAccess);
        _pages[1] = DeviceInfoView(_deviceName, _deviceManufacturer,
            _deviceAndroidVersion, _deviceBoard, _deviceBrand, _rootAccess);
      });
    }
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
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: _materialBlue,
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: _materialBlue,
            brightness: Brightness.dark,
          );
        }
        // MOVE THAT AWAY FROM HERE
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.light,
                colorScheme: lightColorScheme),
            darkTheme: ThemeData(
                brightness: Brightness.dark,
                useMaterial3: true,
                colorScheme: darkColorScheme),
            themeMode: ThemeMode.system,
            home: Scaffold(
                bottomNavigationBar: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.battery_4_bar_rounded),
                        label: 'Battery info'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.phonelink_setup_rounded),
                        label: 'Device info'),
                  ],
                  currentIndex: _index,
                  onTap: (index) {
                    setState(() {
                      _index = index;
                    });
                  },
                ),
                body: _pages[_index]));
      },
    );
  }
}
